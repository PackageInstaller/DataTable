-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/work/WorkChangeSceneFinish.lua

module("logic.scene.work.WorkChangeSceneFinish", package.seeall)

local M = class("WorkChangeSceneFinish", WorkBase)

function M:ctor()
	M.super.ctor(self)
end

function M:onEnter(context)
	local sceneType = context.info.sceneType
	local sceneId = context.info.sceneId

	SceneFace.instance:printMsg(string.format("Change Scene Finish to [%s][%s]", sceneType, sceneId))
	GlobalDispatcher:dispatchEvent(EventType.SCENE_FLOW_ENTER_FINISH, {
		sceneId = sceneId,
		sceneType = sceneType
	})

	local curSceneFlow = SceneFace.instance:getCurSceneFlow()

	if curSceneFlow then
		local info = {
			sceneId = sceneId,
			sceneType = sceneType
		}

		curSceneFlow:_notifyComponents(SceneFunctionName.onEnterDone, context.info.flowInfo)
	end

	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	return
end

return M
