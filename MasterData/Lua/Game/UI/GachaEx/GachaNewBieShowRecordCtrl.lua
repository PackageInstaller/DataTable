local GachaNewBieShowRecordCtrl = class("GachaNewBieShowRecordCtrl", BaseCtrl)
GachaNewBieShowRecordCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieShowTitle"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieShowCancel"
  },
  txtBtnOk = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieShowOk"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnConfirm1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  GachaNewBieRecordItem = {
    sCtrlName = "Game.UI.GachaEx.GachaNewBieRecordItemCtrl",
    nCount = 5
  },
  GachaNewBieRecordItemC = {
    sCtrlName = "Game.UI.GachaEx.GachaNewBieRecordItemCtrl"
  },
  btnItem = {
    sNodeName = "GachaNewBieRecordItem",
    sComponentName = "Button",
    callback = "OnBtnClick_Item",
    nCount = 5
  },
  btnItemC = {
    sNodeName = "GachaNewBieRecordItemC",
    sComponentName = "Button",
    callback = "OnBtnClick_ItemC"
  },
  CloseButton = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  }
}
GachaNewBieShowRecordCtrl._mapEventConfig = {}

function GachaNewBieShowRecordCtrl:Awake()
end

function GachaNewBieShowRecordCtrl:FadeIn()
end

function GachaNewBieShowRecordCtrl:FadeOut()
end

function GachaNewBieShowRecordCtrl:OnEnable()
  self.animRoot = self.gameObject:GetComponent("Animator")
  self.bClose = true
end

function GachaNewBieShowRecordCtrl:OnDisable()
end

function GachaNewBieShowRecordCtrl:OnDestroy()
end

function GachaNewBieShowRecordCtrl:OnBtnClick_Close()
  if self.bClose then
    return
  end
  
  local function Close()
    self.gameObject:SetActive(false)
  end
  
  self.animRoot:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, Close, true, true, true)
  self.bClose = true
end

function GachaNewBieShowRecordCtrl:OnBtnClick_Confirm()
  if self.bClose then
    return
  end
  local newbieData = PlayerData.Gacha:GetGachaNewbieData(self.curPoolId)
  if newbieData == nil then
    return
  end
  local items = {}
  if self.selectIdx == 0 then
    items = newbieData.Temp
  elseif self.selectIdx > 0 then
    items = newbieData.Cards[self.selectIdx]
  end
  EventManager.Hit("GachaNewbieObtainRecord", self.selectIdx, items)
end

function GachaNewBieShowRecordCtrl:OnBtnClick_Item(btn, nIndex)
  if self.selectIdx == nIndex then
    return
  end
  if self.selectIdx == 0 then
    self._mapNode.GachaNewBieRecordItemC:SetSelect(false)
  elseif self.selectIdx > 0 then
    self._mapNode.GachaNewBieRecordItem[self.selectIdx]:SetSelect(false)
  end
  self._mapNode.GachaNewBieRecordItem[nIndex]:SetSelect(true)
  self.selectIdx = nIndex
end

function GachaNewBieShowRecordCtrl:OnBtnClick_ItemC()
  if self.selectIdx == 0 then
    return
  end
  if self.selectIdx > 0 then
    self._mapNode.GachaNewBieRecordItem[self.selectIdx]:SetSelect(false)
  end
  self._mapNode.GachaNewBieRecordItemC:SetSelect(true)
  self.selectIdx = 0
end

function GachaNewBieShowRecordCtrl:SetPoolId(id)
  self.curPoolId = id
  local newbieData = PlayerData.Gacha:GetGachaNewbieData(self.curPoolId)
  if newbieData == nil then
    return
  end
  self.selectIdx = -1
  if newbieData.Temp == nil or #newbieData.Temp == 0 then
    self._mapNode.GachaNewBieRecordItemC.gameObject:SetActive(false)
  else
    self._mapNode.GachaNewBieRecordItemC.gameObject:SetActive(true)
    self._mapNode.GachaNewBieRecordItemC:SetItems(newbieData.Temp, 0)
    self._mapNode.GachaNewBieRecordItemC:SetSelect(true)
    self.selectIdx = 0
  end
  for i = 1, 5 do
    self._mapNode.GachaNewBieRecordItem[i].gameObject:SetActive(false)
  end
  for idx, card in ipairs(newbieData.Cards) do
    self._mapNode.GachaNewBieRecordItem[idx].gameObject:SetActive(true)
    self._mapNode.GachaNewBieRecordItem[idx]:SetItems(card, idx)
    if self.selectIdx < 0 then
      self._mapNode.GachaNewBieRecordItem[idx]:SetSelect(true)
      self.selectIdx = idx
    else
      self._mapNode.GachaNewBieRecordItem[idx]:SetSelect(false)
    end
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.animRoot:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
  self.bClose = false
end

return GachaNewBieShowRecordCtrl
