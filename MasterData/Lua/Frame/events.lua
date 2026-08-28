--[[
like Unity Brocast Event System in lua.
]]

local EventLib = require( "Frame.eventlib")

---@class Event
local Event = {}
local events = {}

function Event.AddListener(event,handler)
	if not event or type(event) ~= "string" then
		error("event parameter in addlistener function has to be string, " .. type(event) .. " not right.")
	end
	if not handler or type(handler) ~= "function" then
		error("handler parameter in addlistener function has to be function, " .. type(handler) .. " not right")
	end

	if not events[event] then
		--create the Event with name
		events[event] = EventLib:new(event)
	end

	--conn this handler
	events[event]:connect(handler)
	return handler
end

function Event.Broadcast(event,...)
	if not events[event] then
		print(debug.traceback("(event) brocast " .. event .. " has no event.", 2))
	else
		events[event]:fire(...)
	end
end

function Event.HasListener(event)
	return events[event] ~= nil
end

function Event.RemoveListener(event,handler)
	if not events[event] then
		-- error("remove " .. event .. " has no event.")
		print(debug.traceback("remove " .. event .. " has no event.", 2))
	else
		events[event]:disconnect(handler)
	end
end

function Event.DisconnectAll(event)
	if not events[event] then
		-- error("remove " .. event .. " has no event.")
		print(debug.traceback("dis connect " .. event .. " has no event.", 2))
	else
		events[event]:DisconnectAll()
	end
end

--- 清理所有监听
function Event.Clear()
	for eventName, event in pairs(events) do
		event:DisconnectAll()
	end
end

return Event