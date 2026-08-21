require("action_move_base")
_class("ActionMoveSpecifyPath", ActionMoveBase)
ActionMoveSpecifyPath = ActionMoveSpecifyPath

function ActionMoveSpecifyPath:Constructor()
  self._index = 0
end

function ActionMoveSpecifyPath:Reset()
  self._index = 0
end

function ActionMoveSpecifyPath:FindNewTargetPos()
  local path = self.m_entityOwn:AI():GetAIMovePath_Test()
  return path[#path]
end

function ActionMoveSpecifyPath:FindNewWalkPos()
  self._index = self._index + 1
  local path = self.m_entityOwn:AI():GetAIMovePath_Test()
  if self._index <= #path then
    return path[self._index]
  end
  return self.m_entityOwn:GetGridPosition()
end
