local var_0_0 = class("ActivityNoobSignView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Asset.Load(arg_1_0:GetUIName(arg_1_2))

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.uiList_ = LuaList.New(handler(arg_1_0, arg_1_0.RefreshReward), arg_1_0.scrollView_, ActivityNoobSignItem)
	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
end

function var_0_0.GetUIName(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return "Widget/System/Activitynewbie/NewbieSignUI1_new"
	else
		return "Widget/System/Activitynewbie/NewbieSignUI2_new"
	end
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

function var_0_0.SetData(arg_6_0, arg_6_1)
	arg_6_0.pageIndex_ = arg_6_1

	local var_6_0 = ActivityNoobData:GetSignDay()
	local var_6_1 = math.floor(var_6_0 / 7) + 1

	if arg_6_0.lockController_ ~= nil then
		arg_6_0.lockController_:SetSelectedIndex(var_6_1 < arg_6_0.pageIndex_ and 1 or 0)
	end

	local var_6_2 = ActivityNewbieTools.GetSignCfg()

	arg_6_0.rewardList_ = {}

	local var_6_3 = (arg_6_1 - 1) * 7 + 1
	local var_6_4 = var_6_3 + 7

	for iter_6_0 = var_6_3, var_6_4 - 1 do
		arg_6_0.rewardList_[#arg_6_0.rewardList_ + 1] = var_6_2[iter_6_0]
	end

	arg_6_0.uiList_:StartScroll(#arg_6_0.rewardList_)
end

function var_0_0.RefreshReward(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.rewardList_[arg_7_1]

	arg_7_2:RefreshUI(var_7_0, arg_7_0.pageIndex_, arg_7_1)
end

return var_0_0
