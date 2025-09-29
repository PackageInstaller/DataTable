-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/flow/component/TeamSceneViewMgr.lua

module("logic.scene.flow.component.TeamSceneViewMgr", package.seeall)

local M = class("TeamSceneViewMgr", ISceneFlowComp)

function M:onEnterDone()
	ViewMgr.instance:open(ViewName.TeamMainViewViewPresentor)
end

function M:onExit()
	ViewMgr.instance:close(ViewName.TeamMainViewViewPresentor, true)
end

return M
