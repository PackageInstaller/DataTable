-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/dungeonbattleflow/DungeonBattleModel.lua

module("logic.extensions.dungeon.view.dungeonbattleflow.DungeonBattleModel", package.seeall)

local M = class("DungeonBattleModel")

function M:setInfo(info)
	self._dungeonCode = info.dungeonCode
	self._dungeonMo = DungeonModel.instance:getDungeonMoById(self._dungeonCode)
	self._dungeonCo = self._dungeonMo:getDungeonCO()
	self._isShowPlot = info.isShowPlot
	self._hasAfflatusBuff = info.afflatusBuff
	self._multiCount = info.multiCount
	self._dungeonIndex = info.dungeonIndex
	self._isNotReturnDungeon = false

	self:setGamePlay(info.gamePlay)
end

function M:getDungeonType()
	return self._dungeonCo.type
end

function M:getDungeonCode()
	return self._dungeonCode
end

function M:getDungeonCo()
	return self._dungeonCo
end

function M:getDungeonStarRequire()
	return self._dungeonCo.starRequire
end

function M:getPlotCodeBeforeBattle()
	return self._dungeonCo.plotBeforeBattle
end

function M:getPlotCodeAfterBattle()
	return self._dungeonCo.plotAfterBattle
end

function M:getIsPlotDungeon()
	return self._dungeonMo:getIsPlotNode()
end

function M:getDungeonBGM()
	local dungeonCO = DungeonConfig.instance:getDungeonCfgById(self._dungeonCode)

	if dungeonCO and dungeonCO.bgmName and dungeonCO.bgmName ~= "" then
		return dungeonCO.bgmName
	else
		return "music_battlebgm1"
	end
end

function M:getDungeonSpaceAudio()
	local dungeonCO = DungeonConfig.instance:getDungeonCfgById(self._dungeonCode)

	if dungeonCO and dungeonCO.spaceAudioName and dungeonCO.spaceAudioName ~= "" then
		return dungeonCO.spaceAudioName
	else
		return "amb_battle_city"
	end
end

function M:getDungeonIndex()
	return self._dungeonIndex
end

function M:setBattleIsWin(win)
	self._isWin = win
end

function M:getBattleIsWin()
	return self._isWin
end

function M:setIsNotReturnDungeon(status)
	self._isNotReturnDungeon = status
end

function M:getIsNotReturnDungeon()
	return self._isNotReturnDungeon
end

function M:getPlotCodeAfterReady()
	return self._dungeonCo.plotAfterReady
end

function M:isShowPlot()
	return self._isShowPlot
end

function M:isHaveAfflatusBuff()
	return self._hasAfflatusBuff
end

function M:setMultiCount(count)
	self._multiCount = count
end

function M:getMultiCount()
	return self._multiCount
end

function M:setGamePlay(gamePlay)
	self._gamePlay = gamePlay
end

function M:getGamePlay()
	return self._gamePlay
end

return M
