-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Framework\\EventCenter.lua

local DEFAULT_FILTER = ""
local _EventCenter = {}

_EventCenter.eventDict = {}

function _EventCenter.destroy()
	_EventCenter.eventDict = nil
end

function _EventCenter.clearAllEvent()
	_EventCenter.eventDict = {}
end

function _EventCenter.clearOneEvent(inEventType)
	if _EventCenter.eventDict[inEventType] == nil then
		-- block empty
	else
		_EventCenter.eventDict[inEventType] = nil
	end
end

function _EventCenter.addEventListener(eventType, func, filter)
	filter = filter or DEFAULT_FILTER

	if _EventCenter.eventDict[eventType] == nil then
		_EventCenter.eventDict[eventType] = {}
	end

	if _EventCenter.eventDict[eventType][filter] == nil then
		_EventCenter.eventDict[eventType][filter] = {}
	end

	if _EventCenter.eventDict[eventType][filter][func] == nil then
		_EventCenter.eventDict[eventType][filter][func] = func
	end
end

function _EventCenter.removeEventListener(eventType, func, filter)
	filter = filter or DEFAULT_FILTER

	if _EventCenter.eventDict[eventType] and _EventCenter.eventDict[eventType][filter] and func then
		_EventCenter.eventDict[eventType][filter][func] = nil
	end
end

function _EventCenter.sendEvent(eventType, filter, ...)
	if _EventCenter.eventDict[eventType] == nil then
		-- block empty
	else
		local eventDtata = _EventCenter.eventDict[eventType]

		if eventDtata[DEFAULT_FILTER] then
			for k, v in pairs(eventDtata[DEFAULT_FILTER]) do
				if v ~= nil then
					if filter ~= nil and filter ~= DEFAULT_FILTER then
						v(filter, ...)
					else
						v(...)
					end
				end
			end
		end

		if filter and filter ~= DEFAULT_FILTER and eventDtata[filter] then
			for k, v in pairs(eventDtata[filter]) do
				if v ~= nil then
					v(...)
				end
			end
		end
	end
end

function _EventCenter.addEventListenerGroup(instance, funcConfig, filter)
	for funcName, eventType in pairs(funcConfig) do
		if instance[funcName] then
			instance["listenerFunc" .. funcName] = Slot(instance[funcName], instance)

			_EventCenter.addEventListener(eventType, instance["listenerFunc" .. funcName], filter)
		end
	end
end

function _EventCenter.removeEventListenerGroup(instance, funcConfig, filter)
	for funcName, eventType in pairs(funcConfig) do
		if instance["listenerFunc" .. funcName] then
			_EventCenter.removeEventListener(eventType, instance["listenerFunc" .. funcName], filter)

			instance["listenerFunc" .. funcName] = nil
		end
	end
end

function _EventCenter.dumpEvent(obj)
	for key, value in pairs(_EventCenter.eventDict[obj]) do
		-- block empty
	end
end

function _EventCenter.dumpAll()
	for k, v in pairs(_EventCenter.eventDict) do
		_EventCenter.dumpEvent(k)
	end
end

GLDeclare("EventCenter", _EventCenter)

return _EventCenter
