local var_0_0 = class("VolumeDemonChallengeMainView", DemonChallengeMainView)

function var_0_0.AddUIListener(arg_1_0)
	arg_1_0:AddBtnListener(arg_1_0.rewardBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_1_0.activityId_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("demonChallengeAward", {
			selectId = arg_1_0.curSelectId_
		})
	end)
	arg_1_0:AddBtnListener(arg_1_0.startBtn_, nil, function()
		if not ActivityData:GetActivityIsOpen(arg_1_0.activityId_) then
			ShowTips("TIME_OVER")

			return
		end

		JumpTools.OpenPageByJump("volumeDemonChallengeDifficultySelect", {
			selectId = arg_1_0.curSelectId_
		})
	end)
end

function var_0_0.LevelRenderer(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.levelControllerS_[arg_4_1] == nil then
		arg_4_0.levelControllerS_[arg_4_1] = ControllerUtil.GetController(arg_4_2.transform, "lock")
	end

	arg_4_0.levelControllerS_[arg_4_1]:SetSelectedState("false")

	arg_4_0.lockTextS_[arg_4_1] = arg_4_0:FindCom(typeof(Text), "title/lock/text", arg_4_2.transform)
end

return var_0_0
