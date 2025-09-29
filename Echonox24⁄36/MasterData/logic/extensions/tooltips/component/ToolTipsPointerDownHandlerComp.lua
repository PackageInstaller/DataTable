-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/component/ToolTipsPointerDownHandlerComp.lua

module("logic.extensions.tooltips.component.ToolTipsPointerDownHandlerComp", package.seeall)

local M = class("ToolTipsPointerDownHandlerComp", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._clickBtn = false
end

function M:buildUI()
	local maskGo = self:getGoByPath("empty_raycast_mask")

	self._clickBtn = Astral.UIClickTrigger.Get(maskGo)

	self._clickBtn:AddClickListener(self._clickMask, self)

	self._passEvent = maskGo:GetComponent(ComponentType.PassEvent)
	self._guiAnimation = self.mainGO:GetComponent(typeof(Astral.GUITimelineAniLua))
end

function M:unbindEvents()
	self._clickBtn:RemoveClickListener()
end

function M:destroyUI()
	return
end

function M:onEnter()
	self._isEnter = true

	local param = self:getFirstParam()

	if param.isPassEvent == false then
		self._passEvent.isPassEvent = param.isPassEvent
	else
		self._passEvent.isPassEvent = true
	end

	self._simulateCloseWhenDraging = param.simulateCloseWhenDraging
	self._isDraging = false
	self._isClosing = false

	if self._simulateCloseWhenDraging then
		self._passEvent:SetIsDragingStatusCallBack(self._onDragStatusUpdate, self)
	end
end

function M:onExit()
	self._isEnter = false

	ToolTipsController.instance:setInCloseTipsTime()
end

function M:_clickMask()
	if not self._isEnter then
		return
	end

	self:close()
end

function M:simulateCloseWhenDraging()
	self._isClosing = true
end

function M:_onDragStatusUpdate(isDraging)
	self._isDraging = isDraging

	if not isDraging and self._isClosing then
		self._viewPresentor:closeWhenDragEnd()
	end
end

return M
