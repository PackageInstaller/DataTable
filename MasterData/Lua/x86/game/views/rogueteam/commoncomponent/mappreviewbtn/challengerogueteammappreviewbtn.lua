local ChallengeRogueTeamMapPreviewBtn = class("ChallengeRogueTeamMapPreviewBtn", ReduxView)

function ChallengeRogueTeamMapPreviewBtn:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddUIListener()

	self.mapControllerEx_ = self.controllerEx_:GetController("map")
	self.eyeControllerEx_ = self.controllerEx_:GetController("eye")
	self.canClick_ = false
end

function ChallengeRogueTeamMapPreviewBtn:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.canClick_ == false then
			return
		end

		if gameContext:IsOpenRoute("challengeRogueTeamMapPreview") then
			self:Back()

			return
		end

		JumpTools.OpenPageByJump("challengeRogueTeamMapPreview")
	end)
end

function ChallengeRogueTeamMapPreviewBtn:RefreshUI()
	self.nameText_.text = ChallengeRogueTeamTools.GetFloorName()
end

function ChallengeRogueTeamMapPreviewBtn:ShowState(arg_5_1)
	if arg_5_1 == ChallengeRogueTeamConst.MAP_BTN_WINDOW.MAIN then
		self.canClick_ = false

		self.mapControllerEx_:SetSelectedState("text")
	else
		if arg_5_1 == ChallengeRogueTeamConst.MAP_BTN_WINDOW.PREVIEW then
			self.eyeControllerEx_:SetSelectedState("off")
		else
			self.eyeControllerEx_:SetSelectedState("on")
		end

		self.mapControllerEx_:SetSelectedState("eye")

		self.canClick_ = true
	end
end

function ChallengeRogueTeamMapPreviewBtn:Dispose()
	ChallengeRogueTeamMapPreviewBtn.super.Dispose(self)
end

return ChallengeRogueTeamMapPreviewBtn
