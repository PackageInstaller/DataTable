local ActionManager = class("ActionManager")

function ActionManager:ctor()
  self.targets = {}
end

function ActionManager:addAction(target, action, paused)
  target.actions = target.actions or {}
  table.insert(target.actions, action)
  if not table.indexof(self.targets, target) then
    table.insert(self.targets, target)
  end
end

function ActionManager:update(dt)
  local targetIndex = 1
  while targetIndex <= #self.targets do
    local target = self.targets[targetIndex]
    if not target.paused then
      local actionIndex = 1
      while actionIndex <= #target.actions do
        target.currentAction = target.actions[index]
        target.currentAction.step(dt)
        if target.currentAction.isDone() then
          table.remove(target.actions, actionIndex)
        else
          actionIndex = actionIndex + 1
        end
      end
    end
    if #target.actions == 0 then
      table.remove(self.targets, targetIndex)
    else
      targetIndex = targetIndex + 1
    end
  end
end

return ActionManager
