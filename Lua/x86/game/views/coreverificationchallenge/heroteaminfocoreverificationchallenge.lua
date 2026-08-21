local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("HeroTeamInfoCoreVerificationChallenge", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "Widget/System/Formation/Core_Verification/FormationChallengeActivityCoreVerificationHeroUI"
end

function var_0_1.GetHeroList(arg_2_0)
	local var_2_0 = HeroTools.Sort(HeroData:GetHeroList())
	local var_2_1 = {}
	local var_2_2 = {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if table.keyof(arg_2_0.lockHeroList_, iter_2_1) then
			table.insert(var_2_1, iter_2_1)
		else
			table.insert(var_2_2, iter_2_1)
		end
	end

	table.insertto(var_2_1, var_2_2)

	for iter_2_2 = 3, 1, -1 do
		if arg_2_0.heroTeam_[iter_2_2] ~= 0 then
			table.removebyvalue(var_2_1, arg_2_0.heroTeam_[iter_2_2])
			table.insert(var_2_1, 1, arg_2_0.heroTeam_[iter_2_2])
		end
	end

	return var_2_1
end

function var_0_1.GetHeroHeadClass(arg_3_0)
	return CoreVerificationChallengeSectionHeroTeamHeadItem
end

function var_0_1.ExtraSorter(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	local var_4_0, var_4_1, var_4_2 = SectionSelectHeroTools.IsInTeam(arg_4_1.id, arg_4_1.trialID, arg_4_0.heroTeam_, arg_4_0.heroTrialList_)
	local var_4_3, var_4_4, var_4_5 = SectionSelectHeroTools.IsInTeam(arg_4_2.id, arg_4_2.trialID, arg_4_0.heroTeam_, arg_4_0.heroTrialList_)

	arg_4_0.recommonTeam_ = CoreVerificationChallengeTools.GetModeCfg()[arg_4_0.stageID_].recommend_team

	local var_4_6 = 0
	local var_4_7 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.recommonTeam_) do
		if iter_4_1 == arg_4_1.id then
			var_4_6 = 1

			break
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0.recommonTeam_) do
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
				if arg_4_0.curOrder_ == "desc" then
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

return var_0_1
