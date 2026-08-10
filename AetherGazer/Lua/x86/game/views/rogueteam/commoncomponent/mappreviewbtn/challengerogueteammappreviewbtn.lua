local var_0_0 = class("ChallengeRogueTeamMapPreviewBtn", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddUIListener()

	arg_1_0.mapControllerEx_ = arg_1_0.controllerEx_:GetController("map")
	arg_1_0.eyeControllerEx_ = arg_1_0.controllerEx_:GetController("eye")
	arg_1_0.canClick_ = false
end

function var_0_0.AddUIListener(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.btn_, nil, function()
		if arg_2_0.canClick_ == false then
			return
		end

		if gameContext:IsOpenRoute("challengeRogueTeamMapPreview") then
			arg_2_0:Back()

			return
		end

		JumpTools.OpenPageByJump("challengeRogueTeamMapPreview")
	end)
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.nameText_.text = ChallengeRogueTeamTools.GetFloorName()
end

function var_0_0.ShowState(arg_5_0, arg_5_1)
	if arg_5_1 == ChallengeRogueTeamConst.MAP_BTN_WINDOW.MAIN then
		arg_5_0.canClick_ = false

		arg_5_0.mapControllerEx_:SetSelectedState("text")
	else
		if arg_5_1 == ChallengeRogueTeamConst.MAP_BTN_WINDOW.PREVIEW then
			arg_5_0.eyeControllerEx_:SetSelectedState("off")
		else
			arg_5_0.eyeControllerEx_:SetSelectedState("on")
		end

		arg_5_0.mapControllerEx_:SetSelectedState("eye")

		arg_5_0.canClick_ = true
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
