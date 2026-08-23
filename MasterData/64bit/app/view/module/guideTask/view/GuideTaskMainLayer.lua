local var_0_0 = g.core.model.User.guideTaskData
local GuideTaskMainLayer = class("GuideTaskMainLayer", require("app.fairyGUI.guideTask.UI_GuideTaskMainLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/guideTask/guideTask",
		resName = "GuideTaskMainLayer",
		pkgName = "guideTask"
	}, ...)
end)

function GuideTaskMainLayer:ctor()
	self._classifyTask = nil
	self._taskData = nil
	self._selectedTabIndex = 1

	self:addBg("bg/guideTask/bg_gongnengzhiyin.jpg")
	self.m_topBarComp:setResInfoById(108)
	self:_initRegisterListen()
	self.m_enterTransition:play()
end

function GuideTaskMainLayer:_initRegisterListen()
	self.m_classifyTabList:setIniter()
	self.m_classifyTabList:setItemRenderer(handler(self, self._onTabItemRender))
	self.m_classifyTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickClassifyGuideTask))
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUIDE_TASK_INFO, handler(self, self._onRcvGuideTaskInfo), self)
end

function GuideTaskMainLayer:_onRcvGuideTaskInfo()
	self:_updateGuideMainView()
end

function GuideTaskMainLayer:onLoad()
	self:_updateGuideMainView()
	g.core.network.GameNetProxy:send_C2S_GuideTask_Info({})
end

function GuideTaskMainLayer:_updateGuideMainView()
	self._classifyTask = self._classifyTask or var_0_0:getClassifyTask()
	self._taskData = var_0_0:getClassifyTaskByType(self._selectedTabIndex)

	local var_6_0 = table.nums(self._classifyTask)

	if var_6_0 > 0 then
		self.m_classifyTabList:setNumItems(var_6_0)
		self.m_classifyTabList:resizeToFit(var_6_0)
		self.m_classifyTabList:setSelectedIndex(self._selectedTabIndex - 1)
		self.m_taskMainComp:updateMainView(self._taskData)
	end
end

function GuideTaskMainLayer:receiveCompEvent(arg_7_1)
	if arg_7_1 == "GUIDE_TASK_TAB_CLEAR_NEW" then
		local var_7_0 = table.nums(self._classifyTask)

		if var_7_0 > 0 then
			self.m_classifyTabList:setNumItems(var_7_0)
			self.m_classifyTabList:resizeToFit(var_7_0)
		end
	end
end

function GuideTaskMainLayer:_onTabItemRender(arg_8_1, arg_8_2)
	local var_8_0 = var_0_0:getClassifyTaskByType(arg_8_1 + 1)

	if var_8_0 and next(var_8_0) then
		arg_8_2:setTitle(var_8_0[1].type_name)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = arg_8_2:getChild("redPointComp"),
			customData = {
				type = arg_8_1 + 1
			}
		})
	end
end

function GuideTaskMainLayer:_onClickClassifyGuideTask(arg_9_1)
	self._selectedTabIndex = arg_9_1:getDataValue() + 1
	self._taskData = var_0_0:getClassifyTaskByType(self._selectedTabIndex)

	self.m_taskMainComp:setTaskSelectedIdx(1)
	self.m_taskMainComp:updateMainView(self._taskData)
end

return GuideTaskMainLayer
