local MineTaskPop = class("MineTaskPop", require("app.fairyGUI.mine.UI_MineTaskPop"), function()
	return fgui.GComponent:create({
		resName = "MineTaskPop",
		pkgPath = "ui/mine/mine",
		pkgName = "mine"
	})
end)

function MineTaskPop:ctor()
	self:showAtCenter()

	self._taskProgressAwardComps = {}

	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskListRender))
	self.m_onKeyAwardBtn:setVisible(false)
	self.m_onKeyAwardBtn:addClickListener(handler(self, self._oneKeyReward))
end

function MineTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_GETMISSIONREWARD, self._onRcvGetMissionAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_GETACHIEVEREWARD, self._onRcvGetAchieveAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_MINE_GETMISSION, self._onRcvMissionInfo, self)
	g.core.network.GameNetProxy:send_C2S_Mine_GetMission({})
end

function MineTaskPop:_onRcvGetMissionAward(arg_4_1, arg_4_2, arg_4_3)
	g.core.module.ModuleManager:awardSummary(arg_4_3.award or {})
	self:_updateView()
end

function MineTaskPop:_onRcvGetAchieveAward(arg_5_1, arg_5_2, arg_5_3)
	g.core.module.ModuleManager:awardSummary(arg_5_3.award or {})
	self:_updateProg()
end

function MineTaskPop:_onRcvMissionInfo()
	self:_updateView()
end

function MineTaskPop:_updateView()
	self:_updateProg()

	self._taskDataList = g.core.model.User.mineData:getTaskDataList()

	self.m_taskList:setNumItems(#self._taskDataList)
end

function MineTaskPop:_updateProg()
	local var_8_0, var_8_1 = g.core.model.User.mineData:getScoreProgress()

	for iter_8_0, iter_8_1 in ipairs((g.core.model.User.mineData:getAchieveList())) do
		if not self._taskProgressAwardComps[iter_8_0] then
			local var_8_2 = iter_8_1.info.num / var_8_1 * self.m_progressComp:getWidth()

			self._taskProgressAwardComps[iter_8_0] = fgui.UIPackage:createObject("mine", "MineTaskAwardItemComp")

			self._taskProgressAwardComps[iter_8_0]:setX(var_8_2)
			self.m_rewardHolder:addChild(self._taskProgressAwardComps[iter_8_0])
		end

		self._taskProgressAwardComps[iter_8_0]:updateCompData(iter_8_1)
	end

	self.m_progressComp:setMax(var_8_1)
	self.m_progressComp:setValue(var_8_0)
end

function MineTaskPop:_onTaskListRender(arg_9_1, arg_9_2)
	if self._taskDataList[arg_9_1 + 1] then
		arg_9_2:updateCell(self._taskDataList[arg_9_1 + 1])
	end
end

function MineTaskPop:_oneKeyReward()
	return
end

return MineTaskPop
