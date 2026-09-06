-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/bootstrap/core/math.lua

module("bootstrap.core.math", package.seeall)

function math.round(value)
	value = checknumber(value)

	return math.floor(value + 0.5)
end

local pi_div_180 = math.pi / 180

function math.angle2radian(angle)
	return angle * pi_div_180
end

local pi_mul_180 = math.pi * 180

function math.radian2angle(radian)
	return radian / pi_mul_180
end

math.randomseed(os.time())
math.random(1, 10000)
