-- chunkname: @UnityEngine/LayerMask.lua

local Layer = Layer
local rawget = rawget
local setmetatable = setmetatable
local LayerMask = {}

function LayerMask.__index(t, k)
	return rawget(LayerMask, k)
end

function LayerMask.__call(t, v)
	local var_2_0 = {}

	var_2_0.value = value or 0

	return setmetatable(var_2_0, LayerMask)
end

function LayerMask.New(value)
	return setmetatable({
		value = value or 0
	}, LayerMask)
end

function LayerMask:Get()
	return self.value
end

function LayerMask.NameToLayer(name)
	return Layer[name]
end

function LayerMask.GetMask(...)
	local arg = {
		...
	}
	local value = 0

	for i = 1, #arg do
		local n = LayerMask.NameToLayer(arg[i])

		if n ~= nil then
			value = value + 2^n
		end
	end

	return value
end

UnityEngine.LayerMask = LayerMask

setmetatable(LayerMask, LayerMask)

return LayerMask
