local var_0_0 = class("ActivityNewbieSignView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = Asset.Load("Widget/System/Activitynewbie/NewbieSignUI")

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.uiList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshReward), arg_1_0.scrollView_, ActivityNewbieSignItem)

	arg_1_0.uiList_:StartScroll(#ActivityNewbieTools.GetSignCfg(), 1)
end

function var_0_0.SetData(arg_2_0)
	local var_2_0 = #ActivityNewbieTools.GetSignCfg()
	local var_2_1 = ActivityNewbieData:GetSignDay()
	local var_2_2 = 0

	if var_2_1 - 2 > 0 then
		var_2_2 = var_2_1 - 2
	end

	if manager.time:GetTodayFreshTime() > ActivityNewbieData:GetSignTimestamp() then
		var_2_2 = var_2_2 + 1
	end

	arg_2_0.uiList_:StartScroll(var_2_0, var_2_2)
end

function var_0_0.Dispose(arg_3_0)
	if arg_3_0.uiList_ then
		arg_3_0.uiList_:Dispose()

		arg_3_0.uiList_ = nil
	end

	Object.Destroy(arg_3_0.gameObject_)

	arg_3_0.transform_ = nil
	arg_3_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	return
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.RefreshReward(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = ActivityNewbieTools.GetSignCfg()[arg_6_1]

	arg_6_2:RefreshUI(var_6_0)
end

return var_0_0
