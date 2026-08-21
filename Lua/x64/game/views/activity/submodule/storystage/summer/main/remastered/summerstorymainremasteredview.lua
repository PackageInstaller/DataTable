local var_0_0 = class("SummerStoryMainRemasteredView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/BranchlineUI/SummerUI/SummerIslandMapUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.itemList_ = {}

	for iter_3_0, iter_3_1 in ipairs(WarchessLevelCfg.get_id_list_by_tag[ChessConst.SUBPLOT_TAG.ISLAND]) do
		arg_3_0.itemList_[iter_3_0] = SummerStoryMainWarchessRemasteredItem.New(arg_3_0[string.format("sideStoryGo%s_", iter_3_0)], iter_3_1)
	end

	local var_3_0 = ChapterClientCfg[6010003].chapter_list
	local var_3_1 = var_3_0[1]

	arg_3_0.mainItem_ = SummerStoryMainRemasteredItem.New(arg_3_0.mainStoryGo_, var_3_1)

	local var_3_2 = var_3_0[2]

	arg_3_0.seabedItem_ = SummerStorySeabedRemasteredItem.New(arg_3_0.seabedGo_, var_3_2, ActivityConst.SUMMER_STORY_SEABED)
	arg_3_0.plotController_ = ControllerUtil.GetController(arg_3_0.sideStoryBtn_.transform, "name")
	arg_3_0.chessController_ = ControllerUtil.GetController(arg_3_0.shipLogBtn_.transform, "name")
end

function var_0_0.OnEnter(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	arg_4_0.mainItem_:OnEnter()
	arg_4_0.seabedItem_:OnEnter()

	for iter_4_0, iter_4_1 in pairs(arg_4_0.itemList_) do
		iter_4_1:OnEnter()
	end

	arg_4_0.unLockSideStoryState_ = ActivityTools.IsUnlockActivity(ActivityConst.SUMMER_CHESS_SHIP_LOG)
	arg_4_0.unLockChipLogState_ = ActivityTools.IsUnlockActivity(ActivityConst.SUMMER_CHESS_SHIP_LOG)

	arg_4_0:RefreshUI()
	manager.redPoint:bindUIandKey(arg_4_0.sideStoryBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER))
	manager.redPoint:bindUIandKey(arg_4_0.shipLogBtn_.transform, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.SUMMER_CHESS_SHIP_LOG))

	if not getData("ActivityFirstEnter", ActivityConst.THEME.SUMMER, false) then
		local var_4_0 = ChapterClientCfg[6010003].chapter_list[1]
		local var_4_1 = ChapterCfg[var_4_0].section_id_list[1]

		if ChapterTools.IsClearStage(var_4_1) then
			return
		end

		saveData("ActivityFirstEnter", ActivityConst.THEME.SUMMER, true)
		BattleStageAction.ClickSubPlot(var_4_0)
		arg_4_0:Go("/summerStoryRemastered", {
			chapterID = var_4_0
		})
	end
end

function var_0_0.OnExit(arg_5_0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(arg_5_0.sideStoryBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_SIDE_STORY, ActivityConst.THEME.SUMMER))
	manager.redPoint:unbindUIandKey(arg_5_0.shipLogBtn_.transform, string.format("%s_%s", RedPointConst.WAR_CHESS, ActivityConst.SUMMER_CHESS_SHIP_LOG))
	arg_5_0.mainItem_:OnExit()
	arg_5_0.seabedItem_:OnExit()

	for iter_5_0, iter_5_1 in pairs(arg_5_0.itemList_) do
		iter_5_1:OnExit()
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0.mainItem_:Dispose()

	arg_6_0.mainItem_ = nil

	arg_6_0.seabedItem_:Dispose()

	arg_6_0.seabedItem_ = nil

	for iter_6_0, iter_6_1 in pairs(arg_6_0.itemList_) do
		iter_6_1:Dispose()
	end

	arg_6_0.timeList_ = nil
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.sideStoryBtn_, nil, function()
		if not arg_7_0.unLockSideStoryState_ then
			local var_8_0 = ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ChapterCfg[var_8_0[2][1]].subhead, BattleActivityStoryStageCfg[var_8_0[2][2]].name))

			return
		end

		arg_7_0:Go("/summerPlotRemastered", {
			theme = ActivityConst.THEME.SUMMER
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.shipLogBtn_, nil, function()
		if not arg_7_0.unLockChipLogState_ then
			local var_9_0 = ActivityCfg[ActivityConst.SUMMER_CHESS_SHIP_LOG].unlock_condition

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), ChapterCfg[var_9_0[2][1]].subhead, BattleActivityStoryStageCfg[var_9_0[2][2]].name))

			return
		end

		arg_7_0:Go("/summerChessRemastered", {
			tag = ChessConst.SUBPLOT_TAG.SEA
		})
	end)
end

function var_0_0.RefreshUI(arg_10_0)
	local var_10_0, var_10_1 = ActivityTools.GetActivityChessProgress(ChessConst.SUBPLOT_TAG.ISLAND)

	arg_10_0.exploreText_.text = string.format("%d%%", math.floor(var_10_0 / var_10_1))

	if arg_10_0.unLockSideStoryState_ then
		arg_10_0.plotController_:SetSelectedState("on")
	else
		arg_10_0.plotController_:SetSelectedState("off")
	end

	if arg_10_0.unLockChipLogState_ then
		arg_10_0.chessController_:SetSelectedState("on")
	else
		arg_10_0.chessController_:SetSelectedState("off")
	end
end

return var_0_0
