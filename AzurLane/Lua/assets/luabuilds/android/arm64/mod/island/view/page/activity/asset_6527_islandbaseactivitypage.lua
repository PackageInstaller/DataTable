class = var_0_10000

local var_0_0 = "IslandBaseActivityPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.SetShareData(arg_1_0, arg_1_1)
	arg_1_0.shareData = arg_1_1

	return
end

function var_0_1.SetUIName(arg_2_0, arg_2_1)
	arg_2_0._uiName = arg_2_1

	return
end

function var_0_1.getUIName(arg_3_0)
	return arg_3_0._uiName
end

function var_0_1.Flush(arg_4_0, arg_4_1)
	arg_4_0.activity = arg_4_1

	if arg_4_0:OnDataSetting() then
		return
	end

	defaultValue = var_2

	if var_2(arg_4_0.isFirst, true) then
		arg_4_0.isFirst = false

		arg_4_0:OnFirstFlush()
	end

	arg_4_0:OnUpdateFlush()

	return
end

function var_0_1.ShowOrHide(arg_5_0, arg_5_1)
	SetActive = var_1_10002

	var_1_10002(arg_5_0._go, arg_5_1)

	if arg_5_1 then
		local var_5_0 = {}
		local var_5_1 = arg_5_0
		local var_5_2 = arg_5_0.emit

		ActivityMainScene = var_1_10006

		var_5_2(var_5_1, var_1_10006.GET_PAGE_BGM, arg_5_0.__cname, var_5_0)

		if var_5_0.bgm then
			pg = var_3

			local var_5_3 = var_3.BgmMgr.GetInstance()
			local var_5_4 = var_3.Push

			ActivityMainScene = var_6

			var_5_4(var_5_3, var_6.__cname, var_5_0.bgm)
		end

		arg_5_0:OnShowFlush()
	else
		arg_5_0:OnHideFlush()
	end

	return
end

function var_0_1.SwitchOut(arg_6_0, arg_6_1)
	arg_6_1()

	return
end

function var_0_1.OnInit(arg_7_0)
	return
end

function var_0_1.OnDataSetting(arg_8_0)
	return
end

function var_0_1.OnFirstFlush(arg_9_0)
	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	return
end

function var_0_1.OnHideFlush(arg_11_0)
	return
end

function var_0_1.OnShowFlush(arg_12_0)
	return
end

function var_0_1.OnDestroy(arg_13_0)
	return
end

function var_0_1.UseSecondPage(arg_14_0, arg_14_1)
	return false
end

return var_0_1
