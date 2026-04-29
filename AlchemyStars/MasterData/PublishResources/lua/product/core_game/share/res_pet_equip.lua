_class("ResPetEquip", Object)
ResPetEquip = ResPetEquip

function ResPetEquip:Constructor()
  self._Res = {}
  self._MaxLv = {}
  self:Init()
end

function ResPetEquip:Init()
  self._Res = {}
  local cfg = Cfg.cfg_pet_equip({})
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

function ResPetEquip:GetRes(petId, level)
  if petId == nil or level == nil then
    return nil
  end
  if self._Res[petId] == nil then
    Log.error("ResPetEquip:GetRes petId error ", petId)
    return nil
  end
  local res = self._Res[petId][level]
  if res == nil then
    Log.error("ResPetEquip:GetRes petId level error ", petId, ", ", level)
    return nil
  end
  return res
end

function ResPetEquip:GetMaxLv(petId)
  local ns = self._MaxLv[petId]
  if ns == nil then
    Log.error("ResPetEquip:GetMaxLv petId error ", petId)
    return nil
  end
  return ns
end
