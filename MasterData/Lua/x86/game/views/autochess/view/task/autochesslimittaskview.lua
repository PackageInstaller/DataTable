local AutoChessLimitTaskView = class("AutoChessLimitTaskView", (import("game.views.task.limitTime.LimitTimeTaskBaseView")))

function AutoChessLimitTaskView:Init()
	AutoChessLimitTaskView.super.Init(self)
	AutoChessLimitTaskView.super.SetProgressString(GetTips("AUTO_CHESS_LIMITED_TASK_NUM"))
end

function AutoChessLimitTaskView:BindRedPoint()
	for iter_2_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:bindUIandKey(self.tabList_[iter_2_0].transform_, RedPointConst.AUTO_CHESS_LIMIT_TASK_TAG .. self.subActivityIDList_[iter_2_0])
	end
end

function AutoChessLimitTaskView:UnBindRedPoint()
	for iter_3_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:unbindUIandKey(self.tabList_[iter_3_0].transform_, RedPointConst.AUTO_CHESS_LIMIT_TASK_TAG .. self.subActivityIDList_[iter_3_0])
	end
end

return AutoChessLimitTaskView
