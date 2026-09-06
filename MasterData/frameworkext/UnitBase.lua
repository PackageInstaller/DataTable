-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/unit/UnitBase.lua

module("frameworkext.unit.UnitBase", package.seeall)

local UnitBase = class("UnitBase")

function UnitBase:ctor(componetContainer)
	self.go = componetContainer.gameObject
	self.go.tag = self:getTag()
	self.go.layer = self:getLayer()
	self.id = 0
	self._compList = {}
end

function UnitBase:Awake()
	self:_initComponents()

	local len = #self._compList

	for i = 1, len do
		self._compList[i]:onInit()
	end
end

function UnitBase:_addComponent(compName, compClass)
	local compInst = compClass.New(self)

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function UnitBase:OnDestroy()
	local len = #self._compList

	for i = 1, len do
		self._compList[i]:onDestroy()
	end
end

function UnitBase:getTag()
	return UnitTag.Untagged
end

function UnitBase:getLayer()
	return 0
end

function UnitBase:_initComponents()
	return
end

return UnitBase
