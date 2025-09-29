-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/VectorUtil.lua

module("logic.common.util.VectorUtil", package.seeall)

local M = {}

function M.getBetweenPoint(startPoint, endPoint, percent)
	local normal = (endPoint - startPoint).normalized
	local distance = Vector3.Distance(endPoint, startPoint)

	percent = percent or 0.5

	return normal * (distance * percent) + startPoint
end

function M.getBetweenPointByDistance(startPoint, endPoint, distance)
	local normal = (endPoint - startPoint).normalized

	return normal * distance + startPoint
end

return M
