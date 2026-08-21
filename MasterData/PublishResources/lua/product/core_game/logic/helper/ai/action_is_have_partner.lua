require("ai_node_new")
_class("ActionIsHavePartner", AINewNode)
ActionIsHavePartner = ActionIsHavePartner

function ActionIsHavePartner:OnUpdate()
  local listParnter = self:_FindMonsterByGroupOther(self.m_entityOwn)
  local nParnterCount = table.count(listParnter)
  if listParnter and 0 < nParnterCount then
    for key, value in ipairs(listParnter) do
      if AINewNode.IsEntityDead(value) then
        nParnterCount = nParnterCount - 1
      end
    end
  end
  self:PrintLog("找到同组伙伴数量 = ", nParnterCount)
  if 0 < nParnterCount then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end

function ActionIsHavePartner:_GetMonsterGroupID(entityWork)
  local cmptMonsterID = entityWork:MonsterID()
  if not cmptMonsterID then
    return nil
  end
  return cmptMonsterID:GetMonsterGroupID()
end

function ActionIsHavePartner:_FindMonsterByGroupOther(entityOwn)
  local listTarget = {}
  local nGroupID = self:_GetMonsterGroupID(entityOwn)
  if not nGroupID then
    return listTarget
  end
  local group = self._world:GetGroup(self._world.BW_WEMatchers.MonsterID)
  local entityList = group:GetEntities()
  for key, value in ipairs(entityList) do
    local nMonsterGroupID = self:_GetMonsterGroupID(value)
    if nMonsterGroupID == nGroupID and value ~= entityOwn then
      table.insert(listTarget, value)
    end
  end
  return listTarget
end
