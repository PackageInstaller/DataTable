local var_0_0 = {
	PRODUCING = 1,
	CAN_PRODUCE = 0,
	SELECTED = 3,
	LOCK = 2
}
local BaseConfirmPop = require("app.view.base.pop.BaseConfirmPop")
local var_0_2 = g.core.model.User
local HLTrainSelectItemCell = class("HLTrainSelectItemCell", require("app.fairyGUI.homeLandTrain.UI_HLTrainSelectItemCell"))

function HLTrainSelectItemCell:ctor()
	self._indexLua = 1

	self:addClickListener(handler(self, self._onClick))
	self.m_cancelBtn:addClickListener(handler(self, self._onCancelClick))
	self.m_confirmBtn:addClickListener(handler(self, self._onConfirmClick))
end

function HLTrainSelectItemCell:_onClick()
	local var_2_0 = self.m_stateController:getSelectedIndex()

	if var_2_0 == var_0_0.CAN_PRODUCE then
		self:setProductState(var_0_0.SELECTED)
		self:dispatchCompEvent("event_selected_product", {
			indexLua = self._indexLua
		})
	elseif var_2_0 == var_0_0.PRODUCING then
		-- block empty
	elseif var_2_0 == var_0_0.LOCK then
		-- block empty
	elseif var_2_0 == var_0_0.SELECTED then
		-- block empty
	end
end

function HLTrainSelectItemCell:_onCancelClick()
	self:setProductState(var_0_0.CAN_PRODUCE)
	self:dispatchCompEvent("event_cancel_selected_product", {
		indexLua = self._indexLua
	})
end

function HLTrainSelectItemCell:_onConfirmClick()
	g.core.module.ModuleManager:pushPopup(BaseConfirmPop.new({
		title = g.core.lang:get(111026),
		desc = g.core.lang:get(111041),
		onConfirm = handler(self, function()
			self:setProductState(var_0_0.PRODUCING)
			self:dispatchCompEvent("event_confirm_selected_product", {
				indexLua = self._indexLua
			})
		end)
	}))
end

function HLTrainSelectItemCell:updateCell(arg_6_1)
	self._indexLua = arg_6_1.indexLua

	local var_6_0 = g.core.common.Goods:convert({
		type = arg_6_1.productInfo.product_type,
		value = arg_6_1.productInfo.product_value
	})

	self.m_nameTxt:setText(var_6_0.name)
	self.m_itemIcon:updateIcon(var_6_0)
	self.m_itemIcon:setNum(0)
	self.m_itemIcon:setTouchable(false)
	self.m_yieldTxt:setText(var_0_2.hlTrainData:getBaseProductionPerHour(arg_6_1.productInfo.id))
	self.m_maxGetTxt:setText(arg_6_1.productInfo.product_storage)
	self.m_lockDesc:setText(g.core.lang:get(111036, {
		name = arg_6_1.roomStruct.refCfgBaseInfo.name,
		level = arg_6_1.productInfo.unlock_level
	}))
	self:setProductState(arg_6_1.productState)
end

function HLTrainSelectItemCell:setProductState(arg_7_1)
	if self.m_stateController:getSelectedIndex() ~= arg_7_1 then
		self.m_stateController:setSelectedIndex(arg_7_1)
	end
end

return HLTrainSelectItemCell
