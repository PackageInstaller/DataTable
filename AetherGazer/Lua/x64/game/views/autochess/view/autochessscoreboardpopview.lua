local var_0_0 = class("AutoChessScoreBoardPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_AutoChess_Battle/Activity_AutoChess_PVP_POPUI_ScoreBoard"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()

	arg_3_0.clickChessHandler_ = handler(arg_3_0, arg_3_0.OnClickChess)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:AddUIListener()

	arg_4_0.autoChessCountDownView_ = AutoChessCountDownView.New(arg_4_0.timerGo_)
	arg_4_0.playerList_ = LuaList.New(handler(arg_4_0, arg_4_0.IndexItem), arg_4_0.playerListGo_, AutoChessScoreBoardPopItemView)
	arg_4_0.tipsPanelView_ = AutoChessTipsPanelView.New(arg_4_0.tipsPanelGo_)
	arg_4_0.startPos_ = 164
	arg_4_0.itemHeight_ = 180
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		arg_5_0:OnCloseTips()
	end)
	arg_5_0.scrollView_.onValueChanged:AddListener(function()
		arg_5_0:OnCloseTips()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:OnCloseTips()
	arg_9_0.autoChessCountDownView_:UpdateCountDownTime()

	arg_9_0.scoreBoardDataList_ = AutoChessData:GetScoreBoardDataList()

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.scoreBoardDataList_) do
		if iter_9_1.isSelf then
			arg_9_0.battleUserId_ = iter_9_1.battleUserId
		end
	end

	arg_9_0.playerList_:StartScroll(#arg_9_0.scoreBoardDataList_)
	arg_9_0:ScrollJump()
	arg_9_0:RegistEventListener("AUTO_CHESS_SCORE_BOARD_CHESS_CLICK", arg_9_0.clickChessHandler_)
end

function var_0_0.OnClickChess(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.isShowTips_ = true

	SetActive(arg_10_0.maskBtn_.gameObject, arg_10_0.isShowTips_)
	arg_10_0.tipsPanelView_:SetActive(arg_10_0.isShowTips_)
	arg_10_0.tipsPanelView_:SetData(arg_10_1)
	arg_10_0.tipsPanelView_:SetGoldState(false)

	local var_10_0 = arg_10_2:GetPos()

	arg_10_0.tipsPanelView_:SetPos(var_10_0)
	AutoChessTools.ScreenAdapter(arg_10_2, arg_10_0.tipsPanelView_)
end

function var_0_0.OnCloseTips(arg_11_0)
	if not arg_11_0.isShowTips_ then
		return
	end

	arg_11_0.isShowTips_ = false

	SetActive(arg_11_0.maskBtn_.gameObject, arg_11_0.isShowTips_)
	arg_11_0.tipsPanelView_:SetActive(arg_11_0.isShowTips_)
end

function var_0_0.IndexItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:SetData(arg_12_0.scoreBoardDataList_[arg_12_1], arg_12_0.scrollView_, false)
	arg_12_2:UpdateTipsState(arg_12_2.scoreBoardData_.userId == arg_12_0.battleUserId_)
end

function var_0_0.ScrollJump(arg_13_0)
	local var_13_0 = 1

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.scoreBoardDataList_) do
		if iter_13_1.isSelf then
			var_13_0 = iter_13_0

			break
		end
	end

	if var_13_0 >= 6 then
		local var_13_1 = arg_13_0.startPos_ + arg_13_0.itemHeight_ * (var_13_0 - 6)
		local var_13_2 = arg_13_0.startPos_ + arg_13_0.itemHeight_ * (#arg_13_0.scoreBoardDataList_ - 6)
		local var_13_3 = (var_13_2 - var_13_1) / var_13_2

		arg_13_0.playerList_:SetScrolledPosition(Vector2.New(0, var_13_3))
	end
end

function var_0_0.OnExit(arg_14_0)
	arg_14_0:RemoveAllEventListener()
	var_0_0.super.OnExit(arg_14_0)
end

function var_0_0.Dispose(arg_15_0)
	arg_15_0.autoChessCountDownView_:Dispose()
	arg_15_0.playerList_:Dispose()
	arg_15_0.tipsPanelView_:Dispose()
	var_0_0.super.Dispose(arg_15_0)
end

return var_0_0
