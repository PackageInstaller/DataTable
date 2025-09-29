-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/luaComponent/SimpleCellComponent.lua

module("logic.common.viewlib.luaComponent.SimpleCellComponent", package.seeall)

local M = class("SimpleCellComponent", SimpleLuaComponent)

function M:Awake()
	self:_initViewElementsRegistry()
	self:buildUI()
end

function M:OnEnable()
	self:bindEvents()
	self:bindDispatcherEvent()
	self:onEnter()
end

function M:OnDisable()
	self:unbindEvents()
	self:unbindDispatcherEvent()
	self:onExit()
end

function M:OnDestroy()
	self:destroyUI()
end

function M:_initViewElementsRegistry()
	self._registry = ViewElementsRegistry.New(self._go)
end

function M:buildUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:bindDispatcherEvent()
	return
end

function M:unbindDispatcherEvent()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_setData(...)
	return
end

function M:_refreshUI()
	return
end

function M:setData(...)
	self:_setData(...)
	self:_refreshUI()
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

return M
