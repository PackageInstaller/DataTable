local var_0_0 = g.core.const.ConstMgr.outpostConst
local OutpostCommon = require("app.view.module.outpost.const.OutpostCommon")
local OutpostKnightChangeEquipCell = class("OutpostKnightChangeEquipCell", require("app.fairyGUI.outpost.UI_OutpostKnightChangeEquipCell"))

function OutpostKnightChangeEquipCell:ctor()
	self._curEquip = nil
	self._knightStruct = nil
	self._needCoinNum = 0

	self.m_changeBtn:addClickListener(handler(self, self._onConfirmClick))

	self._isNeedTipConfirm = nil
end

function OutpostKnightChangeEquipCell:updateEquipWear(arg_2_1, arg_2_2, arg_2_3)
	self._isNeedTipConfirm = nil
	self._knightStruct = arg_2_3
	self._curEquip = arg_2_1

	self.m_equipIcon:updateEquip(arg_2_1)

	local var_2_0 = arg_2_1:getCfg()

	self.m_nameTxt:setText(var_2_0.name)

	local var_2_1 = OutpostCommon.getAttr(var_2_0.attribute_type, var_2_0.attribute_value)

	self.m_attrNameTxt:setText(var_2_1.name)
	self.m_attrValueTxt:setText(var_2_1.value)
	self.m_isUpController:setSelectedIndex(2)
	self.m_canWearController:setSelectedIndex(1)

	local var_2_3 = var_2_0.profession == 0 and true or arg_2_3:getCfg().profession == var_2_0.profession

	if arg_2_2 then
		local var_2_4 = arg_2_2:getCfg()

		if arg_2_2:getEquipType() == arg_2_1:getEquipType() then
			if var_2_3 then
				self.m_canWearController:setSelectedIndex(0)
			else
				self.m_canWearController:setSelectedIndex(1)
			end

			self._isNeedTipConfirm = var_2_0.attribute_value <= var_2_4.attribute_value

			if var_2_0.attribute_value == var_2_4.attribute_value then
				self.m_isUpController:setSelectedIndex(2)
			else
				self.m_isUpController:setSelectedIndex(var_2_0.attribute_value > var_2_4.attribute_value and 0 or 1)
			end
		end
	else
		self.m_isUpController:setSelectedIndex(0)

		if var_2_3 then
			self.m_canWearController:setSelectedIndex(0)
		else
			self.m_canWearController:setSelectedIndex(1)
		end
	end

	local var_2_5 = self._curEquip:getPrice()

	self.m_costIcon:setIcon(g.core.common.Path:getOutpostItemIcon(g.core.config.outpost_item_info.get(var_0_0.KNIGHT_COIN_ID).icon, true))
	self.m_costValueTxt:setText(var_2_5)

	self._needCoinNum = var_2_5
end

function OutpostKnightChangeEquipCell:_onConfirmClick()
	if self._isNeedTipConfirm then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
			title = g.core.lang:get(1257),
			desc = g.core.lang:get(432671),
			onConfirm = handler(self, self.onChangeEquip)
		}))
	else
		self:onChangeEquip()
	end
end

function OutpostKnightChangeEquipCell:onChangeEquip()
	if self._knightStruct and self._knightStruct:getOwnCoinNum() >= self._needCoinNum then
		self:dispatchCompEvent("OutpostKnightChangeEquipPop_ChangeEquip", self._curEquip)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(432629))
	end
end

return OutpostKnightChangeEquipCell
