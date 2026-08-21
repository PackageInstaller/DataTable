local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("HeroTeamInfoCoreVerificationView", var_0_0)

function var_0_1.GetHeroList(arg_1_0)
	local var_1_0 = HeroTools.Sort(HeroData:GetHeroList())
	local var_1_1 = {}
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if table.keyof(arg_1_0.lockHeroList_, iter_1_1) then
			table.insert(var_1_1, iter_1_1)
		else
			table.insert(var_1_2, iter_1_1)
		end
	end

	table.insertto(var_1_1, var_1_2)

	for iter_1_2 = 3, 1, -1 do
		if arg_1_0.heroTeam_[iter_1_2] ~= 0 then
			table.removebyvalue(var_1_1, arg_1_0.heroTeam_[iter_1_2])
			table.insert(var_1_1, 1, arg_1_0.heroTeam_[iter_1_2])
		end
	end

	return var_1_1
end

function var_0_1.AddHero(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = CoreVerificationData:GetLockHeroByInfoID(arg_2_0.params_.activityID, true)
	local var_2_1 = #var_2_0

	for iter_2_0, iter_2_1 in pairs(arg_2_4) do
		if not table.keyof(var_2_0, iter_2_1) and iter_2_1 ~= 0 and iter_2_0 ~= arg_2_1 then
			var_2_1 = var_2_1 + 1
		end
	end

	if arg_2_2 ~= 0 and not table.keyof(var_2_0, arg_2_2) then
		var_2_1 = var_2_1 + 1
	end

	if var_2_1 > 6 then
		ShowTips(GetTips("ACTIVITY_CORE_VERIFICATION_HERO_LOCKED"))

		return false
	end

	arg_2_4[arg_2_1] = arg_2_2
	arg_2_5[arg_2_1] = arg_2_3

	return true
end

return var_0_1
