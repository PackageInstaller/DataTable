_class("UIPetIntimacyStumblesItem", UICustomWidget)
UIPetIntimacyStumblesItem = UIPetIntimacyStumblesItem

function UIPetIntimacyStumblesItem:OnShow(uiParams)
  self._imgUnlock = self:GetUIComponent("Image", "imgUnlock")
  self._imgLock = self:GetUIComponent("Image", "imgLock")
  self._txtLv = self:GetUIComponent("UILocalizationText", "txtLv")
  self._unlock = self:GetGameObject("unlock")
  self._txtUnlock = self:GetUIComponent("UILocalizationText", "txtUnlock")
  self._txtAttack = self:GetUIComponent("UILocalizationText", "txtAttack")
  self._txtDefend = self:GetUIComponent("UILocalizationText", "txtDefend")
  self._txtHp = self:GetUIComponent("UILocalizationText", "txtHp")
end

function UIPetIntimacyStumblesItem:Flush(lv, pet)
  local petTemplateId = pet:GetTemplateID()
  local cfg = Cfg.cfg_pet_affinity({PetID = petTemplateId, AffinityLevel = lv})
  if not cfg then
    return
  end
  local c = cfg[1]
  if not c then
    return
  end
  local level = pet:GetPetAffinityLevel()
  local unlock = lv <= level
  self._imgUnlock.gameObject:SetActive(unlock)
  self._imgLock.gameObject:SetActive(not unlock)
  self._txtLv:SetText(StringTable.Get("str_affinity_stumbles_lv", lv))
  self._unlock:SetActive(not unlock)
  local tUnlockProfile = UIPetIntimacyLevelUp.GetUnlockProfile(petTemplateId, lv - 1, lv)
  local isUnlockProfile = tUnlockProfile and table.count(tUnlockProfile) > 0
  local tUnlockVoice = UIPetIntimacyLevelUp.GetUnlockVoice(petTemplateId, nil, lv - 1, lv)
  local isUnlockVoice = tUnlockVoice and table.count(tUnlockVoice) > 0
  local key = ""
  if isUnlockProfile and isUnlockVoice then
    key = "str_affinity_stumbles_unlock_new_profile_voice"
  else
    if isUnlockProfile and not isUnlockVoice then
      key = "str_affinity_stumbles_unlock_new_profile"
    end
    if not isUnlockProfile and isUnlockVoice then
      key = "str_affinity_stumbles_unlock_new_voice"
    end
  end
  if string.isnullorempty(key) then
    self._txtUnlock:SetText("")
  else
    self._txtUnlock:SetText(StringTable.Get(key))
  end
  self._txtAttack:SetText("+" .. c.Attack)
  self._txtDefend:SetText("+" .. c.Defence)
  self._txtHp:SetText("+" .. c.Health)
  local f208 = 0.8156862745098039
  local colorText = Color(f208, f208, f208, 1)
  if unlock then
    colorText = Color(0.00392156862745098, 0.9490196078431372, 1, 1)
  end
  self._txtAttack.color = colorText
  self._txtDefend.color = colorText
  self._txtHp.color = colorText
end
