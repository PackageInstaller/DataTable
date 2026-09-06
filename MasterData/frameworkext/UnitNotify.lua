-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/unit/UnitNotify.lua

module("frameworkext.unit.UnitNotify", package.seeall)

local UnitNotify = {}

UnitNotify.SpineLoaded = 1
UnitNotify.LiveLoaded = 2
UnitNotify.StartMove = 3
UnitNotify.PosChanged = 4
UnitNotify.Arrive = 5
UnitNotify.Interrupt = 6
UnitNotify.PassWayPoint = 7

return UnitNotify
