-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonReportMO.lua

module("logic.extensions.season.model.SeasonReportMO", package.seeall)

local M = class("SeasonReportMO")

function M:ctor()
	return
end

function M:updateByAgent(NO)
	self._taskCfg = SeasonConfig.instance:getConfigByKey(ConfigName.SeasonTask, NO.id)
	self._todayPoint = NO.todayPoint
	self._cumulativePoint = NO.cumulativePoint
end

function M:getTodayNumStr()
	return tostring(self:getTodayNum()) .. self:getQuantifier()
end

function M:getTodayNum()
	return self._todayPoint
end

function M:getQuantifier()
	return self._taskCfg.quantifier
end

function M:getTotalNumStr()
	return tostring(self._cumulativePoint) .. self._taskCfg.quantifier
end

function M:getDesc()
	local strList = string.split(self._taskCfg.text, "#")

	return strList[2]
end

return M
