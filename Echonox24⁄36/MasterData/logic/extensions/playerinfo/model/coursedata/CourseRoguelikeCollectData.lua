-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/coursedata/CourseRoguelikeCollectData.lua

module("logic.extensions.playerinfo.model.coursedata.CourseRoguelikeCollectData", package.seeall)

local M = class("CourseRoguelikeCollectData")

function M:ctor(roguelikeInfo)
	local roguelikes = {}
	local totalPass = 0
	local totalFinisedCfg = RoguelikeConfig.instance:getHandbookCount(999)

	for i, v in ipairs(roguelikeInfo.scriptInfo) do
		local scriptCfg = RoguelikeConfig.instance:getScriptById(v.scriptId)

		if scriptCfg and scriptCfg.type ~= 1 then
			totalPass = totalPass + v.passCnt

			local finishCfgCnt, _, _, clue = RoguelikeConfig.instance:getHandbookCount(v.scriptId)

			assert(finishCfgCnt >= 0, "副本数据有误，副本id:" .. v.scriptId)

			local finish = v.finishCnt or 0
			local rogue = CourseRoguelikeData.New(v, clue, finishCfgCnt ~= 0 and finish / finishCfgCnt or 1)

			table.insert(roguelikes, rogue)

			totalFinisedCfg = totalFinisedCfg + finishCfgCnt
		end
	end

	self._roguelikes = roguelikes
	self._totalPassed = totalPass
	self._totalFinisedRate = roguelikeInfo.totalFinish / totalFinisedCfg
end

function M:getRoguelikeList()
	return self._roguelikes
end

function M:getTotalPassCount()
	return self._totalPassed
end

function M:getTotalFinishedRate()
	return self._totalFinisedRate
end

return M
