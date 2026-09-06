-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/ai/workflow/work/WorkResult.lua

module("frameworkext.ai.workflow.work.WorkResult", package.seeall)

local WorkResult = class("WorkResult")

WorkResult.Unknown = 0
WorkResult.Succeed = 1
WorkResult.Fail = 2
WorkResult.Interrupt = 3

return WorkResult
