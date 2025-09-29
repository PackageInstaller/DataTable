-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/reloadlua/ReloadLuaMgr.lua

module("logic.reloadlua.ReloadLuaMgr", package.seeall)

local ReloadLuaMgr = class("ReloadLuaMgr")

setglobal("ReloadLuaMgr", ReloadLuaMgr)

ReloadLuaMgr.reloaded = {}

function ReloadLuaMgr.getModule(name)
	local module = getmodule(name)

	if not module then
		printError(string.format("module=%s 未加载", scriptName))
	end

	return module
end

function ReloadLuaMgr.require(modulePath)
	package.loaded[modulePath] = nil

	return require(modulePath)
end

function ReloadLuaMgr.reloadFuncs(scriptName, modulePath, changedArray)
	printWarn("TCL:-- reload  " .. scriptName)

	local oldModule = ReloadLuaMgr.getModule(scriptName)

	if not oldModule then
		return
	end

	local status, tb = pcall(ReloadLuaMgr.require, modulePath)

	if not status then
		printError(tb)
	end

	ReloadLuaMgr.reloaded[scriptName] = tb

	local len = changedArray.Length

	for i = 0, len - 1 do
		local funcName = changedArray[i]

		if tb[funcName] then
			local timerEntry = ReloadLuaMgr.getTimerEntry(oldModule[funcName])

			if timerEntry then
				timerEntry.handler = tb[funcName]
			end

			local oldFun = oldModule[funcName]

			if not oldModule.warm_backup then
				oldModule.warm_backup = {}
			end

			oldModule.warm_backup[tostring(oldFun)] = funcName
			oldModule[funcName] = tb[funcName]
		end
	end
end

ReloadLuaMgr.cantReloadVars = {
	__index = 1,
	__supers = 1,
	instance = 1,
	super = 1
}

function ReloadLuaMgr.reloadVars(scriptName)
	local oldModule = ReloadLuaMgr.getModule(scriptName)

	if not oldModule then
		return
	end

	local newModule = ReloadLuaMgr.reloaded[scriptName]

	if newModule then
		for k, v in pairs(newModule) do
			if type(v) ~= "function" and not ReloadLuaMgr.cantReloadVars[k] and (not oldModule[k] or oldModule[k] ~= v) then
				oldModule[k] = newModule[k]
			end
		end
	end
end

function ReloadLuaMgr.refreshEvent(handler, handlerObj)
	local func = ReloadLuaMgr.getReloadFunc(handler, handlerObj)

	func = func or handler

	func(handlerObj)
end

function ReloadLuaMgr.getReloadFunc(handler, handlerObj)
	local func

	if not handlerObj or not handler then
		return func
	end

	local cName = handlerObj.__cname
	local reload = cName ~= nil

	if reload then
		reload = ReloadLuaMgr.reloaded[cName] ~= nil

		if reload then
			local module = getmodule(cName)
			local funcName = module.warm_backup and module.warm_backup[tostring(handler)]

			func = funcName and module[funcName]
		end
	end

	return func
end

function ReloadLuaMgr._findListenerInQueue(handler)
	local bRetEntry, entry
	local entryCount = #Scheduler._listeners

	for i = entryCount, 1, -1 do
		entry = Scheduler._listeners[i]

		if entry.handler == handler then
			bRetEntry = entry

			break
		end
	end

	return bRetEntry
end

function ReloadLuaMgr._findEntryInPendings(handler)
	local entry
	local count = #Scheduler._pendings

	for i = count, 1, -1 do
		local pEntry = Scheduler._pendings[i]

		if pEntry.handler == handler and pEntry.status == kScheduleStatusToInsert then
			entry = pEntry

			break
		end
	end

	return entry
end

function ReloadLuaMgr.getTimerEntry(handler)
	local entry = ReloadLuaMgr._findListenerInQueue(handler)

	entry = entry or ReloadLuaMgr._findEntryInPendings(handler)

	return entry
end

function ReloadLuaMgr.clear()
	for k, v in ReloadLuaMgr.reloaded do
		ReloadLuaMgr.reloaded[k] = nil
	end
end

return ReloadLuaMgr
