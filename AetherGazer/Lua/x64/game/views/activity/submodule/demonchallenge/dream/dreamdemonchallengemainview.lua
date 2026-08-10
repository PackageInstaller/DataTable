local var_0_0 = import("game.views.activity.Submodule.DemonChallenge.Volume.VolumeDemonChallengeMainView")
local var_0_1 = class("DreamDemonChallengeMainView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)

	arg_1_0.difficultyControllerList_ = {}
	arg_1_0.difficultyControllerList_[1] = ControllerUtil.GetController(arg_1_0.difficultyContentTrans_, "nor")
	arg_1_0.difficultyControllerList_[2] = ControllerUtil.GetController(arg_1_0.difficultyContentTrans_, "diff")
	arg_1_0.difficultyControllerList_[3] = ControllerUtil.GetController(arg_1_0.difficultyContentTrans_, "hard")
end

function var_0_1.OnLevelSelect(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = ActivityData:GetActivityData(arg_2_2)

	if not var_2_0:IsActivitying() then
		if arg_2_0.curLevelIndex_ and arg_2_0.curLevelIndex_ ~= arg_2_1 then
			if var_2_0.stopTime <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			else
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_2_0.startTime)))
			end

			arg_2_0.tree_:SelectGroup(arg_2_0.curLevelIndex_)
		else
			arg_2_0.isNeedExit_ = true
		end

		return
	end

	arg_2_0:RefreshRewardRedPoint(arg_2_0.curSelectId_, arg_2_2)

	arg_2_0.curLevelIndex_ = arg_2_1
	arg_2_0.curSelectId_ = arg_2_2

	local var_2_1 = DemonChallengeTools.GetChildId(arg_2_0.curSelectId_, 1)
	local var_2_2 = getSpriteWithoutAtlas("TextureConfig/" .. DemonChallengeCfg[var_2_1].icon)

	if var_2_2 then
		arg_2_0.roleImg_.sprite = var_2_2
	end

	arg_2_0:RefreshDescText()
	SubDemonChallengeAction.SetSelectedActivityId(arg_2_2)
	arg_2_0:RefreshCompleteStatus(arg_2_2)
end

function var_0_1.RefreshCompleteStatus(arg_3_0, arg_3_1)
	local var_3_0 = SubDemonChallengeData:GetChallengeInfo(arg_3_1)

	for iter_3_0, iter_3_1 in ipairs(var_3_0.challengeInfo) do
		if iter_3_1.challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.UNFINISHED then
			arg_3_0.difficultyControllerList_[iter_3_0]:SetSelectedState("off")
		else
			arg_3_0.difficultyControllerList_[iter_3_0]:SetSelectedState("on")
		end
	end
end

return var_0_1
