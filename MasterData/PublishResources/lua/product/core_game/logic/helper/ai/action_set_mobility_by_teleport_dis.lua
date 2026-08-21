require("ai_node_new")
_class("ActionSetMobilityByTeleportDis", AINewNode)
ActionSetMobilityByTeleportDis = ActionSetMobilityByTeleportDis

function ActionSetMobilityByTeleportDis:OnBegin()
  local skillIndexX, skillIndexY = self:GetLogicData(-1), self:GetLogicData(-2)
  local configPos = Vector2(skillIndexX, skillIndexY)
  local minMobility = self:GetLogicData(-3)
  local skillEffectSvc = self._world:GetService("SkillEffectCalc")
  local casterPos = self.m_entityOwn:GetGridPosition()
  local pos, dis = skillEffectSvc:FindSkillRangeFixed4(casterPos, {
    Vector2(skillIndexX, skillIndexY)
  })
  local aiCmpt = self.m_entityOwn:AI()
  local curM = aiCmpt:GetMobilityValid()
  curM = math.max(curM - dis, minMobility)
  self:PrintDebugLog("Entity:", self.m_entityOwn:GetID(), "ConfigPos:", configPos, " MinMobility:", minMobility, " SourcePos:", casterPos, " TelPortPos ", pos, " Dis:", dis, " CurMobility:", curM)
  aiCmpt:SetMobilityTotal(curM)
end
