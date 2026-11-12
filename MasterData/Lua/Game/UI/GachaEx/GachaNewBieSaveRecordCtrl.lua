local GachaNewBieSaveRecordCtrl = class("GachaNewBieSaveRecordCtrl", BaseCtrl)
GachaNewBieSaveRecordCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieSaveRecordTitle"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieSaveRecordCancel"
  },
  txtBtnOk = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieSaveRecordOk"
  },
  txtReplaceTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieSaveRecordTip"
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
  GachaNewBieShowRecordItemC = {
    sCtrlName = "Game.UI.GachaEx.GachaNewBieShowRecordItemCtrl"
  },
  GachaNewBieRecordItem = {
    sCtrlName = "Game.UI.GachaEx.GachaNewBieRecordItemCtrl",
    nCount = 5
  },
  btnItem = {
    sNodeName = "GachaNewBieRecordItem",
    sComponentName = "Button",
    callback = "OnBtnClick_Item",
    nCount = 5
  },
  CloseButton = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  }
}
GachaNewBieSaveRecordCtrl._mapEventConfig = {}

function GachaNewBieSaveRecordCtrl:Awake()
end

function GachaNewBieSaveRecordCtrl:FadeIn()
end

function GachaNewBieSaveRecordCtrl:FadeOut()
end

function GachaNewBieSaveRecordCtrl:OnEnable()
  self.animRoot = self.gameObject:GetComponent("Animator")
  self.bClose = true
end

function GachaNewBieSaveRecordCtrl:OnDisable()
end

function GachaNewBieSaveRecordCtrl:OnDestroy()
end

function GachaNewBieSaveRecordCtrl:OnBtnClick_Close()
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

function GachaNewBieSaveRecordCtrl:OnBtnClick_Confirm()
  if self.bClose then
    return
  end
  EventManager.Hit("GachaNewbieReplaceRecord", self.selectIdx)
end

function GachaNewBieSaveRecordCtrl:OnBtnClick_Item(btn, nIndex)
  if self.selectIdx == nIndex then
    return
  end
  self._mapNode.GachaNewBieRecordItem[self.selectIdx]:SetSelect(false)
  self._mapNode.GachaNewBieRecordItem[nIndex]:SetSelect(true)
  self.selectIdx = nIndex
end

function GachaNewBieSaveRecordCtrl:SetItems(id)
  self.curPoolId = id
  local newbie = ConfigTable.GetData("GachaNewbie", self.curPoolId)
  if newbie == nil then
    return
  end
  local newbieData = PlayerData.Gacha:GetGachaNewbieData(self.curPoolId)
  if newbieData == nil then
    return
  end
  local c = tostring(#newbieData.Cards) .. "/" .. tostring(newbie.SaveCount)
  NovaAPI.SetTMPText(self._mapNode.txtReplaceTip, orderedFormat(ConfigTable.GetUIText("Gacha_NewBieSaveRecordTip") or "", c))
  self._mapNode.GachaNewBieShowRecordItemC:SetItems(newbieData.Temp, 0)
  self.selectIdx = 1
  for idx, card in ipairs(newbieData.Cards) do
    self._mapNode.GachaNewBieRecordItem[idx].gameObject:SetActive(true)
    self._mapNode.GachaNewBieRecordItem[idx]:SetItems(card, idx)
    if self.selectIdx == idx then
      self._mapNode.GachaNewBieRecordItem[idx]:SetSelect(true)
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

return GachaNewBieSaveRecordCtrl
