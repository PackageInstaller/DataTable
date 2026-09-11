local ChallengeRogueTeamMechanismBar = class("ChallengeRogueTeamMechanismBar", ReduxView)

function ChallengeRogueTeamMechanismBar:UIName()
	return "Widget/System/Activity_Roulike/item/RoulikeProgresshead"
end

function ChallengeRogueTeamMechanismBar:Init()
	self.gameObject_ = GameObject.Instantiate(Asset.Load(self:UIName()), manager.ui.uiPop.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddUIListener()
	self:AdaptScreen()

	self.itemView_ = ChallengeRogueTeamMechanismItem.New(self.mechanismItem_)
	self.createFlag_ = true
end

function ChallengeRogueTeamMechanismBar:AddUIListener()
	return
end

function ChallengeRogueTeamMechanismBar:PlayAnimator(arg_4_1)
	self.itemView_:PlayAnimator(arg_4_1)
end

function ChallengeRogueTeamMechanismBar:ShowBar()
	if not self.createFlag_ then
		self:Init()
	end

	self:Show(true)
	self.itemView_:RefreshUI()
	self.transform_:SetAsLastSibling()
end

function ChallengeRogueTeamMechanismBar:HideBar()
	self:Show(false)
end

function ChallengeRogueTeamMechanismBar:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

function ChallengeRogueTeamMechanismBar:Dispose()
	ChallengeRogueTeamMechanismBar.super.Dispose(self)

	if self.createFlag_ then
		self.itemView_:Dispose()

		self.itemView_ = nil

		Object.Destroy(self.gameObject_)

		self.transform_ = nil
		self.gameObject_ = nil
		self.createFlag_ = false
	end
end

return ChallengeRogueTeamMechanismBar
