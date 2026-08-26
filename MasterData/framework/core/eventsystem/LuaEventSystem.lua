-- chunkname: @framework/core/eventsystem/LuaEventSystem.lua

module("framework.core.eventsystem.LuaEventSystem", package.seeall)

local LuaEventSystem = {}

LuaEventSystem.Idle = 1
LuaEventSystem.Active = 2
LuaEventSystem.ToInsert = 3
LuaEventSystem.ToDelete = 4
LuaEventSystem.High = 1
LuaEventSystem.Common = 2
LuaEventSystem.Low = 3

function LuaEventSystem.addEventMechanism(luaObj)
	luaObj._allEvents = {}
	luaObj._allDeltaEvents = {}
	luaObj._inDispatching = {}
	luaObj._dispatchDelta = {}

	function luaObj.registerCallback(eventSender, eventName, callback, cbObj, priority)
		if callback == nil then
			logError("LuaEventSystem registerCallback callback shoule not be nil, please check it!")

			return
		end

		local toDelete = false

		if eventSender._inDispatching[eventName] then
			local status = eventSender:_getStatusInDeltaList(eventName, callback, cbObj)

			if status == LuaEventSystem.ToDelete then
				toDelete = true
			elseif status == LuaEventSystem.ToInsert then
				return
			end
		end

		local isInQueue = eventSender:_isInEventQueue(eventName, callback, cbObj)

		if isInQueue and not toDelete then
			return
		end

		local eventItem = EventItem.getPool():getObject()

		eventItem.eventName = eventName
		eventItem.callback = callback

		eventItem:setCbObj(cbObj)

		eventItem.priority = priority or LuaEventSystem.Common

		if eventSender._inDispatching[eventName] then
			eventSender:_removeFromDeltaList(eventName, callback, cbObj)

			eventItem.status = LuaEventSystem.ToInsert

			local deltaList = eventSender._allDeltaEvents[eventName]

			if not deltaList then
				deltaList = {}
				eventSender._allDeltaEvents[eventName] = deltaList
			end

			table.insert(deltaList, eventItem)
		else
			eventSender:_directAddEvent(eventItem)
		end
	end

	function luaObj.unregisterCallback(eventSender, eventName, callback, cbObj, removeAll)
		local eventList = eventSender._allEvents[eventName]

		if not eventList then
			return
		end

		if eventSender._inDispatching[eventName] then
			eventSender:_removeFromDeltaList(eventName, callback, cbObj, removeAll)

			local eventItem = EventItem.getPool():getObject()

			eventItem.eventName = eventName
			eventItem.callback = callback

			eventItem:setCbObj(cbObj)

			eventItem.status = LuaEventSystem.ToDelete
			eventItem.removeAll = removeAll

			local deltaList = eventSender._allDeltaEvents[eventName]

			if not deltaList then
				deltaList = {}
				eventSender._allDeltaEvents[eventName] = deltaList
			end

			table.insert(deltaList, eventItem)
		else
			eventSender:_directRemoveEvent(eventName, callback, cbObj, removeAll)
		end
	end

	function luaObj.unregisterAllCallback(eventSender, eventName)
		local eventList = eventSender._allEvents[eventName]

		if not eventList then
			return
		end

		local removeList = {}
		local priorityList

		for idx = LuaEventSystem.High, LuaEventSystem.Low do
			priorityList = eventList[idx]

			for idy = 1, #eventList[idx] do
				local eventItem = priorityList[idy]
				local removeItem = EventItem.getPool():getObject()

				removeItem.callback = eventItem.callback

				removeItem:setCbObj(eventItem:getCbObj())
				table.insert(removeList, removeItem)
			end
		end

		for _, removeItem in ipairs(removeList) do
			eventSender:unregisterCallback(eventName, removeItem.callback, removeItem:getCbObj())
		end
	end

	function luaObj.dispatchEvent(eventSender, eventName, ...)
		if luaObj._allEvents == nil or luaObj._allEvents[eventName] == nil then
			return
		end

		if luaObj._inDispatching[eventName] then
			local dispatchItem = DispatchItem.getPool():getObject()

			dispatchItem.eventName = eventName

			local args = ...

			if args == nil then
				dispatchItem.eventArgs = nil
			else
				dispatchItem.eventArgs = {
					...
				}
			end

			table.insert(luaObj._dispatchDelta, dispatchItem)

			return
		end

		luaObj._inDispatching[eventName] = true

		eventSender:_directDispatch(eventName, ...)

		luaObj._inDispatching[eventName] = nil

		local deltaEvents = eventSender._allDeltaEvents[eventName]

		if deltaEvents ~= nil then
			local deltaCount = #deltaEvents
			local eventItem

			for idx = 1, deltaCount do
				if LuaEventSystem.ToInsert == deltaEvents[idx].status then
					eventSender:_directAddEvent(deltaEvents[idx])
				elseif LuaEventSystem.ToDelete == deltaEvents[idx].status then
					eventSender:_directRemoveEvent(deltaEvents[idx].eventName, deltaEvents[idx].callback, deltaEvents[idx]:getCbObj(), deltaEvents[idx].removeAll)
					EventItem.getPool():putObject(deltaEvents[idx])
				end

				deltaEvents[idx] = nil
			end
		end

		if #eventSender._dispatchDelta > 0 then
			local dispatchItem = table.remove(eventSender._dispatchDelta, 1)

			if not eventSender._inDispatching[dispatchItem.eventName] then
				if dispatchItem.eventArgs ~= nil then
					eventSender:dispatchEvent(dispatchItem.eventName, unpack(dispatchItem.eventArgs))
				else
					eventSender:dispatchEvent(dispatchItem.eventName)
				end

				DispatchItem.getPool():putObject(dispatchItem)
			else
				table.insert(eventSender._dispatchDelta, 1, dispatchItem)
			end
		end
	end

	function luaObj._directDispatch(eventSender, eventName, ...)
		local curEvents = luaObj._allEvents[eventName]
		local priorityItems, priorityCount, eventItem

		for idx = LuaEventSystem.High, LuaEventSystem.Low do
			for idy = 1, #curEvents[idx] do
				if not curEvents[idx][idy]:dispatch(...) then
					eventSender:unregisterCallback(eventName, curEvents[idx][idy].callback, curEvents[idx][idy]:getCbObj())
				end
			end
		end
	end

	function luaObj._directAddEvent(eventSender, eventItem)
		local curEventList = eventSender._allEvents[eventItem.eventName]

		if curEventList == nil then
			curEventList = {}

			for idx = LuaEventSystem.High, LuaEventSystem.Low do
				curEventList[idx] = {}
			end

			eventSender._allEvents[eventItem.eventName] = curEventList
		end

		if eventSender:_isInEventQueue(eventItem.eventName, eventItem.callback, eventItem:getCbObj()) then
			EventItem.getPool():putObject(eventItem)

			return
		end

		eventItem.status = LuaEventSystem.Active

		table.insert(curEventList[eventItem.priority], eventItem)
	end

	function luaObj._isInEventQueue(eventSender, eventName, callback, cbObj)
		local eventList = eventSender._allEvents[eventName]

		if eventList == nil then
			return false
		end

		local priorityList

		for idx = LuaEventSystem.High, LuaEventSystem.Low do
			priorityList = eventList[idx]

			for idy = 1, #eventList[idx] do
				local eventItem = priorityList[idy]

				if eventItem.callback == callback and eventItem:getCbObj() == cbObj then
					return true
				end
			end
		end

		return false
	end

	function luaObj._directRemoveEvent(eventSender, eventName, callback, cbObj, removeAll)
		local eventList = eventSender._allEvents[eventName]

		if eventList == nil then
			return
		end

		local priorityList

		for idx = LuaEventSystem.High, LuaEventSystem.Low do
			priorityList = eventList[idx]

			for idy = #eventList[idx], 1, -1 do
				local eventItem = priorityList[idy]

				if eventItem.callback == callback then
					if removeAll then
						EventItem.getPool():putObject(eventItem)
						table.remove(priorityList, idy)
					elseif eventItem:getCbObj() == cbObj then
						EventItem.getPool():putObject(eventItem)
						table.remove(priorityList, idy)

						break
					end
				end
			end
		end
	end

	function luaObj._getStatusInDeltaList(eventSender, eventName, callback, cbObj)
		local curDeltaList = eventSender._allDeltaEvents[eventName]

		if curDeltaList == nil then
			return 0
		end

		local deltaItem

		for idx = #curDeltaList, 1, -1 do
			if curDeltaList[idx].eventName == eventName and curDeltaList[idx].callback == callback and curDeltaList[idx]:getCbObj() == cbObj then
				return curDeltaList[idx].status
			end
		end
	end

	function luaObj._removeFromDeltaList(eventSender, eventName, callback, cbObj, removeAll)
		local deltaList = eventSender._allDeltaEvents[eventName]

		if not deltaList then
			return
		end

		local eventItem

		for idx = #deltaList, 1, -1 do
			if deltaList[idx].callback == callback then
				if removeAll then
					EventItem.getPool():putObject(deltaList[idx])
					table.remove(deltaList, idx)
				elseif deltaList[idx]:getCbObj() == cbObj then
					EventItem.getPool():putObject(deltaList[idx])
					table.remove(deltaList, idx)

					break
				end
			end
		end
	end
end

return LuaEventSystem
