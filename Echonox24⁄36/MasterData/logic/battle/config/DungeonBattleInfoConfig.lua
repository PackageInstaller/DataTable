-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/config/DungeonBattleInfoConfig.lua

module("logic.battle.config.DungeonBattleInfoConfig", package.seeall)

local DungeonBattleInfoConfig = class("DungeonBattleInfoConfig", BaseConfig)

function DungeonBattleInfoConfig:onInit()
	self._cfgBattleInfo = false
	self._cfgBattleInfoWrapper = {}
end

function DungeonBattleInfoConfig:getNames()
	return {}
end

function DungeonBattleInfoConfig:handleConfig(name, content)
	return
end

function DungeonBattleInfoConfig:getDungeonBattleInfoCOWrapper(code)
	local battleInfoCOWrapper = self._cfgBattleInfoWrapper[code]

	if not battleInfoCOWrapper then
		local battleInfoCO = BattleConfig.instance:getBattleLevelCO(code)

		battleInfoCOWrapper = battleInfoCO and DungeonBattleInfoCOWrapper.New(battleInfoCO) or false
		self._cfgBattleInfoWrapper[code] = battleInfoCOWrapper
	end

	return battleInfoCOWrapper
end

DungeonBattleInfoConfig.instance = DungeonBattleInfoConfig.New()

return DungeonBattleInfoConfig
