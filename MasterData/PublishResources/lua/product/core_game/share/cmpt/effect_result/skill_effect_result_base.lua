_class("SkillEffectResultBase", Object)
SkillEffectResultBase = SkillEffectResultBase

function SkillEffectResultBase:Constructor()
  self._scopeResult = nil
end

function SkillEffectResultBase:GetEffectType()
  return self.__EFFECT_TYPE
end

function SkillEffectResultBase:GetResultType()
end

function SkillEffectResultBase:GetTargetID()
end

function SkillEffectResultBase:GetGridPos()
end

function SkillEffectResultBase:IsSame(otherResult)
  return false
end

function SkillEffectResultBase:GetNewGridNumByType(pieceType)
  return 0
end

function SkillEffectResultBase:SetSkillEffectScopeResult(scopeResult)
  self._scopeResult = scopeResult
end

function SkillEffectResultBase:GetSkillEffectScopeResult()
  return self._scopeResult
end

function SkillEffectResultBase:_AddDataToList(listArray, nID)
  if type(nID) == "number" then
    table.insert(listArray, nID)
  elseif type(nID) == "table" then
    listArray = nID
  end
end

function SkillEffectResultBase:Clone()
  Log.exception("EffectType:", self:GetEffectType(), " Need Realize Clone()")
end
