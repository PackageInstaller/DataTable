local HeroTeamInfoCoreVerificationChallenge = class("HeroTeamInfoCoreVerificationChallenge", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function HeroTeamInfoCoreVerificationChallenge:UIName()
	return "Widget/System/Formation/Core_Verification/FormationChallengeActivityCoreVerificationHeroUI"
end

function HeroTeamInfoCoreVerificationChallenge:GetHeroList()
	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs((HeroTools.Sort(HeroData:GetHeroList()))) do
		if table.keyof(self.lockHeroList_, iter_2_1) then
			table.insert(var_2_0, iter_2_1)
		else
			table.insert(var_2_1, iter_2_1)
		end
	end

	table.insertto(var_2_0, var_2_1)

	for iter_2_2 = 3, 1, -1 do
		if self.heroTeam_[iter_2_2] ~= 0 then
			table.removebyvalue(var_2_0, self.heroTeam_[iter_2_2])
			table.insert(var_2_0, 1, self.heroTeam_[iter_2_2])
		end
	end

	return var_2_0
end

function HeroTeamInfoCoreVerificationChallenge:GetHeroHeadClass()
	return CoreVerificationChallengeSectionHeroTeamHeadItem
end

function HeroTeamInfoCoreVerificationChallenge:ExtraSorter(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0, var_4_1, var_4_2 = SectionSelectHeroTools.IsInTeam(arg_4_1.id, arg_4_1.trialID, self.heroTeam_, self.heroTrialList_)
	local var_4_3, var_4_4, var_4_5 = SectionSelectHeroTools.IsInTeam(arg_4_2.id, arg_4_2.trialID, self.heroTeam_, self.heroTrialList_)

	self.recommonTeam_ = CoreVerificationChallengeTools.GetModeCfg()[self.stageID_].recommend_team

	local var_4_6 = 0
	local var_4_7 = 0

	for iter_4_0, iter_4_1 in ipairs(self.recommonTeam_) do
		if iter_4_1 == arg_4_1.id then
			var_4_6 = 1

			break
		end
	end

	for iter_4_2, iter_4_3 in ipairs(self.recommonTeam_) do
		if iter_4_3 == arg_4_2.id then
			var_4_7 = 1

			break
		end
	end

	if var_4_6 ~= 0 or var_4_7 ~= 0 then
		if var_4_6 ~= var_4_7 then
			return true, var_4_7 < var_4_6
		else
			return true, var_4_7 < var_4_6
		end
	end

	if var_4_0 ~= var_4_3 then
		if var_4_0 and not var_4_3 then
			return true, true
		elseif not var_4_0 and var_4_3 then
			return true, false
		else
			return true, var_4_2 < var_4_5
		end
	end

	if arg_4_1.trialID ~= 0 or arg_4_2.trialID ~= 0 then
		if arg_4_1.trialID ~= 0 and arg_4_2.trialID ~= 0 then
			if arg_4_3 == 0 and arg_4_1.star ~= arg_4_2.star then
				if self.curOrder_ == "desc" then
					return true, arg_4_1.star > arg_4_2.star
				else
					return true, arg_4_1.star < arg_4_2.star
				end
			end

			local var_4_8 = getHeroPower(arg_4_1.trialID, true)
			local var_4_9 = getHeroPower(arg_4_2.trialID, true)

			if var_4_8 ~= var_4_9 then
				if arg_4_4 == "desc" then
					return true, var_4_9 < var_4_8
				else
					return true, var_4_8 < var_4_9
				end
			else
				return true, arg_4_1.trialID > arg_4_2.trialID
			end
		else
			return true, arg_4_1.trialID > arg_4_2.trialID
		end
	end

	return false, false
end

return HeroTeamInfoCoreVerificationChallenge
