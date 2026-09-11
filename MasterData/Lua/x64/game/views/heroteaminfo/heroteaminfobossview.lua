local HeroTeamInfoBossView = class("HeroTeamInfoBossView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function HeroTeamInfoBossView:OnEnter()
	self.bossIndex_ = self.params_.bossIndex

	HeroTeamInfoBossView.super.OnEnter(self)
end

function HeroTeamInfoBossView:HeadRenderer(arg_2_1, arg_2_2)
	HeroTeamInfoBossView.super.HeadRenderer(self, arg_2_1, arg_2_2)

	local var_2_0 = self.heroDataList_[arg_2_1].id

	arg_2_2:SetHeroLock(table.keyof(self.lockHeroList_, self.heroDataList_[arg_2_1].id) ~= nil)
	arg_2_2:SetChallengeFlag(self:IsCurrentBossLock(var_2_0))
end

function HeroTeamInfoBossView:GetHeroList()
	local var_3_0 = {}
	local var_3_1 = {}
	local var_3_2 = {}
	local var_3_3 = BossTools.GetLockHero()[self.bossIndex_]

	for iter_3_0, iter_3_1 in ipairs((HeroTools.Sort(HeroData:GetHeroList()))) do
		if table.keyof(var_3_3, iter_3_1) then
			table.insert(var_3_0, iter_3_1)
		elseif table.keyof(self.lockHeroList_, iter_3_1) then
			table.insert(var_3_1, iter_3_1)
		else
			table.insert(var_3_2, iter_3_1)
		end
	end

	table.insertto(var_3_0, var_3_2)
	table.insertto(var_3_0, var_3_1)

	for iter_3_2 = 3, 1, -1 do
		if self.heroTeam_[iter_3_2] ~= 0 then
			table.removebyvalue(var_3_0, self.heroTeam_[iter_3_2])
			table.insert(var_3_0, 1, self.heroTeam_[iter_3_2])
		end
	end

	return var_3_0
end

function HeroTeamInfoBossView:IsCurrentBossLock(arg_4_1)
	return table.keyof(BossTools.GetLockHero()[self.bossIndex_], arg_4_1) ~= nil
end

return HeroTeamInfoBossView
