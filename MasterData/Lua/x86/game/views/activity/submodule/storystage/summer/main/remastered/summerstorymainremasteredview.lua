local SummerStoryMainRemasteredView = class("SummerStoryMainRemasteredView", ReduxView)

function SummerStoryMainRemasteredView:UIName()
	return "UI/BranchlineUI/SummerUI/SummerIslandMapUI"
end

function SummerStoryMainRemasteredView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerStoryMainRemasteredView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}

	for iter_3_0, iter_3_1 in ipairs(WarchessLevelCfg.get_id_list_by_tag[ChessConst.SUBPLOT_TAG.ISLAND]) do
		self.itemList_[iter_3_0] = SummerStoryMainWarchessRemasteredItem.New(self[string.format("sideStoryGo%s_", iter_3_0)], iter_3_1)
	end

	self.mainItem_ = SummerStoryMainRemasteredItem.New(self.mainStoryGo_, ChapterClientCfg[6010003].chapter_list[1])
	self.seabedItem_ = SummerStorySeabedRemasteredItem.New(self.seabedGo_, ChapterClientCfg[6010003].chapter_list[2], ActivityConst.SUMMER_STORY_SEABED)
	self.plotController_ = ControllerUtil.GetController(self.sideStoryBtn_.transform, "name")
	self.chessController_ = ControllerUtil.GetController(self.shipLogBtn_.transform, "name")
end

function SummerStoryMainRemasteredView:OnEnter()
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
		if ChapterTools.IsClearStage(ChapterCfg[ChapterClientCfg[6010003].chapter_list[1]].section_id_list[1]) then
			return
		end

		saveData("ActivityFirstEnter", ActivityConst.THEME.SUMMER, true)
		BattleStageAction.ClickSubPlot(ChapterClientCfg[6010003].chapter_list[1])
		self:Go("/summerStoryRemastered", {
			chapterID = ChapterClientCfg[6010003].chapter_list[1]
		})
	end
end

function SummerStoryMainRemasteredView:OnExit()
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(self.sideStoryBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER))
	manager.redPoint:unbindUIandKey(self.shipLogBtn_.transform, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.SUMMER_CHESS_SHIP_LOG))
	self.mainItem_:OnExit()
	self.seabedItem_:OnExit()

	for iter_5_0, iter_5_1 in pairs(self.itemList_) do
		iter_5_1:OnExit()
	end
end

function SummerStoryMainRemasteredView:Dispose()
	SummerStoryMainRemasteredView.super.Dispose(self)
	self.mainItem_:Dispose()

	self.mainItem_ = nil

	self.seabedItem_:Dispose()

	self.seabedItem_ = nil

	for iter_6_0, iter_6_1 in pairs(self.itemList_) do
		iter_6_1:Dispose()
	end

	self.timeList_ = nil
end

function SummerStoryMainRemasteredView:AddListeners()
	self:AddBtnListener(self.sideStoryBtn_, nil, function()
		if not self.unLockSideStoryState_ then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ChapterCfg[ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition[2][1]].subhead, BattleActivityStoryStageCfg[ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition[2][2]].name))

			return
		end

		self:Go("/summerPlotRemastered", {
			theme = ActivityConst.THEME.SUMMER
		})
	end)
	self:AddBtnListener(self.shipLogBtn_, nil, function()
		if not self.unLockChipLogState_ then
			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ChapterCfg[ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition[2][1]].subhead, BattleActivityStoryStageCfg[ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition[2][2]].name))

			return
		end

		self:Go("/summerChessRemastered", {
			tag = ChessConst.SUBPLOT_TAG.SEA
		})
	end)
end

function SummerStoryMainRemasteredView:RefreshUI()
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

return SummerStoryMainRemasteredView
