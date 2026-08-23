local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local var_0_1 = g.core.const.ConstMgr.outpostConst
local var_0_2 = g.core.model.User.outpostData
local OutpostKnightChangeEquipPop = class("OutpostKnightChangeEquipPop", require("app.fairyGUI.outpost.UI_OutpostKnightChangeEquipPop"), function()
	return fgui.GComponent:create({
		isFullScreen = false,
		pkgPath = "ui/outpost/outpost",
		resName = "OutpostKnightChangeEquipPop",
		pkgName = "outpost"
	}, ...)
end)

function OutpostKnightChangeEquipPop:ctor(arg_2_1)
	self:showAtCenter()

	self._allEquips = {}
	self._struct = arg_2_1.struct

	self.m_coinComp:initKnight(self._struct)

	self._virtualObj = arg_2_1.virtualObj
	self._suitPos = self._virtualObj.cmdEquipPos
	self._buildType = self._virtualObj.cmdBuild
	self._oldEquip = nil
	self._talentDesc = {}

	self.m_equipList:setVirtual()
	self.m_equipList:setItemRenderer(handler(self, self._onEquipRenderer))
	self.m_attrList:setVirtual()
	self.m_attrList:setItemRenderer(handler(self, self._onAttrRenderer))
	self.m_tabCtrlController:addEventListener(fgui.UIEventType.Changed, handler(self, self.updateListShow))
	self:addListen(self.m_equipList)
end

function OutpostKnightChangeEquipPop:onLoad()
	if not self._suitPos then
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OUTPOST_BUILD_ORDERPROCESS, handler(self, self.changEquip), self)
	self:updateView()
end

function OutpostKnightChangeEquipPop:changEquip()
	self:updateView()
end

function OutpostKnightChangeEquipPop:updateView()
	self.m_knightIcon:setURL(g.core.common.Path:getKnightCartoonById(self._struct:getCfg().advance_id))
	self.m_fightValueTxt:setText(self._struct:getSelfFightValue())

	if self._suitPos == var_0_1.EquipType.ARMS then
		self.m_showTabController:setSelectedIndex(1)
	else
		self.m_showTabController:setSelectedIndex(0)
	end

	self:updateListShow()
end

function OutpostKnightChangeEquipPop:updateListShow()
	if self._suitPos ~= var_0_1.EquipType.ARMS then
		if self.m_tabCtrlController:getSelectedIndex() == 0 then
			self._suitPos = var_0_1.EquipType.UPPER_BODY_ARMOR or var_0_1.EquipType.LOWER_BODY_ARMOR
		end
	end

	local var_6_0 = self._struct:getEquips()[self._suitPos]

	self.m_placeLoader:setURL("ui://outpost/pic_hxsz_zhiye" .. self._struct:getCfg().profession)

	if var_6_0 then
		self.m_hasEquipController:setSelectedIndex(1)

		local var_6_1 = var_6_0:getCfg()

		self.m_equipComp:updateEquip(var_6_0)
		self.m_nameTxt:setText(var_6_1.name)

		local var_6_2 = OutpostCommon.getAttr(var_6_1.attribute_type, var_6_1.attribute_value)

		self.m_starComp:initStar({
			style = 1,
			gap = -7,
			index = var_6_0:getStarIndex(),
			num = var_6_0:getStar()
		})
		self.m_attrNameTxt:setText(var_6_2.name)
		self.m_defValueTxt:setText(var_6_2.value)

		self._talentDesc = {
			var_6_0:getTalentCfg().description
		}

		self.m_attrList:setNumItems(#self._talentDesc)
	else
		self.m_hasEquipController:setSelectedIndex(0)
	end

	self._oldEquip = var_6_0
	self._allEquips = var_0_2:getBuildData():getBuild({
		type = self._buildType
	}):getEquipList(true, self._suitPos)

	table.sort(self._allEquips, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0:getCfg()
		local var_7_1 = arg_7_1:getCfg()
		local var_7_2 = var_7_0.profession == self._struct:getCfg().profession

		if var_7_2 ~= (var_7_1.profession == self._struct:getCfg().profession) then
			return var_7_2
		end

		if var_7_0.attribute_value ~= var_7_1.attribute_value then
			return var_7_1.attribute_value < var_7_0.attribute_value
		end

		return false
	end)
	self.m_equipList:setNumItems(#self._allEquips)
	self.m_ieEmptyController:setSelectedIndex(#self._allEquips > 0 and 0 or 1)
end

function OutpostKnightChangeEquipPop:_onEquipRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateEquipWear(self._allEquips[arg_8_1 + 1], self._oldEquip, self._struct)
end

function OutpostKnightChangeEquipPop:_onAttrRenderer(arg_9_1, arg_9_2)
	arg_9_2:updateAttr(self._talentDesc[arg_9_1 + 1])
end

function OutpostKnightChangeEquipPop:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "OutpostKnightChangeEquipPop_ChangeEquip" then
		g.core.network.GameNetProxy:send_C2S_Outpost_Build_OrderProcess({
			target_num = 1,
			build_tp = self._buildType,
			order_tp = var_0_1.EXCHANGE_TYPE.SELL,
			knight_id = self._struct:getServerId(),
			target_id = arg_10_2:getCfg().id
		})
	end
end

function OutpostKnightChangeEquipPop:onUnload()
	self._struct:setClickChangeEquip(false)
	self._virtualObj:clearCmdState()
end

return OutpostKnightChangeEquipPop
