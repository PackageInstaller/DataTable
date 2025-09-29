-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/battleflow/viewextension/TeachingBattleRoundExtensionView.lua

module("logic.extensions.dungeon.battleflow.viewextension.TeachingBattleRoundExtensionView", package.seeall)

local TeachingBattleRoundExtensionView = class("TeachingBattleRoundExtensionView", IBattleExtensionView)

function TeachingBattleRoundExtensionView:dependMainResource()
	return "ui/views/battle/teach_explore_battle_hint.prefab"
end

function TeachingBattleRoundExtensionView:attachToWhichRoot()
	return IBattleExtensionView.AttackRoot.TOP_LEFT
end

function TeachingBattleRoundExtensionView:buildUI()
	self._roundTxt = self:getTextByPath("hint1/txtResidue")
	self._descTxt = self:getTextByPath("hint1/txtHint")
end

function TeachingBattleRoundExtensionView:destroyUI()
	return
end

function TeachingBattleRoundExtensionView:onEnter()
	self:_setEvent(true)
	self:_updateView()
end

function TeachingBattleRoundExtensionView:onExit()
	self:_setEvent(false)
end

function TeachingBattleRoundExtensionView:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBattleRoundUpdate, self._onRoundUpdate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleRoundUpdate, self._onRoundUpdate, self)
	end
end

function TeachingBattleRoundExtensionView:_updateView()
	local dungeonCode = BattleEnterUtil.getCurrentDungeonCode()
	local dungeonMO = DungeonModel.instance:getDungeonMoById(dungeonCode)

	self._descTxt.text = dungeonMO:getDesc()
end

function TeachingBattleRoundExtensionView:_onRoundUpdate(e, currentRound, maxRound)
	self._roundTxt.text = string.format("剩余回合数:%d", maxRound - currentRound)
end

return TeachingBattleRoundExtensionView
