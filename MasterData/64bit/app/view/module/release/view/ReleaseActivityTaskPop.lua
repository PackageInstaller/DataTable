local var_0_0 = g.core.model.User.releaseActivityData
local ReleaseActivityTaskPop = class("ReleaseActivityTaskPop", require("app.fairyGUI.release.UI_ReleaseActivityTaskPop"), function()
	return fgui.GComponent:create({
		resName = "ReleaseActivityTaskPop",
		pkgPath = "ui/release/release",
		pkgName = "release"
	}, ...)
end)

function ReleaseActivityTaskPop:ctor()
	self:showAtCenter()
	self:_initMainView()
end

function ReleaseActivityTaskPop:_initMainView()
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRender))
	self.m_taskList:doFairyBatching(false)
	self.m_popPanel:setText("")
	self.m_popPanel:setTitle(var_0_0:getActivityReleaseDisplayCfg().task_name)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_PAGE_OPEN_02)
end

function ReleaseActivityTaskPop:_onTaskItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateTaskCell(self._taskList[arg_4_1 + 1])
end

function ReleaseActivityTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RELEASE_TASKAWARD, handler(self, self._onS2CReleaseTaskAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ACTION_STATUS_FLUSH, handler(self, self._updateView), self)
	self:_updateView()
end

function ReleaseActivityTaskPop:_updateView()
	self._taskList = var_0_0:getTaskData():getTaskPopListData()

	self.m_taskList:setNumItems(#self._taskList)
	self.m_activityComp:updateTime()
end

function ReleaseActivityTaskPop:_onS2CReleaseTaskAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	g.core.module.ModuleManager:awardSummary(arg_7_4.awards)
	self:_updateView()
end

return ReleaseActivityTaskPop
