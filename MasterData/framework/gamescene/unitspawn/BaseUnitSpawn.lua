-- chunkname: @framework/gamescene/unitspawn/BaseUnitSpawn.lua

module("framework.gamescene.unitspawn.BaseUnitSpawn", package.seeall)

local BaseUnitSpawn = class("BaseUnitSpawn", LuaCompBase)

function BaseUnitSpawn:init(go)
	self.go = go
	self.go.tag = self:getTag()
	self._compList = {}

	self:initComponents()
end

function BaseUnitSpawn:onStart()
	return
end

function BaseUnitSpawn:onDestroy()
	self._compList = nil
	self.go = nil
end

function BaseUnitSpawn:addComp(compName, compClass)
	local compInst = MonoHelper.addLuaComOnceToGo(self.go, compClass, self)

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function BaseUnitSpawn:getCompList()
	return self._compList
end

function BaseUnitSpawn:getTag()
	return SceneTag.Untagged
end

function BaseUnitSpawn:initComponents()
	return
end

return BaseUnitSpawn
