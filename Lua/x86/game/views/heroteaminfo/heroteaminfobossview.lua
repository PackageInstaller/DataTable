local var_0_0 = import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")
local var_0_1 = class("HeroTeamInfoBossView", var_0_0)

function var_0_1.OnEnter(arg_1_0)
	arg_1_0.bossIndex_ = arg_1_0.params_.bossIndex

	var_0_1.super.OnEnter(arg_1_0)
end

function var_0_1.HeadRenderer(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.HeadRenderer(arg_2_0, arg_2_1, arg_2_2)

	local var_2_0 = arg_2_0.heroDataList_[arg_2_1].id

	arg_2_2:SetHeroLock(table.keyof(arg_2_0.lockHeroList_, var_2_0) ~= nil)
	arg_2_2:SetChallengeFlag(arg_2_0:IsCurrentBossLock(var_2_0))
end

function var_0_1.GetHeroList(arg_3_0)
	local var_3_0 = HeroTools.Sort(HeroData:GetHeroList())
	local var_3_1 = {}
	local var_3_2 = {}
	local var_3_3 = {}
	local var_3_4 = BossTools.GetLockHero()[arg_3_0.bossIndex_]

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if table.keyof(var_3_4, iter_3_1) then
			table.insert(var_3_1, iter_3_1)
		elseif table.keyof(arg_3_0.lockHeroList_, iter_3_1) then
			table.insert(var_3_2, iter_3_1)
		else
			table.insert(var_3_3, iter_3_1)
		end
	end

	table.insertto(var_3_1, var_3_3)
	table.insertto(var_3_1, var_3_2)

	for iter_3_2 = 3, 1, -1 do
		if arg_3_0.heroTeam_[iter_3_2] ~= 0 then
			table.removebyvalue(var_3_1, arg_3_0.heroTeam_[iter_3_2])
			table.insert(var_3_1, 1, arg_3_0.heroTeam_[iter_3_2])
		end
	end

	return var_3_1
end

function var_0_1.IsCurrentBossLock(arg_4_0, arg_4_1)
	local var_4_0 = BossTools.GetLockHero()[arg_4_0.bossIndex_]

	return table.keyof(var_4_0, arg_4_1) ~= nil
end

return var_0_1
