ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local var_0_0 = class("ActivityThirdVolumeMainView", ActivityMainBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/VolumeMainUI"
end

function var_0_0.InitSubmoduleButton(arg_2_0)
	arg_2_0.submoduleBtnList_ = {
		ActivitySkinTrialSubmoduleItem.New(arg_2_0.heroSkinGo_, ActivityConst.VOLUME_SKIN_TRIAL_STAGE),
		ActivityHeroTrialItem.New(arg_2_0.heroTrialGo_, ActivityConst.HADES_HERO_TRIAL_STAGE),
		ActivitySubmoduleItem.New(arg_2_0.musicGame_, ActivityConst.VOLUME_III_PT),
		ActivitySubmoduleItem.New(arg_2_0.windGame_, ActivityConst.VOLUME_III_COWBOY),
		ActivitySubmoduleItem.New(arg_2_0.cakeGame_, ActivityConst.MOONBO),
		ActivitySubmoduleItem.New(arg_2_0.mainStory_, ActivityConst.MAIN_STORY_CHAPTER_10),
		ActivitySubmoduleItem.New(arg_2_0.impressionGo_, ActivityConst.VOLUME_SLAYER),
		ActivitySubmoduleItem.New(arg_2_0.losterStory_, ActivityConst.VOLUME_MATRIX),
		ActivitySubmoduleItem.New(arg_2_0.puzzleGo_, ActivityConst.ACTIVITY_PUZZLE)
	}
end

function var_0_0.GetActivityID(arg_3_0)
	return ActivityConst.THIRD_VOLUME_ACTIVITY
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = ActivityData:GetActivityData(arg_4_0:GetActivityID())
	local var_4_1 = var_4_0.startTime
	local var_4_2 = var_4_0.stopTime

	arg_4_0.textTime_.text = string.format("%s\n            %s", manager.time:STimeDescS(var_4_1, "!%Y.%m.%d %H:%M"), manager.time:STimeDescS(var_4_2, "!%Y.%m.%d %H:%M"))
end

function var_0_0.OnEnter(arg_5_0)
	var_0_0.super.OnEnter(arg_5_0)

	if gameContext:IsBack("/thirdVolumeMain") > 0 then
		arg_5_0.animator_:Play("VolumeMainUI", -1, 1)
		SetActive(arg_5_0.particleGo_, false)
	else
		SetActive(arg_5_0.particleGo_, true)
	end

	MoonBoData:FreshTime()
end

function var_0_0.AddListeners(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.shopBtn_, nil, function()
		local var_7_0 = ActivityCfg[arg_6_0:GetActivityID()].activity_theme
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_7_0]) do
			table.insert(var_7_1, ActivityShopCfg[iter_7_1].shop_id)
		end

		local var_7_2, var_7_3 = ShopTools.IsShopOpen(var_7_1[1])

		if var_7_2 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_7_1[1],
				showShops = var_7_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_7_3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_7_3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.chessBtn_, nil, function()
		JumpTools.GoToSystem("/warChessStage", {
			firstChapter = 4040501,
			chapterClientID = 404
		}, ViewConst.SYSTEM_ID.WARCHESS)
	end)
end

return var_0_0
