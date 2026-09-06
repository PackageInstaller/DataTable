-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anchorsimulator/data/AnchorSimulatorMo.lua

module("logic.extensions.anchorsimulator.data.AnchorSimulatorMo", package.seeall)

local AnchorSimulatorMo = class("AnchorSimulatorMo")

function AnchorSimulatorMo:ctor(activityId)
	self._activityId = activityId
	self._heatValue = 0
	self._propertys = {}
	self._finishTrainRounds = 0
	self._finishLiveRounds = 0
	self._curStrength = 0
	self._curRoundTrainTimes = 0
	self._todayRefreshBuffTimes = 0
	self._buffId = 0
	self._selectClasses = {}
	self._todayLiveTimes = 0
end

function AnchorSimulatorMo:dispose()
	return
end

function AnchorSimulatorMo:handlePM_AnchorSimulatorGetInfoRes(msg)
	self._heatValue = checknumber(msg.heatValue)
	self._finishTrainRounds = msg.finishTrainRounds
	self._finishLiveRounds = msg.finishLiveRounds
	self._curStrength = msg.curStrength
	self._curRoundTrainTimes = msg.curRoundTrainTimes
	self._todayRefreshBuffTimes = msg.todayRefreshBuffTimes
	self._buffId = msg.buffId
	self._todayLiveTimes = msg.todayLiveTimes

	table.clear(self._propertys)

	for i, v in ipairs(msg.propertyList) do
		self._propertys[v.propertyType] = v
	end
end

function AnchorSimulatorMo:handlePM_AnchorSimulatorTrainRes(msg)
	self._finishTrainRounds = msg.finishTrainRounds
	self._curStrength = msg.curStrength
	self._curRoundTrainTimes = msg.curRoundTrainTimes
	self._buffId = msg.buffId
	self._todayRefreshBuffTimes = msg.todayRefreshBuffTimes

	table.clear(self._propertys)

	for i, v in ipairs(msg.propertyList) do
		self._propertys[v.propertyType] = v
	end

	table.clear(self._selectClasses)
	table.insertto(self._selectClasses, msg.selectClasses)
end

function AnchorSimulatorMo:handlePM_AnchorSimulatorRefreshBuffRes(msg)
	self._todayRefreshBuffTimes = msg.todayRefreshBuffTimes
	self._buffId = msg.buffId
end

function AnchorSimulatorMo:handlePM_AnchorSimulatorStartLiveRes(msg)
	self._heatValue = checknumber(msg.heatValue)
	self._finishLiveRounds = msg.finishLiveRounds
	self._todayLiveTimes = msg.todayLiveTimes
end

function AnchorSimulatorMo:handlePM_AnchorSimulatorRankViewRes(msg)
	return
end

function AnchorSimulatorMo:getHeatValue()
	return self._heatValue
end

function AnchorSimulatorMo:getCurPropertyExp(propertyType)
	local property = self._propertys[propertyType]

	return (property or nil) and (property.exp or 0)
end

function AnchorSimulatorMo:getFinishTrainRounds()
	return self._finishTrainRounds
end

function AnchorSimulatorMo:getFinishLiveRounds()
	return self._finishLiveRounds
end

function AnchorSimulatorMo:isCanStartLive()
	return self._finishTrainRounds > self._finishLiveRounds
end

function AnchorSimulatorMo:getCurStrength()
	return self._curStrength
end

function AnchorSimulatorMo:getCurRoundTrainTimes()
	return self._curRoundTrainTimes
end

function AnchorSimulatorMo:getRefreshBuffTimes()
	return self._todayRefreshBuffTimes
end

function AnchorSimulatorMo:getBuffId()
	return self._buffId
end

function AnchorSimulatorMo:getSelectClasses()
	return self._selectClasses
end

function AnchorSimulatorMo:getTodayLiveTimes()
	return self._todayLiveTimes
end

return AnchorSimulatorMo
