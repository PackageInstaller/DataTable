-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/notify/NotifyDispatcher.lua

module("framework.notify.NotifyDispatcher", package.seeall)

local NotifyDispatcher = {}

function NotifyDispatcher.extend(target)
	target._listenPendings = {}
	target._dispatchPendings = {}
	target._allListeners = {}
	target._dispatching = {}
	target._tempToRemoves = {}

	function target.addListener(targetObj, notifyName, handler, handlerObj, priority)
		if not handler then
			printError("Notify handler cannot be nil,notifyName=", notifyName)

			return
		end

		local bExists = targetObj:_hasListenerInQueue(notifyName, handler, handlerObj)
		local bToInsert = false
		local bToDelete = false

		if targetObj._dispatching[notifyName] then
			local status = targetObj:_getStatusInPending(notifyName, handler, handlerObj)

			if status == NotifyStatus.ToInsert then
				bToInsert = true
			elseif status == NotifyStatus.ToDelete then
				bToDelete = true
			end
		end

		if bToInsert then
			return
		end

		if bExists and not bToDelete then
			return
		end

		local entry = NotifyEntry.getPool():fetchObject()

		entry.name = notifyName
		entry.handlerObj = handlerObj
		entry.handler = handler
		entry.priority = priority or NotifyPriority.Normal

		if targetObj._dispatching[notifyName] then
			targetObj:_removeFromListenPending(notifyName, handler, handlerObj)

			entry.status = NotifyStatus.ToInsert
			targetObj._listenPendings[notifyName] = targetObj._listenPendings[notifyName] or {}

			table.insert(targetObj._listenPendings[notifyName], entry)
		else
			targetObj:_safeAddListener(entry)
		end
	end

	function target.removeAllListener(targetObj, notifyName)
		if targetObj._allListeners[notifyName] == nil then
			return
		end

		local listeners = targetObj._allListeners[notifyName]

		for i = NotifyPriority.High, NotifyPriority.Low, -1 do
			local entries = listeners[i]
			local entryCount = #entries

			for j = 1, entryCount do
				local tempItem = {}

				tempItem.handler = entries[j].handler
				tempItem.handlerObj = entries[j].handlerObj

				table.insert(targetObj._tempToRemoves, tempItem)
			end
		end

		local len = #targetObj._tempToRemoves

		for i = 1, len do
			targetObj:removeListener(notifyName, targetObj._tempToRemoves[i].handler, targetObj._tempToRemoves[i].handlerObj)

			targetObj._tempToRemoves[i] = nil
		end
	end

	function target.removeListener(targetObj, notifyName, handler, handlerObj, isRemoveAllHandler)
		if targetObj._allListeners[notifyName] == nil then
			return
		end

		if targetObj._dispatching[notifyName] then
			targetObj:_removeFromListenPending(notifyName, handler, handlerObj, isRemoveAllHandler)

			local entry = NotifyEntry.getPool():fetchObject()

			entry.handler = handler
			entry.handlerObj = handlerObj
			entry.status = NotifyStatus.ToDelete
			entry.name = notifyName
			entry.isRemoveAllHandler = isRemoveAllHandler
			targetObj._listenPendings[notifyName] = targetObj._listenPendings[notifyName] or {}

			table.insert(targetObj._listenPendings[notifyName], entry)
		else
			targetObj:_safeRemoveListener(notifyName, handler, handlerObj, isRemoveAllHandler)
		end
	end

	function target._removeFromListenPending(targetObj, notifyName, handler, handlerObj, isRemoveAllHandler)
		local pendings = targetObj._listenPendings[notifyName]

		if not pendings then
			return
		end

		local pCount = #pendings

		for i = pCount, 1, -1 do
			local entry = pendings[i]

			if entry.name == notifyName and entry.handler == handler then
				if isRemoveAllHandler then
					NotifyEntry.getPool():returnObject(entry)
					table.remove(pendings, i)
				elseif entry.handlerObj == handlerObj then
					NotifyEntry.getPool():returnObject(entry)
					table.remove(pendings, i)

					break
				end
			end
		end
	end

	function target._safeAddListener(targetObj, entry)
		local listeners = targetObj._allListeners[entry.name]

		if listeners == nil then
			listeners = {}

			for i = NotifyPriority.Low, NotifyPriority.High do
				listeners[i] = {}
			end

			targetObj._allListeners[entry.name] = listeners
		end

		if targetObj:_hasListenerInQueue(entry.name, entry.handler, entry.handlerObj) then
			NotifyEntry.getPool():returnObject(entry)

			return
		end

		entry.status = NotifyStatus.Active

		table.insert(listeners[entry.priority], entry)
	end

	function target._safeRemoveListener(targetObj, notifyName, handler, handlerObj, isRemoveAllHandler)
		if targetObj._allListeners[notifyName] == nil then
			return
		end

		local listeners = targetObj._allListeners[notifyName]

		for i = NotifyPriority.Low, NotifyPriority.High do
			local entries = listeners[i]
			local entryCount = #entries

			for j = entryCount, 1, -1 do
				if entries[j].handler == handler then
					if isRemoveAllHandler then
						NotifyEntry.getPool():returnObject(entries[j])
						table.remove(entries, j)
					elseif entries[j].handlerObj == handlerObj then
						NotifyEntry.getPool():returnObject(entries[j])
						table.remove(entries, j)

						break
					end
				end
			end
		end
	end

	function target.dispatch(targetObj, notifyName, ...)
		if targetObj._allListeners == nil or targetObj._allListeners[notifyName] == nil then
			return
		end

		if targetObj._dispatching[notifyName] then
			local dEntry = DispatchEntry.getPool():fetchObject()

			dEntry.name = notifyName

			local args = ...

			dEntry.message = args ~= nil and {
				...
			} or nil

			table.insert(targetObj._dispatchPendings, dEntry)

			return
		end

		targetObj._dispatching[notifyName] = true

		local listeners = targetObj._allListeners[notifyName]

		for i = NotifyPriority.High, NotifyPriority.Low, -1 do
			local entries = listeners[i]
			local entryCount = #entries

			for j = 1, entryCount do
				if entries[j].handlerObj then
					trycall(entries[j].handler, entries[j].handlerObj, ...)
				else
					trycall(entries[j].handler, ...)
				end
			end
		end

		targetObj._dispatching[notifyName] = nil

		local pendings = targetObj._listenPendings[notifyName]

		if pendings then
			local pendingCount = #pendings

			for i = 1, pendingCount do
				local pEntry = pendings[i]

				if pEntry.status == NotifyStatus.ToInsert then
					targetObj:_safeAddListener(pEntry)
				elseif pEntry.status == NotifyStatus.ToDelete then
					targetObj:_safeRemoveListener(pEntry.name, pEntry.handler, pEntry.handlerObj, pEntry.isRemoveAllHandler)
					NotifyEntry.getPool():returnObject(pEntry)
				end

				pendings[i] = nil
			end
		end

		if #targetObj._dispatchPendings > 0 then
			local dpEntry = table.remove(targetObj._dispatchPendings, 1)

			if not targetObj._dispatching[dpEntry.name] then
				if dpEntry.message then
					targetObj:dispatch(dpEntry.name, unpack(dpEntry.message))
				else
					targetObj:dispatch(dpEntry.name)
				end

				DispatchEntry.getPool():returnObject(dpEntry)
			end
		end
	end

	function target._getStatusInPending(targetObj, notifyName, handler, handlerObj)
		local status = 0
		local pendings = targetObj._listenPendings[notifyName]

		if pendings then
			local count = #pendings

			for i = count, 1, -1 do
				local pEntry = pendings[i]

				if pEntry.name == notifyName and pEntry.handlerObj == handlerObj and pEntry.handler == handler then
					if pEntry.status == NotifyStatus.ToInsert then
						status = NotifyStatus.ToInsert

						break
					elseif pEntry.status == NotifyStatus.ToDelete then
						status = NotifyStatus.ToDelete

						break
					end
				end
			end
		end

		return status
	end

	function target._hasListenerInQueue(targetObj, notifyName, handler, handlerObj)
		if targetObj._allListeners[notifyName] == nil then
			return false
		end

		local listeners = targetObj._allListeners[notifyName]
		local flag = false

		for i = NotifyPriority.Low, NotifyPriority.High do
			local entries = listeners[i]
			local entryCount = #entries

			for j = entryCount, 1, -1 do
				if entries[j].handler == handler and entries[j].handlerObj == handlerObj then
					flag = true

					break
				end
			end

			if flag then
				break
			end
		end

		return flag
	end

	function target.hasListener(targetObj, notifyName, handler, handlerObj)
		local bRet = targetObj:_hasListenerInQueue(notifyName, handler, handlerObj)

		if targetObj._dispatching then
			local status = targetObj:_getStatusInPending(notifyName, handler, handlerObj)

			if status == NotifyStatus.ToInsert then
				bRet = true
			elseif status == NotifyStatus.ToDelete then
				bRet = false
			end
		end

		return bRet
	end
end

return NotifyDispatcher
