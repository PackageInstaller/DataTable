local MallSummaryBox = class("MallSummaryBox", import("view.base.BaseSubView"))

function MallSummaryBox:getUIName()
	return "MallSummaryBox"
end

function MallSummaryBox:OnLoaded()
	setText(self.uiTitleText, i18n("mall_summary_title"))
	setText(self.uiTipText, i18n("word_click_to_close"))
	setText(self.uiIncomeHeaderText, i18n("mall_total_income_header"))
	setText(self.uiBalanceHeaderText, i18n("mall_balance_header"))

	return
end

function MallSummaryBox:OnInit()
	onButton(self, self.uiCloseBtn, function()
		self:Hide()

		return
	end, SFX_PANEL)

	self.floorUIList = UIItemList.New(self.uiFloorsTF, self.uiFloorsTF:Find("tpl"))

	self.floorUIList:make(function(arg_5_0, arg_5_1, arg_5_2)
		if arg_5_0 == UIItemList.EventUpdate then
			setText(arg_5_2:Find("header"), i18n("mall_floor_income_header", arg_5_1 + 1))
			setText(arg_5_2:Find("value"), self.incomeList[arg_5_1 + 1])
		end

		return
	end)

	return
end

function MallSummaryBox:Show()
	MallSummaryBox.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.activity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MALL)
	self.balance = self.activity:GetLastBalance()
	self.totalIncome = 0
	self.incomeList = {}

	for iter_6_0, iter_6_1 in ipairs(self.activity:GetFloorListAsc()) do
		if iter_6_1:IsUnlock() then
			local var_6_0 = iter_6_1:GetLastIncome()

			self.totalIncome = self.totalIncome + var_6_0

			table.insert(self.incomeList, var_6_0)
		end
	end

	setText(self.uiIncomeValText, self.totalIncome)
	setText(self.uiBalanceValText, self.balance)
	self.floorUIList:align(#self.incomeList)

	return
end

function MallSummaryBox:Hide()
	MallSummaryBox.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

function MallSummaryBox:OnDestroy()
	return
end

return MallSummaryBox
