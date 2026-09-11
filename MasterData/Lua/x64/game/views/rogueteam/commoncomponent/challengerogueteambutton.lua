local ChallengeRogueTeamButton = class("ChallengeRogueTeamButton", ReduxView)

ChallengeRogueTeamButton.ENABLE_CLICK = "01"
ChallengeRogueTeamButton.CANCLE = "02"
ChallengeRogueTeamButton.DISENABLE_CLICK = "03"
ChallengeRogueTeamButton.CONFIRM_EXIT = "04"
ChallengeRogueTeamButton.FINISH = "05"
ChallengeRogueTeamButton.GOLD_COLOR = "06"
ChallengeRogueTeamButton.BUTTON_TEXT = {
	RECUIT_HERO = "ROGUE_TEAM_BUTTON_RECRUIT_HERO",
	CONFIRM_EXIT = "ROGUE_TEAM_BUTTON_CONFIRM_EXIT",
	CONFIRM = "ROGUE_TEAM_BUTTON_CONFIRM",
	CLEAN_MISSION = "ROGUE_TEAM_BUTTON_CLEAN_MISSION",
	MAKE_CHOICE = "ROGUE_TEAM_BUTTON_MAKE_CHOICE",
	CONFIRM_ORDER = "ROGUE_TEAM_BUTTON_CONFIRM_ORDER",
	EXIT = "ROGUE_TEAM_BUTTON_EXIT"
}

function ChallengeRogueTeamButton:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.controllerEx_:GetController("default0")
	self.clickHandler_ = arg_1_2
end

function ChallengeRogueTeamButton:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if self.clickHandler_ then
			self.clickHandler_()
		end
	end)
end

function ChallengeRogueTeamButton:Dispose()
	ChallengeRogueTeamButton.super.Dispose(self)
end

function ChallengeRogueTeamButton:RefreshBtnState(arg_5_1, arg_5_2)
	self.stateController_:SetSelectedState(arg_5_1)

	self.text_.text = GetTips(arg_5_2 or ChallengeRogueTeamButton.BUTTON_TEXT.CONFIRM)

	if self.buttonTextType_ ~= arg_5_2 then
		self.textAnimator_:Play("UI_text_cx", -1, 0)
		self.textAnimator_:Update(0)
	end

	self.buttonTextType_ = arg_5_2
end

return ChallengeRogueTeamButton
