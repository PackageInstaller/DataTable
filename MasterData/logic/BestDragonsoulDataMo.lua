-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bestdragonsoul/model/BestDragonsoulDataMo.lua

module("logic.extensions.bestdragonsoul.model.BestDragonsoulDataMo", package.seeall)

local BestDragonsoulDataMo = class("BestDragonsoulDataMo")

function BestDragonsoulDataMo:ctor()
	self._gamePlanId = 0
	self._curStageIdx = 0
	self._curAreaIdx = 0
	self._scoreDic = {}
	self._curStageTime = 0
	self._propsCount = {}
	self._propsScore = {}
end

function BestDragonsoulDataMo:init(gamePlanId, stageIdx)
	self._gamePlanId = gamePlanId

	self:setCurStageIdx(stageIdx)
	self:setCurStageTime(self:getCurMaxStageTime())
	self:setCurAreaIdx(0)
	self:initPropFmt()
end

function BestDragonsoulDataMo:startNextArea()
	local curAreaIdx = self:getCurAreaIdx()
	local curMaxAreaIdx = self:getCurMaxAreaIdx()

	curAreaIdx = math.max((curAreaIdx + 1) % (curMaxAreaIdx + 1), 1)

	self:setCurAreaIdx(curAreaIdx)
end

function BestDragonsoulDataMo:initPropFmt()
	local stageData = BestdragonsoulConfig.instance:getGameStageData(self._gamePlanId, self:getCurStageIdx())

	self._propfmt = {}

	for areaIdx, areaData in ipairs(stageData) do
		self._propfmt[areaIdx] = self:initAreaPropFmt(areaData)
	end

	self._propsCount = {}
	self._propsScore = {}
end

function BestDragonsoulDataMo:setCurStageTime(time)
	self._curStageTime = time
end

function BestDragonsoulDataMo:addCurStageTime(delta)
	self._curStageTime = Mathf.Clamp(self:getCurStageTime() + delta, 0, self:getCurMaxStageTime())
end

function BestDragonsoulDataMo:getCurStageTime()
	return self._curStageTime
end

function BestDragonsoulDataMo:getCurMaxStageTime()
	local gameData = BestdragonsoulConfig.instance:getGameDataById(self._gamePlanId)

	return checknumber(gameData.stageTimeArray[self:getCurStageIdx()])
end

function BestDragonsoulDataMo:setCurStageIdx(stageIdx)
	self._curStageIdx = stageIdx
end

function BestDragonsoulDataMo:getCurStageIdx()
	return self._curStageIdx
end

function BestDragonsoulDataMo:getMaxStageScore()
	return BestdragonsoulConfig.instance:getMaxScorePerGame()
end

function BestDragonsoulDataMo:getCurMaxStageIdx()
	local stageCfg = BestdragonsoulConfig.instance:getGameStageCfg(self._gamePlanId)

	return #stageCfg
end

function BestDragonsoulDataMo:getCurAreaData()
	return BestdragonsoulConfig.instance:getGameAreaData(self._gamePlanId, self:getCurStageIdx(), self:getCurAreaIdx())
end

function BestDragonsoulDataMo:getCurMaxAreaIdx()
	local stageData = BestdragonsoulConfig.instance:getGameStageData(self._gamePlanId, self:getCurStageIdx())

	return #stageData
end

function BestDragonsoulDataMo:addStageScore(propId, delta)
	local myScore = 0
	local otherScore = 0

	for k, v in pairs(self._propsScore) do
		if k ~= propId then
			otherScore = otherScore + v
		else
			myScore = v
		end
	end

	self._propsScore[propId] = Mathf.Clamp(myScore + delta, 0, self:getMaxStageScore() - otherScore)
	self._propsCount[propId] = self._propsCount[propId] or 0
	self._propsCount[propId] = self._propsCount[propId] + 1
end

function BestDragonsoulDataMo:isGetMaxStageScore()
	return self:getStageTotalScore() >= self:getMaxStageScore()
end

function BestDragonsoulDataMo:getStageTotalScore()
	local score = 0

	for k, v in pairs(self._propsScore) do
		score = score + v
	end

	return score
end

function BestDragonsoulDataMo:getPropsToPrizes()
	local prizes = {}

	for k, v in pairs(self._propsCount) do
		local p = {}

		p.typeId = k
		p.num = v

		table.insert(prizes, p)
	end

	return prizes
end

function BestDragonsoulDataMo:getStageScore(propId)
	return self._propsScore[propId] or 0
end

function BestDragonsoulDataMo:setCurAreaIdx(areaIdx)
	self._curAreaIdx = areaIdx
end

function BestDragonsoulDataMo:getCurAreaIdx()
	return self._curAreaIdx
end

function BestDragonsoulDataMo:getCurRowNum()
	return self:getCurAreaData().rowNum
end

function BestDragonsoulDataMo:getCurColNum()
	return self:getCurAreaData().colNum
end

function BestDragonsoulDataMo:getCurRowInterval()
	return self:getCurAreaData().rowInterval
end

function BestDragonsoulDataMo:getCurAreaInterval()
	return self:getCurAreaData().areaInterval
end

function BestDragonsoulDataMo:getCurMoveDuration()
	return self:getCurAreaData().moveDuration
end

function BestDragonsoulDataMo:getCurAreaPropFmt()
	return self._propfmt[self:getCurAreaIdx()]
end

function BestDragonsoulDataMo:initAreaPropFmt(areaData)
	local propList = {}
	local totalPropNum = 0
	local propSettingArray = string.split(areaData.propSettingStr, "#")

	for _, propInfoStr in ipairs(propSettingArray) do
		local propInfo = string.split(propInfoStr, ":")
		local propId = checknumber(propInfo[1])
		local propNum = checknumber(propInfo[2])

		totalPropNum = totalPropNum + propNum

		for num = 1, propNum do
			table.insert(propList, propId)
		end
	end

	local areaPropFmt = {}
	local propNum = 0

	for rowIdx = 1, areaData.rowNum do
		areaPropFmt[rowIdx] = {}

		for colIdx = 1, areaData.colNum do
			propNum = propNum + 1
			areaPropFmt[rowIdx][colIdx] = propList[propNum] or 0
		end
	end

	if propNum < totalPropNum then
		printError("配置道具数量超过限制,超过部分不会被使用,请检查配置表")
	end

	for row = 1, areaData.rowNum do
		for col = 1, areaData.colNum do
			local tarRow = Mathf.Random(1, areaData.rowNum)
			local tarCol = Mathf.Random(1, areaData.colNum)

			areaPropFmt[row][col] = areaPropFmt[tarRow][tarCol]
			areaPropFmt[tarRow][tarCol] = areaPropFmt[row][col]
		end
	end

	return areaPropFmt
end

return BestDragonsoulDataMo
