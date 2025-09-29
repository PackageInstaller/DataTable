-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/view/ClimbingTowerBasePage.lua

module("logic.extensions.climbingtower.view.ClimbingTowerBasePage", package.seeall)

local M = class("ClimbingTowerBasePage")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getRegistry()
	return self._registry
end

function M:buildUI()
	return
end

function M:destroyUI()
	self._handler = nil
	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._isEnter = true

	self:setActive(self._isEnter)
end

function M:onExit()
	self._isEnter = false

	self:setActive(self._isEnter)
end

function M:isEnter()
	return self._isEnter
end

function M:getPageTyp()
	return nil
end

function M:getMainGo()
	return self.mainGO
end

function M:setActive(active)
	goutil.setActive(self.mainGO, active)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getResInstance(path)
	local handler = self:getHandler()

	if handler then
		return handler:getResInstance(path)
	end

	return nil
end

return M
