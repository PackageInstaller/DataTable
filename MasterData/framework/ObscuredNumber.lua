-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/datastruct/ObscuredNumber.lua

module("framework.datastruct.ObscuredNumber", package.seeall)

local ObscuredNumber = {}
local value_key = "value"
local mt = {
	__add = function(a, b)
		local v = a.value + b.value

		return ObscuredNumber.New(v)
	end,
	__sub = function(a, b)
		local v = a.value - b.value

		return ObscuredNumber.New(v)
	end,
	__mul = function(a, b)
		local v = a.value * b.value

		return ObscuredNumber.New(v)
	end,
	__div = function(a, b)
		local v = a.value / b.value

		return ObscuredNumber.New(v)
	end,
	__unm = function(a)
		return ObscuredNumber.New(-a.value)
	end,
	__eq = function(a, b)
		return a.value == b.value
	end,
	__lt = function(a, b)
		return a.value < b.value
	end,
	__le = function(a, b)
		return a.value <= b.value
	end,
	__index = function(t, key)
		if key == value_key then
			return t._value - t._randomValue
		end

		return nil
	end,
	__newindex = function(t, key, value)
		if key == value_key then
			t._value = value + t._randomValue
		end
	end,
	__tostring = function(t)
		return tostring(t._value - t._randomValue)
	end
}

function ObscuredNumber.New(value)
	local t = {
		_randomValue = math.random() * 12345
	}

	t._value = t._randomValue + (value or 0)

	setmetatable(t, mt)

	t.clone = ObscuredNumber.Clone

	return t
end

function ObscuredNumber.Clone(t)
	return ObscuredNumber.New(t.value)
end

return ObscuredNumber
