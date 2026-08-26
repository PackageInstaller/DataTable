-- chunkname: @framework/mvc/model/EmptyScrollParam.lua

module("framework.mvc.model.EmptyScrollParam", package.seeall)

local EmptyScrollParam = class("EmptyScrollParam")

function EmptyScrollParam:ctor()
	self.prefabType = ScrollEnum.ScrollPrefabFromRes
	self.prefabUrl = nil
	self.parentPath = nil
	self.handleClass = BaseEmptyScrollHandler
	self.params = nil
end

function EmptyScrollParam:setFromView(gopath, handleClass, params)
	self.prefabType = ScrollEnum.ScrollPrefabFromView
	self.prefabUrl = gopath
	self.handleClass = handleClass or BaseEmptyScrollHandler
	self.params = params
end

function EmptyScrollParam:setFromRes(resPath, parentPath, handleClass, params)
	self.prefabType = ScrollEnum.ScrollPrefabFromRes
	self.prefabUrl = resPath
	self.parentPath = parentPath
	self.handleClass = handleClass or BaseEmptyScrollHandler
	self.params = params
end

return EmptyScrollParam
