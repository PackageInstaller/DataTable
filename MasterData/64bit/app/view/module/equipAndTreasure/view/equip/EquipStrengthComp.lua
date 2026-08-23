local EquipStrengthComp = class("EquipStrengthComp", require("app.fairyGUI.equipAndTreasure.UI_EquipStrenghComp"))
local var_0_1 = math.ceil

function EquipStrengthComp:ctor()
	self._curLevel = 0
	self._addStrengLv = 1
	self._equipId = 0
	self._equipData = {}
	self._upgradeSucTime = 1

	self.m_oneBtn:addClickListener(handler(self, self._onStrengthOnce))
	self.m_fiveBtn:addClickListener(handler(self, self._onStrengthTen))
	self.m_tipsBtn:addClickListener(handler(self, self._onClickTipsButton))
	self.m_shortCutBtn:addClickListener(handler(self, self._onClickShortCutBtn))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function EquipStrengthComp:_onTouchBegin(arg_2_1)
	if self.m_showTipsController:getSelectedIndex() == 1 then
		if not self.m_tipsBtn:containPoint((arg_2_1:getInput():getTouch():getLocation())) then
			self.m_showTipsController:setSelectedIndex(0)
		end
	end
end

function EquipStrengthComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EQUIPMENT_UPGRADE, handler(self, self._onEquipmentUpgrade), self)
end

function EquipStrengthComp:updateView(arg_4_1)
	if not arg_4_1.isServer then
		self._upgradeSucTime = 1
	end

	self.m_haveEquipController:setSelectedIndex(next(arg_4_1.data) and 1 or 0)

	if not next(arg_4_1.data) then
		return
	end

	self._equipData = arg_4_1.data

	local var_4_0 = g.core.model.User:getLevel()
	local var_4_1 = arg_4_1.data:getServerData().level

	self._equipId = arg_4_1.data:getServerData().id
	self._curLevel = var_4_1

	local var_4_2 = var_4_0 * 2
	local var_4_3 = g.core.model.User:getMaxLevel() * 2 <= var_4_1

	self._isLimit = var_4_0 * 2 <= var_4_1

	self.m_strengthStateController:setSelectedIndex(var_4_3 and 1 or 0)
	self.m_curLvTxt:setText(var_4_1)
	self.m_maxLvTxt:setText("Max" .. var_4_2)

	local var_4_4 = arg_4_1.data:getEquipAttrAll()
	local var_4_5, var_4_6, var_4_7, var_4_8 = g.core.lang:getAttrDelta(var_4_4[1].attr, var_4_4[1].value, arg_4_1.data:getEquipNextAttrAll()[1].value, true)

	self.m_strengDescComp:updateAttr({
		type = var_4_4[1].attr,
		name = var_4_5,
		value = var_4_6,
		value2 = var_4_7
	})
	self.m_strengDescComp:setCtrlState("attrNum", {
		index = var_4_3 and 0 or 1
	})
	self.m_costIcon:setIcon((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_COIN, true)))
	self.m_costMoneyText:setText((var_0_1(self._equipData:getOnceStrengthCost())))

	self._attr = var_4_4[1].attr
	self._lastAttrValue = var_4_4[1].value

	if self:_checkShortCutBtnIsShow() then
		self.m_shortCutBtn:setTitle((g.core.lang:get(201568, {
			level = g.core.model.User.equipmentData:getEquipStrengthShortCutLevel()
		})))
		self.m_shortCutBtn:setVisible(true)
	else
		self.m_shortCutBtn:setVisible(false)
	end
end

function EquipStrengthComp:_checkShortCutBtnIsShow()
	local var_5_0 = g.core.model.User.equipmentData:getEquipStrengthShortCutLevel()

	if self._upgradeSucTime < 2 then
		return false
	end

	if var_5_0 < 0 then
		return false
	end

	if self._curLevel > var_5_0 - 40 then
		return false
	end

	if var_5_0 < g.core.config.parameter_info.get(114).parameter then
		return false
	end

	return true
end

function EquipStrengthComp:_onStrengthOnce()
	self._addStrengLv = 1

	self:_goToStrength()
end

function EquipStrengthComp:_onStrengthTen()
	self._addStrengLv = 10

	self:_goToStrength()
end

function EquipStrengthComp:_onClickShortCutBtn()
	self._addStrengLv = g.core.model.User.equipmentData:getEquipStrengthShortCutLevel()

	self:_goToStrength()
end

function EquipStrengthComp:_goToStrength()
	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.EQUIP_STRENGTH) then
		return
	end

	local var_9_0 = var_0_1(self._equipData:getOnceStrengthCost())

	if self._isLimit then
		g.core.module.ModuleManager:tip(g.core.lang:get(201514))

		return
	elseif var_9_0 > g.core.model.User.resourceData:getCoin() then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			value = 3,
			type = g.core.common.Goods.TYPE_RESOURCE,
			size = g.core.model.User.resourceData:getCoin()
		})

		return
	end

	self:dispatchCompEvent("EVENT_EQUIPMENT_UPGRADE", {
		id = {
			self._equipData:getServerData().id
		},
		times = {
			self._addStrengLv
		}
	})
end

function EquipStrengthComp:_onEquipmentUpgrade(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	self._equipData = g.core.model.User.equipmentData:getEquipBySid(self._equipId)

	self:updateView({
		isServer = true,
		data = self._equipData
	})

	if self._addStrengLv == 10 then
		self._upgradeSucTime = self._upgradeSucTime + 1
	end
end

function EquipStrengthComp:_onClickTipsButton()
	if self.m_showTipsController:getSelectedIndex() == 1 then
		self.m_showTipsController:setSelectedIndex(0)
	else
		self.m_showTipsController:setSelectedIndex(1)
	end
end

return EquipStrengthComp
