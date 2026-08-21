local var_0_0 = import("game.views.activity.Submodule.DemonChallenge.Dream.DreamDemonChallengeMainView")
local var_0_1 = class("XuHeng3rdDemonChallengeMainView", var_0_0)

function var_0_1.InitUI(arg_1_0)
	var_0_1.super.InitUI(arg_1_0)

	arg_1_0.glowController = ControllerUtil.GetController(arg_1_0.glow_, "name")
end

function var_0_1.OnLevelSelect(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_0.curLevelIndex_ ~= arg_2_1 then
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_xinmo_turn", "")
		arg_2_0:ResetAnimator(arg_2_0.roleAni_, "XuHeng3rdDemonLevelUI_shuimo")

		arg_2_0.roleAni_.enabled = true

		arg_2_0.glowController:SetSelectedIndex(arg_2_1 - 1)
	end

	saveData("DemonChallenge" .. "_" .. USER_ID, tostring(arg_2_2), manager.time:GetServerTime())
	var_0_1.super.OnLevelSelect(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
end

function var_0_1.LevelRenderer(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.levelControllerS_[arg_3_1] == nil then
		arg_3_0.levelControllerS_[arg_3_1] = ControllerUtil.GetController(arg_3_2.transform, "lock")
	end

	arg_3_0.levelControllerS_[arg_3_1]:SetSelectedState("false")

	arg_3_0.lockTextS_[arg_3_1] = arg_3_0:FindCom(typeof(Text), "title/lock/text", arg_3_2.transform)

	arg_3_0:AddBtnListener(arg_3_0:FindCom(typeof(Button), "title/lock", arg_3_2.transform), nil, function()
		local var_4_0 = ActivityData:GetActivityData(arg_3_1)

		if var_4_0.stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_4_0.startTime)))
		end
	end)
end

function var_0_1.OnEnter(arg_5_0)
	var_0_1.super.OnEnter(arg_5_0)
	manager.windowBar:SetGameHelpKey("ACTIVITY_DEMON_CHALLENGE_DESCRIPE_2_2")
end

function var_0_1.ResetAnimator(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:Play(arg_6_2, 0, 0)
	arg_6_1:Update(0)

	arg_6_1.enabled = false
end

return var_0_1
