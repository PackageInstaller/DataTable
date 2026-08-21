_class("ResPetEquipRefine", Object)
ResPetEquipRefine = ResPetEquipRefine

function ResPetEquipRefine:Constructor()
  self._Res = {}
  self._MaxLv = {}
  self:InitResPetEquipRefine()
end

function ResPetEquipRefine:InitResPetEquipRefine()
  self._Res = {}
  local cfg = Cfg.cfg_pet_equip_refine({})
  for k, v in pairs(cfg) do
    if self._Res[v.PetID] == nil then
      self._Res[v.PetID] = {}
    end
    if self._MaxLv[v.PetID] == nil or self._MaxLv[v.PetID] < v.Level then
      self._MaxLv[v.PetID] = v.Level
    end
    self._Res[v.PetID][v.Level] = v
  end
end

function ResPetEquipRefine:GetRes(petId, level)
  if petId == nil or level == nil then
    return nil
  end
  if self._Res[petId] == nil then
    return nil
  end
  local res = self._Res[petId][level]
  if res == nil then
    Log.error("ResPetEquipRefine:GetRes petId level error ", petId, ", ", level)
    return nil
  end
  return res
end

function ResPetEquipRefine:GetMaxLv(petId)
  local ns = self._MaxLv[petId]
  if ns == nil then
    Log.error("ResPetEquipRefine:GetMaxLv petId error ", petId)
    return nil
  end
  return ns
end
