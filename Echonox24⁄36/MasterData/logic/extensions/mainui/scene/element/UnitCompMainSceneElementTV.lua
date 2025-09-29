-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/element/UnitCompMainSceneElementTV.lua

module("logic.extensions.mainui.scene.element.UnitCompMainSceneElementTV", package.seeall)

local M = class("UnitCompMainSceneElementTV", UnitCompMainSceneElementBase)
local DEFAULT_CENTER = {
	z = 0,
	x = 0,
	y = 0.52
}
local DEFAULT_SIZE = {
	z = 0.8,
	x = 0.8,
	y = 0.62
}

function M:ctor(mainGo)
	M.super.ctor(self, mainGo)

	self._colliderCenter = Vector3.New(DEFAULT_CENTER.x, DEFAULT_CENTER.y, DEFAULT_CENTER.z)
	self._colliderSize = Vector3.New(DEFAULT_SIZE.x, DEFAULT_SIZE.y, DEFAULT_SIZE.z)
end

function M:Awake()
	M.super.Awake(self)
	self:_initCollider()
end

function M:OnEnable()
	M.super.OnEnable(self)
	self:setEvent(true)
end

function M:OnDisable()
	M.super.OnDisable(self)
	self:setEvent(false)
end

function M:OnDestroy()
	M.super.OnDestroy(self)
	self:setEvent(false)
end

function M:onLeaveScene(needUnloadRes)
	M.super.onLeaveScene(self, needUnloadRes)
end

function M:onReturnScene(needUnloadRes)
	M.super.onReturnScene(self, needUnloadRes)
end

function M:onReturnSceneFinished(needUnloadRes)
	M.super.onReturnSceneFinished(self, needUnloadRes)
end

function M:_initComponents()
	self:_addComponent("ui", UnitCompMainSceneTvBannerUI)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
	end
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	return
end

function M:setElementId(elementId)
	M.super.setElementId(self, elementId)
end

function M:getCompCollider()
	local mainGO = self:getMainGO()

	if mainGO then
		return mainGO:GetComponent(ComponentType.BoxCollider)
	end
end

function M:_initCollider()
	local mainGO = self:getMainGO()
	local collider = goutil.addComponentOnce(mainGO, ComponentType.BoxCollider)

	if collider then
		collider.center = self._colliderCenter
		collider.size = self._colliderSize
	end
end

function M:onClickElement()
	return
end

return M
