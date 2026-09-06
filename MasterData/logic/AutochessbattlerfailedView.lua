-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/autochess/view/AutochessbattlerfailedView.lua

module("logic.extensions.autochess.view.AutochessbattlerfailedView", package.seeall)

local AutochessbattlerfailedView = class("AutochessbattlerfailedView", ViewComponent)

function AutochessbattlerfailedView:buildUI()
	AutochessbattlerfailedView.super.buildUI(self)

	self._txtTime = self:getTxt("txtTime")
end

function AutochessbattlerfailedView:onEnter()
	AutochessbattlerfailedView.super.onEnter(self)

	local activityId = AutochessModel.instance:getActivityId()
	local time = AutochessConfig.instance:getSettleTimeSec(activityId)

	self._targetTickTime = ServerTime.now() + time

	settimer(1, self._tick, self, true)
	self:_tick()
end

function AutochessbattlerfailedView:onExit()
	AutochessbattlerfailedView.super.onExit(self)
	removetimer(self._tick, self)
end

function AutochessbattlerfailedView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	self._txtTime.text = string.format("%ss后自动关闭", leftTime)

	if leftTime <= 0 then
		self._txtTime.text = "点击任意空白区域关闭界面"

		self:close()
	end
end

return AutochessbattlerfailedView
