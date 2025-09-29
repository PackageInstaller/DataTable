-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/TypeUtil.lua

module("logic.common.util.TypeUtil", package.seeall)

local TypeUtil = {}
local kNumber = "number"
local kString = "string"
local kBoolean = "boolean"
local kTable = "table"

function TypeUtil.isNumber(value)
	return type(value) == kNumber
end

function TypeUtil.isString(value)
	return type(value) == kString
end

function TypeUtil.isBoolean(value)
	return type(value) == kBoolean
end

function TypeUtil.isTable(value)
	return type(value) == kTable
end

return TypeUtil
