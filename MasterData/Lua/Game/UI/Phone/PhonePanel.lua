local PhonePanel = class("PhonePanel", BasePanel)
PhonePanel._nSnapshotPrePanel = 4
PhonePanel._tbDefine = {
  {
    sPrefabPath = "Phone/PhonePanel.prefab",
    sCtrlName = "Game.UI.Phone.PhoneCtrl"
  }
}

function PhonePanel:GetAvgContactsData(sContactsId)
  local tbContacts = PlayerData.Phone:GetAvgContactsData(sContactsId)
  if tbContacts == nil then
    return sContactsId
  else
    return tbContacts
  end
end

function PhonePanel:Awake()
  self.nCurTog = nil
  self.nSelectCharId = nil
  self.sTxtLan = Settings.sCurrentTxtLanguage
  self.sVoLan = Settings.sCurrentVoLanguage
  self.bIsPlayerMale = PlayerData.Base:GetPlayerSex() == true
end

function PhonePanel:OnEnable()
end

function PhonePanel:OnAfterEnter()
end

function PhonePanel:OnDisable()
end

function PhonePanel:OnDestroy()
end

function PhonePanel:OnRelease()
end

return PhonePanel
