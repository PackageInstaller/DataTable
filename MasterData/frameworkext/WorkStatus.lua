-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/work/WorkStatus.lua

module("frameworkext.ai.workflow.work.WorkStatus", package.seeall)

local WorkStatus = class("WorkStatus")

WorkStatus.Init = 0
WorkStatus.Running = 1
WorkStatus.Stopped = 2

return WorkStatus
