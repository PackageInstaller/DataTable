_class("ResPetSkill", Object)
ResPetSkill = ResPetSkill

function ResPetSkill:Constructor()
  self._SkillRes = {}
  self:Init()
end

function ResPetSkill:Init()
  self._SkillRes = {}
  local cfg = Cfg.cfg_pet_skill({})
  for k, v in pairs(cfg) do
    if self._SkillRes[v.PetID] == nil then
      self._SkillRes[v.PetID] = {}
    end
    if self._SkillRes[v.PetID][v.Grade] == nil then
      self._SkillRes[v.PetID][v.Grade] = {}
    end
    self._SkillRes[v.PetID][v.Grade][v.Awakening] = v
  end
end

function ResPetSkill:GetSKill(petId, grade, awakening)
  if petId == nil or grade == nil or awakening == nil then
    return nil
  end
  if self._SkillRes[petId] == nil then
    Log.error("ResPetSkill:GetSKill petId error ", petId)
    return nil
  end
  if self._SkillRes[petId][grade] == nil then
    Log.error("ResPetSkill:GetSKill petId grade error ", petId, ", ", grade)
    return nil
  end
  local skill = self._SkillRes[petId][grade][awakening]
  if skill == nil then
    Log.error("ResPetSkill:GetSKill petId grade awakening error ", petId, ", ", grade, ", ", awakening)
    return nil
  end
  return skill
end

function ResPetSkill:GetNormalSKill(petId, grade, awakening)
  local ns = self:GetSKill(petId, grade, awakening)
  if ns == nil then
    return nil
  end
  return ns.NormalSkill
end

function ResPetSkill:GetActiveSkill(petId, grade, awakening)
  local ns = self:GetSKill(petId, grade, awakening)
  if ns == nil then
    return nil
  end
  return ns.ActiveSkill
end

function ResPetSkill:GetExtraActiveSkill(petId, grade, awakening)
  local ns = self:GetSKill(petId, grade, awakening)
  if ns == nil then
    return nil
  end
  return ns.ExtraActiveSkill
end

function ResPetSkill:GetVariantActiveSkill(petId, grade, awakening)
  local ns = self:GetSKill(petId, grade, awakening)
  if ns == nil then
    return nil
  end
  return ns.VariantActiveSkillInfo
end

function ResPetSkill:GetPassiveSkill(petId, grade, awakening)
  local ns = self:GetSKill(petId, grade, awakening)
  if ns == nil then
    return nil
  end
  return ns.PassiveSkill
end

function ResPetSkill:GetIntensifyBuffList(petId, grade, awakening)
  local ns = self:GetSKill(petId, grade, awakening)
  if ns == nil then
    return nil
  end
  return ns.IntensifyBuff
end

function ResPetSkill:GetChainSkill(petId, grade, awakening)
  local ns = self:GetSKill(petId, grade, awakening)
  if ns == nil then
    return nil
  end
  local ss = {
    ns.ChainSkill1,
    ns.ChainSkill2,
    ns.ChainSkill3,
    ns.ChainSkill4
  }
  return ss
end

function ResPetSkill:GetWorkSkill(petId, grade, awakening)
  local ns = self:GetSKill(petId, grade, awakening)
  if ns == nil then
    return nil
  end
  local ss = {
    ns.WorkSkill1,
    ns.WorkSkill2,
    ns.WorkSkill3
  }
  return ss
end
