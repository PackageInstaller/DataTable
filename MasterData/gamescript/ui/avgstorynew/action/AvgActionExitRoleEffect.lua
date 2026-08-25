local AvgActionExitRoleEffect = System.NewClass("AvgActionExitRoleEffect", AvgActionBase)

function AvgActionExitRoleEffect:DoAction(_, _, finishCb)
  local safeTimer
  
  local function callback()
    self.binder:StopTimer(safeTimer)
    if finishCb then
      finishCb()
    end
    finishCb = nil
  end
  
  self.avgPanel.roleComp:DoExitDialog(callback)
  safeTimer = self.binder:BindTimer(2, 0, nil, function()
    callback()
  end)
end

return AvgActionExitRoleEffect
