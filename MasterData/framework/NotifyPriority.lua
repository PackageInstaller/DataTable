-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/notify/NotifyPriority.lua

module("framework.notify.NotifyPriority", package.seeall)

local NotifyPriority = class("NotifyPriority")

NotifyPriority.Low = 1
NotifyPriority.Normal = 2
NotifyPriority.High = 3

return NotifyPriority
