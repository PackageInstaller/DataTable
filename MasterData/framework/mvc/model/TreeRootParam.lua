-- chunkname: @framework/mvc/model/TreeRootParam.lua

module("framework.mvc.model.TreeRootParam", package.seeall)

local TreeRootParam = pureTable("TreeRootParam")

function TreeRootParam:ctor()
	self.rootType = 0
	self.rootLength = 0
	self.nodeType = 0
	self.nodeLength = 0
	self.nodeCountEachLine = -1
	self.nodeStartSpace = 0
	self.nodeEndSpace = 0
end

return TreeRootParam
