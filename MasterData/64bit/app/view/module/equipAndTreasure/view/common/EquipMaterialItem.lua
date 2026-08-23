local PressComp = require("app.view.module.recruit.view.comp.PressComp")
local EquipMaterialItem = class("EquipMaterialItem", require("app.fairyGUI.equipAndTreasure.UI_EquipMaterialItem"))

function EquipMaterialItem:ctor()
	self._material = nil
	self._isAdd = nil
	self._itemIdx = 0

	PressComp.bindComp(self)
	self:addPressListener(handler(self, self._onTouch))
	self:setClickListener(handler(self, self._onClick))
	self:setIgnoreMove(true)
	self:setPressTime(0.2)
	self:setPressInterval(0.1)
end

function EquipMaterialItem:updateItem(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = arg_2_1.material
	local var_2_1 = arg_2_1.selectedNum

	self._itemIdx = arg_2_1.itemIdx

	if not var_2_0 then
		return
	end

	self._material = var_2_0

	if var_2_0.size > 0 then
		self.m_showMaskController:setSelectedIndex(1)
	else
		self.m_showMaskController:setSelectedIndex(0)
	end

	self.m_baseIcon:updateIcon(var_2_0)

	if var_2_1 and var_2_1 > 0 then
		self.m_selectController:setSelectedIndex(1)
		self.m_useNumText:setText(var_2_1)
	else
		self.m_selectController:setSelectedIndex(0)
	end
end

function EquipMaterialItem:onLoad()
	return
end

function EquipMaterialItem:onUnload()
	return
end

function EquipMaterialItem:changeNum(arg_5_1)
	self.m_useNumText:setText(arg_5_1)
end

function EquipMaterialItem:_onClickSub()
	self:dispatchCompEvent("EquipMaterialItem_sub", {
		itemIdx = self._itemIdx
	})
end

function EquipMaterialItem:_onTouch()
	if self._isAdd == false then
		self:dispatchCompEvent("EquipMaterialItem_sub", {
			itemIdx = self._itemIdx
		})
	elseif self._isAdd == true then
		self:dispatchCompEvent("EquipMaterialItem_add", {
			itemIdx = self._itemIdx
		})
	end
end

function EquipMaterialItem:_onClick(arg_8_1)
	if self._material.size > 0 then
		local var_8_0 = arg_8_1:getInput():getTouch():getLocation()

		if var_8_0 and self.m_subBtn:containPoint(var_8_0) then
			self:dispatchCompEvent("EquipMaterialItem_sub", {
				itemIdx = self._itemIdx
			})
		else
			self:dispatchCompEvent("EquipMaterialItem_add", {
				itemIdx = self._itemIdx
			})
		end
	else
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			size = 0,
			type = self._material.type,
			value = self._material.value
		})
	end
end

function EquipMaterialItem:_additionalTouchBegin(arg_9_1, arg_9_2)
	self._isAdd = not (arg_9_2 and self.m_subBtn:containPoint(arg_9_2))
end

function EquipMaterialItem:_additionalTouchEnd(arg_10_1, arg_10_2)
	self._isAdd = nil
end

return EquipMaterialItem
