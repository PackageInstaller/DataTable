-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\luacov\\util.lua

local util = {}

function util.unprefix(str, prefix)
	if str:sub(1, #prefix) == prefix then
		return str:sub(#prefix + 1)
	else
		return str
	end
end

local function read_file(name)
	local f, open_err = io.open(name, "rb")

	if not f then
		return nil, util.unprefix(open_err, name .. ": ")
	end

	local contents, read_err = f:read("*a")

	f:close()

	if contents then
		return contents
	else
		return nil, read_err
	end
end

function util.load_string(str, env, chunkname)
	if _VERSION:find("5%.1") then
		local func, err = loadstring(str, chunkname)

		if not func then
			return nil, err
		end

		if env then
			setfenv(func, env)
		end

		return func
	else
		return load(str, chunkname, "bt", env or _ENV)
	end
end

function util.load_config(name, env)
	local src, read_err = read_file(name)

	if not src then
		return nil, "read", read_err
	end

	local func, load_err = util.load_string(src, env, "@config")

	if not func then
		return nil, "load", "line " .. util.unprefix(load_err, "config:")
	end

	local ok, ret = pcall(func)

	if not ok then
		return nil, "run", "line " .. util.unprefix(ret, "config:")
	end

	return true, ret
end

function util.file_exists(name)
	local f = io.open(name)

	if f then
		f:close()

		return true
	else
		return false
	end
end

return util
