local var_0_0 = g.core.model.User.newSlgData
local NewSlgSeasonTaskLayer = class("NewSlgSeasonTaskLayer", require("app.fairyGUI.newSlg.UI_NewSlgSeasonTaskLayer"), function()
	return fgui.GComponent:create({
		pkgName = "newSlg",
		isFullScreen = true,
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgSeasonTaskLayer"
	}, ...)
end)

function NewSlgSeasonTaskLayer:ctor()
	self:addBg("bg/newSlg/bg_hzts_renwu.jpg")
	self.m_taskList:setVirtual()
	self.m_taskList:doFairyBatching(false)
	self.m_taskList:setItemRenderer(handler(self, self.onSeasonTaskRenderer))

	self._taskData = nil

	self.m_ComTopBar:setResInfoById(372)
	self:updateTaskShow()
end

function NewSlgSeasonTaskLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SEASONTASKAWARD, self.onReward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_ENTER, self.updateTaskShow, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, self.onCrossDayNotify, self)
	self:newSchedule(handler(self, self._onUpdateTaskTime), 1)
end

function NewSlgSeasonTaskLayer:updateTaskShow()
	self._taskData = var_0_0:getSeasonTask()

	self.m_taskList:setNumItems(#self._taskData)
	self.m_taskList:transitionShowCells("listCardAUiLeftIn", 0.05, 1)
end

function NewSlgSeasonTaskLayer:onCrossDayNotify()
	if g.core.common.ServerTime:getTime() >= var_0_0:getActEndTime() then
		g.core.module.ModuleManager:popComponent()

		return
	end

	self:updateTaskShow()
end

function NewSlgSeasonTaskLayer:onSeasonTaskRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateSeasonTaskComp(self._taskData[arg_6_1 + 1])
end

function NewSlgSeasonTaskLayer:_onUpdateTaskTime(arg_7_1)
	for iter_7_0, iter_7_1 in ipairs((self.m_taskList:getChildren())) do
		if iter_7_1 and iter_7_1.updatePreTime then
			iter_7_1:updatePreTime(arg_7_1)
		end
	end
end

function NewSlgSeasonTaskLayer:onReward(arg_8_1, arg_8_2, arg_8_3)
	g.core.module.ModuleManager:awardSummary(arg_8_3.awards)
	self:updateTaskShow()
end

return NewSlgSeasonTaskLayer
