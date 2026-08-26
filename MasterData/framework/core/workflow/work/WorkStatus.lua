-- chunkname: @framework/core/workflow/work/WorkStatus.lua

module("framework.core.workflow.work.WorkStatus", package.seeall)

local WorkStatus = {}

WorkStatus.Init = 1
WorkStatus.Running = 2
WorkStatus.Stopped = 3
WorkStatus.Done = 4

return WorkStatus
