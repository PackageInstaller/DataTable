local var_0_0 = g.core.model.User.retroData
local RetroActivityTaskPop = class("RetroActivityTaskPop", require("app.fairyGUI.retro.UI_RetroActivityTaskPop"), function()
	return fgui.GComponent:create({
		resName = "RetroActivityTaskPop",
		pkgPath = "ui/retro/retro",
		pkgName = "retro"
	}, ...)
end)

function RetroActivityTaskPop:ctor()
	self:showAtCenter()
	self:_initMainView()
end

function RetroActivityTaskPop:_initMainView()
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskItemRender))
	self.m_taskList:doFairyBatching(false)
	self.m_popPanel:setText("")
	self.m_title:setText(var_0_0:getRetroDisplayInfo().task_name)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_PAGE_OPEN_02)
end

function RetroActivityTaskPop:_onTaskItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateTaskCell(self._taskList[arg_4_1 + 1])
end

function RetroActivityTaskPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RETRO_TASKAWARD, handler(self, self._onS2CRetroTaskAward), self)
	self:_updateView()
end

function RetroActivityTaskPop:_updateView()
	self._taskList = var_0_0:getTaskData():getTaskPopListData()

	self.m_taskList:setNumItems(#self._taskList)
	self.m_timeComp:updateTime()
end

function RetroActivityTaskPop:_onS2CRetroTaskAward(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self:_updateView()
end

return RetroActivityTaskPop
