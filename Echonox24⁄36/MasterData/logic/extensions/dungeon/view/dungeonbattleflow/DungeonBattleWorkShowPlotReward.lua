-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/dungeonbattleflow/DungeonBattleWorkShowPlotReward.lua

module("logic.extensions.dungeon.view.dungeonbattleflow.DungeonBattleWorkShowPlotReward", package.seeall)

local M = class("DungeonBattleWorkShowPlotReward", WorkBase)

function M:onEnter(context)
	self:_showReward()
end

function M:onExit(isInterrupt)
	return
end

function M:_showReward()
	if self.context.model:getIsPlotDungeon() then
		if MainlineDungeonController.instance:hasCacheItem() then
			MainlineDungeonController.instance:popCacheItemMoList(self._onRewardViewClose, self)
		else
			self:onDone(WorkResult.Succeed)
		end
	end
end

function M:_onRewardViewClose()
	MainlineDungeonController.instance:clearCacheItem()
	self:onDone(WorkResult.Succeed)
end

return M
