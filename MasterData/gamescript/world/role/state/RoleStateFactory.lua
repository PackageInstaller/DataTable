local M = {
  [CommonDefine.RoleStateType.Idle] = "World.Role.State.RoleIdleState",
  [CommonDefine.RoleStateType.Move] = "World.Role.State.RoleMoveState",
  [CommonDefine.RoleStateType.RotMove] = "World.Role.State.RoleRotMoveState",
  [CommonDefine.RoleStateType.SmoothMove] = "World.Role.State.RoleSmoothMoveState"
}

function M.CreateState(type, ...)
  if not M[type] then
    Logger.Debug("============找不到stateType===========")
    return nil
  end
  do return require(M[type]), ... end
  return require(M[type]), ...
end

return M
