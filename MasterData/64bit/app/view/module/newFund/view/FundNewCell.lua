local var_0_0 = g.core.model.User.gmFundData
local FundNewCell = class("FundNewCell", require("app.fairyGUI.newFund.UI_FundNewCell"))

function FundNewCell:ctor()
	self.m_freeList:setVirtual()
	self.m_payList:setVirtual()
	self.m_freeList:setItemRenderer(handler(self, self._onFreeListRenderer))
	self.m_payList:setItemRenderer(handler(self, self._onPayListRenderer))
end

function FundNewCell:updateFundNewCell(arg_2_1, arg_2_2)
	self._cfg = arg_2_1
	self._fundType = arg_2_2

	self.m_descTxt:setText(arg_2_1.name)
	self.m_lvNumTxt:setText(arg_2_1.des_num)
	self.m_stringLvTxt:setText(arg_2_1.des)
	self.m_typeController:setSelectedIndex(arg_2_2 - 1)

	local var_2_0, var_2_1 = var_0_0:getFundAwardByCfg(arg_2_1)

	self._freeAwards = var_2_0
	self._payAwards = var_2_1

	self.m_freeList:setNumItems(#var_2_0)
	self.m_payList:setNumItems(#var_2_1)
end

function FundNewCell:_onFreeListRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateFundNewItemComp(self._freeAwards[arg_3_1 + 1], self._cfg, true, self._fundType)
end

function FundNewCell:_onPayListRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateFundNewItemComp(self._payAwards[arg_4_1 + 1], self._cfg, false, self._fundType)
end

return FundNewCell
