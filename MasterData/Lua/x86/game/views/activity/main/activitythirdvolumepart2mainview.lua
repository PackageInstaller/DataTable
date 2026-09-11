ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local ActivityThirdVolumePart2MainView = class("ActivityThirdVolumePart2MainView", ActivityMainBaseView)

function ActivityThirdVolumePart2MainView:UIName()
	return "UI/VolumeIIIDownUI/MainUI/VolumeIIIDownMainUI"
end

function ActivityThirdVolumePart2MainView:InitSubmoduleButton()
	self.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(self.musicGame_, ActivityConst.VOLUME_MUSIC),
		ActivitySubmoduleItem.New(self.matrixGo_, ActivityConst.OSHINAS_MATRIX),
		ActivitySubmoduleItem.New(self.subPlotGo_, ActivityConst.THIRD_VOLUME_PART_2_SUB_PLOT),
		ActivitySubmoduleItem.New(self.ptGo_, ActivityConst.VOLUME_III_DOWN_PT),
		ActivitySubmoduleItem.New(self.demonGo_, ActivityConst.VOLUME_DEMON),
		ActivitySubmoduleItem.New(self.raceTrialGo_, ActivityConst.VOLUME_RACE_TRIAL),
		ActivityHeroTrialItem.New(self.heroTrialGo_, ActivityConst.OCEANUS_HERO_TRIAL),
		ActivitySkinTrialSubmoduleItem.New(self.heroSkinGo_, ActivityConst.TYR_SKIN_TRIAL),
		ActivitySubmoduleItem.New(self.raceGo_, ActivityConst.ACTIVITY_RACE),
		GuildActivitySubmoduleItem.New(self.guildActivityBtn_.gameObject, ActivityConst.GUILD_ACTIVITY, handler(self, self.OnGuildActivityClick))
	}
end

function ActivityThirdVolumePart2MainView:GetActivityID()
	return ActivityConst.THIRD_VOLUME_PART_2_ACTIVITY
end

function ActivityThirdVolumePart2MainView:RefreshUI()
	self.textTime_.text = string.format("%s", manager.time:STimeDescS(ActivityData:GetActivityData(self:GetActivityID()).stopTime, "!%Y.%m.%d %H:%M"))
end

function ActivityThirdVolumePart2MainView:AddListeners()
	self:AddBtnListener(self.shopBtn_, nil, function()
		local var_6_0 = {}
		local var_6_1 = {}

		for iter_6_0, iter_6_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityCfg[self:GetActivityID()].activity_theme]) do
			table.insert(var_6_0, ActivityShopCfg[iter_6_1].shop_id)

			local var_6_2, var_6_3 = ShopTools.IsShopOpen(ActivityShopCfg[iter_6_1].shop_id)

			if var_6_2 then
				table.insert(var_6_1, ActivityShopCfg[iter_6_1].shop_id)
			end
		end

		if #var_6_1 <= 0 then
			local var_6_4, var_6_5 = ShopTools.IsShopOpen(var_6_0[1])

			if var_6_5 == 2 then
				ShowTips("SHOP_EXPIRED")
			elseif var_6_5 == 3 then
				ShowTips("SHOP_NOT_OPEN")
			end

			return
		end

		JumpTools.GoToSystem("/activityShop", {
			shopId = var_6_1[1],
			showShops = var_6_1
		}, ViewConst.SYSTEM_ID.SHOP)
	end)
	self:AddBtnListener(self.storyBtn_, nil, function()
		BattleFieldData:SetCacheChapterClient(ChapterClientCfg[10111].toggle, 10111)
		JumpTools.OpenPageByJump("/chapterMapContent")
	end)
end

function ActivityThirdVolumePart2MainView:OnGuildActivityClick()
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

	if (GameSetting.activity_club_red_dot_need.value[1] <= GuildActivityData:GetTotalCoinToGet() or nil) and true and manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.GUILD_ACTIVITY_UNGET_COIN, self:GetActivityID())) == 0 then
		GuildActivityAction.SetCoinRedPointClicked(true, self:GetActivityID())
	end
end

return ActivityThirdVolumePart2MainView
