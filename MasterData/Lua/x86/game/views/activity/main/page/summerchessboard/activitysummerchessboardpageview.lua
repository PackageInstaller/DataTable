ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")

local ActivitySummerChessBoardPageView = class("ActivitySummerChessBoardPageView", ActivityMainBasePanel)

function ActivitySummerChessBoardPageView:GetUIName()
	return "Widget/System/Summer2024/Summer2024_Entry/Summer2024_SummerEntryUI"
end

function ActivitySummerChessBoardPageView:Init()
	ActivitySummerChessBoardPageView.super.Init(self)

	self.exploreView_ = SummerChessBoardExploreBtnView.New(self.exploreGo_)
	self.taskView_ = SummerChessBoardTaskBtnView.New(self.taskGo_)
	self.photoView_ = ActivitySummerChessBoardPhotoBtnView.New(self.photoGo_, ActivityConst.SUMMER_PHOTO_SWIMWEAR)
end

function ActivitySummerChessBoardPageView:OnEnter()
	ActivitySummerChessBoardPageView.super.OnEnter(self)
	self.exploreView_:OnEnter()
	self.taskView_:OnEnter()
	self.photoView_:OnEnter()
	self:RefreshEventBtn()
	manager.redPoint:bindUIandKey(self.startBtn_.transform, RedPointConst.SUMMER_EXPLORE_BTN)
	manager.redPoint:bindUIandKey(self.eventBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)
end

function ActivitySummerChessBoardPageView:OnExit()
	ActivitySummerChessBoardPageView.super.OnExit(self)
	self.exploreView_:OnExit()
	self.taskView_:OnExit()
	self.photoView_:OnExit()
	manager.redPoint:unbindUIandKey(self.startBtn_.transform, RedPointConst.SUMMER_EXPLORE_BTN)
	manager.redPoint:unbindUIandKey(self.eventBtn_.transform, RedPointConst.SUMMER_CHESS_BOARD_EMERGENCY)
end

function ActivitySummerChessBoardPageView:Dispose()
	self.exploreView_:Dispose()

	self.exploreView_ = nil

	self.taskView_:Dispose()

	self.taskView_ = nil

	self.photoView_:Dispose()

	self.photoView_ = nil

	ActivitySummerChessBoardPageView.super.Dispose(self)
end

function ActivitySummerChessBoardPageView:OnTaskListChange()
	self:RefreshEventBtn()
end

function ActivitySummerChessBoardPageView:RefreshEventBtn()
	SetActive(self.eventBtn_, SummerChessBoardData:GetBreakOutEventAndRedData() > 0)
end

function ActivitySummerChessBoardPageView:AddListeners()
	self:AddBtnListener(self.eventBtn_, nil, function()
		self:Go("/summerChessBoardMainEntry", {
			needOpenEmergencyView = true
		})
	end)
	self:AddBtnListener(self.startBtn_, nil, function()
		self:Go("/summerChessBoardMainEntry")
	end)
	self:AddBtnListener(self.helpBtn_, nil, function()
		local var_11_0 = {
			content = GetTips("ACTIVITY_CHESS_BOARD_DESC")
		}

		var_11_0.key = "ACTIVITY_CHESS_BOARD_DESC"

		JumpTools.OpenPageByJump("gameHelp", var_11_0)
	end)
end

return ActivitySummerChessBoardPageView
