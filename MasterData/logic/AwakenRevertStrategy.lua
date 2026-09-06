-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/model/AwakenRevertStrategy.lua

module("logic.extensions.timewheel.model.AwakenRevertStrategy", package.seeall)

local AwakenRevertStrategy = class("AwakenRevertStrategy")

function AwakenRevertStrategy:ctor()
	self:reset()
end

function AwakenRevertStrategy:init(curAwakenLv, raceId)
	local cfgPet = CharacterConfig.instance:getPetCo(raceId)

	self._costStrategyId = cfgPet.awakenCostStrategyId
	self._curAwakenLv = curAwakenLv
end

function AwakenRevertStrategy:reset()
	self._curAwakenLv = 1
end

function AwakenRevertStrategy:getResult()
	local cfgAwakenList = CharacterConfig.instance:getPetAwakenCostListCfgs(self._costStrategyId)

	printInfo("test 使用的是方案", self._costStrategyId)

	if not cfgAwakenList or #cfgAwakenList == 0 then
		printError("test 解决方案不存在", self._costStrategyId)

		return 1, 1
	end

	local petNum = 0
	local coinNum = 0

	for i, v in ipairs(cfgAwakenList) do
		if v.level <= self._curAwakenLv then
			petNum = petNum + v.needPetNum
			coinNum = coinNum + v.needCoinNum
		else
			break
		end
	end

	return petNum, coinNum
end

return AwakenRevertStrategy
