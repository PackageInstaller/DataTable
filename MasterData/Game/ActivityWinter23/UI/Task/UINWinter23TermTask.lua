local base = require("Game.ActivitySpring.UI.Task.UINSpring23ActTaskNode")
local UINWinter23TermTask = class("UINWinter23TermTask", base)
local JumpManager = require("Game.Jump.JumpManager")

function UINWinter23TermTask:BindWinter23TermTaskOperFunc(func)
  self._operFunc = func
end

function UINWinter23TermTask:InitChristmas22ActTaskNode(actTermTaskData, term)
  self._actTermTaskData = actTermTaskData
  self._term = term
  self._taskitemDic = {}
  self._taskIdDic = {}
  local onceTaskIds = self._actTermTaskData:GetTermTaskIds(self._term)
  for _, taskId in pairs(onceTaskIds) do
    self._taskIdDic[taskId] = true
  end
end

function UINWinter23TermTask:OnClickGetAll()
  self._actTermTaskData:ReqCommitTermAllTask(self._term, function()
    if not IsNull(self.transform) then
      self:RefillChristmas22ActTaskNode()
    end
    if self._operFunc ~= nil then
      self._operFunc()
    end
  end)
end

function UINWinter23TermTask:__TaskClick(taskData)
  if not taskData:CheckComplete() then
    local flag, jumpId, jumpArgs = taskData:GetTaskJumpArg()
    if flag then
      JumpManager:Jump(jumpId, nil, nil, jumpArgs)
    end
    return
  end
  self._actTermTaskData:ReqCommitTermOnceTask(taskData.id, function()
    if not IsNull(self.transform) then
      self:RefillChristmas22ActTaskNode()
    end
    if self._operFunc ~= nil then
      self._operFunc()
    end
  end)
end

return UINWinter23TermTask
