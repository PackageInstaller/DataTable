local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local var_0_2 = g.core.model.User.outpostData
local OutpostKnightDetailLayer = class("OutpostKnightDetailLayer", require("app.fairyGUI.outpost.UI_OutpostKnightDetailLayer"), function()
	return fgui.GComponent:create({
		pkgName = "outpost",
		isFullScreen = true,
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostKnightDetailLayer"
	}, ...)
end)

function OutpostKnightDetailLayer:ctor(arg_2_1)
	self:addBg("bg/outpost/pic_hxsz_jiaoyisuobg.jpg")

	self._struct = arg_2_1.struct
	self._tabComp = {
		[0] = self.m_infoComp,
		self.m_bagComp
	}
	self._equips = self._struct:getEquips()
	self._allLineKnights = var_0_2:getKnightsData():getAllLineUpKnights()
	self._allKnightPosSid = {}
	self._curIndex = 0

	for iter_2_0, iter_2_1 in ipairs(self._allLineKnights) do
		local var_2_0 = iter_2_1:getServerId()

		self._allKnightPosSid[iter_2_0] = var_2_0

		if var_2_0 == self._struct:getServerId() then
			self._curIndex = iter_2_0
		end
	end

	self.m_coinComp:initKnight(self._struct)

	self._stateComp = {
		[var_0_1.STATE_ENUM.KNIGHT_HUNGER] = self.m_jieComp,
		[var_0_1.STATE_ENUM.KNIGHT_DEMONIC] = self.m_moqiComp,
		[var_0_1.STATE_ENUM.KNIGHT_FATIGUE] = self.m_pilaoComp,
		[var_0_1.STATE_ENUM.KNIGHT_MOOD] = self.m_xinqingComp
	}

	self.m_rightBtn:addClickListener(handler(self, self._onClickRight))
	self.m_leftBtn:addClickListener(handler(self, self._onClickLeft))
	self.m_equipList:setVirtual()
	self.m_equipList:setItemRenderer(handler(self, self._onEquipRenderer))
	self.m_equipList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self.onClickEquip))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self.onChangeTab))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
end

function OutpostKnightDetailLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_DONATEKNIGHT, handler(self, self.updateDetailView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_OUTPOST_STATUS_CHANGE, handler(self, self.updateStatusValue), self)
	self.m_enterTransition:play()
	self:updateDetailView()
end

function OutpostKnightDetailLayer:onChangeTab()
	local var_5_0 = self.m_tabController:getSelectedIndex()

	self._tabComp[var_5_0]:updateWithStruct(self._struct)
	self._tabComp[var_5_0]:playEnter()
end

function OutpostKnightDetailLayer:updateKnightBaseState()
	if not self._struct then
		return
	end

	if self._spine then
		self._spine:removeFromParent()

		self._spine = nil
	end

	self._spine = BattleKnight.new({
		resId = self._struct:getCfg().advance_id
	})

	self.m_knightHolder:addNode(self._spine)
	self._spine:setScale(1.75)
	self:doUpdateStatusValue()
end

function OutpostKnightDetailLayer:updateStatusValue()
	if not self._curFramUpdateStatus then
		self._curFramUpdateStatus = true

		self:newScheduleOnce(handler(self, self.doUpdateStatusValue))
	end
end

function OutpostKnightDetailLayer:doUpdateStatusValue()
	self._curFramUpdateStatus = false

	for iter_8_0, iter_8_1 in pairs(self._stateComp) do
		iter_8_1:updateStatues(self._struct, iter_8_0)
		iter_8_1:setTitle(math.floor(self._struct:getKnightStateValue(iter_8_0) + 0.5))
	end
end

function OutpostKnightDetailLayer:updateDetailView()
	self:onChangeTab()
	self:updateKnightBaseState()
	self.m_fightValueTxt:setText(self._struct:getSelfFightValue())
	self.m_equipList:setNumItems(var_0_1.EQUIP_NUM)
	self.m_placeLoader:setURL("ui://outpost/pic_hxsz_zhiye" .. self._struct:getCfg().profession)
end

function OutpostKnightDetailLayer:_onClickRight()
	if #self._allKnightPosSid <= 1 then
		return
	end

	self._curIndex = self._curIndex + 1

	if self._curIndex > #self._allKnightPosSid then
		self._curIndex = 1
	end

	self._struct = var_0_2:getKnightsData():getKnightBySid(self._allKnightPosSid[self._curIndex])
	self._equips = self._struct:getEquips()

	self.m_coinComp:initKnight(self._struct)
	self:updateDetailView()
end

function OutpostKnightDetailLayer:_onClickLeft()
	if #self._allKnightPosSid <= 1 then
		return
	end

	self._curIndex = self._curIndex - 1

	if self._curIndex <= 0 then
		self._curIndex = #self._allKnightPosSid
	end

	self._struct = var_0_2:getKnightsData():getKnightBySid(self._allKnightPosSid[self._curIndex])
	self._equips = self._struct:getEquips()

	self.m_coinComp:initKnight(self._struct)
	self:updateDetailView()
end

function OutpostKnightDetailLayer:_onEquipRenderer(arg_12_1, arg_12_2)
	arg_12_2:updateEquip(self._equips[arg_12_1 + 1], arg_12_1 + 1, self._struct:getCfg().profession)
end

function OutpostKnightDetailLayer:onClickEquip(arg_13_1)
	local var_13_0 = self._equips[arg_13_1:getDataValue() + 1]

	if not var_13_0 then
		return
	end

	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.knight.OutpostKnightSuitDetailPop").new({
		struct = var_13_0
	})))
end

return OutpostKnightDetailLayer
