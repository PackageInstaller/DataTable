local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.model.User.pubgData
local PubgMapStartTimePop = class("PubgMapStartTimePop", require("app.fairyGUI.pubg.UI_PubgMapStartTimePop"), function()
	return fgui.GComponent:create({
		resName = "PubgMapStartTimePop",
		pkgName = "pubg"
	}, ...)
end)

function PubgMapStartTimePop:ctor()
	self:showAtCenter()

	self._mapData = var_0_1:getMapData()
	self._isClose = false

	self.m_enterTransition:play()
end

function PubgMapStartTimePop:onLoad()
	self:newSchedule(handler(self, self._onUpdateStartTime), 1)
	self:_onUpdateStartTime()
end

function PubgMapStartTimePop:_onUpdateStartTime()
	local var_4_0 = self._mapData:getMapStartTime() - var_0_0:getTime()

	if var_4_0 > 0 then
		self.m_timeText:setText(g.core.lang:get(430930, {
			time = var_4_0
		}))
	else
		self:newScheduleOnce(handler(self, self.endTime))
	end
end

function PubgMapStartTimePop:endTime()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self._onClickClose))
end

function PubgMapStartTimePop:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return PubgMapStartTimePop
