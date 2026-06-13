--[[
-- Lua全局工具类，全部定义为全局函数、变量
-- TODO:
-- 1、SafePack和SafeUnpack会被大量使用，到时候看需要需要做记忆表降低GC
--]]

local unpack = unpack or table.unpack

-- 解决原生pack的nil截断问题，SafePack与SafeUnpack要成对使用
function SafePack(...)
	local params = {...}
	params.n = select('#', ...)
	return params
end

-- 解决原生unpack的nil截断问题，SafePack与SafeUnpack要成对使用
function SafeUnpack(safe_pack_tb)
	return unpack(safe_pack_tb, 1, safe_pack_tb.n)
end

-- 对两个SafePack的表执行连接
function ConcatSafePack(safe_pack_l, safe_pack_r)
	local concat = {}
	for i = 1,safe_pack_l.n do
		concat[i] = safe_pack_l[i]
	end
	for i = 1,safe_pack_r.n do
		concat[safe_pack_l.n + i] = safe_pack_r[i]
	end
	concat.n = safe_pack_l.n + safe_pack_r.n
	return concat
end

-- 闭包绑定
function Bind(self, func, ...)
	assert(self == nil or type(self) == "table")
	assert(func ~= nil and type(func) == "function")
	local params = nil
	if self == nil then
		params = SafePack(...)
	else
		params = SafePack(self, ...)
	end
	return function(...)
		local args = ConcatSafePack(params, SafePack(...))
		return func(SafeUnpack(args))
	end
end

-- 回调绑定
-- 重载形式：
-- 1、成员函数、私有函数绑定：BindCallback(obj, callback, ...)
-- 2、闭包绑定：BindCallback(callback, ...)
function BindCallback(...)
	local bindFunc = nil
	local params = SafePack(...)
	assert(params.n >= 1, "BindCallback : error params count!")
	if type(params[1]) == "table" and type(params[2]) == "function" then
		bindFunc = Bind(...)
	elseif type(params[1]) == "function" then
		bindFunc = Bind(nil, ...)
	else
		error("BindCallback : error params list!")
	end
	return bindFunc
end

-- 将字符串转换为boolean值
function ToBoolean(s)
	local transform_map = {
		["true"] = true,
		["false"] = false,
	}

	return transform_map[s]
end

-- 深拷贝对象
function DeepCopy(object)
	local lookup_table = {}
	
	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end

		local new_table = {}
		lookup_table[object] = new_table
		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end

		return setmetatable(new_table, getmetatable(object))
	end

	return _copy(object)
end

-- 序列化表
function Serialize(tb, flag)
	local result = ""
	result = string.format("%s{", result)

	local filter = function(str)
		str = string.gsub(str, "%[", " ")
		str = string.gsub(str, "%]", " ")
		str = string.gsub(str, '\"', " ")
		str	= string.gsub(str, "%'", " ")
		str	= string.gsub(str, "\\", " ")
		str	= string.gsub(str, "%%", " ")
		return str
	end

	for k,v in pairs(tb) do
		if type(k) == "number" then
			if type(v) == "table" then
				result = string.format("%s[%d]=%s,", result, k, Serialize(v))
			elseif type(v) == "number" then
				result = string.format("%s[%d]=%d,", result, k, v)
			elseif type(v) == "string" then
				result = string.format("%s[%d]=%q,", result, k, v)
			elseif type(v) == "boolean" then
				result = string.format("%s[%d]=%s,", result, k, tostring(v))
			else
				if flag then
					result = string.format("%s[%d]=%q,", result, k, type(v))
				else
					error("the type of value is a function or userdata")
				end
			end
		else
			if type(v) == "table" then
				result = string.format("%s%s=%s,", result, k, Serialize(v, flag))
			elseif type(v) == "number" then
				result = string.format("%s%s=%d,", result, k, v)
			elseif type(v) == "string" then
				result = string.format("%s%s=%q,", result, k, v)
			elseif type(v) == "boolean" then
				result = string.format("%s%s=%s,", result, k, tostring(v))
			else
				if flag then
					result = string.format("%s[%s]=%q,", result, k, type(v))
				else
					error("the type of value is a function or userdata")
				end
			end
		end
	end
	result = string.format("%s}", result)
	return result
end

--数字转二进制
function ToBinary(num)
	local str = ""
	local tmp = num
	while (tmp > 0) do
		if (tmp % 2 == 1) then
			str = str .. "1"
		else
			str = str .. "0"
		end
		
		tmp = math.modf(tmp / 2)
	end
	str = string.reverse(str)
	return str
end

--补齐两个数字的二进制位数
function ToSameLength(num1, num2)
	local str1 = ToBinary(num1) 
	local str2 = ToBinary(num2)
	
	local len1 = string.len(str1)
	local len2 = string.len(str2)
	-- print("len1 = " .. len1)
	-- print("len2 = " .. len2)
	
	local len = 0
	local x = 0
	
	if (len1 > len2) then
		x = len1 - len2
		for i = 1, x do
			str2 = "0" .. str2
		end
		len = len1
		-- print("len = "..len)
	elseif (len2 > len1) then
		x = len2 - len1
		for i = 1, x do
			str1 = "0" .. str1
		end
		len = len2
	end
	len = len1
	return str1, str2, len
end

--按位或 	
function BitOr(num1, num2)
	local str1, str2, len = ToSameLength(num1, num2)
	local rtmp = ""
	
	for i = 1, len do
		local st1 = tonumber(string.sub(str1, i, i))
		local st2 = tonumber(string.sub(str2, i, i))
		
		if(st1 ~= 0) then
			rtmp = rtmp .. "1"
		elseif (st1 == 0) then
			-- print("00000")
			if (st2 == 0) then
				rtmp = rtmp .. "0"
			end
		end
	end
	rtmp = tostring(rtmp)
	return rtmp
end


--按位与
function BitAnd(num1, num2)
	local str1, str2, len = ToSameLength(num1, num2)
	local rtmp = "0"
	
	for i = 1, len do
		local st1 = tonumber(string.sub(str1, i, i))
		local st2 = tonumber(string.sub(str2, i, i))
		
		
		if(st1 == 0) then
			rtmp = rtmp .. "0"	
		else
			if (st2 ~= 0) then
				rtmp = rtmp .. "1"
			else
				rtmp = rtmp .. "0"
			end
		end
	end
	rtmp = tostring(rtmp)
	return rtmp
end

--按位异或
function BitXOR(num1, num2)
	local str1, str2, len = ToSameLength(num1, num2)
	local rtmp = ""
	
	for i = 1, len do
		local st1 = tonumber(string.sub(str1, i, i))
		local st2 = tonumber(string.sub(str2, i, i))
		
		if (st1 ~= st2) then
			rtmp = rtmp .. "1"
		else
			rtmp = rtmp .. "0"
		end
	end
	rtmp = tostring(rtmp)
	return rtmp
end

--按位取反
function BitReverse(num)
	local str = ToBinary(num)
	local len = string.len(str)
	local rtmp = ""
	for i = 1, len do
		local st = tonumber(string.sub(str, i, i))
		if (st == 1) then
			rtmp = rtmp .. "0"
		elseif (st == 0) then
			rtmp = rtmp .. "1"
		end
	end
	rtmp = tostring(rtmp)
	return rtmp
end