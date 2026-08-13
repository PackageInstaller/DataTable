class = var_0_10000

local var_0_0 = "CoreActivityPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

function var_0_1.SetShareData(arg_1_0, arg_1_1)
	arg_1_0.shareData = arg_1_1

	return
end

function var_0_1.SetCoreActivityUI(arg_2_0, arg_2_1)
	arg_2_0.coreActivityUI = arg_2_1

	return
end

function var_0_1.SetUIName(arg_3_0, arg_3_1)
	arg_3_0._uiName = arg_3_1

	return
end

function var_0_1.getUIName(arg_4_0)
	return arg_4_0._uiName
end

function var_0_1.Flush(arg_5_0, arg_5_1)
	arg_5_0.activity = arg_5_1

	if arg_5_0:OnDataSetting() then
		return
	end

	defaultValue = var_2

	if var_2(arg_5_0.isFirst, true) then
		arg_5_0.isFirst = false

		arg_5_0:BindPageLink()
		arg_5_0:OnFirstFlush()
	end

	arg_5_0:OnUpdateFlush()

	return
end

function var_0_1.ShowOrHide(arg_6_0, arg_6_1)
	SetActive = var_1_10002

	var_1_10002(arg_6_0._go, arg_6_1)

	if arg_6_1 then
		local var_6_0 = {}
		local var_6_1 = arg_6_0
		local var_6_2 = arg_6_0.emit

		ActivityMainScene = var_1_10005

		var_6_2(var_6_1, var_1_10005.GET_PAGE_BGM, arg_6_0.__cname, var_6_0)

		if var_6_0.bgm then
			pg = var_3

			local var_6_3 = var_3.BgmMgr.GetInstance()
			local var_6_4 = var_3.Push

			ActivityMainScene = var_5

			var_6_4(var_6_3, var_5.__cname, var_6_0.bgm)
		end

		arg_6_0:OnShowFlush()
	else
		arg_6_0:OnHideFlush()
	end

	return
end

function var_0_1.BindPageLink(arg_7_0)
	ipairs = var_1_10001

	for iter_7_0, iter_7_1 in var_1_10001(arg_7_0:GetPageLink()) do
		ActivityConst = var_1_10006
		var_1_10006 = var_1_10006.PageIdLink
		var_1_10006[iter_7_1] = arg_7_0.activity.id
	end

	return
end

function var_0_1.SwitchOut(arg_8_0, arg_8_1)
	arg_8_1()

	return
end

function var_0_1.OnInit(arg_9_0)
	return
end

function var_0_1.OnDataSetting(arg_10_0)
	return
end

function var_0_1.GetPageLink(arg_11_0)
	return {}
end

function var_0_1.OnFirstFlush(arg_12_0)
	return
end

function var_0_1.OnUpdateFlush(arg_13_0)
	return
end

function var_0_1.OnHideFlush(arg_14_0)
	return
end

function var_0_1.OnShowFlush(arg_15_0)
	return
end

function var_0_1.OnDestroy(arg_16_0)
	return
end

function var_0_1.UseSecondPage(arg_17_0, arg_17_1)
	return false
end

function var_0_1.IsShowingPopWindow(arg_18_0)
	return false
end

function var_0_1.ClosePopWindow(arg_19_0)
	return
end

function var_0_1.IsShowReminder(arg_20_0)
	return nil
end

return var_0_1
