local ChallengeRogueTeamOverStatisticsSummaryTeamView = class("ChallengeRogueTeamOverStatisticsSummaryTeamView", ReduxView)

function ChallengeRogueTeamOverStatisticsSummaryTeamView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.heroItemList_ = {}

	self:RefreshUI()
end

function ChallengeRogueTeamOverStatisticsSummaryTeamView:Dispose()
	for iter_2_0, iter_2_1 in ipairs(self.heroItemList_) do
		iter_2_1:Dispose()
	end

	self.heroItemList_ = nil

	ChallengeRogueTeamOverStatisticsSummaryTeamView.super.Dispose(self)
end

function ChallengeRogueTeamOverStatisticsSummaryTeamView:AddListeners()
	return
end

function ChallengeRogueTeamOverStatisticsSummaryTeamView:RefreshUI()
	local var_4_0, var_4_1, var_4_2, var_4_3 = ChallengeRogueTeamData:GetReserveHeroList()
	local var_4_4 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1 ~= 0 then
			table.insert(var_4_4, {
				heroID = iter_4_1,
				trialID = var_4_3[iter_4_0]
			})
		end
	end

	for iter_4_2, iter_4_3 in pairs((ChallengeRogueTeamData:GetHeroList())) do
		if not self:HasInHeroList(iter_4_3.id, 0, var_4_4) then
			table.insert(var_4_4, {
				trialID = 0,
				heroID = iter_4_3.id
			})
		end
	end

	for iter_4_4, iter_4_5 in pairs((ChallengeRogueTeamData:GetUnlockTrailHeroList())) do
		if not self:HasInHeroList(HeroStandardSystemCfg[iter_4_5.tempID].hero_id, iter_4_5.tempID, var_4_4) then
			table.insert(var_4_4, {
				heroID = HeroStandardSystemCfg[iter_4_5.tempID].hero_id,
				trialID = iter_4_5.tempID
			})
		end
	end

	for iter_4_6, iter_4_7 in ipairs(var_4_4) do
		if self.heroItemList_[iter_4_6] == nil then
			self.heroItemList_[iter_4_6] = ChallengeRogueTeamOverStatisticsSummaryTeamItem.New(self.heroItem_, self.parent_)
		end

		self.heroItemList_[iter_4_6]:SetData(iter_4_7)
	end

	for iter_4_8 = #var_4_4 + 1, #self.heroItemList_ do
		self.heroItemList_[iter_4_8]:Show(false)
	end
end

function ChallengeRogueTeamOverStatisticsSummaryTeamView:HasInHeroList(arg_5_1, arg_5_2, arg_5_3)
	for iter_5_0, iter_5_1 in ipairs(arg_5_3) do
		if iter_5_1.heroID == arg_5_1 and iter_5_1.trialID == arg_5_2 then
			return true
		end
	end

	return false
end

function ChallengeRogueTeamOverStatisticsSummaryTeamView:GetHeight()
	return self.rectTransform_.rect.height
end

function ChallengeRogueTeamOverStatisticsSummaryTeamView:Show(arg_7_1)
	self.animator_.enabled = arg_7_1

	if arg_7_1 == false then
		self.canvasGroup_.alpha = 0
	end
end

return ChallengeRogueTeamOverStatisticsSummaryTeamView
