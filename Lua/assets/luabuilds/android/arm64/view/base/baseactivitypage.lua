local var_0_0 = class("BaseActivityPage", import(".BaseSubView"))

function var_0_0.SetShareData(arg_1_0, arg_1_1)
	arg_1_0.shareData = arg_1_1

	return
end

function var_0_0.SetUIName(arg_2_0, arg_2_1)
	arg_2_0._uiName = arg_2_1

	return
end

function var_0_0.getUIName(arg_3_0)
	return arg_3_0._uiName
end

function var_0_0.Flush(arg_4_0, arg_4_1)
	arg_4_0.activity = arg_4_1

	if arg_4_0:OnDataSetting() then
		return
	end

	if defaultValue(arg_4_0.isFirst, true) then
		arg_4_0.isFirst = false

		arg_4_0:BindPageLink()
		arg_4_0:OnFirstFlush()
	end

	arg_4_0:OnUpdateFlush()

	return
end

function var_0_0.ShowOrHide(arg_5_0, arg_5_1)
	SetActive(arg_5_0._go, arg_5_1)

	if arg_5_1 then
		arg_5_0:emit(ActivityMainScene.GET_PAGE_BGM, arg_5_0.__cname, {})

		if ({}).bgm then
			pg.BgmMgr.GetInstance():Push(ActivityMainScene.__cname, ({}).bgm)
		end

		arg_5_0:OnShowFlush()
	else
		arg_5_0:OnHideFlush()
	end

	return
end

function var_0_0.BindPageLink(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0:GetPageLink()) do
		ActivityConst.PageIdLink[iter_6_1] = arg_6_0.activity.id
	end

	return
end

function var_0_0.SwitchOut(arg_7_0, arg_7_1)
	arg_7_1()

	return
end

function var_0_0.OnInit(arg_8_0)
	return
end

function var_0_0.OnDataSetting(arg_9_0)
	return
end

function var_0_0.GetPageLink(arg_10_0)
	return {}
end

function var_0_0.OnFirstFlush(arg_11_0)
	return
end

function var_0_0.OnUpdateFlush(arg_12_0)
	return
end

function var_0_0.OnHideFlush(arg_13_0)
	return
end

function var_0_0.OnShowFlush(arg_14_0)
	return
end

function var_0_0.OnDestroy(arg_15_0)
	return
end

function var_0_0.UseSecondPage(arg_16_0, arg_16_1)
	return false
end

return var_0_0
