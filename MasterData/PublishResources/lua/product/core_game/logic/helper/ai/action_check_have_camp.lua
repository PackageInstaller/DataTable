require("ai_node_new")
_class("ActionCheckHaveCamp", AINewNode)
ActionCheckHaveCamp = ActionCheckHaveCamp

function ActionCheckHaveCamp:OnUpdate()
  local campType = self:GetLogicData(-1)
  local entityCaster = self.m_entityOwn
  local aiComponent = entityCaster:AI()
  if nil == aiComponent then
    return false
  end
  local monsterEntityList = self._world:GetGroupEntities(self._world.BW_WEMatchers.MonsterID)
  for i, v in ipairs(monsterEntityList) do
    if not v:HasDeadMark() and v:GetID() ~= entityCaster:GetID() and v:MonsterID():GetCampType() == campType then
      return AINewNodeStatus.Success
    end
  end
  return AINewNodeStatus.Failure
end
