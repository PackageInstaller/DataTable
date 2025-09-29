-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/BackpackAnimationComponent.lua

module("logic.extensions.backpack.cellcomponent.BackpackAnimationComponent", package.seeall)

local M = class("BackpackAnimationComponent", CellBaseComponent)

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()
	local mainGO = registry:getMainGO()

	self._animation = mainGO:GetComponent(ComponentType.Animation)
	self._canvasGroup = mainGO:GetComponent(ComponentType.CanvasGroup)
end

function M:playOpenAni()
	self:playAnim("backpack_item_open")
end

function M:playAnim(name)
	self._animation:Stop()
	self._animation:Play(name)
end

function M:resetToLastFrame()
	AnimationUtils.ResetToLastFrame(self._animation)
end

function M:setAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

return M
