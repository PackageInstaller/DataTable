local NewGuildActivitySPTeamInfoView = class("NewGuildActivitySPTeamInfoView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function NewGuildActivitySPTeamInfoView:InitUI()
	NewGuildActivitySPTeamInfoView.super.InitUI(self)

	self.energyItem_ = GuildActivitySPTeamInfoEnergyItemView.New((Object.Instantiate(Asset.Load("UI/GuildActivitySPUI/items/spenergy"), self.extensionContainer_)))
end

function NewGuildActivitySPTeamInfoView:HeadRenderer(arg_2_1, arg_2_2)
	NewGuildActivitySPTeamInfoView.super.HeadRenderer(self, arg_2_1, arg_2_2)
	arg_2_2:SetEnergy(true, GuildActivitySPData:GetHeroFatigue(self.heroDataList_[arg_2_1].id))
end

function NewGuildActivitySPTeamInfoView:RefreshInfoBtn()
	SetActive(self.infoBtn_.gameObject, false)
end

function NewGuildActivitySPTeamInfoView:GetHeroList()
	local var_4_0 = {}
	local var_4_1 = HeroData:GetHeroList()

	for iter_4_0, iter_4_1 in ipairs(GuildActivitySPData:GetFightHeroList()) do
		if var_4_1[iter_4_1.id] then
			var_4_0[iter_4_1.id] = var_4_1[iter_4_1.id]
		end
	end

	return (HeroTools.Sort(var_4_0))
end

function NewGuildActivitySPTeamInfoView:UpdateHeroView()
	NewGuildActivitySPTeamInfoView.super.UpdateHeroView(self)
	self.energyItem_:SetCurrent(true)
	self.energyItem_:SetData(GameSetting.activity_club_sp_hero_fatigue_max.value[1], GuildActivitySPData:GetHeroFatigue(self.selectHeroData_.id))
end

function NewGuildActivitySPTeamInfoView:Dispose()
	if self.energyItem_ then
		self.energyItem_:Dispose()

		self.energyItem_ = nil
	end

	NewGuildActivitySPTeamInfoView.super.Dispose(self)
end

return NewGuildActivitySPTeamInfoView
