local var_0_0 = g.core.model.User.dailyTaskData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local DailyTaskBoxProgressAwardPop = class("DailyTaskBoxProgressAwardPop", require("app.fairyGUI.dailyTask.UI_DailyTaskBoxProgressAwardPop"), function()
	return fgui.GComponent:create({
		pkgName = "dailyTask",
		resName = "DailyTaskBoxProgressAwardPop",
		pkgPath = "ui/dailyTask/dailyTask"
	}, ...)
end)

function DailyTaskBoxProgressAwardPop:ctor(arg_2_1)
	self:showAtCenter()

	self._degreeInfo = {}
	self._maxNum = 0
	self._curScore = 0
	self.rewardData = {}

	self.m_rewardList:setVirtual(self)
	self.m_rewardList:doFairyBatching(false)
	self.m_rewardList:setItemRenderer(handler(self, self._onListRenderer))
end

function DailyTaskBoxProgressAwardPop:onLoad()
	self:_updateView()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_DAILY_TASK_DEGREEAWARD, self._onGetAward, self)
end

function DailyTaskBoxProgressAwardPop:_updateView()
	self:_updateRewardData()
	self.m_scoreTxt:setText(self._curScore)
	self.m_rewardList:setNumItems(self._maxNum)
end

function DailyTaskBoxProgressAwardPop:_updateRewardData()
	local var_5_0 = var_0_0:getDailyTaskBasicInfo()
	local var_5_1 = var_0_0:getDailyTaskDegreeInfo()

	self._degreeInfo = var_5_1

	local var_5_2 = table.nums(var_5_1)

	self._maxNum = var_5_2
	self.rewardData = {}
	self._curScore = var_5_0.curDegree

	for iter_5_0 = 1, var_5_2 do
		table.insert(self.rewardData, {
			state = var_5_1[iter_5_0].state,
			info = var_5_1[iter_5_0].info,
			curScore = var_5_0.curDegree,
			index = iter_5_0
		})
	end
end

function DailyTaskBoxProgressAwardPop:_onListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateItem(self.rewardData[arg_6_1 + 1])
end

function DailyTaskBoxProgressAwardPop:_onGetAward(arg_7_1, arg_7_2, arg_7_3)
	require("app.view.module.show.ShowFactory"):awardSummary(arg_7_3.awards)
	self:_updateView()
end

return DailyTaskBoxProgressAwardPop
