local UINActivityStarUpTask = require("Game.ActivityStarUp.UI.UINActivityStarUpTask")
local UINEventInvitationTaskItem = class("UINEventInvitationTaskItem", UINActivityStarUpTask)
local base = UINActivityStarUpTask

function UINEventInvitationTaskItem:__SetTaskTextFunc(textItemInfo, isFinish, taskInfo)
  textItemInfo:SetIndex(isFinish and 0 or 1, LanguageUtil.GetLocaleText(taskInfo.stcData.task_intro))
end

return UINEventInvitationTaskItem
