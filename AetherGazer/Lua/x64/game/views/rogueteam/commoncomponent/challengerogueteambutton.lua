local var_0_0 = class("ChallengeRogueTeamButton", ReduxView)

var_0_0.ENABLE_CLICK = "01"
var_0_0.CANCLE = "02"
var_0_0.DISENABLE_CLICK = "03"
var_0_0.CONFIRM_EXIT = "04"
var_0_0.FINISH = "05"
var_0_0.GOLD_COLOR = "06"
var_0_0.BUTTON_TEXT = {
	RECUIT_HERO = "ROGUE_TEAM_BUTTON_RECRUIT_HERO",
	CONFIRM_EXIT = "ROGUE_TEAM_BUTTON_CONFIRM_EXIT",
	CONFIRM = "ROGUE_TEAM_BUTTON_CONFIRM",
	CLEAN_MISSION = "ROGUE_TEAM_BUTTON_CLEAN_MISSION",
	MAKE_CHOICE = "ROGUE_TEAM_BUTTON_MAKE_CHOICE",
	CONFIRM_ORDER = "ROGUE_TEAM_BUTTON_CONFIRM_ORDER",
	EXIT = "ROGUE_TEAM_BUTTON_EXIT"
}

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.stateController_ = arg_1_0.controllerEx_:GetController("default0")
	arg_1_0.clickHandler_ = arg_1_2
end

function var_0_0.AddListeners(arg_2_0)
	arg_2_0:AddBtnListener(arg_2_0.button_, nil, function()
		if arg_2_0.clickHandler_ then
			arg_2_0.clickHandler_()
		end
	end)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
end

function var_0_0.RefreshBtnState(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.stateController_:SetSelectedState(arg_5_1)

	arg_5_0.text_.text = GetTips(arg_5_2 or var_0_0.BUTTON_TEXT.CONFIRM)

	if arg_5_0.buttonTextType_ ~= arg_5_2 then
		arg_5_0.textAnimator_:Play("UI_text_cx", -1, 0)
		arg_5_0.textAnimator_:Update(0)
	end

	arg_5_0.buttonTextType_ = arg_5_2
end

return var_0_0
