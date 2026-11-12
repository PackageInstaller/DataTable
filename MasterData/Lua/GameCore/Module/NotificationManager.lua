local NotificationManager = {}
local TimerManager = require("GameCore.Timer.TimerManager")
local Event = require("GameCore.Event.Event")
local SDKManager = CS.SDKManager.Instance
local tbNotification = {}
local bAppSuspended = false

local function OnApplicationFocus(_, bFocus)
  bAppSuspended = not bFocus
end

function NotificationManager.RegisterNotification(nId, nSubkey, nTime)
end

function NotificationManager.UnregisterNotification(nId, nSubkey)
end

local function Uninit()
  EventManager.Remove(EventId.CSLuaManagerShutdown, NotificationManager, Uninit)
  EventManager.Remove("CS2LuaEvent_OnApplicationFocus", NotificationManager, OnApplicationFocus)
end

function NotificationManager.Init()
  EventManager.Add(EventId.CSLuaManagerShutdown, NotificationManager, Uninit)
  EventManager.Add("CS2LuaEvent_OnApplicationFocus", NotificationManager, OnApplicationFocus)
end

return NotificationManager
