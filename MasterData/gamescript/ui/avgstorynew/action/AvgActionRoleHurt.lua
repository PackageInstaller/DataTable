local AvgActionRoleHurt = System.NewClass("AvgActionRoleHurt", AvgActionBase)

function AvgActionRoleHurt:DoAction(_, _, finishCb)
  finishCb()
end

return AvgActionRoleHurt
