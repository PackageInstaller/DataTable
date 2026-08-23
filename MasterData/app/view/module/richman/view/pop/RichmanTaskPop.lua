local var_0_0 = g.core.model.User.richmanData
local RichmanTaskPop = class("RichmanTaskPop", require("app.fairyGUI.richman.UI_RichmanTaskPop"), function()
	return fgui.GComponent:create({
		resName = "RichmanTaskPop",
		pkgPath = "ui/richman/richman",
		pkgName = "richman"
	})
end)

function RichmanTaskPop:ctor()
	self:showAtCenter()
	self.m_taskList:setVirtual()
	self.m_taskList:setItemRenderer(handler(self, self._onTaskRenderer))
	self.m_taskList:doFairyBatching(false)
	self.m_closeBtn:setClickCallBack(handler(self, self._onClosePop))
	self:updateTaskView()
end

function RichmanTaskPop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_TASKAWARD, self.onRichmanTaskReward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_RICH_MAN_GETINFO, self.updateTaskView, self)
end

function RichmanTaskPop:_onTaskRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateRichmanTaskCell(self._taskList[arg_4_1 + 1])
end

function RichmanTaskPop:updateTaskView()
	local var_5_0 = var_0_0:getTaskData():getTaskList()

	var_5_0 = var_5_0 or {}
	self._taskList = var_5_0

	self.m_taskList:setNumItems(#self._taskList)
end

function RichmanTaskPop:onRichmanTaskReward(arg_6_1, arg_6_2, arg_6_3)
	g.core.module.ModuleManager:awardSummary(arg_6_3.awards)
	self:updateTaskView()
end

function RichmanTaskPop:_onClosePop()
	if self._inClose then
		return
	end

	self._inClose = true

	self.m_backTransition:play(handler(self, self._onRemoveSelf))
end

function RichmanTaskPop:_onRemoveSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return RichmanTaskPop
