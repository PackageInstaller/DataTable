-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/UIReflectionFacade.lua

module("logic.common.photo.UIReflectionFacade", package.seeall)

local M = class("UIReflectionFacade")
local DEFAULT_REFLECTION_MAT_PATH = "urpassets/planar_reflection_ui3d/ui3d_planar_reflection.mat"

function M:init()
	self._matLoader = SingleResLoader.New()
	self._reflectionMat = nil
	self._reflectionAlpha = nil

	SpaceX.UI3dReflectionUtils.Init()
	self:setReflectionMat()
end

function M:setReflectionMat(path)
	path = path or DEFAULT_REFLECTION_MAT_PATH

	if self._matLoader:getResource() and self._matLoader:isSameResource(path) then
		self:_setReflectionMat()
	else
		self._matLoader:load(path, self._onReflectionMatLoaded, self)
	end
end

function M:_onReflectionMatLoaded()
	self:_setReflectionMat()
end

function M:_setReflectionMat()
	local res = self._matLoader:getResource()

	self._reflectionMat = res and res:GetMainAsset()

	if self._reflectionMat then
		SpaceX.UI3dReflectionUtils.SetReflectionMat(self._reflectionMat)
		self:_setReflectionAlpha()
	end
end

function M:setPlanePosY(posY)
	SpaceX.UI3dReflectionUtils.SetPlanePosY(posY)
end

function M:setReflectionAlpha(alpha)
	self._reflectionAlpha = alpha

	self:_setReflectionAlpha()
end

function M:_setReflectionAlpha()
	if self._reflectionMat and self._reflectionAlpha then
		SpaceX.UI3dReflectionUtils.SetReflectionAlpha(self._reflectionAlpha)
	end
end

M.instance = M.New()

return M
