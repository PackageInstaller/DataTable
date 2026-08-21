ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local var_0_0 = class("ActivityMainView_1_6", ActivityMainBaseView)

function var_0_0.UIName(arg_1_0)
	return "UI/EmptyDream/MainUI/EmptyDreamMainUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.shopController_ = ControllerUtil.GetController(arg_2_0.shopBtn_.transform, "name")
end

function var_0_0.InitSubmoduleButton(arg_3_0)
	arg_3_0.travelbtncom_ = {}

	ComponentBinder.GetInstance():BindCfgUI(arg_3_0.travelbtncom_, arg_3_0.leftBtn1_.transform.gameObject)

	arg_3_0.travelbtncom_.skuldLockController_ = ControllerUtil.GetController(arg_3_0.leftBtn1_.transform, "lock")
	arg_3_0.submoduleBtnList_ = {
		ActivityHeroTrialItem.New(arg_3_0.heroTrialGo_, ActivityConst.THOR_HERO_TRIAL),
		ActivitySkinTrialSubmoduleItem.New(arg_3_0.heroSkinGo_, ActivityConst.THOR_SKIN_TRIAL),
		ActivitySubmoduleItem.New(arg_3_0.demonGo_, ActivityConst.DREAM_DEMON_CHALLENGE),
		ActivitySubmoduleItem.New(arg_3_0.leftBtn2_, ActivityConst.SPRING_FESTIVAL_PT),
		ActivitySubmoduleItem.New(arg_3_0.rightBtn3_, ActivityConst.STRATEGY_MATRIX_THOR, function()
			local var_4_0

			if StrategyMatrixData.GetDifficultySelect() == 2 and ActivityData:GetActivityIsOpen(ActivityConst.STRATEGY_MATRIX_THOR_HARD) then
				var_4_0 = ActivityConst.STRATEGY_MATRIX_THOR_HARD
			else
				var_4_0 = ActivityConst.STRATEGY_MATRIX_THOR
			end

			local var_4_1 = StrategyMatrixCfg[var_4_0].enter_story_id or 0

			if var_4_1 ~= 0 and not manager.story:IsStoryPlayed(var_4_1) then
				manager.story:StartStoryById(var_4_1, function(arg_5_0)
					ActivityTools.JumpToSubmodulePage(var_4_0)
				end)
			else
				ActivityTools.JumpToSubmodulePage(var_4_0)
			end
		end)
	}
end

function var_0_0.OnEnter(arg_6_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_6_0:RefreshUI()

	for iter_6_0, iter_6_1 in pairs(arg_6_0.submoduleBtnList_) do
		iter_6_1:OnEnter()
	end

	manager.redPoint:bindUIandKey(arg_6_0.leftBtn1_.transform, RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	arg_6_0:AddTimer()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()

	for iter_7_0, iter_7_1 in pairs(arg_7_0.submoduleBtnList_) do
		iter_7_1:OnExit()
	end

	manager.redPoint:unbindUIandKey(arg_7_0.leftBtn1_.transform, RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	arg_7_0:StopTimer()
end

function var_0_0.GetActivityID(arg_8_0)
	return ActivityConst.ACTIVITY_1_6
end

function var_0_0.RefreshUI(arg_9_0)
	local var_9_0 = ActivityData:GetActivityData(arg_9_0:GetActivityID())
	local var_9_1 = var_9_0.startTime
	local var_9_2 = var_9_0.stopTime

	arg_9_0.timeText1_.text = string.format("%s", manager.time:STimeDescS(var_9_1, "!%Y <size=28>%m.%d</size>"))
	arg_9_0.timeText2_.text = string.format("%s", manager.time:STimeDescS(var_9_2, "!<size=28>%m.%d</size> %H:%M"))

	local var_9_3 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)

	arg_9_0.travelbtncom_.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_9_3.startTime, "!%m.%d"), manager.time:STimeDescS(var_9_3.stopTime, "!%m.%d"))

	arg_9_0.travelbtncom_.skuldLockController_:SetSelectedState(SkuldTravelData:GetSkuldTravelIsOpen() and "false" or "true")
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.subPlotBtn_, nil, function()
		local var_11_0 = 10112
		local var_11_1 = BattleFieldData:GetCacheChapter(var_11_0)
		local var_11_2 = ChapterClientCfg[var_11_0].chapter_list[2]
		local var_11_3 = ChapterCfg[var_11_2].section_id_list[1]

		if BattleStageData:GetStageData()[var_11_3] then
			arg_10_0:Go("/chapterVariantEmptyDream", {
				chapterClientID = var_11_0,
				chapterID = var_11_1
			})
		else
			arg_10_0:Go("/chapterSection", {
				chapterID = var_11_1
			})
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.shopBtn_, nil, function()
		local var_12_0 = ActivityCfg[arg_10_0:GetActivityID()].activity_theme
		local var_12_1 = {}

		for iter_12_0, iter_12_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[var_12_0]) do
			table.insert(var_12_1, ActivityShopCfg[iter_12_1].shop_id)
		end

		local var_12_2, var_12_3 = ShopTools.IsShopOpen(var_12_1[1])

		if var_12_2 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_12_1[1],
				showShops = var_12_1
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_12_3 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_12_3 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	arg_10_0:AddBtnListener(arg_10_0.leftBtn1_, nil, function()
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			JumpTools.GoToSystem("/skuldTravelView")
		else
			local var_13_0 = GameSetting.travel_skuld_unlock.value[1]
			local var_13_1 = getChapterDifficulty(var_13_0)
			local var_13_2, var_13_3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, var_13_0)

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK_EX"), var_13_1, GetI18NText(var_13_2) .. "-" .. GetI18NText(var_13_3)))
		end
	end)
end

function var_0_0.AddTimer(arg_14_0)
	arg_14_0:StopTimer()

	local var_14_0 = ActivityConst.ACTIVITY_1_6_PT_SHOP
	local var_14_1 = ActivityData:GetActivityData(var_14_0).stopTime
	local var_14_2 = var_14_1 - manager.time:GetServerTime()

	if var_14_2 < 0 then
		arg_14_0.shopController_:SetSelectedState("off")

		return
	end

	local var_14_3 = true
	local var_14_4 = 432000

	if var_14_2 <= var_14_4 then
		arg_14_0.shopController_:SetSelectedState("on")

		arg_14_0.shopTimeText_.text = manager.time:GetLostTimeStr2(var_14_1, nil, true)
	else
		arg_14_0.shopController_:SetSelectedState("off")

		var_14_3 = false
	end

	arg_14_0.timer_ = Timer.New(function()
		var_14_2 = var_14_1 - manager.time:GetServerTime()

		if var_14_2 <= var_14_4 then
			if var_14_2 <= 0 then
				arg_14_0.shopController_:SetSelectedState("off")
				arg_14_0:StopTimer()

				return
			end

			if var_14_3 then
				arg_14_0.shopController_:SetSelectedState("on")

				arg_14_0.shopTimeText_.text = manager.time:GetLostTimeStr2(var_14_1, nil, true)
				var_14_3 = false
			end

			arg_14_0.shopTimeText_.text = manager.time:GetLostTimeStr2(var_14_1, nil, true)
		elseif var_14_3 == false then
			arg_14_0.shopController_:SetSelectedState("off")

			var_14_3 = true
		end
	end, 1, -1)

	arg_14_0.timer_:Start()
end

function var_0_0.StopTimer(arg_16_0)
	if arg_16_0.timer_ then
		arg_16_0.timer_:Stop()

		arg_16_0.timer_ = nil
	end
end

return var_0_0
