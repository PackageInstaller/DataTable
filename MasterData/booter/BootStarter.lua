-- chunkname: @booter/BootStarter.lua

if jit and SLFramework.FrameworkSettings.Is64Bit then
	jit.off()
end

canLogNormal = SLFramework.SLLogger.CanLogNormal
canLogWarn = SLFramework.SLLogger.CanLogWarn
canLogError = SLFramework.SLLogger.CanLogError
isDebugBuild = SLFramework.UnityHelper.IsDebugBuild()
_xpcall = xpcall

function __G__TRACKBACK__(msg)
	if canLogError then
		printError(msg .. "\n" .. debug.traceback())
	end
end

function callWithCatch(func, ...)
	local args = ...
	local len = args ~= nil and select("#", ...) or 0

	if len > 0 then
		return _xpcall(func, __G__TRACKBACK__, select(1, ...))
	else
		return _xpcall(func, __G__TRACKBACK__)
	end
end

function setGlobal(key, value)
	if key == nil then
		error("BootStarter setGlobal, key should not be nil!")

		return
	end

	rawset(_G, key, value)
end

function getGlobal(key)
	return rawget(_G, key)
end

moduleNameToTables = {}
moduleNameToPath = {}

function getModuleDef(moduleName)
	return moduleNameToTables[moduleName]
end

function getModulePath(moduleName)
	return moduleNameToPath[moduleName]
end

function addGlobalModule(modulePath, moduleName)
	local moduleDef = require(modulePath)

	if moduleName and not moduleNameToTables[moduleName] then
		if type(moduleDef) ~= "table" then
			moduleNameToTables[moduleName] = true

			error("BootStarter addGlobalModule, can not find module define, module path = " .. modulePath)
		else
			moduleNameToTables[moduleName] = moduleDef

			setGlobal(moduleName, moduleDef)
		end
	end

	return moduleDef
end

function setNeedLoadModule(modulePath, moduleName)
	if moduleName and not moduleNameToPath[moduleName] then
		moduleNameToPath[moduleName] = modulePath
	end

	return true
end

gMetaTable = {}

function gMetaTable.__index(_, key)
	local moduleDef = moduleNameToTables[key]

	if not moduleDef then
		local modulePath = moduleNameToPath[key]

		if modulePath then
			moduleDef = require(modulePath)

			if type(moduleDef) ~= "table" then
				moduleNameToTables[key] = true

				error("BootStarter __index, can not find module define, module path = " .. modulePath)
			else
				moduleNameToTables[key] = moduleDef

				setGlobal(key, moduleDef)
			end
		end
	end

	return moduleDef
end

function gMetaTable.__newindex(_, key, value)
	if key ~= "booter" and key ~= "projbooter" and key ~= "framework" and key ~= "modules" and key ~= "protobuf" then
		error("BootStarter gMetaTable.__newindex, can not set _G table value from other module, use setGlobal function instead! key = " .. key)
	end
end

setmetatable(_G, gMetaTable)

local function main()
	addGlobalModule("booter.base.cjson")
	addGlobalModule("booter.base.logger")
	addGlobalModule("booter.base.oop")
	addGlobalModule("booter.base.string")
	addGlobalModule("booter.base.tabletool")
	forceLog("SLFramework, lua start!")
	addGlobalModule("booter.LuaResMgr")

	local GameConfig = SLFramework.GameConfig.Instance

	setGlobal("GameConfig", GameConfig)
	addGlobalModule("projbooter.ProjBooter", "ProjBooter")
end

local result, errorMsg = callWithCatch(main)
