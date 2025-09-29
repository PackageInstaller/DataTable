-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/reloadlua/ReloadLuaUtil.lua

module("logic.reloadlua.ReloadLuaUtil", package.seeall)

local ReloadLuaUtil = {}

function ReloadLuaUtil.requireLuaDebug()
	ReloadLuaUtil.doDebugFile("ReloadLuaDebug")
end

function ReloadLuaUtil.requireLuaDebug2()
	ReloadLuaUtil.doDebugFile("ReloadLuaDebug2")
end

function ReloadLuaUtil.doDebugFile(name)
	local fullPath = UnityEngine.Application.dataPath .. "/Scripts/Lua/logic/config/local/" .. name .. ".lua"

	if not io.exists(fullPath) then
		printError("reloadLua失败，本地脚本缺失。\n请复制ReloadLuaDebugTemplate，并重命名为" .. name .. "。\n文件具体路径如下:\nAssets/Scripts/Lua/logic/config/local/ReloadLuaDebugTemplate.lua\nAssets/Scripts/Lua/logic/config/local/" .. name .. ".lua")

		return
	end

	dofile(fullPath)
end

function ReloadLuaUtil.replaceLog()
	local fullPath = UnityEngine.Application.dataPath .. "/Scripts/Lua/logic/config/local/MyLog.lua"

	if not io.exists(fullPath) then
		return
	end

	if ReloadLuaUtil.hasReplace then
		return
	end

	ReloadLuaUtil.hasReplace = true

	local modulepath = "logic.config.local.MyLog"
	local modulename = "MyLog"

	using(modulepath, modulename)
	require(modulepath)
end

function ReloadLuaUtil.clearEvents()
	printWarn("TCL--: 41 ReloadLuaUtil-clearEvents")

	local fullPath = UnityEngine.Application.dataPath .. "/Scripts/Lua/logic/config/local/ReloadLuaUtilLocalConfig.lua"

	if not io.exists(fullPath) then
		printError("reloadLua失败，本地配置缺失。\n请复制ReloadLuaUtilLocalConfigTemplate，并重命名为ReloadLuaUtilLocalConfig，修改文件中的配置信息为自己需要的。\n文件具体路径如下:\nAssets/Scripts/Lua/logic/config/local/ReloadLuaUtilLocalConfigTemplate.lua\nAssets/Scripts/Lua/logic/config/local/ReloadLuaUtilLocalConfig.lua")

		return
	end

	local modulepath = "logic.config.local.ReloadLuaUtilLocalConfig"
	local modulename = "ReloadLuaUtilLocalConfig"

	using(modulepath, modulename)
	require(modulepath)

	local clearEvents = ReloadLuaUtilLocalConfig.clearEvents

	for k, v in pairs(clearEvents) do
		GlobalDispatcher.__eventMap__[v] = nil
	end
end

return ReloadLuaUtil
