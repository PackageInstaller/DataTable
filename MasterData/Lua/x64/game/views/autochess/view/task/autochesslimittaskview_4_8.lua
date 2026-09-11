local AutoChessLimitTaskView_4_8 = class("AutoChessLimitTaskView_4_8", (import("game.views.task.limitTime.LimitTimeTaskBaseView")))

function AutoChessLimitTaskView_4_8:Init()
	AutoChessLimitTaskView_4_8.super.Init(self)
	AutoChessLimitTaskView_4_8.super.SetProgressString(GetTips("AUTO_CHESS_LIMITED_TASK_NUM"))
end

function AutoChessLimitTaskView_4_8:BindRedPoint()
	for iter_2_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:bindUIandKey(self.tabList_[iter_2_0].transform_, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK_TAG .. self.subActivityIDList_[iter_2_0])
	end
end

function AutoChessLimitTaskView_4_8:UnBindRedPoint()
	for iter_3_0 = 1, #self.subActivityIDList_ do
		manager.redPoint:unbindUIandKey(self.tabList_[iter_3_0].transform_, RedPointConst.AUTO_CHESS_4_8_LIMIT_TASK_TAG .. self.subActivityIDList_[iter_3_0])
	end
end

return AutoChessLimitTaskView_4_8
