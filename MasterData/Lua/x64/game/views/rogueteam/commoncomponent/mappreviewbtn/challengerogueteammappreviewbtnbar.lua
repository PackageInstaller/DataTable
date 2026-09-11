local ChallengeRogueTeamMapPreviewBtnBar = class("ChallengeRogueTeamMapPreviewBtnBar", ReduxView)

function ChallengeRogueTeamMapPreviewBtnBar:UIName()
	return "Widget/System/Activity_Roulike/RoulikMapFloorBtnUI"
end

function ChallengeRogueTeamMapPreviewBtnBar:Init()
	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:UIName()), manager.ui.uiPop.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddUIListener()
	self:AdaptScreen()

	self.btnView_ = ChallengeRogueTeamMapPreviewBtn.New(self.btnGo_)
	self.createFlag_ = true
end

function ChallengeRogueTeamMapPreviewBtnBar:AddUIListener()
	return
end

function ChallengeRogueTeamMapPreviewBtnBar:ShowBar()
	if not self.createFlag_ then
		self:Init()
	end

	self:Show(true)
	self.btnView_:RefreshUI()
	self.transform_:SetAsLastSibling()
end

function ChallengeRogueTeamMapPreviewBtnBar:RefreshUI()
	if not self.createFlag_ then
		self:Init()
	end

	self.btnView_:RefreshUI()
end

function ChallengeRogueTeamMapPreviewBtnBar:ShowState(arg_6_1)
	self.btnView_:ShowState(arg_6_1)
end

function ChallengeRogueTeamMapPreviewBtnBar:HideBar()
	self:Show(false)
end

function ChallengeRogueTeamMapPreviewBtnBar:Show(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function ChallengeRogueTeamMapPreviewBtnBar:Dispose()
	ChallengeRogueTeamMapPreviewBtnBar.super.Dispose(self)

	if self.createFlag_ then
		self.btnView_:Dispose()

		self.btnView_ = nil

		Object.Destroy(self.gameObject_)

		self.transform_ = nil
		self.gameObject_ = nil
		self.createFlag_ = false
	end
end

return ChallengeRogueTeamMapPreviewBtnBar
