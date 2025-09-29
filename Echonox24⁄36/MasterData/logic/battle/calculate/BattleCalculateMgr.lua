-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/calculate/BattleCalculateMgr.lua

module("logic.battle.calculate.BattleCalculateMgr", package.seeall)

local M = class("BattleCalculateMgr")

function M:onInit()
	self:onReset()
end

function M:onReset()
	if self._victoryPerformance then
		self._victoryPerformance:clear()
	end

	self._jumpParams = false
end

function M:startVictoryPerformance()
	SpaceX.OutlineFeatureUtils.UpdateOutlineDepth(true)

	self._victoryPerformance = VictoryPerformance:createInstance()

	self._victoryPerformance:start()
end

function M:stopVictoryPerformance()
	if self._victoryPerformance then
		SpaceX.OutlineFeatureUtils.UpdateOutlineDepth(false)
		self._victoryPerformance:returnSelf()

		self._victoryPerformance = false
	end
end

function M:playVictorTimeline()
	if self._victoryPerformance then
		self._victoryPerformance:playTimeline()
	end
end

function M:findFirstHeroCodeByDefaultRules(codeList)
	if #codeList == 0 then
		return false
	end

	if #codeList == 1 then
		return codeList[1]
	end

	local tempList = BattleTableUtil.getTempList()

	for i, code in ipairs(codeList) do
		table.insert(tempList, HeroDepotModel.instance:getHeroInfoByID(code))
	end

	local sortFunc = CharacterUtil.getSortFunc(CommEnum.HeroFilter.HeroDepot, CommEnum.HeroSortFieldType.Default, false)

	table.sort(tempList, sortFunc)

	local code = tempList[1]:getId()

	BattleTableUtil.releaseTempList(tempList)

	return code
end

function M:setBattleReturnJumpData(params)
	self._jumpParams = params
end

function M:getBattleReturnJumpData()
	return self._jumpParams
end

function M:hidePerform()
	if self._victoryPerformance then
		self._victoryPerformance:hideVictory()
	end
end

function M:showPerform()
	if self._victoryPerformance then
		self._victoryPerformance:showVictory()
	end
end

M.instance = M.New()

return M
