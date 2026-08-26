-- chunkname: @booter/base/tabletool.lua

module("booter.base.tabletool", package.seeall)

local tabletool = {}

function tabletool.copy(sourceTb)
	local destTb = {}

	for k, v in pairs(sourceTb) do
		destTb[k] = v
	end

	return destTb
end

function tabletool.indexOf(array, value, begin)
	for i = begin or 1, #array do
		if array[i] == value then
			return i
		end
	end
end

function tabletool.removeValue(array, value)
	for i, v in ipairs(array) do
		if v == value then
			table.remove(array, i)

			return
		end
	end
end

function tabletool.addValues(targetArray, addArray)
	if targetArray and addArray then
		for _, value in ipairs(addArray) do
			table.insert(targetArray, value)
		end
	end
end

function tabletool.clear(tb)
	for k, _ in pairs(tb) do
		tb[k] = nil
	end
end

function tabletool.revert(array)
	if not array then
		return
	end

	local low, high = 1, #array

	while low < high do
		array[low] = array[high]
		array[high] = array[low]
		low = low + 1
		high = high - 1
	end
end

function tabletool.len(tb)
	local count = 0

	for k, v in pairs(tb) do
		if tb[k] ~= nil then
			count = count + 1
		end
	end

	return count
end

function tabletool.pureTable(tableName, super)
	local M = {}

	M.__cname = tableName
	M.__index = M
	M.__newindex = super and super.__newindex or function(t, key, value)
		if type(value) == "userdata" or type(value) == "function" then
			error("pureTable instance object field not support userdata or function,key=" .. key)
		else
			rawset(t, key, value)
		end
	end

	function M.ctor(object)
		return
	end

	function M.New()
		local object = {}

		object.__cname = tableName

		M.ctor(object)
		setmetatable(object, M)

		return object
	end

	setmetatable(M, {
		__index = super,
		__newindex = function(t, key, value)
			if type(value) ~= "function" then
				error("pureTable table only support function!key=" .. key)
			else
				rawset(t, key, value)
			end
		end
	})

	return M
end

function tabletool.getDictJsonStr(dictTable)
	local temp = {}

	for k, v in pairs(dictTable) do
		table.insert(temp, cjson.encode(k) .. ":" .. cjson.encode(v))
	end

	return string.format("{%s}", table.concat(temp, ","))
end

setGlobal("pureTable", tabletool.pureTable)
setGlobal("tabletool", tabletool)
