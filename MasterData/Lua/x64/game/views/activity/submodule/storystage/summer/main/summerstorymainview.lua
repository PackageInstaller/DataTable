local SummerStoryMainView = class("SummerStoryMainView", ReduxView)

function SummerStoryMainView:UIName()
	return "UI/BranchlineUI/SummerUI/SummerIslandMapUI"
end

function SummerStoryMainView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerStoryMainView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}

	for iter_3_0, iter_3_1 in ipairs(WarchessLevelCfg.get_id_list_by_tag[ChessConst.SUBPLOT_TAG.ISLAND]) do
		self.itemList_[iter_3_0] = SummerStoryMainWarchessItem.New(self[string.format("sideStoryGo%s_", iter_3_0)], iter_3_1)
	end

	self.mainItem_ = SummerStoryMainItem.New(self.mainStoryGo_, ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_STORY_ISLAND][1])
	self.seabedItem_ = SummerStorySeabedItem.New(self.seabedGo_, ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_STORY_SEABED][1], ActivityConst.SUMMER_STORY_SEABED)
	self.plotController_ = ControllerUtil.GetController(self.sideStoryBtn_.transform, "name")
	self.chessController_ = ControllerUtil.GetController(self.shipLogBtn_.transform, "name")
end

function SummerStoryMainView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	self.mainItem_:OnEnter()
	self.seabedItem_:OnEnter()

	for iter_4_0, iter_4_1 in pairs(self.itemList_) do
		iter_4_1:OnEnter()
	end

	self.unLockSideStoryState_ = ActivityTools.IsUnlockActivity(ActivityConst.SUMMER_CHESS_SHIP_LOG)
	self.unLockChipLogState_ = ActivityTools.IsUnlockActivity(ActivityConst.SUMMER_CHESS_SHIP_LOG)

	self:RefreshUI()
	manager.redPoint:bindUIandKey(self.sideStoryBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER))
	manager.redPoint:bindUIandKey(self.shipLogBtn_.transform, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.SUMMER_CHESS_SHIP_LOG))

	if not getData("ActivityFirstEnter", ActivityConst.THEME.SUMMER, false) then
		local var_4_0 = StoryStageActivityData:GetStageData(ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_STORY_ISLAND][1])[ActivityStoryChapterCfg[ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_STORY_ISLAND][1]].stage_list[1]]

		if var_4_0 and var_4_0.clear_times > 0 then
			return
		end

		saveData("ActivityFirstEnter", ActivityConst.THEME.SUMMER, true)
		self:Go("/summerStageMain", {
			theme = ActivityConst.THEME.SUMMER,
			chapterID = ActivityStoryChapterCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_STORY_ISLAND][1]
		})
	end
end

function SummerStoryMainView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.sideStoryBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER))
	manager.redPoint:unbindUIandKey(self.shipLogBtn_.transform, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.SUMMER_CHESS_SHIP_LOG))
	self.mainItem_:OnExit()
	self.seabedItem_:OnExit()

	for iter_5_0, iter_5_1 in pairs(self.itemList_) do
		iter_5_1:OnExit()
	end
end

function SummerStoryMainView:Dispose()
	SummerStoryMainView.super.Dispose(self)
	self.mainItem_:Dispose()

	self.mainItem_ = nil

	self.seabedItem_:Dispose()

	self.seabedItem_ = nil

	for iter_6_0, iter_6_1 in pairs(self.itemList_) do
		iter_6_1:Dispose()
	end

	self.timeList_ = nil
end

function SummerStoryMainView:AddListeners()
	self:AddBtnListener(self.sideStoryBtn_, nil, function()
		if not self.unLockSideStoryState_ then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition[2][1]].name, BattleActivityStoryStageCfg[ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition[2][2]].name))

			return
		end

		self:Go("/summerPlot", {
			theme = ActivityConst.THEME.SUMMER
		})
	end)
	self:AddBtnListener(self.shipLogBtn_, nil, function()
		if not self.unLockChipLogState_ then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ActivityStoryChapterCfg[ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition[2][1]].name, BattleActivityStoryStageCfg[ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition[2][2]].name))

			return
		end

		self:Go("/summerChess", {
			activityId = ActivityConst.SUMMER_CHESS_SHIP_LOG
		})
	end)
end

function SummerStoryMainView:RefreshUI()
	local var_10_0, var_10_1 = ActivityTools.GetActivityChessProgress(ChessConst.SUBPLOT_TAG.ISLAND)

	self.exploreText_.text = string.format("%d%%", math.floor(var_10_0 / var_10_1))

	if self.unLockSideStoryState_ then
		self.plotController_:SetSelectedState("on")
	else
		self.plotController_:SetSelectedState("off")
	end

	if self.unLockChipLogState_ then
		self.chessController_:SetSelectedState("on")
	else
		self.chessController_:SetSelectedState("off")
	end
end

return SummerStoryMainView
