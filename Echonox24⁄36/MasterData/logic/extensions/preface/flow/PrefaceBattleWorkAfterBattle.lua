-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preface/flow/PrefaceBattleWorkAfterBattle.lua

module("logic.extensions.preface.flow.PrefaceBattleWorkAfterBattle", package.seeall)

local M = class("PrefaceBattleWorkAfterBattle", WorkBase)
local kStorySaveKey = "kStorySaveKey"
local ep4StoryId = 1000401

function M:onEnter(context)
	self._plotCode = context.model:getPlotCodeAfterBattle()

	local isShowPlot = context.model:isShowPlot()

	if isShowPlot and context.model:getBattleIsWin() and self._plotCode and self._plotCode > 0 then
		StoryMgr.instance:startSingle(self._plotCode, false, self._onPlotFinish, self, false, NewbieExtension_pb.PlotEnum.DUNGEON)
		StoryMgr.instance:isAfterBattle(true)
	else
		self:_doFinishReprot()
	end
end

function M:onExit(isInterrupt)
	return
end

function M:_onPlotFinish(storyId)
	if self._plotCode and self._plotCode == storyId then
		self:_doFinishReprot()
	end
end

function M:_doFinishReprot()
	if ep4StoryId == self._plotCode then
		local saveKey = string.format("%s_%s_%s", kStorySaveKey, PlayerModel.instance:getId(), ep4StoryId)

		Astral.LocalStorage.Instance:SetInt(saveKey, 1)
	end

	DungeonAgent.instance:SendFinishPostwarPlotRequest()
	self:onDone(WorkResult.Succeed)
end

return M
