local TaskHelper = class("TaskHelper")

function TaskHelper.GetProgressStr(progressSet, task, taskIndex)
  local str = ""
  local index = taskIndex or task.id
  local progress = progressSet[index .. ""]
  if task.type == 125 then
    progress = progress or {}
    local all = #task.condition1:toArray("/")
    local num = 0
    for _, pro in pairs(progress) do
      num = num + 1
    end
    str = num .. "/" .. all
  else
    progress = progress or 0
    str = progress .. "/" .. task.condition1
  end
  return str
end

function TaskHelper.GetJumpType(type)
  local jumpType = type
  local cond = 0
  if type == 102 then
    jumpType = 5
  elseif type == 103 then
    jumpType = 28
    cond = 5
  elseif type == 109 then
    jumpType = 40
  elseif type == 104 then
    jumpType = 21
  elseif type == 108 then
    jumpType = 0
    cond = 10
  elseif type == 106 then
    jumpType = 40
  elseif type == 110 then
    jumpType = 0
    cond = 56
  elseif type == 120 then
    jumpType = 28
  elseif type == 121 then
    jumpType = 5
  elseif type == 123 then
    jumpType = 28
    cond = 5
  elseif type == 124 then
    jumpType = 35
  elseif type == 125 then
    jumpType = 21
  elseif type == 201 then
    jumpType = 41
    game.role.moonBattleCurType = 2
  elseif type == 202 then
    jumpType = 41
    game.role.moonBattleCurType = 2
  end
  return jumpType, cond
end

return TaskHelper
