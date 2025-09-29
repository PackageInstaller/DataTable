-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/redo/BattleSheetMusicRedoCommand.lua

module("logic.battle.battleflow.component.command.impl.redo.BattleSheetMusicRedoCommand", package.seeall)

local BattleSheetMusicRedoCommand = class("BattleSheetMusicRedoCommand", BattleCommandBase)
local kDefaultEffectName = "gangqin_do"

function BattleSheetMusicRedoCommand:parseServerRedoCommand(cmdParser, sheetMusicNO)
	local cmd = BattleSheetMusicRedoCommand:createInstance()

	cmd:setEntityId(sheetMusicNO.entity)
	cmd:setSkillId(sheetMusicNO.skill)
	cmd:setSheetMusicCode(sheetMusicNO.sheetMusicCode)
	cmd:setNoteNOList(sheetMusicNO.notes)
	cmdParser:addCommand(cmd)
end

function BattleSheetMusicRedoCommand:onInit()
	self._sheetMusicCode = false
	self._entityId = false
	self._skillId = false
	self._noteNOList = false
end

function BattleSheetMusicRedoCommand:onClear()
	self._sheetMusicCode = false
	self._entityId = false
	self._skillId = false
	self._noteNOList = false
end

function BattleSheetMusicRedoCommand:execute(battleFlow, runningContext)
	local pianoTerrainMgr = BattleMgr.instance:getPianoTerrainMgr()

	pianoTerrainMgr:setupMusic(self._entityId, self._skillId, self._sheetMusicCode, self._noteNOList)
	self:finish(true)
end

function BattleSheetMusicRedoCommand:toString()
	return string.format("[redo] [sheet music redo command entityId = %s, skillId = %s, sheetMusicCode = %s]", self._entityId, self._skillId, self._sheetMusicCode)
end

function BattleSheetMusicRedoCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleSheetMusicRedoCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

function BattleSheetMusicRedoCommand:setSheetMusicCode(sheetMusicCode)
	self._sheetMusicCode = sheetMusicCode

	return self
end

function BattleSheetMusicRedoCommand:setNoteNOList(noteNOList)
	self._noteNOList = noteNOList

	return self
end

return BattleSheetMusicRedoCommand
