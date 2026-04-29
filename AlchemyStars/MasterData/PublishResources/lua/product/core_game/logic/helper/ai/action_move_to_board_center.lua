require("action_move_base")
_class("ActionMoveToBoardCenter", ActionMoveBase)
ActionMoveToBoardCenter = ActionMoveToBoardCenter

function ActionMoveToBoardCenter:FindNewTargetPos()
  local x = tonumber(self.m_configData[1]) or 5
  local y = tonumber(self.m_configData[2]) or 5
  return Vector2.New(x, y)
end
