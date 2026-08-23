local var_0_0 = g.core.model.User.guideTaskData
local var_0_1 = g.core.common.ModuleUnlock
local var_0_2 = g.core.common.Path
local GuideTaskViewComp = class("GuideTaskViewComp", require("app.fairyGUI.guideTask.UI_GuideTaskViewComp"))

function GuideTaskViewComp:ctor()
	self._classifyData = nil
	self._taskInfo = nil
	self._taskList = nil
	self._awards = {}
	self._unlock = false
	self._unlockTxt = ""
	self._finished = false
	self._selectTabIdx = 1

	self:_initListener()
end

function GuideTaskViewComp:_initListener()
	self.m_goToBtn:addClickListener(handler(self, self._onClickGoToBtn))
	self.m_getAwardsBtn:addClickListener(handler(self, self._onClickGetAwardsBtn))
	self.m_functionList:setVirtual()
	self.m_functionList:setItemRenderer(handler(self, self._onFunctionItemRender))
	self.m_functionList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickFunctionTab))
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRender))
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardsItemRender))
end

function GuideTaskViewComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUIDE_TASK_AWARD, handler(self, self._onRecvTaskAwardsBack), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH, handler(self, self._onActionStatusFlush), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUIDE_TASK_INFO, handler(self, self._onRecvGuideTaskInfo), self)
end

function GuideTaskViewComp:setTaskSelectedIdx(arg_4_1)
	self._selectTabIdx = arg_4_1
end

function GuideTaskViewComp:updateMainView(arg_5_1)
	if not arg_5_1 then
		return
	end

	self._classifyData = arg_5_1

	self:_cleanTabNew()
	self:_updateViewInfo()
	self.m_enterTransition:play()
	self.m_functionList:transitionShowCells("enter_up", 0.03)
end

function GuideTaskViewComp:_updateViewInfo()
	self._taskInfo = self._classifyData[self._selectTabIdx]
	self._taskList = var_0_0:getGuideTaskInfoById(self._taskInfo.id)
	self._awards = var_0_0:getGuideTaskAwards(self._taskInfo.id)
	self._unlock = var_0_1:isModuleUnlock(self._taskInfo.function_id)
	self._unlockTxt = var_0_1:getUnlockTxt(self._taskInfo.function_id)

	self.m_functionNameTxt:setText(self._taskInfo.name)
	self.m_descText:setText(self._taskInfo.txt)
	self.m_funcBgLoader:setURL(var_0_2:getGuideTaskPic(self._taskInfo.pic))

	self._finished = var_0_0:isFinished(self._taskInfo.id)

	if g.core.const.ConstMgr.FUNCTION_TYPE.SPIRE == self._taskInfo.function_id and var_0_1:isFunctionUnlock(self._taskInfo.function_id) then
		self._unlock = true
	end

	if not self._unlock or not self._finished then
		self.m_stateController:setSelectedIndex(0)
	elseif var_0_0:isAwarded(self._taskInfo.id) then
		self.m_stateController:setSelectedIndex(2)
	else
		self.m_stateController:setSelectedIndex(1)
	end

	self.m_awardList:setNumItems(#self._awards)
	self.m_functionList:setNumItems(#self._classifyData)
	self.m_functionList:setSelectedIndex(self._selectTabIdx - 1)
	self.m_taskList:setNumItems(#self._taskList)
end

function GuideTaskViewComp:_onFunctionItemRender(arg_7_1, arg_7_2)
	if self._classifyData[arg_7_1 + 1] then
		arg_7_2:updateTabCell(self._classifyData[arg_7_1 + 1])
	end
end

function GuideTaskViewComp:_onClickFunctionTab(arg_8_1)
	self._selectTabIdx = arg_8_1:getDataValue() + 1

	self:_updateViewInfo()
	self.m_switchTransition:play()
end

function GuideTaskViewComp:_onAwardsItemRender(arg_9_1, arg_9_2)
	if self._awards[arg_9_1 + 1] then
		arg_9_2:updateIcon(self._awards[arg_9_1 + 1])
	end
end

function GuideTaskViewComp:_onTaskItemRender(arg_10_1, arg_10_2)
	if self._taskList[arg_10_1 + 1] then
		arg_10_2:udpateTaskCell(self._taskList[arg_10_1 + 1])
	end
end

function GuideTaskViewComp:_onClickGoToBtn()
	if not self._unlock then
		if g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA == self._taskInfo.function_id and var_0_1:isFunctionUnlock(self._taskInfo.function_id) then
			g.core.module.ModuleManager:tip(g.core.lang:get(431041))
		elseif g.core.const.ConstMgr.FUNCTION_TYPE.SPIRE == self._taskInfo.function_id and var_0_1:isFunctionUnlock(self._taskInfo.function_id) then
			g.core.module.ModuleManager:tip(g.core.lang:get(432033))
		else
			g.core.module.ModuleManager:tip(self._unlockTxt)
		end

		return
	end

	g.view.entrance.ModuleGotoProxy:gotoModule(self._taskInfo.route)
end

function GuideTaskViewComp:_onClickGetAwardsBtn()
	if self._finished then
		g.core.network.GameNetProxy:send_C2S_GuideTask_Award({
			id = self._taskInfo.id
		})
	end
end

function GuideTaskViewComp:_onRecvTaskAwardsBack()
	g.core.module.ModuleManager:awardSummary(var_0_0:getGuideTaskAwards(self._taskInfo.id), true)
	self:_updateViewInfo()
end

function GuideTaskViewComp:_onActionStatusFlush()
	self:_updateViewInfo()
end

function GuideTaskViewComp:_onRecvGuideTaskInfo()
	self:_updateViewInfo()
end

function GuideTaskViewComp:_cleanTabNew()
	self._taskInfo = self._classifyData[self._selectTabIdx]

	g.core.model.User.guideTaskData:cleanGuideTaskNew(self._taskInfo.id)
	self:dispatchCompEvent("GUIDE_TASK_TAB_CLEAR_NEW")
end

return GuideTaskViewComp
