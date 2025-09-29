-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/impl/SceneBaseSpacx.lua

module("logic.scene.impl.SceneBaseSpacx", package.seeall)

local M = class("SceneBaseSpacx", SceneBase)

function M:onEnterFinished()
	if self._isReturnScene then
		self._isReturnScene = nil

		GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_LOADED, self:getSceneType(), self:getSceneId())

		return
	end

	M.super.onEnterFinished(self)
end

function M:onExit()
	M.super.onExit(self)

	self._isReturnScene = nil
end

function M:onLeaveScene(passThroughParam)
	local compLst = self._compList
	local tempComp
	local len = compLst and #compLst or 0

	if len > 0 then
		for i = 1, len do
			tempComp = self._compList[i]

			if tempComp.onLeaveScene then
				tempComp:onLeaveScene(passThroughParam)
			end
		end
	end
end

function M:onReturnScene(passThroughParam)
	self._isReturnScene = true

	local compLst = self._compList
	local tempComp
	local len = compLst and #compLst or 0

	if len > 0 then
		for i = 1, len do
			tempComp = self._compList[i]

			if tempComp.onReturnScene then
				tempComp:onReturnScene(passThroughParam)
			end
		end
	end
end

function M:onReturnSceneFinished(passThroughParam)
	local compLst = self._compList
	local tempComp
	local len = compLst and #compLst or 0

	if len > 0 then
		for i = 1, len do
			tempComp = self._compList[i]

			if tempComp.onReturnSceneFinished then
				tempComp:onReturnSceneFinished(passThroughParam)
			end
		end
	end
end

return M
