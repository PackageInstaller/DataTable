local var_0_0 = class("CoreActivityPage", import("view.base.BaseSubView"))

function var_0_0.SetShareData(arg_1_0, arg_1_1)
	arg_1_0.shareData = arg_1_1

	return
end

function var_0_0.SetCoreActivityUI(arg_2_0, arg_2_1)
	arg_2_0.coreActivityUI = arg_2_1

	return
end

function var_0_0.SetUIName(arg_3_0, arg_3_1)
	arg_3_0._uiName = arg_3_1

	return
end

function var_0_0.getUIName(arg_4_0)
	return arg_4_0._uiName
end

function var_0_0.Flush(arg_5_0, arg_5_1)
	arg_5_0.activity = arg_5_1

	if arg_5_0:OnDataSetting() then
		return
	end

	if defaultValue(arg_5_0.isFirst, true) then
		arg_5_0.isFirst = false

		arg_5_0:BindPageLink()
		arg_5_0:OnFirstFlush()
	end

	arg_5_0:OnUpdateFlush()

	return
end

function var_0_0.ShowOrHide(arg_6_0, arg_6_1)
	SetActive(arg_6_0._go, arg_6_1)

	if arg_6_1 then
		arg_6_0:emit(ActivityMainScene.GET_PAGE_BGM, arg_6_0.__cname, {})

		if ({}).bgm then
			pg.BgmMgr.GetInstance():Push(ActivityMainScene.__cname, ({}).bgm)
		end

		arg_6_0:OnShowFlush()
	else
		arg_6_0:OnHideFlush()
	end

	return
end

function var_0_0.BindPageLink(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0:GetPageLink()) do
		ActivityConst.PageIdLink[iter_7_1] = arg_7_0.activity.id
	end

	return
end

function var_0_0.SwitchOut(arg_8_0, arg_8_1)
	arg_8_1()

	return
end

function var_0_0.OnInit(arg_9_0)
	return
end

function var_0_0.OnDataSetting(arg_10_0)
	return
end

function var_0_0.GetPageLink(arg_11_0)
	return {}
end

function var_0_0.OnFirstFlush(arg_12_0)
	return
end

function var_0_0.OnUpdateFlush(arg_13_0)
	return
end

function var_0_0.OnHideFlush(arg_14_0)
	return
end

function var_0_0.OnShowFlush(arg_15_0)
	return
end

function var_0_0.OnDestroy(arg_16_0)
	return
end

function var_0_0.UseSecondPage(arg_17_0, arg_17_1)
	return false
end

function var_0_0.IsShowingPopWindow(arg_18_0)
	return false
end

function var_0_0.ClosePopWindow(arg_19_0)
	return
end

function var_0_0.IsShowReminder(arg_20_0)
	return nil
end

return var_0_0
