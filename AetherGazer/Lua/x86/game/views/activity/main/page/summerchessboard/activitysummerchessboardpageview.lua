ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local var_0_0 = class("ActivitySummerChessBoardPageView", ActivityMainBasePanel)

function var_0_0.GetUIName(arg_1_0)
	return "Widget/System/Summer2024/Summer2024_Entry/Summer2024_SummerEntryUI"
end

function var_0_0.Init(arg_2_0)
	var_0_0.super.Init(arg_2_0)

	arg_2_0.exploreView_ = SummerChessBoardExploreBtnView.New(arg_2_0.exploreGo_)
	arg_2_0.taskView_ = SummerChessBoardTaskBtnView.New(arg_2_0.taskGo_)
	arg_2_0.photoView_ = ActivitySummerChessBoardPhotoBtnView.New(arg_2_0.photoGo_, ActivityConst.SUMMER_PHOTO_SWIMWEAR)
end

function var_0_0.OnEnter(arg_3_0)
	var_0_0.super.OnEnter(arg_3_0)
	arg_3_0.exploreView_:OnEnter()
	arg_3_0.taskView_:OnEnter()
	arg_3_0.photoView_:OnEnter()
	arg_3_0:RefreshEventBtn()
	manager.redPoint:bindUIandKey(arg_3_0.startBtn_.transform, RedPointConst.SUMMER_EXPLORE_BTN)
	manager.redPoint:bindUIandKey(arg_3_0.eventBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)
end

function var_0_0.OnExit(arg_4_0)
	var_0_0.super.OnExit(arg_4_0)
	arg_4_0.exploreView_:OnExit()
	arg_4_0.taskView_:OnExit()
	arg_4_0.photoView_:OnExit()
	manager.redPoint:unbindUIandKey(arg_4_0.startBtn_.transform, RedPointConst.SUMMER_EXPLORE_BTN)
	manager.redPoint:unbindUIandKey(arg_4_0.eventBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.exploreView_:Dispose()

	arg_5_0.exploreView_ = nil

	arg_5_0.taskView_:Dispose()

	arg_5_0.taskView_ = nil

	arg_5_0.photoView_:Dispose()

	arg_5_0.photoView_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

function var_0_0.OnTaskListChange(arg_6_0)
	arg_6_0:RefreshEventBtn()
end

function var_0_0.RefreshEventBtn(arg_7_0)
	local var_7_0 = SummerChessBoardData:GetBreakOutEventAndRedData()

	SetActive(arg_7_0.eventBtn_, var_7_0 > 0)
end

function var_0_0.AddListeners(arg_8_0)
	arg_8_0:AddBtnListener(arg_8_0.eventBtn_, nil, function()
		arg_8_0:Go("/summerChessBoardMainEntry", {
			needOpenEmergencyView = true
		})
	end)
	arg_8_0:AddBtnListener(arg_8_0.startBtn_, nil, function()
		arg_8_0:Go("/summerChessBoardMainEntry")
	end)
	arg_8_0:AddBtnListener(arg_8_0.helpBtn_, nil, function()
		local var_11_0 = "ACTIVITY_CHESS_BOARD_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips(var_11_0),
			key = var_11_0
		})
	end)
end

return var_0_0
