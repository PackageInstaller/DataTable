local PressComp = require("app.view.module.recruit.view.comp.PressComp")
local FavoMaterialItem = class("FavoMaterialItem", require("app.fairyGUI.knightFavorability.UI_FavoMaterialItem"))

function FavoMaterialItem:ctor()
	self._favoData = nil
	self._index = 0
	self._isAdd = nil

	PressComp.bindComp(self)
	self:addPressListener(handler(self, self._onTouch))
	self:setClickListener(handler(self, self._onClick))
	self:setIgnoreMove(true)
	self:setPressTime(0.2)
	self:setPressInterval(0.1)
	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)
end

function FavoMaterialItem:updateView(arg_2_1)
	self._favoData = arg_2_1.data
	self._index = arg_2_1.index

	local var_2_0

	for iter_2_0, iter_2_1 in pairs(arg_2_1.selectDataList) do
		if self._index == iter_2_1.index then
			var_2_0 = iter_2_1

			break
		end
	end

	if var_2_0 ~= nil then
		self.m_selectController:setSelectedIndex(1)
		self.m_useNumText:setText(var_2_0.num)
	else
		self.m_selectController:setSelectedIndex(0)
	end

	self.m_baseIcon:updateIcon(self._favoData)

	if self._favoData.weight >= 2 then
		self.m_showLikeFlagController:setSelectedIndex(0)
	else
		self.m_showLikeFlagController:setSelectedIndex(1)
	end

	if self._favoData.weight == 0 or self._favoData.weight == 2 then
		self.m_showMaskController:setSelectedIndex(0)
	else
		self.m_showMaskController:setSelectedIndex(1)
	end
end

function FavoMaterialItem:changeNum(arg_3_1)
	self.m_useNumText:setText(arg_3_1)
end

function FavoMaterialItem:_onClickSub()
	self:dispatchCompEvent("FavoMaterialItem_sub")
end

function FavoMaterialItem:_onClick(arg_5_1)
	if self._favoData.size > 0 then
		local var_5_0 = arg_5_1:getInput():getTouch():getLocation()

		if var_5_0 and self.m_subBtn:containPoint(var_5_0) then
			self:dispatchCompEvent("FavoMaterialItem_sub", {
				index = self._index
			})
		else
			self:dispatchCompEvent("FavoMaterialItem_add", {
				index = self._index
			})
		end
	else
		g.core.common.GlobalFunc.pushInfoPop(self._favoData)
	end
end

function FavoMaterialItem:_additionalTouchBegin(arg_6_1, arg_6_2)
	self._isAdd = not (arg_6_2 and self.m_subBtn:containPoint(arg_6_2))
end

function FavoMaterialItem:_onTouch()
	if self._isAdd == false then
		self:dispatchCompEvent("FavoMaterialItem_sub", {
			index = self._index
		})
	elseif self._isAdd == true then
		self:dispatchCompEvent("FavoMaterialItem_add", {
			index = self._index
		})
	end
end

function FavoMaterialItem:_additionalTouchEnd(arg_8_1, arg_8_2)
	self._isAdd = nil
end

return FavoMaterialItem
