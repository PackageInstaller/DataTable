-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/bootstrap/core/table.lua

module("bootstrap.core.table", package.seeall)

function table.nums(t)
	local count = 0

	for k, v in pairs(t) do
		count = count + 1
	end

	return count
end

function table.keys(hashtable)
	local keys = {}

	for k, v in pairs(hashtable) do
		keys[#keys + 1] = k
	end

	return keys
end

function table.values(hashtable)
	local values = {}

	for k, v in pairs(hashtable) do
		values[#values + 1] = v
	end

	return values
end

function table.merge(dest, src)
	for k, v in pairs(src) do
		dest[k] = v
	end
end

function table.insertto(dest, src, begin)
	begin = checkint(begin)

	if begin <= 0 then
		begin = #dest + 1
	end

	local len = #src

	for i = 0, len - 1 do
		dest[i + begin] = src[i + 1]
	end
end

function table.indexof(array, value, begin)
	for i = begin or 1, #array do
		if array[i] == value then
			return i
		end
	end

	return false
end

function table.keyof(hashtable, value)
	for k, v in pairs(hashtable) do
		if v == value then
			return k
		end
	end

	return nil
end

function table.removebyvalue(array, value, removeall)
	local c, i, max = 0, 1, #array

	while i <= max do
		if array[i] == value then
			table.remove(array, i)

			c = c + 1
			i = i - 1
			max = max - 1

			if not removeall then
				break
			end
		end

		i = i + 1
	end

	return c
end

function table.map(t, fn)
	for k, v in pairs(t) do
		t[k] = fn(v, k)
	end
end

function table.walk(t, fn)
	for k, v in pairs(t) do
		fn(v, k)
	end
end

function table.filter(t, fn)
	for k, v in pairs(t) do
		if not fn(v, k) then
			t[k] = nil
		end
	end
end

function table.unique(t, bArray)
	local check = {}
	local n = {}
	local idx = 1

	for k, v in pairs(t) do
		if not check[v] then
			if bArray then
				n[idx] = v
				idx = idx + 1
			else
				n[k] = v
			end

			check[v] = true
		end
	end

	return n
end

function table.clear(t)
	if type(t) == "table" then
		for k, v in pairs(t) do
			t[k] = nil
		end
	end
end

function table.serialize(obj, deep)
	local def_deep = 20
	local baseTab = "    "
	local tb_cache = {}

	deep = type(deep) ~= "number" and def_deep or deep >= 0 and deep <= def_deep and deep or def_deep

	local function get_item_str(key, value, _deep)
		local t = type(value)
		local tab = string.rep(baseTab, _deep)

		_key = key == nil and "" or string.format("%s%s = ", tab, tostring(key))

		if t == "nil" then
			return _key .. t
		elseif t == "function" or t == "userdata" or t == "thread" then
			return _key .. tostring(value)
		elseif t == "boolean" then
			return _key .. tostring(value)
		elseif t == "number" then
			return _key .. string.format("%f", value)
		elseif t == "string" then
			return _key .. string.format("\"%s\"", string.gsub(value, "\\", "\\\\"))
		elseif t == "table" then
			if tb_cache[value] then
				return _key .. string.format("循环引用: %s", tostring(value))
			end

			if _deep >= deep then
				return _key .. string.format("table, 超出指定深度:%d", deep)
			end

			local sb = StringBuffer.New()

			tb_cache[value] = true

			sb:append(_key .. tostring(value) .. " {\n")

			for k, v in pairs(value) do
				sb:append(get_item_str(k, v, _deep + 1) .. ",\n")
			end

			local metatable = getmetatable(value)

			if metatable ~= nil then
				for k, v in pairs(metatable) do
					sb:append(get_item_str(k, v, _deep + 1) .. ",\n")
				end
			end

			sb:append(tab .. "}")

			tb_cache[value] = false

			return sb:toString()
		else
			return key .. string.format("unknown type: %s", t)
		end
	end

	return get_item_str(nil, obj, 0)
end

function table.unserialize(lua)
	local t = type(lua)

	if t == "nil" or lua == "" then
		return nil
	elseif t == "number" or t == "string" or t == "boolean" then
		lua = tostring(lua)
	else
		error("can not unserialize a " .. t .. " type.")
	end

	lua = "return " .. lua

	local func = loadstring(lua)

	if func == nil then
		return nil
	end

	return func()
end

function table.serialize_new(obj, deep)
	local def_deep = 20
	local baseTab = "    "
	local tb_cache = {}

	deep = type(deep) ~= "number" and def_deep or deep >= 0 and deep <= def_deep and deep or def_deep

	local function get_item_str(key, value, _deep)
		local t = type(value)
		local tab = string.rep(baseTab, _deep)

		_key = key == nil and "" or string.format("%s%s = ", tab, tostring(key))

		if t == "nil" then
			return _key .. t
		elseif t == "function" or t == "userdata" or t == "thread" then
			return _key .. tostring(value)
		elseif t == "boolean" then
			return _key .. tostring(value)
		elseif t == "number" then
			return _key .. string.format("%f", value)
		elseif t == "string" then
			return _key .. string.format("\"%s\"", string.gsub(value, "\\", "\\\\"))
		elseif t == "table" then
			if tb_cache[value] then
				return _key .. string.format("循环引用: %s", tostring(value))
			end

			if _deep >= deep then
				return _key .. string.format("table, 超出指定深度:%d", deep)
			end

			local sb = StringBuffer.New()

			tb_cache[value] = true

			sb:append(_key .. tostring(value) .. " {\n")

			for k, v in pairs(value) do
				sb:append(get_item_str(k, v, _deep + 1) .. ",\n")
			end

			local metatable = getmetatable(value)

			if metatable ~= nil then
				for k, v in pairs(metatable) do
					sb:append(get_item_str(k, v, _deep + 1) .. ",\n")
				end
			end

			sb:append(tab .. "}")

			tb_cache[value] = false

			return sb:toString()
		else
			return key .. string.format("unknown type: %s", t)
		end
	end

	return get_item_str(nil, obj, 0)
end
