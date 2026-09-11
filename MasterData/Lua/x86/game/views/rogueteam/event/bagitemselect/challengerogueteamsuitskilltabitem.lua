local ChallengeRogueTeamSuitSkillTabItem = class("ChallengeRogueTeamSuitSkillTabItem", ReduxView)

function ChallengeRogueTeamSuitSkillTabItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.index_ = arg_1_3
	self.selectController_ = self.controller_:GetController("select")
	self.isSuitSkillController_ = self.controller_:GetController("isSuitSkillIcon")
end

function ChallengeRogueTeamSuitSkillTabItem:Dispose()
	ChallengeRogueTeamSuitSkillTabItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamSuitSkillTabItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_DISCARD_SUIT_SKILL, self.index_)
	end)
end

function ChallengeRogueTeamSuitSkillTabItem:SetData(arg_5_1)
	self.campId_ = arg_5_1

	if arg_5_1 == 0 then
		self.num_.text = #ChallengeRogueTeamData:TreasureGetList()

		self.isSuitSkillController_:SetSelectedState("true")
	else
		self.num_.text = #ChallengeRogueTeamData:TreasureGetListByCampList({
			arg_5_1
		})

		self.isSuitSkillController_:SetSelectedState("false")

		self.icon_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetCampIcon(arg_5_1))
	end

	self:Show(true)
end

function ChallengeRogueTeamSuitSkillTabItem:RefreshSelect(arg_6_1)
	self.selectController_:SetSelectedState(tostring(self.campId_ == arg_6_1))
end

function ChallengeRogueTeamSuitSkillTabItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

return ChallengeRogueTeamSuitSkillTabItem
