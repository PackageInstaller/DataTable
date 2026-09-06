-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/framework/notify/NotifyStatus.lua

module("framework.notify.NotifyStatus", package.seeall)

local NotifyStatus = class("NotifyStatus")

NotifyStatus.Idle = 1
NotifyStatus.Active = 2
NotifyStatus.ToInsert = 3
NotifyStatus.ToDelete = 4

return NotifyStatus
