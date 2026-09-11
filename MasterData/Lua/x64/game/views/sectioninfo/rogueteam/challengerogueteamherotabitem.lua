local ChallengeRogueTeamHeroTabItem = class("ChallengeRogueTeamHeroTabItem", ReduxView)

function ChallengeRogueTeamHeroTabItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controller_:GetController("select")
	self.allController_ = self.controller_:GetController("all")
end

function ChallengeRogueTeamHeroTabItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callback_ then
			self.callback_(self.index_)
		end
	end)
end

function ChallengeRogueTeamHeroTabItem:Dispose()
	ChallengeRogueTeamHeroTabItem.super.Dispose(self)
end

function ChallengeRogueTeamHeroTabItem:SetData(arg_5_1, arg_5_2)
	self.index_ = arg_5_1

	self.allController_:SetSelectedState(tostring(arg_5_2 == -1))

	if arg_5_2 ~= -1 then
		self.icon_.sprite = HeroTools.GetSkillAttributeIcon(arg_5_2)
		self.name_.text = GetTips(HeroConst.HERO_ATTACK_TYPE_STR[arg_5_2])
	end
end

function ChallengeRogueTeamHeroTabItem:SetClickCallBack(arg_6_1)
	self.callback_ = arg_6_1
end

function ChallengeRogueTeamHeroTabItem:RefreshSelect(arg_7_1)
	self.selectController_:SetSelectedState(tostring(self.index_ == arg_7_1))
end

return ChallengeRogueTeamHeroTabItem
