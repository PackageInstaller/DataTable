local var_0_0 = g.core.const.ConstMgr.outpostConst
local var_0_1 = g.core.model.User.outpostData
local OutpostDebugComp = class("OutpostDebugComp", require("app.fairyGUI.outpost.UI_OutpostDebugComp"))

function OutpostDebugComp:ctor()
	self.world = nil
	self._map = nil
	self._isShowKnight = false
	self._showKnightList = {}
	self._showMonsterList = {}
	self._knightComp = nil

	self:initView()
end

function OutpostDebugComp:initView()
	self.m_closeBtn:addClickListener(handler(self, self.onClickCloseBtn))
	self.m_showCompBtn:addClickListener(handler(self, self.onClickShowCompBtn))
	self.m_showRange:addClickListener(handler(self, self.onClickShowRangeBtn))
	self.m_selectKnight:addClickListener(handler(self, self.onClickSelectKnightBtn))
	self.m_selectMonster:addClickListener(handler(self, self.onClickSelectMonsterBtn))
	self.m_asyncUpdateBtn:addClickListener(handler(self, self.onClickAsyncUpdate))
	self.m_moreDebugBtn:addClickListener(handler(self, self.onClickMorePopBtn))
	self.m_knightRecoverHpBtn:addClickListener(handler(self, self.onClickKnightRecoverBtn))
	self.m_asyncUpdateBtn:setTitle(var_0_1:isAsyncUpdate() and "分帧（开了）" or "分帧（关闭）")
	self.m_knightList:setIniter()
	self.m_knightList:setItemRenderer(handler(self, self._onRenderKnightList))
	self.m_knightList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickListItem))
end

function OutpostDebugComp:onClickMorePopBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.stage.debug.OutpostDebugPop").new({
		map = self._map
	})))
end

function OutpostDebugComp:onClickKnightRecoverBtn()
	for iter_4_0, iter_4_1 in ipairs(self._map:getAllKnightList()) do
		iter_4_1:recover(iter_4_1:getAttr():getMaxHp())
	end
end

function OutpostDebugComp:onClickShowCompBtn()
	self.m_showStateController:setSelectedIndex(1 - self.m_showStateController:getSelectedIndex())

	if self._isShowKnight then
		self:onClickSelectKnightBtn()
	else
		self:onClickSelectMonsterBtn()
	end
end

function OutpostDebugComp:onClickCloseBtn()
	self:removeFromParent()
end

function OutpostDebugComp:setVirtualWorld(arg_7_1)
	self.m_showStateController:setSelectedIndex(0)

	self.world = arg_7_1
	self._map = self.world:getVirtualMap()

	self:onClickSelectKnightBtn()
end

function OutpostDebugComp:onClickShowRangeBtn()
	var_0_1:setShowAttackRange(not var_0_1:isShowAttackRange())
end

function OutpostDebugComp:onClickAsyncUpdate()
	var_0_1:setAsyncUpdate(not var_0_1:isAsyncUpdate())
	self.m_asyncUpdateBtn:setTitle(var_0_1:isAsyncUpdate() and "分帧（开了）" or "分帧（关闭）")
end

function OutpostDebugComp:onClickSelectKnightBtn()
	self._isShowKnight = true
	self._showKnightList = {}
	self._showMonsterList = {}
	self._showKnightList = self._map:getAllKnightList()

	self.m_knightList:setNumItems(#self._showKnightList)
	self.m_knightList:setSelectedIndex(-1)
end

function OutpostDebugComp:onClickSelectMonsterBtn()
	self._isShowKnight = false
	self._showKnightList = {}
	self._showMonsterList = {}

	for iter_11_0, iter_11_1 in pairs(self._map:getAllMonster()) do
		for iter_11_2, iter_11_3 in ipairs(iter_11_1) do
			table.insert(self._showMonsterList, iter_11_3)
		end
	end

	for iter_11_4, iter_11_5 in pairs(self._map:getBoss()) do
		table.insert(self._showMonsterList, iter_11_5)
	end

	self.m_knightList:setNumItems(#self._showMonsterList)
	self.m_knightList:setSelectedIndex(-1)
end

function OutpostDebugComp:_onRenderKnightList(arg_12_1, arg_12_2)
	if self._isShowKnight then
		arg_12_2:updateKnight(self._showKnightList[arg_12_1 + 1])
	else
		arg_12_2:updateMonster(self._showMonsterList[arg_12_1 + 1])
	end
end

function OutpostDebugComp:_onClickListItem()
	local var_13_0 = self.m_knightList:getSelectedIndex()

	if self._isShowKnight then
		if not self._showKnightList[var_13_0 + 1] or self._showKnightList[var_13_0 + 1]:isClear() then
			return
		end

		if not self._knightComp then
			self._knightComp = fgui.UIPackage:createObject("outpost", "OutpostDebugKnightComp")

			self.m_knightCompHolder:addChild(self._knightComp)
		end

		self._knightComp:showView()
		self._knightComp:updateKnight(self._showKnightList[var_13_0 + 1])
	else
		local var_13_1 = self._showMonsterList[var_13_0 + 1]

		if not self._showMonsterList[var_13_0 + 1] or var_13_1:isClear() then
			return
		end

		if not self._knightComp then
			self._knightComp = fgui.UIPackage:createObject("outpost", "OutpostDebugKnightComp")

			self.m_knightCompHolder:addChild(self._knightComp)
		end

		self._knightComp:showView()
		self._knightComp:updateMonster(var_13_1)
	end
end

function OutpostDebugComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_ORDERPROCESS, handler(self, self._onS2CBuildOrderProcess), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BATTLEFINISH, handler(self, self._onS2CBattleFinish), self)
end

function OutpostDebugComp:_onS2CBuildOrderProcess(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	if not self._knightComp then
		return
	end

	if arg_15_4.order_tp == var_0_0.EXCHANGE_TYPE.PUBLISH then
		if arg_15_4.build_tp == var_0_0.BuildType.WeaponShop or arg_15_4.build_tp == var_0_0.BuildType.ArmorShop then
			self._knightComp:updateEquipChange(arg_15_4)
		end
	end
end

function OutpostDebugComp:_onS2CBattleFinish(arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	if not self._knightComp then
		return
	end

	for iter_16_0, iter_16_1 in ipairs(arg_16_4.knights or {}) do
		self._knightComp:updateLevelChange(iter_16_1)
	end
end

return OutpostDebugComp
