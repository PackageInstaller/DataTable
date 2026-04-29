_class("UIHomePetInviteItemEnableInfo", Object)
UIHomePetInviteItemEnableInfo = UIHomePetInviteItemEnableInfo

function UIHomePetInviteItemEnableInfo:Constructor(id, petId)
  self._interactId = id
  self._petId = petId
  self._needCheckSkin = false
  self._skin = {}
end

function UIHomePetInviteItemEnableInfo:GetPetId()
  return self._petId
end

function UIHomePetInviteItemEnableInfo:GetInteractId()
  return self._interactId
end

function UIHomePetInviteItemEnableInfo:GetOriginalSkin()
  return self._originalSkin
end

function UIHomePetInviteItemEnableInfo:SetOriginalSkin(skin)
  self._originalSkin = skin
end

function UIHomePetInviteItemEnableInfo:GetUsingSkin()
  return self._usingSkin
end

function UIHomePetInviteItemEnableInfo:SetUsingSkin(skin)
  self._usingSkin = skin
end

function UIHomePetInviteItemEnableInfo:GetSkin()
  return self._skin
end

function UIHomePetInviteItemEnableInfo:AddSkin(skin)
  table.insert(self._skin, skin)
end

function UIHomePetInviteItemEnableInfo:GetNeedCheckSkin()
  self._needCheckSkin = true
  for i = 1, #self._skin do
    local id = string.gsub(self._skin[i].Prefab, ".prefab", "")
    if self._petId == tonumber(id) then
      self._needCheckSkin = false
      break
    end
  end
  return self._needCheckSkin
end

function UIHomePetInviteItemEnableInfo:GetPetCfg()
  return Cfg.cfg_pet[self._petId]
end
