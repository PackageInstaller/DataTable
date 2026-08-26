-- chunkname: @framework/mvc/view/ViewFullScreenMgr.lua

module("framework.mvc.view.ViewFullScreenMgr", package.seeall)

local ViewFullScreenMgr = class("ViewFullScreenMgr")

function ViewFullScreenMgr:init()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenFullViewFinish, self._onOpenFullViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, self._onCloseFullView, self)
	ViewMgr.instance:registerCallback(ViewEvent.ReOpenWhileOpen, self._reOpenWhileOpen, self)
end

function ViewFullScreenMgr:_onOpenFullViewFinish(viewName)
	self:_onOpenFullView(viewName)
end

function ViewFullScreenMgr:_reOpenWhileOpen(viewName)
	if ViewMgr.instance:isFull(viewName) then
		self:_onOpenFullView(viewName)
	end
end

function ViewFullScreenMgr:_onOpenFullView(viewName)
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()
	local passed = false

	for i = #openViewNameList, 1, -1 do
		local oneViewName = openViewNameList[i]

		if viewName == oneViewName then
			passed = true
		elseif passed then
			local viewContainer = ViewMgr.instance:getContainer(oneViewName)

			if viewContainer then
				local setting = viewContainer:getSetting()
				local layer = setting.layer
				local isMessageOrTop = layer == UILayerName.Guide or layer == UILayerName.Message or layer == UILayerName.Top or layer == UILayerName.IDCanvasPopUp

				if not isMessageOrTop then
					viewContainer:setVisibleInternal(false)
				end
			end
		end
	end
end

function ViewFullScreenMgr:_onCloseFullView(viewName)
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	for i = #openViewNameList, 1, -1 do
		local oneViewName = openViewNameList[i]
		local viewContainer = ViewMgr.instance:getContainer(oneViewName)

		if viewContainer then
			viewContainer:setVisibleInternal(true)
		end

		if ViewMgr.instance:isFull(oneViewName) then
			break
		end
	end
end

ViewFullScreenMgr.instance = ViewFullScreenMgr.New()

return ViewFullScreenMgr
