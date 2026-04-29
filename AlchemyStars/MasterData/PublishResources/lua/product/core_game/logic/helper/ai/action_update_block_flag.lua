require("ai_node_new")
_class("ActionUpdateBlockFlag", AINewNode)
ActionUpdateBlockFlag = ActionUpdateBlockFlag

function ActionUpdateBlockFlag:OnBegin()
  local cGridLocation = self.m_entityOwn:GridLocation()
  local pos = cGridLocation.Position
  local sBoard = self._world:GetService("BoardLogic")
  local isRemove = self:GetLogicData(-1)
  if isRemove then
    sBoard:RemoveEntityBlockFlag(self.m_entityOwn, pos)
  else
    sBoard:UpdateEntityBlockFlag(self.m_entityOwn, pos, pos)
  end
end

function ActionUpdateBlockFlag:OnUpdate()
  return AINewNodeStatus.Success
end
