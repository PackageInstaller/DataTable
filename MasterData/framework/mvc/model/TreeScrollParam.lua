-- chunkname: @framework/mvc/model/TreeScrollParam.lua

module("framework.mvc.model.TreeScrollParam", package.seeall)

local TreeScrollParam = pureTable("TreeScrollParam")

function TreeScrollParam:ctor()
	self.scrollGOPath = nil
	self.prefabType = ScrollEnum.ScrollPrefabFromRes
	self.prefabUrls = nil
	self.cellClass = nil
	self.scrollDir = ScrollEnum.ScrollDirH
	self.emptyScrollParam = nil
end

return TreeScrollParam
