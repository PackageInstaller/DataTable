-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/schedule/Scheduler.lua

module("framework.schedule.Scheduler", package.seeall)

local Scheduler = {}

function Scheduler.init()
	Scheduler._listeners = {}
	Scheduler._dispatching = false
	Scheduler._pendings = {}
	Scheduler._onceList = {}
	Scheduler._tempEntry = nil
	Scheduler._tempExecuted = false

	ScheduleEntry.initPool()

	Scheduler._pool = ScheduleEntry.getPool()

	UpdateBeat:Add(Scheduler._update, Scheduler)
end

function Scheduler:_update()
	local dt = Time.deltaTime

	Scheduler._dispatching = true

	local count = #Scheduler._listeners

	for i = 1, count do
		Scheduler._tempEntry = Scheduler._listeners[i]

		if Scheduler._tempEntry.status ~= kScheduleStatusToDelete then
			Scheduler._tempExecuted = Scheduler._tempEntry:update(dt)

			if Scheduler._tempExecuted and not Scheduler._tempEntry.isRepeat then
				table.insert(Scheduler._onceList, i)
			end
		end
	end

	Scheduler._tempEntry = nil
	Scheduler._tempExecuted = false
	Scheduler._dispatching = false
	count = #Scheduler._onceList

	for i = #Scheduler._onceList, 1, -1 do
		local onceIndex = Scheduler._onceList[i]

		ScheduleEntry._pool:returnObject(Scheduler._listeners[onceIndex])
		table.remove(Scheduler._listeners, onceIndex)

		Scheduler._onceList[i] = nil
	end

	count = #Scheduler._pendings

	for i = 1, #Scheduler._pendings do
		Scheduler._tempEntry = Scheduler._pendings[i]

		if Scheduler._tempEntry.status == kScheduleStatusToInsert then
			Scheduler._safeAddListener(Scheduler._tempEntry)
		elseif Scheduler._tempEntry.status == kScheduleStatusToDelete then
			Scheduler._safeRemoveListener(Scheduler._tempEntry.handler, Scheduler._tempEntry.handlerObj)
			ScheduleEntry._pool:returnObject(Scheduler._tempEntry)
		end

		Scheduler._pendings[i] = nil
	end

	ScheduleEntry.curFrame = ScheduleEntry.curFrame + 1
end

function Scheduler.addListener(interval, handler, handlerObj, isRepeat)
	local bToInsert = false
	local bToDelete = false

	if Scheduler._dispatching then
		local status = Scheduler._getStatusInPending(handler, handlerObj)

		if status == kScheduleStatusToInsert then
			bToInsert = true
		elseif status == kScheduleStatusToDelete then
			bToDelete = true
		end
	end

	if bToInsert then
		return
	end

	if isRepeat == nil then
		isRepeat = true
	end

	local existedEntry = Scheduler._findListenerInQueue(handler, handlerObj)

	if existedEntry ~= nil and existedEntry.isRepeat and not bToDelete then
		existedEntry.interval = interval
		existedEntry.regFrame = ScheduleEntry.curFrame
		existedEntry.isRepeat = isRepeat

		return
	end

	local entry = ScheduleEntry._pool:fetchObject()

	entry.handlerObj = handlerObj
	entry.handler = handler
	entry.interval = interval
	entry.regFrame = ScheduleEntry.curFrame
	entry.isRepeat = isRepeat

	if Scheduler._dispatching then
		Scheduler._removeFromPending(handler, handlerObj)

		entry.status = kScheduleStatusToInsert

		table.insert(Scheduler._pendings, entry)
	else
		Scheduler._safeAddListener(entry)
	end
end

function Scheduler.removeListener(handler, handlerObj)
	if Scheduler._dispatching then
		Scheduler._removeFromPending(handler, handlerObj)

		local entry = ScheduleEntry._pool:fetchObject()

		entry.handler = handler
		entry.handlerObj = handlerObj
		entry.status = kScheduleStatusToDelete

		table.insert(Scheduler._pendings, entry)
		Scheduler._removeListeners(handler, handlerObj)
	else
		Scheduler._safeRemoveListener(handler, handlerObj)
	end
end

function Scheduler._removeListeners(handler, handlerObj)
	local entryCount = #Scheduler._listeners
	local entry

	for i = entryCount, 1, -1 do
		if Scheduler._listeners[i].handler == handler and Scheduler._listeners[i].handlerObj == handlerObj then
			Scheduler._listeners[i].status = kScheduleStatusToDelete

			break
		end
	end
end

function Scheduler.hasListener(handler, handlerObj)
	local bRet = false
	local entry = Scheduler._findListenerInQueue(handler, handlerObj)

	if entry ~= nil then
		bRet = true
	end

	if Scheduler._dispatching then
		local status = Scheduler._getStatusInPending(handler, handlerObj)

		if status == kScheduleStatusToInsert then
			bRet = true
		elseif status == kScheduleStatusToDelete then
			bRet = false
		end
	end

	return bRet
end

function Scheduler._removeFromPending(handler, handlerObj)
	for i = #Scheduler._pendings, 1, -1 do
		local entry = Scheduler._pendings[i]

		if entry.handlerObj == handlerObj and entry.handler == handler then
			ScheduleEntry._pool:returnObject(entry)
			table.remove(Scheduler._pendings, i)

			break
		end
	end
end

function Scheduler._safeRemoveListener(handler, handlerObj)
	local entryCount = #Scheduler._listeners
	local entry

	for i = entryCount, 1, -1 do
		if Scheduler._listeners[i].handler == handler and Scheduler._listeners[i].handlerObj == handlerObj then
			ScheduleEntry._pool:returnObject(Scheduler._listeners[i])
			table.remove(Scheduler._listeners, i)

			break
		end
	end
end

function Scheduler._safeAddListener(entry)
	local entryInQueue = Scheduler._findListenerInQueue(entry.handler, entry.handlerObj)

	if entryInQueue then
		entryInQueue.interval = entry.interval
		entryInQueue.regFrame = entry.regFrame
		entryInQueue.isRepeat = entry.isRepeat
		entryInQueue.status = kScheduleStatusToInsert

		ScheduleEntry._pool:returnObject(entry)
	else
		entry.status = NotifyStatus.Active

		table.insert(Scheduler._listeners, entry)
	end
end

function Scheduler._getStatusInPending(handler, handlerObj)
	local status = 0
	local count = #Scheduler._pendings

	for i = count, 1, -1 do
		local pEntry = Scheduler._pendings[i]

		if pEntry.handlerObj == handlerObj and pEntry.handler == handler then
			if pEntry.status == kScheduleStatusToInsert then
				status = kScheduleStatusToInsert

				break
			elseif pEntry.status == kScheduleStatusToDelete then
				status = kScheduleStatusToDelete

				break
			end
		end
	end

	return status
end

function Scheduler._findListenerInQueue(handler, handlerObj)
	local bRetEntry, entry
	local entryCount = #Scheduler._listeners

	for i = entryCount, 1, -1 do
		if Scheduler._listeners[i].handler == handler and Scheduler._listeners[i].handlerObj == handlerObj then
			bRetEntry = Scheduler._listeners[i]

			break
		end
	end

	return bRetEntry
end

return Scheduler
