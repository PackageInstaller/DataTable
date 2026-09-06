-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/scene/factory/UnitFactoryBase.lua

module("frameworkext.scene.factory.UnitFactoryBase", package.seeall)

local UnitFactoryBase = class("UnitFactoryBase", SceneComponentBase)

function UnitFactoryBase:ctor(scene)
	UnitFactoryBase.super.ctor(self, scene)

	self._units = {}
end

function UnitFactoryBase:onInit()
	self._container = self._scene:getContainer()
end

function UnitFactoryBase:removeAll()
	for k, v in pairs(self._units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			goutil.destroy(v2.go)

			sameUnits[k2] = nil
		end
	end
end

function UnitFactoryBase:addUnit(unit)
	goutil.addChildToParent(unit.go, self._container)

	local tag = unit.go.tag
	local sameUnits = self._units[tag]

	if not sameUnits then
		sameUnits = {}
		self._units[tag] = sameUnits
	end

	sameUnits[unit.id] = unit
end

function UnitFactoryBase:getUnits(unitTag)
	return self._units[unitTag]
end

function UnitFactoryBase:getUnit(unitTag, id)
	local sameUnits = self._units[unitTag]

	if sameUnits then
		return sameUnits[id]
	end

	return nil
end

function UnitFactoryBase:removeUnit(unitTag, id)
	local sameUnits = self._units[unitTag]

	if sameUnits then
		local unit = sameUnits[id]

		if unit then
			sameUnits[id] = nil

			goutil.destroy(unit.go)
		end
	end
end

return UnitFactoryBase
