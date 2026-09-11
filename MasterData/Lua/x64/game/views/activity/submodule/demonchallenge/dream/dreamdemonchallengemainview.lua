local DreamDemonChallengeMainView = class("DreamDemonChallengeMainView", (import("game.views.activity.Submodule.DemonChallenge.Volume.VolumeDemonChallengeMainView")))

function DreamDemonChallengeMainView:InitUI()
	DreamDemonChallengeMainView.super.InitUI(self)

	self.difficultyControllerList_ = {}
	self.difficultyControllerList_[1] = ControllerUtil.GetController(self.difficultyContentTrans_, "nor")
	self.difficultyControllerList_[2] = ControllerUtil.GetController(self.difficultyContentTrans_, "diff")
	self.difficultyControllerList_[3] = ControllerUtil.GetController(self.difficultyContentTrans_, "hard")
end

function DreamDemonChallengeMainView:OnLevelSelect(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = ActivityData:GetActivityData(arg_2_2)

	if not var_2_0:IsActivitying() then
		if self.curLevelIndex_ and self.curLevelIndex_ ~= arg_2_1 then
			if var_2_0.stopTime <= manager.time:GetServerTime() then
				ShowTips("TIME_OVER")
			else
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_2_0.startTime)))
			end

			self.tree_:SelectGroup(self.curLevelIndex_)
		else
			self.isNeedExit_ = true
		end

		return
	end

	self:RefreshRewardRedPoint(self.curSelectId_, arg_2_2)

	self.curLevelIndex_ = arg_2_1
	self.curSelectId_ = arg_2_2

	local var_2_1 = getSpriteWithoutAtlas("TextureConfig/" .. DemonChallengeCfg[DemonChallengeTools.GetChildId(self.curSelectId_, 1)].icon)

	if var_2_1 then
		self.roleImg_.sprite = var_2_1
	end

	self:RefreshDescText()
	SubDemonChallengeAction.SetSelectedActivityId(arg_2_2)
	self:RefreshCompleteStatus(arg_2_2)
end

function DreamDemonChallengeMainView:RefreshCompleteStatus(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(SubDemonChallengeData:GetChallengeInfo(arg_3_1).challengeInfo) do
		if iter_3_1.challenge_state == ActivityConst.DEMON_CHALLENGE_STATE.UNFINISHED then
			self.difficultyControllerList_[iter_3_0]:SetSelectedState("off")
		else
			self.difficultyControllerList_[iter_3_0]:SetSelectedState("on")
		end
	end
end

return DreamDemonChallengeMainView
