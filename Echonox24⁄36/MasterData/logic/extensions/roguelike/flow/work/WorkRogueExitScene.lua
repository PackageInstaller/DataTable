-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/WorkRogueExitScene.lua

module("logic.extensions.roguelike.flow.work.WorkRogueExitScene", package.seeall)

local M = class("WorkRogueExitScene", WorkBase)

function M:onEnter(context)
	self:_closeView()
	SceneMgr.instance:exitCurScene()
	self:onDone(WorkResult.Succeed)
end

function M:_closeView()
	return
end

function M:onExit(isInterrupt)
	return
end

return M
