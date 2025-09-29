-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlecalculateeditor/flow/BattleCalculateEditorViewMgr.lua

module("logic.extensions.battlecalculateeditor.flow.BattleCalculateEditorViewMgr", package.seeall)

local M = class("BattleCalculateEditorViewMgr", IBattleFlowComp)

function M:onResourceLoaded()
	ViewMgr.instance:open(ViewName.BattleCalculateEditor)
end

function M:onClear(isRestart)
	ViewMgr.instance:destroy(ViewName.BattleCalculateEditor)
end

function M:clearForExit()
	return
end

return M
