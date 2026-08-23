local var_0_0 = {
	SELECTED = 3,
	CAN_PRODUCE = 0,
	LOCK = 2,
	PRODUCING = 1
}
local var_0_1 = g.core.model.User.hlTrainData
local HLTrainSelectProductComp = class("HLTrainSelectProductComp", require("app.fairyGUI.homeLandTrain.UI_HLTrainSelectProductComp"))

function HLTrainSelectProductComp:ctor()
	self._selectedIdxLua = 0
	self._roomStruct = nil

	self.m_selectList:setVirtual(self)
	self.m_selectList:setItemRenderer(handler(self, self._onSelectListRenderer))
end

function HLTrainSelectProductComp:receiveCompEvent(arg_2_1, arg_2_2)
	if arg_2_1 == "event_selected_product" then
		self._selectedIdxLua = arg_2_2.indexLua

		self:_updateItemProductState(self._selectedIdxLua)
	elseif arg_2_1 == "event_confirm_selected_product" then
		self._selectedIdxLua = 0

		return false
	elseif arg_2_1 == "event_cancel_selected_product" then
		self._selectedIdxLua = 0
	end
end

function HLTrainSelectProductComp:initComp(arg_3_1)
	self._roomStruct = arg_3_1
	self._selectedIdxLua = 0
	self._productInfoArr = var_0_1:getAppearProductInfoArr(arg_3_1.advanceId, arg_3_1.curLevel)

	self.m_selectList:setNumItems(#self._productInfoArr)
end

function HLTrainSelectProductComp:getSelectedProductId(arg_4_1)
	return self._productInfoArr[arg_4_1].id
end

function HLTrainSelectProductComp:_onSelectListRenderer(arg_5_1, arg_5_2)
	arg_5_2:updateCell({
		indexLua = arg_5_1 + 1,
		roomStruct = self._roomStruct,
		productInfo = self._productInfoArr[arg_5_1 + 1],
		productState = self:_getProductState(arg_5_1 + 1)
	})
end

function HLTrainSelectProductComp:_updateItemProductState(arg_6_1)
	if arg_6_1 == 0 then
		return
	end

	local var_6_0 = self.m_selectList:getChildAt((self.m_selectList:itemIndexToChildIndex(arg_6_1 - 1)))

	if var_6_0 then
		var_6_0:setProductState((self:_getProductState(arg_6_1)))
	end
end

function HLTrainSelectProductComp:_getProductState(arg_7_1)
	if self._roomStruct.curLevel < self._productInfoArr[arg_7_1].unlock_level then
		return var_0_0.LOCK
	elseif self._productInfoArr[arg_7_1].id == self._roomStruct.productId then
		return var_0_0.PRODUCING
	elseif arg_7_1 == self._selectedIdxLua then
		return var_0_0.SELECTED
	else
		return var_0_0.CAN_PRODUCE
	end
end

return HLTrainSelectProductComp
