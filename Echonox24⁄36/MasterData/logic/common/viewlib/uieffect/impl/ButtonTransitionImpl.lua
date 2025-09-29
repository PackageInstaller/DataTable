-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/uieffect/impl/ButtonTransitionImpl.lua

module("logic.common.viewlib.uieffect.impl.ButtonTransitionImpl", package.seeall)

local ButtonTransitionImpl = class("ButtonTransitionImpl", UIEffectBase)

function ButtonTransitionImpl:setVisible(visible)
	if not self:checkUIValid() then
		return
	end

	goutil.setActive(self._mainGO, visible)
end

function ButtonTransitionImpl:setDisable(interactable)
	if not self:checkUIValid() then
		return
	end

	interactable = interactable or false

	self._transition:SetColor(self.GrayColorStr)
	self._transition:SetRaycastTarget(interactable)
end

function ButtonTransitionImpl:setEnable()
	if not self:checkUIValid() then
		return
	end

	self._transition:Clear()
end

function ButtonTransitionImpl:_buildUI(mainGO)
	self.GrayColorStr = "#999999DD"
	self._mainGO = mainGO
	self._transition = ButtonTransition.Get(mainGO)
end

function ButtonTransitionImpl:_destroyUI()
	self._transition = nil
end

return ButtonTransitionImpl
