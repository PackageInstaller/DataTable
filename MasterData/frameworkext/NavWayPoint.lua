-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/unit/component/mover/NavWayPoint.lua

module("frameworkext.unit.component.mover.NavWayPoint", package.seeall)

local NavWayPoint = class("NavWayPoint")

function NavWayPoint._poolCreateFunc()
	return {}
end

function NavWayPoint.initPool()
	NavWayPoint._pool = ObjectPool.New(100, NavWayPoint._poolCreateFunc, nil, nil)
end

function NavWayPoint.getPool()
	return NavWayPoint._pool
end

return NavWayPoint
