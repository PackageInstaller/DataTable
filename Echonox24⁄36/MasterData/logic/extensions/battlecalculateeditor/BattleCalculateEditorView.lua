-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlecalculateeditor/BattleCalculateEditorView.lua

module("logic.extensions.battlecalculateeditor.BattleCalculateEditorView", package.seeall)

local M = class("BattleCalculateEditorView", ViewComponent)

function M:buildUI()
	self._closeBtn = self:getBtnByPath("close")
	self._switchSceneBtn = self:getBtnByPath("scene")
	self._switchHeroBtn = self:getBtnByPath("character")
end

function M:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._switchSceneBtn:AddClickListener(self._onClickSwitchScene, self)
	self._switchHeroBtn:AddClickListener(self._onClickSwitchHero, self)
	BattleDispatcher:addEventListener(BattleEventType.OnBattleSceneEnterFinish, self._onSceneLoaded, self)
end

function M:unbindEvents()
	self._closeBtn:RemoveClickListener()
	self._switchSceneBtn:RemoveClickListener()
	self._switchHeroBtn:RemoveClickListener()
	BattleDispatcher:removeEventListener(BattleEventType.OnBattleSceneEnterFinish, self._onSceneLoaded, self)
end

function M:_onClickClose()
	BattleMgr.instance:exit()
end

function M:onExit()
	self._victory:stop()
end

function M:onEnter()
	self._victory = EditorVictoryPerformance.New()

	self._victory:start()

	self._paths = {
		"sx-s109_factoryscrap_run",
		"sx-s112_consciousness-space_run",
		"sx-s120_miningarea_boss_run",
		"sx-s120_miningarea_boss_run",
		"sx-s110_alphastar_run"
	}
	self._changeIdx = 0
end

function M:_onClickSwitchScene()
	self._changeIdx = self._changeIdx + 1

	local model = BattleMgr.instance:getModel()

	model:setSceneName(self._paths[self._changeIdx])
	SceneMgr.instance:enter(SceneType.BattleCalculateEditor, model:getSceneCode(), 0, 0)
end

function M:_onClickSwitchHero()
	return
end

function M:_onSceneLoaded(_, sceneType, sceneId)
	self._victory:onSwitchScene()
end

return M
