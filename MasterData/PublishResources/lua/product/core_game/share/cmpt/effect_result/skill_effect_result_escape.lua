_class("SkillEffectResult_Escape", SkillEffectResultBase)
SkillEffectResult_Escape = SkillEffectResult_Escape

function SkillEffectResult_Escape:Constructor(nTargetID, posGrid, disappear, addNum)
  self.m_nTargetID = nTargetID
  self.m_posGrid = posGrid
  self._disappear = disappear
  self._addNum = addNum
end

function SkillEffectResult_Escape:GetEffectType()
  return SkillEffectType.Escape
end

function SkillEffectResult_Escape:GetGridPos()
  return self.m_posGrid
end

function SkillEffectResult_Escape:GetTargetID()
  return self.m_nTargetID
end

function SkillEffectResult_Escape:GetDisappear()
  return self._disappear
end

function SkillEffectResult_Escape:GetAddNum()
  return self._addNum
end

function SkillEffectResult_Escape:SetPosNew(posNew)
  self._posNew = posNew
end

function SkillEffectResult_Escape:GetPosNew()
  return self._posNew
end
