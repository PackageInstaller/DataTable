local var_0_0 = class("MoonBoRewardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.awardList_ = LuaList.New(handler(arg_3_0, arg_3_0.AwardIndexItem), arg_3_0.listGo_, CommonItem)
end

function var_0_0.AwardIndexItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0.curAwardsList_[arg_4_1]

	arg_4_2:RefreshData(formatReward(var_4_0))

	local var_4_1 = ControllerUtil.GetController(arg_4_2.transform_, "received")

	if MoonBoData:GetRewardIsShow(MoonBoCfg[arg_4_0.levelNum_].reward_level, var_4_0[1]) then
		var_4_1:SetSelectedState("false")
	else
		var_4_1:SetSelectedState("true")
	end

	arg_4_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_4_0)
	end)

	arg_4_2.countText_.text = string.format("%s/%s", MoonBoData:GetCurCanGetRewardCount(MoonBoCfg[arg_4_0.levelNum_].reward_level, var_4_0[1]), MoonBoData:GetCfgRewardsCount(arg_4_0.levelNum_, var_4_0[1]))
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = #MoonBoCfg.get_id_list_by_activity_id[arg_6_2] - arg_6_1 + 1

	arg_6_0.levelNum_ = MoonBoCfg.get_id_list_by_activity_id[arg_6_2][var_6_0]
	arg_6_0.need_.text = MoonBoData:LevelNumToLanguage(arg_6_0.levelNum_ % 100)
	arg_6_0.curAwardsList_ = MoonBoData:GetCfgRewards(arg_6_0.levelNum_)

	arg_6_0.awardList_:StartScroll(#arg_6_0.curAwardsList_)
end

function var_0_0.OnExit(arg_7_0)
	return
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()

	if arg_8_0.awardList_ then
		arg_8_0.awardList_:Dispose()

		arg_8_0.awardList_ = nil
	end

	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
