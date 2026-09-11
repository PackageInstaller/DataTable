local NewGuildBossSetAssistantView = class("NewGuildBossSetAssistantView", (import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView")))

function NewGuildBossSetAssistantView:Init()
	NewGuildBossSetAssistantView.super.Init(self)
	self.filterView_:SetExtraSorter(function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = GuildData:CheckCurrentHeroIDIsAssistant(arg_2_0.id) and 1 or 0
		local var_2_1 = GuildData:CheckCurrentHeroIDIsAssistant(arg_2_1.id) and 1 or 0

		if var_2_0 ~= var_2_1 then
			return true, var_2_1 < var_2_0
		end

		return false, false
	end)
end

function NewGuildBossSetAssistantView:HeadRenderer(arg_3_1, arg_3_2)
	NewGuildBossSetAssistantView.super.HeadRenderer(self, arg_3_1, arg_3_2)

	if GuildData:CheckCurrentHeroIDIsAssistant(self.heroDataList_[arg_3_1].id) then
		arg_3_2:SetTeamMarkBg("purple")
		arg_3_2:SetTeamMark(true, GetTips("CURRENT_ASSISTANT"))
	else
		arg_3_2:SetTeamMark(false)
	end
end

function NewGuildBossSetAssistantView:OnEnter()
	NewGuildBossSetAssistantView.super.OnEnter(self)
	self:AddEventListeners()
end

function NewGuildBossSetAssistantView:OnExit()
	NewGuildBossSetAssistantView.super.OnExit(self)
	self:RemoveAllEventListener()
end

function NewGuildBossSetAssistantView:AddEventListeners()
	self:RegistEventListener(GUILD_BOSS_ASSISTANT_HERO_CHANGE, function(arg_7_0)
		self.heroHeadList_:Refresh()
		self:RefreshJoinBtn()
	end)
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)
end

function NewGuildBossSetAssistantView:GetHeroTeam()
	self.lockStateList_ = {
		false,
		false,
		false
	}
end

function NewGuildBossSetAssistantView:OnJoinClick()
	local var_10_0 = GuildData:GetGuildInfo().id

	if GuildData:CheckCurrentHeroIDIsAssistant(self.selectHeroData_.id) then
		GuildAction.SetAssistHero(var_10_0, self.selectHeroData_.id, false)

		return
	end

	if GameSetting.club_boss_assist_max_num.value[1] <= #GuildData:GetCurrentBossAssistantHeroId() then
		ShowTips("CLUB_BOSS_ASSIST_MAX_NUM")
	else
		GuildAction.SetAssistHero(var_10_0, self.selectHeroData_.id, true)
	end
end

function NewGuildBossSetAssistantView:RefreshJoinBtn()
	if GuildData:CheckCurrentHeroIDIsAssistant(self.selectHeroData_.id) then
		self.joinBtnController_:SetSelectedState("currentAssistant")

		self.joinBtn_.interactable = true
	else
		self.joinBtnController_:SetSelectedState("setAssistant")

		self.joinBtn_.interactable = true
	end
end

function NewGuildBossSetAssistantView:IsInTeam(arg_12_1, arg_12_2)
	return GuildData:CheckCurrentHeroIDIsAssistant(arg_12_1), false, -1
end

function NewGuildBossSetAssistantView:GetDefaultHeroData()
	local var_13_0 = GuildData:GetCurrentBossAssistantHeroId()

	if var_13_0 and #var_13_0 > 0 then
		for iter_13_0, iter_13_1 in ipairs(self.heroDataList_) do
			if iter_13_1.id == var_13_0[1] then
				return iter_13_1
			end
		end
	end

	return self.heroDataList_[1]
end

return NewGuildBossSetAssistantView
