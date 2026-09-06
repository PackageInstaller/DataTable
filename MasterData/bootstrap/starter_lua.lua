-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/bootstrap/starter_lua.lua

if jit then
	jit.off()
end

enableLog = Framework.CLogger.enableLog
enableWarnLog = Framework.CLogger.enableWarnLog
enableErrorLog = Framework.CLogger.enableErrorLog
enableDebug = Framework.CLogger.isDebugBuild

function __G__TRACKBACK__(msg)
	if enableErrorLog then
		nprintError(msg .. "\n" .. debug.traceback())
	end

	return msg
end

function trycall(func, ...)
	local args = ...

	if args ~= nil then
		args = {
			...
		}

		return xpcall(function()
			func(unpack(args))
		end, __G__TRACKBACK__)
	else
		return xpcall(func, __G__TRACKBACK__)
	end
end

module_paths = {}
module_tables = {}

function setglobal(key, value)
	rawset(_G, key, value)
end

function getglobal(key)
	return rawget(_G, key)
end

function getmodule(name)
	return module_tables[name]
end

function usingnow(modulepath, modulename)
	local table = require(modulepath)

	if modulename and not module_tables[modulename] then
		if type(table) ~= "table" then
			module_tables[modulename] = true

			error("can not find module for path=" .. modulepath)
		else
			module_tables[modulename] = table

			setglobal(modulename, table)
		end
	end

	return table
end

function using(modulepath, modulename)
	if modulename and not module_paths[modulename] then
		module_paths[modulename] = modulepath
	end

	return true
end

gmetatable = {}

function gmetatable.__index(_, key)
	local table = module_tables[key]

	if not table then
		local path = module_paths[key]

		if path then
			table = require(path)

			if type(table) ~= "table" then
				module_tables[key] = true

				error("can not find module for path=" .. path)
			else
				module_tables[key] = table

				setglobal(key, table)
			end
		end
	end

	return table
end

function gmetatable.__newindex(_, key, value)
	if key ~= "framework" and key ~= "frameworkext" and key ~= "bootstrap" and key ~= "logic" then
		error("set global vairable directly is not allowed,please use setglobal instead!,key=" .. key)
	end
end

setmetatable(_G, gmetatable)

local function Main()
	usingnow("bootstrap.core.log")
	usingnow("bootstrap.core.table")
	usingnow("bootstrap.core.oop")
	usingnow("bootstrap.core.math")
	usingnow("bootstrap.core.io")
	usingnow("bootstrap.core.string")
	usingnow("bootstrap.shortcut_csharp")
	usingnow("bootstrap.LogTag", "LogTag")
	usingnow("bootstrap.BootstrapUtil", "BootstrapUtil")
	usingnow("bootstrap.BootstrapConstdef", "BootstrapConstdef")
	usingnow("bootstrap.BootstrapLauncherBase", "BootstrapLauncherBase")
	print("AoUnity-lua is started...")

	local VersionMgr = {}

	VersionMgr.Instance = {}

	function VersionMgr.Instance.IsClientNew()
		return false
	end

	setglobal("VersionMgr", VersionMgr)
	usingnow("bootstrap.BootstrapLauncher", "BootstrapLauncher")
end

local ret, errMessage = trycall(Main)
