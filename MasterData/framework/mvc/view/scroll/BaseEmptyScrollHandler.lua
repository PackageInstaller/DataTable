-- chunkname: @framework/mvc/view/scroll/BaseEmptyScrollHandler.lua

module("framework.mvc.view.scroll.BaseEmptyScrollHandler", package.seeall)

local BaseEmptyScrollHandler = class("BaseEmptyScrollHandler")

function BaseEmptyScrollHandler:refreshEmptyView(emptyGO, params)
	return
end

return BaseEmptyScrollHandler
