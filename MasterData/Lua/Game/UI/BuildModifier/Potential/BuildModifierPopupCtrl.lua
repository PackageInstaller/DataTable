local BuildModifierPopupCtrl = class("BuildModifierPopupCtrl", BaseCtrl)
BuildModifierPopupCtrl._mapNodeConfig = {
  goContent = {
    sNodeName = "----SafeAreaRoot----"
  },
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "BuildModifier_PopupTitle"
  },
  txtPotential = {
    sComponentName = "TMP_Text",
    sLanguageId = "Depot_NoteInfo"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  snapshot = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtNameQuantitySelector = {
    sComponentName = "TMP_Text",
    sLanguageId = "BuildModifier_PotentialPopupTitle1"
  },
  tc_quantity_selector = {
    sCtrlName = "Game.UI.BuildModifier.Potential.BuildModifierPotentialQuantitySelector"
  },
  PotentialCard = {
    sCtrlName = "Game.UI.BuildModifier.Potential.PotentialCardItemCtrl"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  btnNoConfirm = {sComponentName = "UIButton"},
  txtEquipmentHint = {sComponentName = "TMP_Text"},
  txtDisable = {
    sComponentName = "TMP_Text",
    sLanguageId = "BuildModifier_PotentialPopupTitle3"
  },
  txtBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "BtnBuildModifier_Confirm"
  },
  txtBtnBuy2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "BtnBuildModifier_Confirm"
  }
}
BuildModifierPopupCtrl._mapEventConfig = {}
BuildModifierPopupCtrl._mapRedDotConfig = {}

function BuildModifierPopupCtrl:Awake()
end

function BuildModifierPopupCtrl:FadeIn()
end

function BuildModifierPopupCtrl:FadeOut()
end

function BuildModifierPopupCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  local nPotentialId = tbParam[1]
  local nOriginLevel = tbParam[2]
  local nAfterLevel = tbParam[3]
  local nAddLevel = tbParam[4]
  local nMax = tbParam[5]
  local nMin = tbParam[6]
  local nFreePoint = tbParam[7]
  local callback = tbParam[8]
  self.nFreePoint = nFreePoint or 0
  self:Refresh(nPotentialId, nOriginLevel, nAfterLevel, nAddLevel, nMax, nMin, callback)
  self:RefreshFreePoint()
  
  local function callback(nCount)
    self:RefreshNoteCount(nCount)
  end
  
  self._mapNode.tc_quantity_selector:SetCallback(callback)
  
  local function wait()
    self._mapNode.goContent:SetActive(false)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.snapshot.gameObject)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goContent:SetActive(true)
  end
  
  cs_coroutine.start(wait)
end

function BuildModifierPopupCtrl:OnDisable()
end

function BuildModifierPopupCtrl:OnDestroy()
end

function BuildModifierPopupCtrl:OnRelease()
end

function BuildModifierPopupCtrl:RefreshFreePoint()
  local sFreeNote
  local nSub = self.nInCount - self.nAfterLevel
  local sSub
  if 0 < nSub then
    sSub = "+" .. nSub
  elseif nSub < 0 then
    sSub = tostring(nSub)
  else
    sSub = ""
  end
  sFreeNote = orderedFormat(ConfigTable.GetUIText("BuildModifier_FreePotential"), self.nFreePoint) .. sSub
  NovaAPI.SetTMPText(self._mapNode.txtPotential, sFreeNote)
end

function BuildModifierPopupCtrl:Refresh(nPotentialId, nOriginLevel, nAfterLevel, nAddLevel, nMax, nMin, callback)
  self.callback = callback
  self.nOriginLevel = nOriginLevel
  self.nAfterLevel = nAfterLevel
  self.nInCount = nAfterLevel
  self.nPotentialId = nPotentialId
  self.nAddLevel = nAddLevel or 0
  self._mapNode.PotentialCard:SetRecommend(false)
  self._mapNode.PotentialCard:SetPotentialItem(nPotentialId, self.nOriginLevel + self.nAddLevel, nil, false, nil, self.nAfterLevel + self.nAddLevel, AllEnum.PotentialCardType.StarTower)
  self.bSpecial = self._mapNode.PotentialCard.bSpecial
  if not self.bSpecial then
    self._mapNode.tc_quantity_selector:Init(nOriginLevel + self.nAddLevel, nAfterLevel + self.nAddLevel, nMax + self.nAddLevel, nMin + self.nAddLevel, self.nAddLevel, false)
  else
    self._mapNode.tc_quantity_selector:Init(nAfterLevel + self.nAddLevel, nAfterLevel + self.nAddLevel, nAfterLevel + self.nAddLevel, nAfterLevel + self.nAddLevel, self.nAddLevel, true)
  end
  if nAddLevel ~= nil and 0 < nAddLevel then
    self._mapNode.txtEquipmentHint.gameObject:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtEquipmentHint, orderedFormat(ConfigTable.GetUIText("BuildModifier_PotentialPopupTitle2"), nAddLevel))
  else
    self._mapNode.txtEquipmentHint.gameObject:SetActive(false)
  end
  self:SetBtnState()
end

function BuildModifierPopupCtrl:RefreshNoteCount(nCount)
  self.nAfterLevel = nCount - self.nAddLevel
  self:RefreshFreePoint()
  self._mapNode.PotentialCard:SetPotentialItem(self.nPotentialId, self.nOriginLevel + self.nAddLevel, nil, false, nil, self.nAfterLevel + self.nAddLevel, AllEnum.PotentialCardType.StarTower)
  self:SetBtnState()
end

function BuildModifierPopupCtrl:OnBtnClick_Close()
  if self.callback ~= nil then
    self.callback(false)
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.BuildModifierPopupPanel)
end

function BuildModifierPopupCtrl:OnBtnClick_Confirm()
  if self.callback ~= nil then
    self.callback(true, self.nPotentialId, self.nAfterLevel)
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.BuildModifierPopupPanel)
end

function BuildModifierPopupCtrl:SetBtnState()
  if self.bSpecial then
    self._mapNode.txtDisable.gameObject:SetActive(true)
    self._mapNode.btnConfirm.gameObject:SetActive(false)
    self._mapNode.btnNoConfirm.gameObject:SetActive(false)
    return
  end
  self._mapNode.txtDisable.gameObject:SetActive(false)
  self._mapNode.btnConfirm.gameObject:SetActive(self.nInCount ~= self.nAfterLevel)
  self._mapNode.btnNoConfirm.gameObject:SetActive(self.nInCount == self.nAfterLevel)
end

return BuildModifierPopupCtrl
