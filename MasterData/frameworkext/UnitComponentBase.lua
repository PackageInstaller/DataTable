-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/unit/UnitComponentBase.lua

module("frameworkext.unit.UnitComponentBase", package.seeall)

local UnitComponentBase = class("UnitComponentBase")

function UnitComponentBase:ctor(unit)
	self._unit = unit

	NotifyDispatcher.extend(self)
end

function UnitComponentBase:onInit()
	return
end

function UnitComponentBase:onDestroy()
	return
end

return UnitComponentBase
