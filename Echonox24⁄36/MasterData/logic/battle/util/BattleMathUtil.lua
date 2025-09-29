-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleMathUtil.lua

module("logic.battle.util.BattleMathUtil", package.seeall)

local BattleMathUtil = {}
local kEpsilon = 1e-05
local kPrecision = 10000

BattleMathUtil.INT_MIN = -4294967296
BattleMathUtil.INT_MAX = 4294967295
BattleMathUtil.tempVec3 = Vector3.New()

function BattleMathUtil.getTempVec3(x, y, z)
	local vec3 = BattleMathUtil.tempVec3

	vec3:Set(x, y, z)

	return vec3
end

function BattleMathUtil.addPrecision(intValue)
	return intValue
end

function BattleMathUtil.removePrecision(intValue)
	return intValue
end

function BattleMathUtil.removePrecisionAsInt(intValue)
	return intValue
end

function BattleMathUtil.distance(x1, z1, x2, z2)
	return math.sqrt((x1 - x2)^2 + (z1 - z2)^2)
end

function BattleMathUtil.isFloatEquals(v1, v2)
	return math.abs(v1 - v2) < kEpsilon
end

function BattleMathUtil.ratioToPercent(ratio)
	return math.floor(ratio * 100)
end

function BattleMathUtil.swap(v1, v2)
	return v2, v1
end

return BattleMathUtil
