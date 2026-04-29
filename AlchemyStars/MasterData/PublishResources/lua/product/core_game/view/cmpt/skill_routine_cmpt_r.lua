_class("SkillRoutineComponent", Object)
SkillRoutineComponent = SkillRoutineComponent

function SkillRoutineComponent:Constructor()
  self._effectResultContainer = nil
  self._resultDict = {}
  self._damageDampList = {}
end

function SkillRoutineComponent:GetResultContainer(key)
  if key then
    local v = self._resultDict[key]
    self._resultDict[key] = nil
    return v
  end
  return self._effectResultContainer
end

function SkillRoutineComponent:SetResultContainer(res, key)
  if key then
    self._resultDict[key] = res
  else
    self._effectResultContainer = res
  end
end

function SkillRoutineComponent:ClearSkillRoutine()
  self._effectResultContainer = nil
  self._resultDict = {}
  self._damageDampList = {}
end

function SkillRoutineComponent:GetDamageDampList()
  return self._damageDampList
end

function SkillRoutineComponent:SetDamageDampList(t)
  self._damageDampList = t
end

function Entity:SkillRoutine()
  return self:GetComponent(self.WEComponentsEnum.SkillRoutine)
end

function Entity:AddSkillRoutine()
  local index = self.WEComponentsEnum.SkillRoutine
  local component = SkillRoutineComponent:New()
  self:AddComponent(index, component)
end
