SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local GuildBossSectionInfoView = class("GuildBossSectionInfoView", SectionBaseView)

function GuildBossSectionInfoView:Init()
	GuildBossSectionInfoView.super.Init(self)
end

function GuildBossSectionInfoView:InitUI()
	GuildBossSectionInfoView.super.InitUI(self)
	self:BindCfgUI()
end

function GuildBossSectionInfoView:OnEnter()
	GuildBossSectionInfoView.super.OnEnter(self)
	self:RegistEventListener(GUILD_EXIT, function()
		self:Go("/home")
	end)

	if self.guildStateController_ then
		self.guildStateController_:SetSelectedState("guildBoss")
	end

	if self.hideFatigueController_ then
		self.hideFatigueController_:SetSelectedState("close")
	end
end

function GuildBossSectionInfoView:UpdateBar()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(GetTips("CLUB_BOSS_DESCRIPE"))
end

function GuildBossSectionInfoView:RefreshData()
	self.cfg_ = BattleStageTools.GetStageCfg(self.params_.sectionType, self.params_.section)
	self.cost = self.cfg_.cost or 0

	GuildBossSectionInfoView.super.RefreshData(self)

	self.lock_ = false
	self.lockTips_ = ""
	self.isFirstClear_ = 0 == 0
	self.drop_lib_id = self.cfg_.drop_lib_id
end

function GuildBossSectionInfoView:RefreshStageInfo()
	self.cfg_ = BattleStageTools.GetStageCfg(self.params_.sectionType, self.params_.section)

	if self.oldCfgID_ ~= self.cfg_.id then
		self.sectionName_.text = GetI18NText(ClubBossPreposeCfg[self.params_.index].name)
		self.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, self.cfg_.background_1))
		self.oldCfgID_ = self.cfg_.id
		self.multiple_ = 1

		local var_7_0 = GuildData:GetGuildBossBuffList()[self.params_.index]

		self.bossBuffDescLabel_.text = GetI18NText(getAffixDesc(var_7_0))
		self.bossBuffNameLabel_.text = GetI18NText(getAffixName(var_7_0))
		self.bossBuffIcon_.sprite = getAffixSprite(var_7_0)

		local var_7_1 = math.min(self.params_.preData.score, ClubBossPreposeCfg[self.params_.index].point_max)

		self.bossProgressImage_.fillAmount = var_7_1 / ClubBossPreposeCfg[self.params_.index].point_max
		self.bossProgressLabel_.text = string.format("%d%%", 100 * var_7_1 / ClubBossPreposeCfg[self.params_.index].point_max)
		self.lastLabel_.text = string.format("%d/%d", GuildData:GetBossLastTime(), GameSetting.club_boss_prepose_max.value[1])
	end
end

function GuildBossSectionInfoView:OnClickBtn()
	if GuildData:GetBossLastTime() <= 0 then
		ShowTips("ERROR_BATTLE_DAILY_BATTLE_TIMES_LIMIT")

		return
	end

	local var_8_0, var_8_1 = GuildData:GetLastTime()

	if var_8_0 ~= "prepose" then
		ShowTips("CLUB_BOSS_PREPOSE_FINISH_TIP")

		return
	end

	if ClubBossPreposeCfg[self.params_.index].point_max <= GuildData:GetPreInfoList()[self.params_.index].score then
		ShowMessageBox({
			isTop = true,
			content = GetTips("CLUB_BOSS_PREPOSE_FINISH_CONFIRM_TIP"),
			OkCallback = function()
				self:GoToSelectHero()
			end,
			CancelCallback = function()
				return
			end
		})
	else
		self:GoToSelectHero()
	end
end

function GuildBossSectionInfoView:GoToSelectHero()
	self:Go("/sectionSelectHero", {
		section = self.params_.section,
		sectionType = self.params_.sectionType,
		activityID = self.params_.activityId,
		multiple = self.multiple_,
		dest = self.params_.index
	})
end

function GuildBossSectionInfoView:OnTop()
	self:UpdateBar()
end

function GuildBossSectionInfoView:OnBehind()
	manager.windowBar:HideBar()
end

function GuildBossSectionInfoView:Dispose()
	GuildBossSectionInfoView.super.Dispose(self)
end

return GuildBossSectionInfoView
