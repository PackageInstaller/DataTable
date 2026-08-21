local var_0_0 = class("SummerChessBoardMainEntryView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_ChessBoardUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddListeners()

	arg_3_0.activityList_ = {}
	arg_3_0.chessBtnList_ = {}

	for iter_3_0, iter_3_1 in ipairs(ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].sub_activity_list) do
		arg_3_0.chessBtnList_[iter_3_0] = SummerChessBoardChessBtn.New(arg_3_0[string.format("chessGo%s_", iter_3_0)], iter_3_1)

		table.insert(arg_3_0.activityList_, iter_3_1)
	end

	for iter_3_2 = 5, #arg_3_0.chessBtnList_ + 1, -1 do
		if arg_3_0[string.format("chessGo%s_", iter_3_2)] then
			SetActive(arg_3_0[string.format("chessGo%s_", iter_3_2)], false)
		end
	end

	local var_3_0 = {
		ActivityConst.SUMMER_CHESS_BOARD_RHYTHM,
		ActivityConst.SUMMER_CHESS_BOARD_NONSTER_COSPLAY
	}
	local var_3_1 = {
		ActivityConst.SUMMER_CHESS_BOARD_WHAC_A_MOLE,
		ActivityConst.SUMMER_CHESS_BOARD_DUCK,
		ActivityConst.SUMMER_CHESS_BOARD_BUBBLE,
		ActivityConst.SUMMER_CHESS_BOARD_PLUZZE
	}

	arg_3_0.permanentBtnList_ = {}

	for iter_3_3, iter_3_4 in ipairs(var_3_0) do
		arg_3_0.permanentBtnList_[iter_3_3] = SummerChessBoardPermanentGameBtn.New(arg_3_0[string.format("permanentGo%s_", iter_3_3)], iter_3_4)

		table.insert(arg_3_0.activityList_, iter_3_4)
	end

	arg_3_0.miniGameBtnList_ = {}

	for iter_3_5, iter_3_6 in ipairs(var_3_1) do
		arg_3_0.miniGameBtnList_[iter_3_5] = SummerChessBoardMiniGameBtn.New(arg_3_0[string.format("miniGameGo%s_", iter_3_5)], iter_3_6)

		table.insert(arg_3_0.activityList_, iter_3_6)
	end

	arg_3_0.exploreView_ = SummerChessBoardExploreBtnView.New(arg_3_0.exploreGo_)
	arg_3_0.taskView_ = SummerChessBoardTaskBtnView.New(arg_3_0.taskGo_)
	arg_3_0.tipsView_ = SummerChessBoardTipsView.New(arg_3_0.tipsGo_)
	arg_3_0.tipsOverHandler_ = handler(arg_3_0, arg_3_0.TipsOver)
	arg_3_0.clickCount_ = 0
end

function var_0_0.OnTop(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_CHESS_BOARD_DESC")

	if not arg_4_0:ShowTips() and gameContext:GetLastOpenPage() ~= "summerChessBoardUnlockArea" and arg_4_0.params_ and arg_4_0.params_.needOpenEmergencyView == true then
		JumpTools.OpenPageByJump("summerChessBoardEmergencyView")

		arg_4_0.params_.needOpenEmergencyView = false
	end

	arg_4_0.clickCount_ = 0
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0:RefreshEventBtn()
	BlisterGameData:SetActivityId(ActivityConst.ACTIVITY_3_4_BLISTER_GAME)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.chessBtnList_) do
		iter_5_1:OnEnter()
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_0.permanentBtnList_) do
		iter_5_3:OnEnter()
	end

	for iter_5_4, iter_5_5 in ipairs(arg_5_0.miniGameBtnList_) do
		iter_5_5:OnEnter()
	end

	arg_5_0.exploreView_:OnEnter()
	arg_5_0.taskView_:OnEnter()
	manager.notify:RegistListener(SUMMER_CHESS_BOARD_TIPS_ANIMATOR_OVER, arg_5_0.tipsOverHandler_)
	manager.redPoint:bindUIandKey(arg_5_0.exploreNoteBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE)

	if manager.redPoint:getTipValue(RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO) > 0 then
		SetActive(arg_5_0.exploreNoteRedGo_, true)
	end

	manager.redPoint:bindUIandKey(arg_5_0.eventBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)
	SetActive(arg_5_0.exploreNoteBtn_.gameObject, #SummerChessBoardTools.GetFinishExploreNoteList() > 0)
end

function var_0_0.OnExit(arg_6_0)
	manager.redPoint:unbindUIandKey(arg_6_0.exploreNoteBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE)
	manager.redPoint:unbindUIandKey(arg_6_0.eventBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)
	manager.notify:RemoveListener(SUMMER_CHESS_BOARD_TIPS_ANIMATOR_OVER, arg_6_0.tipsOverHandler_)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.chessBtnList_) do
		iter_6_1:OnExit()
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.permanentBtnList_) do
		iter_6_3:OnExit()
	end

	for iter_6_4, iter_6_5 in ipairs(arg_6_0.miniGameBtnList_) do
		iter_6_5:OnExit()
	end

	arg_6_0.exploreView_:OnExit()
	arg_6_0.taskView_:OnExit()
	arg_6_0.tipsView_:OnExit()
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.tipsOverHandler_ = nil

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.chessBtnList_) do
		iter_7_1:Dispose()
	end

	arg_7_0.chessBtnList_ = nil

	for iter_7_2, iter_7_3 in ipairs(arg_7_0.permanentBtnList_) do
		iter_7_3:Dispose()
	end

	arg_7_0.permanentBtnList_ = nil

	for iter_7_4, iter_7_5 in ipairs(arg_7_0.miniGameBtnList_) do
		iter_7_5:Dispose()
	end

	arg_7_0.miniGameBtnList_ = nil

	arg_7_0.exploreView_:Dispose()

	arg_7_0.exploreView_ = nil

	arg_7_0.taskView_:Dispose()

	arg_7_0.taskView_ = nil

	arg_7_0.tipsView_:Dispose()

	arg_7_0.tipsView_ = nil

	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.OnTaskListChange(arg_8_0)
	arg_8_0:RefreshEventBtn()
end

function var_0_0.RefreshEventBtn(arg_9_0)
	local var_9_0 = SummerChessBoardData:GetBreakOutEventAndRedData()

	SetActive(arg_9_0.eventBtn_, var_9_0 > 0)
end

function var_0_0.AddListeners(arg_10_0)
	arg_10_0:AddBtnListener(arg_10_0.eventBtn_, nil, function()
		JumpTools.OpenPageByJump("summerChessBoardEmergencyView")
	end)
	arg_10_0:AddBtnListener(arg_10_0.exploreNoteBtn_, nil, function()
		local var_12_0 = ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE][1]

		ActivityUnlockStateAction.UpdateState(var_12_0, ActivityConst.ACTIVITY_OPERATION_KEY.CLICK_EXPLORE_NOTE, 1)
		JumpTools.OpenPageByJump("summerChessBoardNote")
	end)
end

function var_0_0.ShowTips(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = manager.time:GetServerTime()

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.activityList_) do
		local var_13_2 = SummerChessBoardData:CallFun("GetUnlockConditionList", iter_13_1)

		if #var_13_2 > 0 then
			for iter_13_2, iter_13_3 in ipairs(var_13_2) do
				if ActivityUnlockStateData:GetUnlockState(iter_13_3)[ActivityConst.ACTIVITY_OPERATION_KEY.TIPS] ~= 1 then
					local var_13_3 = ActivitySummerChessConditionCfg[iter_13_3]

					if var_13_3.unlock_text ~= "" and var_13_1 < ActivityData:GetActivityData(var_13_3.activity_id).stopTime then
						if type(var_13_3.jump_system) == "table" then
							table.insert(var_13_0, iter_13_3)
						else
							ActivityUnlockStateAction.UpdateState(iter_13_3, GetI18NText(ActivityConst.ACTIVITY_OPERATION_KEY.TIPS), 1)
							arg_13_0.tipsView_:SetText(GetI18NText(var_13_3.unlock_text))

							return true
						end
					end
				end
			end
		end
	end

	if #var_13_0 > 0 then
		local var_13_4 = var_13_0[1]

		ActivityUnlockStateAction.UpdateState(var_13_4, GetI18NText(ActivityConst.ACTIVITY_OPERATION_KEY.TIPS), 1)
		JumpTools.OpenPageByJump("summerChessBoardUnlockArea", {
			chessConditionID = var_13_4
		})

		return true
	end

	return false
end

function var_0_0.TipsOver(arg_14_0)
	arg_14_0:ShowTips()
end

function var_0_0.OnSummerChessBoardClickLockActivity(arg_15_0)
	arg_15_0.clickCount_ = arg_15_0.clickCount_ + 1

	if arg_15_0.clickCount_ >= 2 then
		arg_15_0.clickCount_ = 0

		arg_15_0.taskAni_:Play("guide")
	end
end

return var_0_0
