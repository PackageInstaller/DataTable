-- chunkname: @framework/mvc/model/CircleScrollParam.lua

module("framework.mvc.model.CircleScrollParam", package.seeall)

local CircleScrollParam = pureTable("CircleScrollParam")

function CircleScrollParam:ctor()
	self.scrollGOPath = nil
	self.prefabType = ScrollEnum.ScrollPrefabFromRes
	self.prefabUrl = nil
	self.cellClass = nil
	self.scrollDir = ScrollEnum.ScrollDirH
	self.rotateDir = ScrollEnum.ScrollRotateCW
	self.circleCellCount = 0
	self.scrollRadius = nil
	self.cellRadius = nil
	self.firstDegree = nil
	self.isLoop = false
	self.emptyScrollParam = nil
end

return CircleScrollParam
