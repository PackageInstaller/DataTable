local var_0_0 = g.core.const.ConstMgr.PeakArenaConst
local var_0_1 = g.core.model.User.peakArenaData
local var_0_2 = g.core.module.ModuleManager
local PeakArenaScheduleLayer = class("PeakArenaScheduleLayer", require("app.fairyGUI.peakArena.UI_PeakArenaScheduleLayer"), function()
	return fgui.GComponent:create({
		resName = "PeakArenaScheduleLayer",
		pkgPath = "ui/peakArena/peakArena",
		isFullScreen = true,
		pkgName = "peakArena"
	}, ...)
end)

function PeakArenaScheduleLayer:ctor()
	self._groupId = var_0_0.TOP_BAR_ID

	self.m_topBarComp:setResInfoById(var_0_0.TOP_BAR_ID)
end

function PeakArenaScheduleLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CUserSnapshot), self)
	self:_updateComp(var_0_0.FINAL_GROUP_ID)
	self.m_enterTransition:play()
end

function PeakArenaScheduleLayer:_onS2CUserSnapshot()
	self:_updateComp(self._groupId)
end

function PeakArenaScheduleLayer:receiveCompEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "ClickGroupNameItem" then
		self:_updateComp(arg_5_2)
	end
end

function PeakArenaScheduleLayer:_updateComp(arg_6_1)
	self._groupId = arg_6_1

	if var_0_1:getGroupStruct(arg_6_1):isEmpty() then
		var_0_2:tip(g.core.lang:get(307026))
	else
		self.m_groupMemberComp:changeGroup(arg_6_1)
	end
end

return PeakArenaScheduleLayer
