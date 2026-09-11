local ChallengeRogueTeamOverStatisticsSummarySuitSkillView = class("ChallengeRogueTeamOverStatisticsSummarySuitSkillView", ReduxView)

function ChallengeRogueTeamOverStatisticsSummarySuitSkillView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.emptyController_ = self.controllerEx_:GetController("empty")
	self.unlockSuitSkillController_ = self.controllerEx_:GetController("unlockSuitSkill")
	self.suitSkillItemList_ = {}

	self:RefreshUI()
end

function ChallengeRogueTeamOverStatisticsSummarySuitSkillView:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.suitSkillItemList_) do
		iter_2_1:Dispose()
	end

	self.suitSkillItemList_ = nil

	ChallengeRogueTeamOverStatisticsSummarySuitSkillView.super.Dispose(self)
end

function ChallengeRogueTeamOverStatisticsSummarySuitSkillView:AddListeners()
	return
end

function ChallengeRogueTeamOverStatisticsSummarySuitSkillView:RefreshUI()
	local var_4_0 = ChallengeRogueTeamData:SuitSkillGetID()

	if var_4_0 == 0 then
		self.unlockSuitSkillController_:SetSelectedState("false")
	else
		self.unlockSuitSkillController_:SetSelectedState("true")

		self.suitSkillNameText_.text = RogueTeamItemCfg[ChallengeRogueTeamTools.GetItemIDByCampID(var_4_0)].name
	end

	self.treasureDataList_ = ChallengeRogueTeamTools.TreasureGroup((ChallengeRogueTeamData:TreasureGetList()))

	for iter_4_0, iter_4_1 in ipairs(RogueTeamItemCfg.get_id_list_by_item_temp_type[RogueTeamCfg[ChallengeRogueTeamData:GetCacheTemplateID()].item_temp][ChallengeRogueTeamConst.ITEM_TYPE.SUIT_SKILL]) do
		table.insert(self.suitSkillItemList_, ChallengeRogueTeamOverStatisticsSummarySuitSkillItem.New(self.item_, self.parent_, iter_4_1, table.length(self.treasureDataList_[RogueTeamItemCfg[iter_4_1].camp[1]])))
	end
end

function ChallengeRogueTeamOverStatisticsSummarySuitSkillView:GetHeight()
	return self.rectTransform_.rect.height
end

function ChallengeRogueTeamOverStatisticsSummarySuitSkillView:Show(arg_6_1)
	self.animator_.enabled = arg_6_1

	if arg_6_1 == false then
		self.canvasGroup_.alpha = 0
	end
end

return ChallengeRogueTeamOverStatisticsSummarySuitSkillView
