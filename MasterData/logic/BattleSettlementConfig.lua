-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlesettlement/config/BattleSettlementConfig.lua

module("logic.extensions.battlesettlement.config.BattleSettlementConfig", package.seeall)

local BattleSettlementConfig = class("BattleSettlementConfig", BaseConfig)

function BattleSettlementConfig:onInit()
	BattleSettlementConfig.super.onInit(self)

	self._battleWinnerOpCfg = nil
	self._battleWinnerOpTypeCfg = nil
	self._battlePerfectWinOpCfg = nil
	self._battleTaskCfg = nil
end

function BattleSettlementConfig:getNames()
	return {
		"battle_winner_op",
		"battle_winner_op_type",
		"battle_perfect_win_op",
		"battle_task"
	}
end

function BattleSettlementConfig:handleConfig(name, content)
	if name == "battle_winner_op" then
		self._battleWinnerOpCfg = content
	elseif name == "battle_winner_op_type" then
		self._battleWinnerOpTypeCfg = content
	elseif name == "battle_perfect_win_op" then
		self._battlePerfectWinOpCfg = content
	elseif name == "battle_task" then
		self._battleTaskCfg = content
	end
end

function BattleSettlementConfig:getBattleWinnerOpCfgById(id)
	return self._battleWinnerOpCfg[id]
end

function BattleSettlementConfig:getBattleWinnerOpTypeCfgByType(typeId)
	return self._battleWinnerOpTypeCfg[typeId]
end

function BattleSettlementConfig:getBattleWinnerOpTypeCfgById(id)
	local cfg = self:getBattleWinnerOpCfgById(id)

	if cfg then
		return (self:getBattleWinnerOpTypeCfgByType(cfg.type))
	end

	return nil
end

function BattleSettlementConfig:getBattlePerfectWinOpCfgById(id)
	return self._battlePerfectWinOpCfg[id]
end

function BattleSettlementConfig:getBattlePerfectWinOpTypeCfgById(id)
	local cfg = self:getBattlePerfectWinOpCfgById(id)

	if cfg then
		return (self:getBattleWinnerOpTypeCfgByType(cfg.type))
	end

	return nil
end

function BattleSettlementConfig:getBattleTaskCfgById(id)
	return self._battleTaskCfg[id]
end

BattleSettlementConfig.instance = BattleSettlementConfig.New()

return BattleSettlementConfig
