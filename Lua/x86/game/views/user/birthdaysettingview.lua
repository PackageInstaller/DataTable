local var_0_0 = class("BirthdaySettingView", ReduxView)
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

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/ChooseBrithdayUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.monthScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshMonthItem), arg_4_0.monthList_, BirtndaySettingItem)
	arg_4_0.dayScrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.RefreshDayItem), arg_4_0.dayList_, BirtndaySettingItem)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		SetActive(arg_5_0.Go, false)
		ShowMessageBox({
			content = string.format(GetTips("TIPS_SET_BIRTHDAY"), arg_5_0.monthPageIndex_, arg_5_0.dayPageIndex_),
			OkCallback = function()
				PlayerAction.ChangePlayerBirthday(arg_5_0.monthPageIndex_, arg_5_0.dayPageIndex_)
			end,
			MaskCallback = function()
				SetActive(arg_5_0.Go, true)
				arg_5_0.monthScrollHelper_:StartScroll(#var_0_1, arg_5_0.monthPageIndex_, true, false)
				arg_5_0.dayScrollHelper_:StartScroll(var_0_2[arg_5_0.monthPageIndex_], arg_5_0.dayPageIndex_, true, false)
			end,
			CancelCallback = function()
				SetActive(arg_5_0.Go, true)
				arg_5_0.monthScrollHelper_:StartScroll(#var_0_1, arg_5_0.monthPageIndex_, true, false)
				arg_5_0.dayScrollHelper_:StartScroll(var_0_2[arg_5_0.monthPageIndex_], arg_5_0.dayPageIndex_, true, false)
			end
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, JumpTools.Back)
	arg_5_0:AddBtnListener(arg_5_0.bgBtn_, nil, JumpTools.Back)
	arg_5_0.monthScrollHelper_:SetPageChangeHandler(handler(arg_5_0, arg_5_0.OnMonthPageChange))
	arg_5_0.dayScrollHelper_:SetPageChangeHandler(handler(arg_5_0, arg_5_0.OnDayPageChange))
end

function var_0_0.OnChangeBirthday(arg_10_0)
	ShowMessageBox({
		ButtonType = "SingleBtn",
		content = GetTips("TIPS_SET_BIRTHDAY_SURE"),
		OkCallback = JumpTools.Back
	})
end

function var_0_0.OnMonthPageChange(arg_11_0, arg_11_1)
	if arg_11_1 == 0 then
		arg_11_1 = 1
	end

	arg_11_0.monthPageIndex_ = arg_11_1 > #var_0_1 and #var_0_1 or arg_11_1

	if arg_11_0.dayPageIndex_ > var_0_2[arg_11_0.monthPageIndex_] then
		arg_11_0.dayPageIndex_ = 1
	end

	arg_11_0.dayScrollHelper_:StartScroll(var_0_2[arg_11_0.monthPageIndex_], arg_11_0.dayPageIndex_, true, false)
end

function var_0_0.OnDayPageChange(arg_12_0, arg_12_1)
	if arg_12_1 == 0 then
		arg_12_1 = 1
	end

	arg_12_0.dayPageIndex_ = arg_12_1 > var_0_2[arg_12_0.monthPageIndex_] and var_0_2[arg_12_0.monthPageIndex_] or arg_12_1
end

function var_0_0.RefreshMonthItem(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2:RefreshUI(arg_13_1, arg_13_0.monthPageIndex_)
end

function var_0_0.RefreshDayItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:RefreshUI(arg_14_1, arg_14_0.dayPageIndex_)
end

function var_0_0.OnEnter(arg_15_0)
	arg_15_0.monthPageIndex_, arg_15_0.dayPageIndex_ = 1, 1

	arg_15_0.monthScrollHelper_:StartScroll(#var_0_1, arg_15_0.monthPageIndex_, true, false)
	arg_15_0.dayScrollHelper_:StartScroll(var_0_2[arg_15_0.monthPageIndex_], arg_15_0.dayPageIndex_, true, false)
end

function var_0_0.Dispose(arg_16_0)
	arg_16_0.monthScrollHelper_:Dispose()

	arg_16_0.monthScrollHelper_ = nil

	arg_16_0.dayScrollHelper_:Dispose()

	arg_16_0.dayScrollHelper_ = nil

	Object.Destroy(arg_16_0.gameObject_)
	var_0_0.super.Dispose(arg_16_0)
end

return var_0_0
