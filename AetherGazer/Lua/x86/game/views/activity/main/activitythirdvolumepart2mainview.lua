ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local var_0_0 = class("ActivityThirdVolumePart2MainView", ActivityMainBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIDownUI/MainUI/VolumeIIIDownMainUI"
end

function var_0_0.InitSubmoduleButton(arg_2_0)
	arg_2_0.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(arg_2_0.musicGame_, ActivityConst.VOLUME_MUSIC),
		ActivitySubmoduleItem.New(arg_2_0.matrixGo_, ActivityConst.OSHINAS_MATRIX),
		ActivitySubmoduleItem.New(arg_2_0.subPlotGo_, ActivityConst.THIRD_VOLUME_PART_2_SUB_PLOT),
		ActivitySubmoduleItem.New(arg_2_0.ptGo_, ActivityConst.VOLUME_III_DOWN_PT),
		ActivitySubmoduleItem.New(arg_2_0.demonGo_, ActivityConst.VOLUME_DEMON),
		ActivitySubmoduleItem.New(arg_2_0.raceTrialGo_, ActivityConst.VOLUME_RACE_TRIAL),
		ActivityHeroTrialItem.New(arg_2_0.heroTrialGo_, ActivityConst.OCEANUS_HERO_TRIAL),
		ActivitySkinTrialSubmoduleItem.New(arg_2_0.heroSkinGo_, ActivityConst.TYR_SKIN_TRIAL),
		ActivitySubmoduleItem.New(arg_2_0.raceGo_, ActivityConst.ACTIVITY_RACE),
		GuildActivitySubmoduleItem.New(arg_2_0.guildActivityBtn_.gameObject, ActivityConst.GUILD_ACTIVITY, handler(arg_2_0, arg_2_0.OnGuildActivityClick))
	}
end

function var_0_0.GetActivityID(arg_3_0)
	return ActivityConst.THIRD_VOLUME_PART_2_ACTIVITY
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = ActivityData:GetActivityData(arg_4_0:GetActivityID())
	local var_4_1 = var_4_0.startTime
	local var_4_2 = var_4_0.stopTime

	arg_4_0.textTime_.text = string.format("%s", manager.time:STimeDescS(var_4_2, "!%Y.%m.%d %H:%M"))
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.shopBtn_, nil, function()
		local var_6_0 = ActivityCfg[arg_5_0:GetActivityID()].activity_theme
		local var_6_1 = {}
		local var_6_2 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_6_0]) do
			table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)

			local var_6_3, var_6_4 = ShopTools.IsShopOpen(ActivityShopCfg[iter_6_1].shop_id)

			if var_6_3 then
				table.insert(var_6_2, ActivityShopCfg[iter_6_1].shop_id)
			end
		end

		if #var_6_2 <= 0 then
			local var_6_5, var_6_6 = ShopTools.IsShopOpen(var_6_1[1])

			if var_6_6 == 2 then
				ShowTips("SHOP_EXPIRED")
			elseif var_6_6 == 3 then
				ShowTips("SHOP_NOT_OPEN")
			end

			return
		end

		JumpTools.GoToSystem("/activityShop", {
			shopId = var_6_2[1],
			showShops = var_6_2
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	arg_5_0:AddBtnListener(arg_5_0.storyBtn_, nil, function()
		local var_7_0 = 10111

		BattleFieldData:SetCacheChapterClient(ChapterClientCfg[var_7_0].toggle, var_7_0)
		JumpTools.OpenPageByJump("/chapterMapContent")
	end)
end

function var_0_0.OnGuildActivityClick(arg_8_0)
	local var_8_0 = GuildActivityData:HaveRegister()

	if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_ACTIVITY_START) then
		if var_8_0 then
			StartGuildActivity(GuildActivityData:GetCurrentGrid())
		else
			JumpTools.OpenPageByJump("/guildActivitySignUp", {})
		end
	else
		JumpTools.OpenPageByJump("/guildActivitySignUp", {})
	end

	if not var_8_0 and manager.redPoint:getTipValue(RedPointConst.GUILD_ACTIVITY_UNREGISTER) == 1 then
		GuildActivityAction.SetUnRegisterRedPointClicked(true)
	end

	local var_8_1 = GameSetting.activity_club_red_dot_need.value[1]
	local var_8_2 = false

	if var_8_1 <= GuildActivityData:GetTotalCoinToGet() then
		var_8_2 = true
	end

	if var_8_2 and manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_UNGET_COIN, arg_8_0:GetActivityID())) == 0 then
		GuildActivityAction.SetCoinRedPointClicked(true, arg_8_0:GetActivityID())
	end
end

return var_0_0
