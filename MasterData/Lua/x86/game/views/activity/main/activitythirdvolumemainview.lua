ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local ActivityThirdVolumeMainView = class("ActivityThirdVolumeMainView", ActivityMainBaseView)

function ActivityThirdVolumeMainView:UIName()
	return "UI/VolumeIIIUI/VolumeMainUI"
end

function ActivityThirdVolumeMainView:InitSubmoduleButton()
	self.submoduleBtnList_ = {
		ActivitySkinTrialSubmoduleItem.New(self.heroSkinGo_, ActivityConst.VOLUME_SKIN_TRIAL_STAGE),
		ActivityHeroTrialItem.New(self.heroTrialGo_, ActivityConst.HADES_HERO_TRIAL_STAGE),
		ActivitySubmoduleItem.New(self.musicGame_, ActivityConst.VOLUME_III_PT),
		ActivitySubmoduleItem.New(self.windGame_, ActivityConst.VOLUME_III_COWBOY),
		ActivitySubmoduleItem.New(self.cakeGame_, ActivityConst.MOONBO),
		ActivitySubmoduleItem.New(self.mainStory_, ActivityConst.MAIN_STORY_CHAPTER_10),
		ActivitySubmoduleItem.New(self.impressionGo_, ActivityConst.VOLUME_SLAYER),
		ActivitySubmoduleItem.New(self.losterStory_, ActivityConst.VOLUME_MATRIX),
		ActivitySubmoduleItem.New(self.puzzleGo_, ActivityConst.ACTIVITY_PUZZLE)
	}
end

function ActivityThirdVolumeMainView:GetActivityID()
	return ActivityConst.THIRD_VOLUME_ACTIVITY
end

function ActivityThirdVolumeMainView:RefreshUI()
	local var_4_0 = ActivityData:GetActivityData(self:GetActivityID())

	self.textTime_.text = string.format("%s\n            %s", manager.time:STimeDescS(var_4_0.startTime, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_4_0.stopTime, "!%Y.%m.%d %H:%M"))
end

function ActivityThirdVolumeMainView:OnEnter()
	ActivityThirdVolumeMainView.super.OnEnter(self)

	if gameContext:IsBack("/thirdVolumeMain") > 0 then
		self.animator_:Play("VolumeMainUI", -1, 1)
		SetActive(self.particleGo_, false)
	else
		SetActive(self.particleGo_, true)
	end

	MoonBoData:FreshTime()
end

function ActivityThirdVolumeMainView:AddListeners()
	self:AddBtnListener(self.shopBtn_, nil, function()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityCfg[self:GetActivityID()].activity_theme]) do
			table.insert(var_7_0, ActivityShopCfg[iter_7_1].shop_id)
		end

		local var_7_1, var_7_2 = ShopTools.IsShopOpen(var_7_0[1])

		if var_7_1 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_7_0[1],
				showShops = var_7_0
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_7_2 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_7_2 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	self:AddBtnListener(self.chessBtn_, nil, function()
		JumpTools.GoToSystem("/warChessStage", {
			firstChapter = 4040501,
			chapterClientID = 404
		}, ViewConst.SYSTEM_ID.WARCHESS)
	end)
end

return ActivityThirdVolumeMainView
