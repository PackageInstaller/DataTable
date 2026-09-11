local ChallengeRogueTeamIllustratedEventItem = class("ChallengeRogueTeamIllustratedEventItem", ReduxView)

function ChallengeRogueTeamIllustratedEventItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selelctController_ = self.controller_:GetController("select")
	self.lockController_ = self.controller_:GetController("lock")
end

function ChallengeRogueTeamIllustratedEventItem:Dispose()
	ChallengeRogueTeamIllustratedEventItem.super.Dispose(self)
end

function ChallengeRogueTeamIllustratedEventItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callback_ then
			self.callback_(self.id_)
		end
	end)
end

function ChallengeRogueTeamIllustratedEventItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1
	self.id_ = arg_5_2
	self.cfg_ = RogueTeamEventCfg[arg_5_2]
	self.image_.sprite = pureGetSpriteWithoutAtlas(self.cfg_.image)
	self.text_.text = self.cfg_.title
end

function ChallengeRogueTeamIllustratedEventItem:SetClickCallBack(arg_6_1)
	self.callback_ = arg_6_1
end

function ChallengeRogueTeamIllustratedEventItem:RefreshSelect(arg_7_1)
	self.selelctController_:SetSelectedState(tostring(self.id_ == arg_7_1))
end

function ChallengeRogueTeamIllustratedEventItem:RefreshUnlock(arg_8_1)
	self.lockController_:SetSelectedState(tostring(arg_8_1))
end

return ChallengeRogueTeamIllustratedEventItem
