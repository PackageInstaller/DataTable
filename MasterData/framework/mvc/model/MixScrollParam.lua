-- chunkname: @framework/mvc/model/MixScrollParam.lua

module("framework.mvc.model.MixScrollParam", package.seeall)

local MixScrollParam = pureTable("MixScrollParam")

function MixScrollParam:ctor()
	self.scrollGOPath = nil
	self.prefabType = ScrollEnum.ScrollPrefabFromRes
	self.prefabUrl = nil
	self.cellClass = nil
	self.scrollDir = ScrollEnum.ScrollDirH
	self.emptyScrollParam = nil
	self.startSpace = 0
	self.endSpace = 0
end

return MixScrollParam
