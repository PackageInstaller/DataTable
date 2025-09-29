-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/free/AirWorkShopFreeEndlessMo.lua

module("logic.extensions.airworkshop.model.free.AirWorkShopFreeEndlessMo", package.seeall)

local M = class("AirWorkShopFreeEndlessMo")

function M:ctor()
	return
end

function M:updateFromServer(info)
	self._maxWinNum = info.maxWinNum
	self._winNum = info.winNum
	self._life = info.life
	self._isWin = info.isWin
	self._recordLst = {}

	if info.record and #info.record > 0 then
		for index, LevelNO in ipairs(info.record) do
			table.insert(self._recordLst, LevelNO)
		end
	end

	self._match = nil

	if info.match and info.match.mapId and tonumber(info.match.mapId) > 0 then
		self._match = info.match
	end
end

function M:getStatusMsg()
	local msg = {}

	table.insert(msg, string.format("无尽模式:历史最高连胜次数:%s", self._maxWinNum))
	table.insert(msg, string.format("当前连胜次数:%s", self._winNum))
	table.insert(msg, string.format("life:%s", self._life))
	table.insert(msg, string.format("当前关卡是否赢:%s", self._isWin))
	table.insert(msg, string.format("记录关卡数量:%s", #self._recordLst))

	if #self._recordLst > 0 then
		for index, value in ipairs(self._recordLst) do
			table.insert(msg, string.format("    [%s]mapId:%s", index, value.mapId))
		end
	end

	if self._match then
		table.insert(msg, string.format("匹配到的关卡:%s", self._match.mapId))
	else
		table.insert(msg, "匹配到的关卡:空")
	end

	return table.concat(msg, "\n")
end

function M:getMaxWinNum()
	return self._maxWinNum or 0
end

function M:getCurWinNum()
	return self._winNum or 0
end

function M:getCurLife()
	return self._life or 0
end

function M:getCurUseLife()
	local max = AirWorkShopConfig.instance:getAtkConst("MaxEndLessLife").numValue
	local curLife = max - self:getCurLife()

	curLife = curLife < 0 and 0 or curLife

	return curLife
end

function M:getIsWin()
	return self._isWin
end

function M:getRecordLst()
	return self._recordLst
end

function M:getMatchLevelNO()
	return self._match
end

function M:setMatchLevelNO(levelNO)
	self._match = levelNO
end

return M
