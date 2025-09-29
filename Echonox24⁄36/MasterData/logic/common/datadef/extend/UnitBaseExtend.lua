-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/datadef/extend/UnitBaseExtend.lua

module("logic.common.datadef.extend.UnitBaseExtend", package.seeall)

local UnitBaseExtend = {}

function UnitBaseExtend.extend()
	return
end

function UnitBase:ctor(componetContainer)
	self.go = componetContainer.gameObject
	self.go.layer = self:getLayer()
	self.id = 0
	self._innerChannelId = IDRecycleGenerater.getInnerChannelUid()
	self._channelId = -1
	self._compList = {}
end

return UnitBaseExtend
