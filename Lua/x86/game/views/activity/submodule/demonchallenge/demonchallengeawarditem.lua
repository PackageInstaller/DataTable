local var_0_0 = class("DemonChallengeAwardItem", ReduxView)
local var_0_1 = import("game.tools.JumpTools")

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddListeners()

	arg_2_0.itemList_ = LuaList.New(handler(arg_2_0, arg_2_0.IndexItem), arg_2_0.itemListGo_, CommonItem)
	arg_2_0.controller_ = ControllerUtil.GetController(arg_2_0.transform_, "conName")
end

function var_0_0.RefreshData(arg_3_0, arg_3_1)
	arg_3_0.itemInfo_ = arg_3_1

	arg_3_0:RefreshUI()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.receiveBtn_, nil, function()
		SubDemonChallengeAction.GetChallengeReward(arg_5_0.itemInfo_.id, arg_5_0.itemInfo_.activityId)
	end)
end

function var_0_0.RefreshUI(arg_7_0)
	local var_7_0 = DemonChallengeCfg.get_id_list_by_activity_id[arg_7_0.itemInfo_.activityId]

	arg_7_0.levelIndex_ = table.indexof(var_7_0, arg_7_0.itemInfo_.id)

	local var_7_1 = ""

	if arg_7_0.levelIndex_ == 1 then
		var_7_1 = GetTips("CLEAR_NORMAL_DIFFICULTY")
	elseif arg_7_0.levelIndex_ == 2 then
		var_7_1 = GetTips("CLEAR_DIFFICULTY")
	else
		var_7_1 = GetTips("CLEAR_EXTREME_DIFFICULTY")
	end

	arg_7_0.Desctext_.text = GetI18NText(var_7_1)

	arg_7_0:RefreshState()
	arg_7_0:RefreshItem()
end

function var_0_0.RefreshState(arg_8_0)
	local var_8_0 = SubDemonChallengeData:GetChallengeInfo(arg_8_0.itemInfo_.activityId).challengeInfo
	local var_8_1 = var_8_0[arg_8_0.levelIndex_].challenge_state
	local var_8_2 = var_8_0[arg_8_0.levelIndex_].reward_state
	local var_8_3

	if var_8_1 == ActivityConst.DEMON_CHALLENGE_STATE.UNFINISHED then
		var_8_3 = 0
	elseif var_8_2 == ActivityConst.DEMON_CHALLENGE_REWARD_STATE.UNRECEIVE then
		var_8_3 = 1
	elseif var_8_2 == ActivityConst.DEMON_CHALLENGE_REWARD_STATE.RECEIVED then
		var_8_3 = 2
	end

	arg_8_0.controller_:SetSelectedState(tostring(var_8_3))
end

function var_0_0.RefreshItem(arg_9_0)
	local var_9_0 = DemonChallengeCfg[arg_9_0.itemInfo_.id].stage_id
	local var_9_1 = BattleHeartDemonStageCfg[var_9_0]

	arg_9_0.rewardCfg_ = getRewardFromDropCfg(var_9_1.drop_lib_id, true)

	arg_9_0.itemList_:StartScroll(#arg_9_0.rewardCfg_)
end

function var_0_0.IndexItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0.rewardCfg_[arg_10_1]

	arg_10_2:RefreshData(rewardToItemTemplate(var_10_0))
	arg_10_2:RegistCallBack(function()
		ShowPopItem(POP_ITEM, var_10_0)
	end)
	arg_10_2:Show(true)
end

function var_0_0.GetItemInfo(arg_12_0)
	return arg_12_0.itemInfo_
end

function var_0_0.Dispose(arg_13_0)
	if arg_13_0.itemList_ then
		arg_13_0.itemList_:Dispose()
	end

	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
