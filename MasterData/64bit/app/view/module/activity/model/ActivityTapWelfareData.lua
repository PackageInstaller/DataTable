local var_0_0 = g.core.common.ServerTime
local var_0_1 = g.core.platform.PlatformProxy
local ChannelConst = require("app.core.platform.const.ChannelConst")
local ActivityTapWelfareData = class("ActivityTapWelfareData")

function ActivityTapWelfareData:ctor()
	self:initData()
end

function ActivityTapWelfareData:initData()
	self._startTime = 1729094400
	self._endTime = 1730908800
end

function ActivityTapWelfareData:isShowEntrance()
	local var_3_0 = var_0_0:getTime()

	return self:_checkChannel() and var_3_0 >= self._startTime and var_3_0 < self._endTime
end

function ActivityTapWelfareData:_checkChannel()
	local var_4_0 = var_0_1:getCurChannel()

	if var_4_0.name == ChannelConst.ChannelNames.TAPTAP then
		return true
	end

	if var_4_0.name == ChannelConst.ChannelNames.YOOZOO then
		return var_4_0.subInfo == "iOS" or var_4_0.subInfo == "android"
	end

	return false
end

function ActivityTapWelfareData:saveRedPointStatus()
	local var_5_0 = g.core.common.Storage:load("tap_welfare.json", true) or {}

	var_5_0.is_click = true

	g.core.common.Storage:save("tap_welfare.json", var_5_0, true)
end

function ActivityTapWelfareData:isFirstClick()
	if not self:isShowEntrance() then
		return false
	end

	return not checkbool((g.core.common.Storage:load("tap_welfare.json", true) or {}).is_click)
end

return ActivityTapWelfareData
