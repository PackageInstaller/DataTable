local SummerChessBoardMainEntryView = class("SummerChessBoardMainEntryView", ReduxView)

function SummerChessBoardMainEntryView:UIName()
	return "Widget/System/Summer2024/Summer2024_ChessBoard/Summer2024_ChessBoardUI"
end

function SummerChessBoardMainEntryView:UIParent()
	return manager.ui.uiMain.transform
end

function SummerChessBoardMainEntryView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.activityList_ = {}
	self.chessBtnList_ = {}

	for iter_3_0, iter_3_1 in ipairs(ActivityCfg[ActivityConst.SUMMER_CHESS_BOARD_MAIN_CHESS].sub_activity_list) do
		self.chessBtnList_[iter_3_0] = SummerChessBoardChessBtn.New(self[string.format("chessGo%s_", iter_3_0)], iter_3_1)

		table.insert(self.activityList_, iter_3_1)
	end

	for iter_3_2 = 5, #self.chessBtnList_ + 1, -1 do
		if self[string.format("chessGo%s_", iter_3_2)] then
			SetActive(self[string.format("chessGo%s_", iter_3_2)], false)
		end
	end

	self.permanentBtnList_ = {}

	for iter_3_3, iter_3_4 in ipairs({
		ActivityConst.SUMMER_CHESS_BOARD_RHYTHM,
		ActivityConst.SUMMER_CHESS_BOARD_NONSTER_COSPLAY
	}) do
		self.permanentBtnList_[iter_3_3] = SummerChessBoardPermanentGameBtn.New(self[string.format("permanentGo%s_", iter_3_3)], iter_3_4)

		table.insert(self.activityList_, iter_3_4)
	end

	self.miniGameBtnList_ = {}

	for iter_3_5, iter_3_6 in ipairs({
		ActivityConst.SUMMER_CHESS_BOARD_WHAC_A_MOLE,
		ActivityConst.SUMMER_CHESS_BOARD_DUCK,
		ActivityConst.SUMMER_CHESS_BOARD_BUBBLE,
		ActivityConst.SUMMER_CHESS_BOARD_PLUZZE
	}) do
		self.miniGameBtnList_[iter_3_5] = SummerChessBoardMiniGameBtn.New(self[string.format("miniGameGo%s_", iter_3_5)], iter_3_6)

		table.insert(self.activityList_, iter_3_6)
	end

	self.exploreView_ = SummerChessBoardExploreBtnView.New(self.exploreGo_)
	self.taskView_ = SummerChessBoardTaskBtnView.New(self.taskGo_)
	self.tipsView_ = SummerChessBoardTipsView.New(self.tipsGo_)
	self.tipsOverHandler_ = handler(self, self.TipsOver)
	self.clickCount_ = 0
end

function SummerChessBoardMainEntryView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_CHESS_BOARD_DESC")

	if not self:ShowTips() and gameContext:GetLastOpenPage() ~= "summerChessBoardUnlockArea" and self.params_ and self.params_.needOpenEmergencyView == true then
		JumpTools.OpenPageByJump("summerChessBoardEmergencyView")

		self.params_.needOpenEmergencyView = false
	end

	self.clickCount_ = 0
end

function SummerChessBoardMainEntryView:OnEnter()
	self:RefreshEventBtn()
	BlisterGameData:SetActivityId(ActivityConst.ACTIVITY_3_4_BLISTER_GAME)

	for iter_5_0, iter_5_1 in ipairs(self.chessBtnList_) do
		iter_5_1:OnEnter()
	end

	for iter_5_2, iter_5_3 in ipairs(self.permanentBtnList_) do
		iter_5_3:OnEnter()
	end

	for iter_5_4, iter_5_5 in ipairs(self.miniGameBtnList_) do
		iter_5_5:OnEnter()
	end

	self.exploreView_:OnEnter()
	self.taskView_:OnEnter()
	manager.notify:RegistListener(SUMMER_CHESS_BOARD_TIPS_ANIMATOR_OVER, self.tipsOverHandler_)
	manager.redPoint:bindUIandKey(self.exploreNoteBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE)

	if manager.redPoint:getTipValue(RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE_VIDEO) > 0 then
		SetActive(self.exploreNoteRedGo_, true)
	end

	manager.redPoint:bindUIandKey(self.eventBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)
	SetActive(self.exploreNoteBtn_.gameObject, #SummerChessBoardTools.GetFinishExploreNoteList() > 0)
end

function SummerChessBoardMainEntryView:OnExit()
	manager.redPoint:unbindUIandKey(self.exploreNoteBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE)
	manager.redPoint:unbindUIandKey(self.eventBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)
	manager.notify:RemoveListener(SUMMER_CHESS_BOARD_TIPS_ANIMATOR_OVER, self.tipsOverHandler_)

	for iter_6_0, iter_6_1 in ipairs(self.chessBtnList_) do
		iter_6_1:OnExit()
	end

	for iter_6_2, iter_6_3 in ipairs(self.permanentBtnList_) do
		iter_6_3:OnExit()
	end

	for iter_6_4, iter_6_5 in ipairs(self.miniGameBtnList_) do
		iter_6_5:OnExit()
	end

	self.exploreView_:OnExit()
	self.taskView_:OnExit()
	self.tipsView_:OnExit()
	manager.windowBar:HideBar()
end

function SummerChessBoardMainEntryView:Dispose()
	self.tipsOverHandler_ = nil

	for iter_7_0, iter_7_1 in ipairs(self.chessBtnList_) do
		iter_7_1:Dispose()
	end

	self.chessBtnList_ = nil

	for iter_7_2, iter_7_3 in ipairs(self.permanentBtnList_) do
		iter_7_3:Dispose()
	end

	self.permanentBtnList_ = nil

	for iter_7_4, iter_7_5 in ipairs(self.miniGameBtnList_) do
		iter_7_5:Dispose()
	end

	self.miniGameBtnList_ = nil

	self.exploreView_:Dispose()

	self.exploreView_ = nil

	self.taskView_:Dispose()

	self.taskView_ = nil

	self.tipsView_:Dispose()

	self.tipsView_ = nil

	SummerChessBoardMainEntryView.super.Dispose(self)
end

function SummerChessBoardMainEntryView:OnTaskListChange()
	self:RefreshEventBtn()
end

function SummerChessBoardMainEntryView:RefreshEventBtn()
	SetActive(self.eventBtn_, SummerChessBoardData:GetBreakOutEventAndRedData() > 0)
end

function SummerChessBoardMainEntryView:AddListeners()
	self:AddBtnListener(self.eventBtn_, nil, function()
		JumpTools.OpenPageByJump("summerChessBoardEmergencyView")
	end)
	self:AddBtnListener(self.exploreNoteBtn_, nil, function()
		ActivityUnlockStateAction.UpdateState(ActivitySummerChessConditionCfg.get_id_list_by_activity_id[ActivityConst.SUMMER_CHESS_BOARD_EXPLORE_NOTE][1], ActivityConst.ACTIVITY_OPERATION_KEY.CLICK_EXPLORE_NOTE, 1)
		JumpTools.OpenPageByJump("summerChessBoardNote")
	end)
end

function SummerChessBoardMainEntryView:ShowTips()
	local var_13_0 = {}
	local var_13_1 = manager.time:GetServerTime()

	for iter_13_0, iter_13_1 in ipairs(self.activityList_) do
		local var_13_2 = SummerChessBoardData:CallFun("GetUnlockConditionList", iter_13_1)

		if #var_13_2 > 0 then
			for iter_13_2, iter_13_3 in ipairs(var_13_2) do
				if ActivityUnlockStateData:GetUnlockState(iter_13_3)[ActivityConst.ACTIVITY_OPERATION_KEY.TIPS] ~= 1 then
					if ActivitySummerChessConditionCfg[iter_13_3].unlock_text ~= "" and var_13_1 < ActivityData:GetActivityData(ActivitySummerChessConditionCfg[iter_13_3].activity_id).stopTime then
						if type(ActivitySummerChessConditionCfg[iter_13_3].jump_system) == "table" then
							table.insert(var_13_0, iter_13_3)
						else
							ActivityUnlockStateAction.UpdateState(iter_13_3, GetI18NText(ActivityConst.ACTIVITY_OPERATION_KEY.TIPS), 1)
							self.tipsView_:SetText(GetI18NText(ActivitySummerChessConditionCfg[iter_13_3].unlock_text))

							return true
						end
					end
				end
			end
		end
	end

	if #var_13_0 > 0 then
		ActivityUnlockStateAction.UpdateState(var_13_0[1], GetI18NText(ActivityConst.ACTIVITY_OPERATION_KEY.TIPS), 1)
		JumpTools.OpenPageByJump("summerChessBoardUnlockArea", {
			chessConditionID = var_13_0[1]
		})

		return true
	end

	return false
end

function SummerChessBoardMainEntryView:TipsOver()
	self:ShowTips()
end

function SummerChessBoardMainEntryView:OnSummerChessBoardClickLockActivity()
	self.clickCount_ = self.clickCount_ + 1

	if self.clickCount_ >= 2 then
		self.clickCount_ = 0

		self.taskAni_:Play("guide")
	end
end

return SummerChessBoardMainEntryView
