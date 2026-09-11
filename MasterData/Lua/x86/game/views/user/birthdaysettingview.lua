local BirthdaySettingView = class("BirthdaySettingView", ReduxView)
local var_0_1 = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9,
	10,
	11,
	12
}
local var_0_2 = {
	31,
	29,
	31,
	30,
	31,
	30,
	31,
	31,
	30,
	31,
	30,
	31
}

function BirthdaySettingView:UIName()
	return "Widget/System/UserInfor/ChooseBrithdayUI"
end

function BirthdaySettingView:UIParent()
	return manager.ui.uiPop.transform
end

function BirthdaySettingView:Init()
	self:InitUI()
	self:AddUIListener()
end

function BirthdaySettingView:InitUI()
	self:BindCfgUI()

	self.monthScrollHelper_ = LuaList.New(handler(self, self.RefreshMonthItem), self.monthList_, BirtndaySettingItem)
	self.dayScrollHelper_ = LuaList.New(handler(self, self.RefreshDayItem), self.dayList_, BirtndaySettingItem)
end

function BirthdaySettingView:AddUIListener()
	self:AddBtnListener(self.okBtn_, nil, function()
		SetActive(self.Go, false)
		ShowMessageBox({
			content = string.format(GetTips("TIPS_SET_BIRTHDAY"), self.monthPageIndex_, self.dayPageIndex_),
			OkCallback = function()
				PlayerAction.ChangePlayerBirthday(self.monthPageIndex_, self.dayPageIndex_)
			end,
			MaskCallback = function()
				SetActive(self.Go, true)
				self.monthScrollHelper_:StartScroll(#var_0_1, self.monthPageIndex_, true, false)
				self.dayScrollHelper_:StartScroll(var_0_2[self.monthPageIndex_], self.dayPageIndex_, true, false)
			end,
			CancelCallback = function()
				SetActive(self.Go, true)
				self.monthScrollHelper_:StartScroll(#var_0_1, self.monthPageIndex_, true, false)
				self.dayScrollHelper_:StartScroll(var_0_2[self.monthPageIndex_], self.dayPageIndex_, true, false)
			end
		})
	end)
	self:AddBtnListener(self.cancelBtn_, nil, JumpTools.Back)
	self:AddBtnListener(self.bgBtn_, nil, JumpTools.Back)
	self.monthScrollHelper_:SetPageChangeHandler(handler(self, self.OnMonthPageChange))
	self.dayScrollHelper_:SetPageChangeHandler(handler(self, self.OnDayPageChange))
end

function BirthdaySettingView:OnChangeBirthday()
	ShowMessageBox({
		ButtonType = "SingleBtn",
		content = GetTips("TIPS_SET_BIRTHDAY_SURE"),
		OkCallback = JumpTools.Back
	})
end

function BirthdaySettingView:OnMonthPageChange(arg_11_1)
	if arg_11_1 == 0 then
		arg_11_1 = 1
	end

	if arg_11_1 > #var_0_1 then
		self.monthPageIndex_ = #var_0_1 or arg_11_1
	end

	if self.dayPageIndex_ > var_0_2[self.monthPageIndex_] then
		self.dayPageIndex_ = 1
	end

	self.dayScrollHelper_:StartScroll(var_0_2[self.monthPageIndex_], self.dayPageIndex_, true, false)
end

function BirthdaySettingView:OnDayPageChange(arg_12_1)
	if arg_12_1 == 0 then
		arg_12_1 = 1
	end

	if arg_12_1 > var_0_2[self.monthPageIndex_] then
		self.dayPageIndex_ = var_0_2[self.monthPageIndex_] or arg_12_1
	end
end

function BirthdaySettingView:RefreshMonthItem(arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(arg_13_1, self.monthPageIndex_)
end

function BirthdaySettingView:RefreshDayItem(arg_14_1, arg_14_2)
	arg_14_2:RefreshUI(arg_14_1, self.dayPageIndex_)
end

function BirthdaySettingView:OnEnter()
	self.monthPageIndex_, self.dayPageIndex_ = 1, 1

	self.monthScrollHelper_:StartScroll(#var_0_1, self.monthPageIndex_, true, false)
	self.dayScrollHelper_:StartScroll(var_0_2[self.monthPageIndex_], self.dayPageIndex_, true, false)
end

function BirthdaySettingView:Dispose()
	self.monthScrollHelper_:Dispose()

	self.monthScrollHelper_ = nil

	self.dayScrollHelper_:Dispose()

	self.dayScrollHelper_ = nil

	Object.Destroy(self.gameObject_)
	BirthdaySettingView.super.Dispose(self)
end

return BirthdaySettingView
