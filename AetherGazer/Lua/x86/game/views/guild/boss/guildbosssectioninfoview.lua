SectionBaseView = import("game.views.sectionInfo.SectionInfoBaseView")

local var_0_0 = class("GuildBossSectionInfoView", SectionBaseView)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
end

function var_0_0.InitUI(arg_2_0)
	var_0_0.super.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0:RegistEventListener(GUILD_EXIT, function()
		arg_3_0:Go("/home")
	end)

	if arg_3_0.guildStateController_ then
		arg_3_0.guildStateController_:SetSelectedState("guildBoss")
	end

	if arg_3_0.hideFatigueController_ then
		arg_3_0.hideFatigueController_:SetSelectedState("close")
	end
end

function var_0_0.UpdateBar(arg_5_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(GetTips("CLUB_BOSS_DESCRIPE"))
end

function var_0_0.RefreshData(arg_6_0)
	arg_6_0.cfg_ = BattleStageTools.GetStageCfg(arg_6_0.params_.sectionType, arg_6_0.params_.section)
	arg_6_0.cost = arg_6_0.cfg_.cost or 0

	var_0_0.super.RefreshData(arg_6_0)

	local var_6_0 = 0

	arg_6_0.lock_ = false
	arg_6_0.lockTips_ = ""
	arg_6_0.isFirstClear_ = var_6_0 == 0
	arg_6_0.drop_lib_id = arg_6_0.cfg_.drop_lib_id
end

function var_0_0.RefreshStageInfo(arg_7_0)
	arg_7_0.cfg_ = BattleStageTools.GetStageCfg(arg_7_0.params_.sectionType, arg_7_0.params_.section)

	if arg_7_0.oldCfgID_ ~= arg_7_0.cfg_.id then
		arg_7_0.sectionName_.text = GetI18NText(ClubBossPreposeCfg[arg_7_0.params_.index].name)
		arg_7_0.sectionImage_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.Stage.path, arg_7_0.cfg_.background_1))
		arg_7_0.oldCfgID_ = arg_7_0.cfg_.id
		arg_7_0.multiple_ = 1

		local var_7_0 = arg_7_0.params_.preData
		local var_7_1 = GuildData:GetGuildBossBuffList()[arg_7_0.params_.index]

		arg_7_0.bossBuffDescLabel_.text = GetI18NText(getAffixDesc(var_7_1))
		arg_7_0.bossBuffNameLabel_.text = GetI18NText(getAffixName(var_7_1))
		arg_7_0.bossBuffIcon_.sprite = getAffixSprite(var_7_1)

		local var_7_2 = ClubBossPreposeCfg[arg_7_0.params_.index].point_max
		local var_7_3 = var_7_0.score
		local var_7_4 = math.min(var_7_3, var_7_2)

		arg_7_0.bossProgressImage_.fillAmount = var_7_4 / var_7_2
		arg_7_0.bossProgressLabel_.text = string.format("%d%%", 100 * var_7_4 / var_7_2)
		arg_7_0.lastLabel_.text = string.format("%d/%d", GuildData:GetBossLastTime(), GameSetting.club_boss_prepose_max.value[1])
	end
end

function var_0_0.OnClickBtn(arg_8_0)
	if GuildData:GetBossLastTime() <= 0 then
		ShowTips("ERROR_BATTLE_DAILY_BATTLE_TIMES_LIMIT")

		return
	end

	local var_8_0, var_8_1 = GuildData:GetLastTime()

	if var_8_0 ~= "prepose" then
		ShowTips("CLUB_BOSS_PREPOSE_FINISH_TIP")

		return
	end

	if ClubBossPreposeCfg[arg_8_0.params_.index].point_max <= GuildData:GetPreInfoList()[arg_8_0.params_.index].score then
		ShowMessageBox({
			isTop = true,
			content = GetTips("CLUB_BOSS_PREPOSE_FINISH_CONFIRM_TIP"),
			OkCallback = function()
				arg_8_0:GoToSelectHero()
			end,
			CancelCallback = function()
				return
			end
		})
	else
		arg_8_0:GoToSelectHero()
	end
end

function var_0_0.GoToSelectHero(arg_11_0)
	arg_11_0:Go("/sectionSelectHero", {
		section = arg_11_0.params_.section,
		sectionType = arg_11_0.params_.sectionType,
		activityID = arg_11_0.params_.activityId,
		multiple = arg_11_0.multiple_,
		dest = arg_11_0.params_.index
	})
end

function var_0_0.OnTop(arg_12_0)
	arg_12_0:UpdateBar()
end

function var_0_0.OnBehind(arg_13_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_14_0)
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
