-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterpreview/scene/CharacterPreviewResMgr.lua

module("logic.extensions.characterpreview.scene.CharacterPreviewResMgr", package.seeall)

local M = class("CharacterPreviewResMgr", ISceneFlowComp)

function M:onInit()
	self._handler = Handler.New()
end

function M:onEnter(sceneInfo)
	self._sceneInfo = sceneInfo
end

function M:onExit()
	self._handler:clear()
end

function M:onSceneLoadDone()
	return
end

function M:onEnterDone()
	return
end

function M:onExitDone()
	return
end

function M:onDestroy()
	self._resInstance = nil
	self._sceneInfo = nil
end

function M:removeListener()
	self._handler:clear()
end

function M:load(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self:_onAllLoaded()
end

function M:_onAllLoaded()
	self._handler:call(true)
end

return M
