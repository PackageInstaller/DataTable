local VolumeDemonChallengeMainView = class("VolumeDemonChallengeMainView", DemonChallengeMainView)

function VolumeDemonChallengeMainView:AddUIListener()
	self:AddBtnListener(self.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityId_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("demonChallengeAward", {
			selectId = self.curSelectId_
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(self.activityId_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("volumeDemonChallengeDifficultySelect", {
			selectId = self.curSelectId_
		})
	end)
end

function VolumeDemonChallengeMainView:LevelRenderer(arg_4_1, arg_4_2)
	if self.levelControllerS_[arg_4_1] == nil then
		self.levelControllerS_[arg_4_1] = ControllerUtil.GetController(arg_4_2.transform, "lock")
	end

	self.levelControllerS_[arg_4_1]:SetSelectedState("false")

	self.lockTextS_[arg_4_1] = self:FindCom(typeof(Text), "title/lock/text", arg_4_2.transform)
end

return VolumeDemonChallengeMainView
