require("ai_node_new")
_class("ActionTargetSelectByNoIDMonster", AINewNode)
ActionTargetSelectByNoIDMonster = ActionTargetSelectByNoIDMonster

function ActionTargetSelectByNoIDMonster:Constructor()
end

function ActionTargetSelectByNoIDMonster:Reset()
  ActionTargetSelectByNoIDMonster.super.Reset(self)
end

function ActionTargetSelectByNoIDMonster:OnBegin()
  local aiCmpt = self.m_entityOwn:AI()
  self:FindTarget()
  local targetEntity = aiCmpt:GetTargetEntity()
  local monsterIDList = self.m_configData
  self.monsterIDStr = ""
  for _, id in ipairs(monsterIDList) do
    self.monsterIDStr = self.monsterIDStr .. tostring(id) .. " "
  end
end

function ActionTargetSelectByNoIDMonster:OnUpdate()
  local aiCmpt = self.m_entityOwn:AI()
  local entityPlayer = aiCmpt:GetTargetDefault()
  self:FindTarget()
  local entityTarget = aiCmpt:GetTargetEntity()
  self:PrintDebugLog("目标ID = ", entityTarget:GetID(), "玩家ID = ", entityPlayer:GetID(), "排除的怪物ID=", self.monsterIDStr)
  if entityPlayer:GetID() ~= entityTarget:GetID() then
    return AINewNodeStatus.Success
  end
  return AINewNodeStatus.Failure
end

function ActionTargetSelectByNoIDMonster:OnEnd()
end

function ActionTargetSelectByNoIDMonster:FindTarget()
  local monsterIDList = self.m_configData
  local ownPos = self.m_entityOwn:GetGridPosition()
  local utilScopeCalc = self._world:GetService("UtilScopeCalc")
  local monsterList = utilScopeCalc:SortMonstersByPos(ownPos)
  local targetEntityID
  for i, element in ipairs(monsterList) do
    local monsterEntity = element.monster_e
    if not table.icontains(monsterIDList, monsterEntity:MonsterID():GetMonsterClassID()) and not monsterEntity:HasDeadMark() then
      targetEntityID = monsterEntity:GetID()
      break
    end
  end
  self:SetRuntimeData("Target", targetEntityID)
end
