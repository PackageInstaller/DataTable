-- chunkname: @framework/mvc/model/ListScrollParam.lua

module("framework.mvc.model.ListScrollParam", package.seeall)

local ListScrollParam = pureTable("ListScrollParam")

function ListScrollParam:ctor()
	self.scrollGOPath = nil
	self.prefabType = ScrollEnum.ScrollPrefabFromRes
	self.prefabUrl = nil
	self.cellClass = nil
	self.multiSelect = false
	self.scrollDir = ScrollEnum.ScrollDirH
	self.lineCount = 1
	self.cellWidth = 100
	self.cellHeight = 100
	self.cellSpaceH = 0
	self.cellSpaceV = 0
	self.startSpace = 0
	self.endSpace = 0
	self.sortMode = ScrollEnum.ScrollSortNone
	self.frameUpdateMs = 10
	self.minUpdateCountInFrame = 1
	self.emptyScrollParam = nil
end

return ListScrollParam
