-- chunkname: @framework/mvc/view/ViewBackStackMgr.lua

module("framework.mvc.view.ViewBackStackMgr", package.seeall)

local ViewBackStackMgr = class("ViewBackStackMgr")

function ViewBackStackMgr:ctor()
	self._backStack = {}
end

function ViewBackStackMgr:init()
	return
end

function ViewBackStackMgr:_onFullOpen(viewName, viewParam)
	if self:isFull(viewName) then
		self:_backStackPush(viewName)
	end
end

function ViewBackStackMgr:_onFullClose(viewName)
	if self:isFull(viewName) then
		local top = self:_backStackTop()

		if top == viewName then
			self:_backStackPop()
		else
			self:removeInBackStack()
		end
	end
end

function ViewBackStackMgr:_backStackPush(viewName, viewParam)
	self:removeInBackStack(viewName)
	table.insert(self._backStack, {
		viewName = viewName,
		viewParam = viewParam
	})
end

function ViewBackStackMgr:_backStackPop(viewName)
	local topIndex = #self._backStack
	local top = self._backStack[topIndex]

	if top and top.viewName == viewName then
		table.remove(self._backStack, topIndex)

		return top
	else
		logError("view not in stack top, can't remove: " .. viewName)
	end
end

function ViewBackStackMgr:_backStackTop()
	return self._backStack[#self._backStack]
end

function ViewBackStackMgr:removeInBackStack(viewName)
	tabletool.removeValue(self._backStack, viewName)
end

ViewBackStackMgr.instance = ViewBackStackMgr.New()

return ViewBackStackMgr
