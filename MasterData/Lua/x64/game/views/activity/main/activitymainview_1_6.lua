ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")

local ActivityMainView_1_6 = class("ActivityMainView_1_6", ActivityMainBaseView)

function ActivityMainView_1_6:UIName()
	return "UI/EmptyDream/MainUI/EmptyDreamMainUI"
end

function ActivityMainView_1_6:Init()
	ActivityMainView_1_6.super.Init(self)

	self.shopController_ = ControllerUtil.GetController(self.shopBtn_.transform, "name")
end

function ActivityMainView_1_6:InitSubmoduleButton()
	self.travelbtncom_ = {}

	ComponentBinder.GetInstance():BindCfgUI(self.travelbtncom_, self.leftBtn1_.transform.gameObject)

	self.travelbtncom_.skuldLockController_ = ControllerUtil.GetController(self.leftBtn1_.transform, "lock")
	self.submoduleBtnList_ = {
		ActivityHeroTrialItem.New(self.heroTrialGo_, ActivityConst.THOR_HERO_TRIAL),
		ActivitySkinTrialSubmoduleItem.New(self.heroSkinGo_, ActivityConst.THOR_SKIN_TRIAL),
		ActivitySubmoduleItem.New(self.demonGo_, ActivityConst.DREAM_DEMON_CHALLENGE),
		ActivitySubmoduleItem.New(self.leftBtn2_, ActivityConst.SPRING_FESTIVAL_PT),
		ActivitySubmoduleItem.New(self.rightBtn3_, ActivityConst.STRATEGY_MATRIX_THOR, function()
			local var_4_0 = StrategyMatrixData.GetDifficultySelect() == 2 and ActivityData:GetActivityIsOpen(ActivityConst.STRATEGY_MATRIX_THOR_HARD) and ActivityConst.STRATEGY_MATRIX_THOR_HARD or ActivityConst.STRATEGY_MATRIX_THOR
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

function ActivityMainView_1_6:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self:RefreshUI()

	for iter_6_0, iter_6_1 in pairs(self.submoduleBtnList_) do
		iter_6_1:OnEnter()
	end

	manager.redPoint:bindUIandKey(self.leftBtn1_.transform, RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	self:AddTimer()
end

function ActivityMainView_1_6:OnExit()
	manager.windowBar:HideBar()

	for iter_7_0, iter_7_1 in pairs(self.submoduleBtnList_) do
		iter_7_1:OnExit()
	end

	manager.redPoint:unbindUIandKey(self.leftBtn1_.transform, RedPointConst.TRAVEL_SKULD_ACTIVITY .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
	self:StopTimer()
end

function ActivityMainView_1_6:GetActivityID()
	return ActivityConst.ACTIVITY_1_6
end

function ActivityMainView_1_6:RefreshUI()
	local var_9_0 = ActivityData:GetActivityData(self:GetActivityID())

	self.timeText1_.text = string.format("%s", manager.time:STimeDescS(var_9_0.startTime, "!%Y <size=28>%m.%d</size>"))
	self.timeText2_.text = string.format("%s", manager.time:STimeDescS(var_9_0.stopTime, "!<size=28>%m.%d</size> %H:%M"))

	local var_9_1 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)

	self.travelbtncom_.textTime_.text = string.format("%s-%s", manager.time:STimeDescS(var_9_1.startTime, "!%m.%d"), manager.time:STimeDescS(var_9_1.stopTime, "!%m.%d"))

	self.travelbtncom_.skuldLockController_:SetSelectedState(SkuldTravelData:GetSkuldTravelIsOpen() and "false" or "true")
end

function ActivityMainView_1_6:AddListeners()
	self:AddBtnListener(self.subPlotBtn_, nil, function()
		local var_11_0 = BattleFieldData:GetCacheChapter(10112)

		if BattleStageData:GetStageData()[ChapterCfg[ChapterClientCfg[10112].chapter_list[2]].section_id_list[1]] then
			self:Go("/chapterVariantEmptyDream", {
				chapterClientID = 10112,
				chapterID = var_11_0
			})
		else
			self:Go("/chapterSection", {
				chapterID = var_11_0
			})
		end
	end)
	self:AddBtnListener(self.shopBtn_, nil, function()
		local var_12_0 = {}

		for iter_12_0, iter_12_1 in ipairs(ActivityShopCfg.get_id_list_by_activity_theme[ActivityCfg[self:GetActivityID()].activity_theme]) do
			table.insert(var_12_0, ActivityShopCfg[iter_12_1].shop_id)
		end

		local var_12_1, var_12_2 = ShopTools.IsShopOpen(var_12_0[1])

		if var_12_1 then
			JumpTools.GoToSystem("/activityShop", {
				shopId = var_12_0[1],
				showShops = var_12_0
			}, ViewConst.SYSTEM_ID.SHOP)
		elseif var_12_2 == 2 then
			ShowTips("SHOP_EXPIRED")
		elseif var_12_2 == 3 then
			ShowTips("SHOP_NOT_OPEN")
		end
	end)
	self:AddBtnListener(self.leftBtn1_, nil, function()
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			JumpTools.GoToSystem("/skuldTravelView")
		else
			local var_13_0, var_13_1 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, GameSetting.travel_skuld_unlock.value[1])

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK_EX"), getChapterDifficulty(GameSetting.travel_skuld_unlock.value[1]), GetI18NText(var_13_0) .. "-" .. GetI18NText(var_13_1)))
		end
	end)
end

function ActivityMainView_1_6:AddTimer()
	self:StopTimer()

	local var_14_0 = ActivityData:GetActivityData(ActivityConst.ACTIVITY_1_6_PT_SHOP).stopTime
	local var_14_1 = var_14_0 - manager.time:GetServerTime()

	if var_14_1 < 0 then
		self.shopController_:SetSelectedState("off")

		return
	end

	local var_14_2 = true
	local var_14_3 = 432000

	if var_14_1 <= 432000 then
		self.shopController_:SetSelectedState("on")

		self.shopTimeText_.text = manager.time:GetLostTimeStr2(var_14_0, nil, true)
	else
		self.shopController_:SetSelectedState("off")

		var_14_2 = false
	end

	self.timer_ = Timer.New(function()
		var_14_1 = var_14_0 - manager.time:GetServerTime()

		if var_14_1 <= var_14_3 then
			if var_14_1 <= 0 then
				self.shopController_:SetSelectedState("off")
				self:StopTimer()

				return
			end

			if var_14_2 then
				self.shopController_:SetSelectedState("on")

				self.shopTimeText_.text = manager.time:GetLostTimeStr2(var_14_0, nil, true)
				var_14_2 = false
			end

			self.shopTimeText_.text = manager.time:GetLostTimeStr2(var_14_0, nil, true)
		elseif var_14_2 == false then
			self.shopController_:SetSelectedState("off")

			var_14_2 = true
		end
	end, 1, -1)

	self.timer_:Start()
end

function ActivityMainView_1_6:StopTimer()
	if self.timer_ then
		self.timer_:Stop()

		self.timer_ = nil
	end
end

return ActivityMainView_1_6
