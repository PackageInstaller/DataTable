local SkillEffectEnum_SummonType = {
  Monster = 1,
  Trap = 2,
  Drop = 3
}
_enum("SkillEffectEnum_SummonType", SkillEffectEnum_SummonType)
_class("SkillEffectResult_SummonEverything", SkillEffectResultBase)
SkillEffectResult_SummonEverything = SkillEffectResult_SummonEverything

function SkillEffectResult_SummonEverything:Constructor(nSummonType, nSummonID, posCenter, posSummon)
  self.m_nSummonType = nSummonType
  self.m_nSummonID = nSummonID
  self.m_posCenter = posCenter or Vector2(0, 0)
  self.m_posSummon = posSummon
  self._dir = Vector2(0, 1)
  self.m_monster = {}
  self.m_trap = {}
  self._transformData = nil
end

function SkillEffectResult_SummonEverything:GetEffectType()
  return SkillEffectType.SummonEverything
end

function SkillEffectResult_SummonEverything:GetSummonType()
  return self.m_nSummonType
end

function SkillEffectResult_SummonEverything:GetSummonID()
  return self.m_nSummonID
end

function SkillEffectResult_SummonEverything:GetSummonPos()
  return self.m_posSummon
end

function SkillEffectResult_SummonEverything:SetSummonPos(posSummon)
  self.m_posSummon = posSummon
  if self._transformData then
    self._transformData:SetPosition(posSummon)
  end
end

function SkillEffectResult_SummonEverything:GetPosCenter()
  return self.m_posCenter
end

function SkillEffectResult_SummonEverything:GetGridPos()
  return self.m_posSummon
end

function SkillEffectResult_SummonEverything:SetMonsterData(nMonsterID, entityWorkID, entityHp, transformData)
  local monsterData = {}
  monsterData.m_nMonsterID = nMonsterID
  monsterData.m_entityWorkID = entityWorkID
  monsterData.m_entityHp = entityHp
  self.m_monster = monsterData
  self._transformData = transformData
end

function SkillEffectResult_SummonEverything:GetMonsterData()
  return self.m_monster
end

function SkillEffectResult_SummonEverything:SetTrapData(nTrapID, entityWorkID)
  local trapData = {}
  trapData.m_nTrapID = nTrapID
  trapData.m_entityWorkID = entityWorkID
  self.m_trap = trapData
end

function SkillEffectResult_SummonEverything:GetTrapData()
  return self.m_trap
end

function SkillEffectResult_SummonEverything:GetSummonTransformData()
  return self._transformData
end

function SkillEffectResult_SummonEverything:SetDirection(direction)
  self._dir = direction
end

_class("RenderSummonFromCageParam", Object)
RenderSummonFromCageParam = RenderSummonFromCageParam

function RenderSummonFromCageParam:Constructor()
  self.cageSummonDelayTime = nil
  self.cageSummonMoveTime = nil
  self.cageSummonUnderDis = nil
  self.cageSummonMatAnim = nil
end

function SkillEffectResult_SummonEverything:GetRenderIsFromCage()
  return self.m_renderIsFromCage
end

function SkillEffectResult_SummonEverything:SetRenderIsFromCage(fromCage)
  self.m_renderIsFromCage = fromCage
end

function SkillEffectResult_SummonEverything:GetRenderFromCageParam()
  return self.m_renderFromCageParam
end

function SkillEffectResult_SummonEverything:SetRenderFromCageParam(param)
  self.m_renderFromCageParam = param
end
