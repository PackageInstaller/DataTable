local GachaNewBieReplaceResultCtrl = class("GachaNewBieReplaceResultCtrl", BaseCtrl)
GachaNewBieReplaceResultCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieReplaceTitle"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieReplaceCancel"
  },
  txtBtnOk = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieReplaceOk"
  },
  GachaNewBieShowRecordItemC = {
    sCtrlName = "Game.UI.GachaEx.GachaNewBieShowRecordItemCtrl"
  },
  GachaNewBieShowRecordItem = {
    sCtrlName = "Game.UI.GachaEx.GachaNewBieShowRecordItemCtrl"
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
  CloseButton = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  }
}
GachaNewBieReplaceResultCtrl._mapEventConfig = {}

function GachaNewBieReplaceResultCtrl:Awake()
end

function GachaNewBieReplaceResultCtrl:FadeIn()
end

function GachaNewBieReplaceResultCtrl:FadeOut()
end

function GachaNewBieReplaceResultCtrl:OnEnable()
  self.animRoot = self.gameObject:GetComponent("Animator")
  self.bClose = true
end

function GachaNewBieReplaceResultCtrl:OnDisable()
end

function GachaNewBieReplaceResultCtrl:OnDestroy()
end

function GachaNewBieReplaceResultCtrl:OnBtnClick_Close()
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

function GachaNewBieReplaceResultCtrl:OnBtnClick_Confirm()
  if self.bClose then
    return
  end
  
  local function Callback(mapData)
    EventManager.Hit("GachaNewbieReplaceRecordOver")
  end
  
  PlayerData.Gacha:SendGachaNewbieSaveReq(self.curPoolId, self.idx, Callback)
  self.bClose = true
end

function GachaNewBieReplaceResultCtrl:SetItems(id, idx)
  self.curPoolId = id
  self.idx = idx
  local newbieData = PlayerData.Gacha:GetGachaNewbieData(self.curPoolId)
  if newbieData == nil then
    return
  end
  self._mapNode.GachaNewBieShowRecordItemC:SetItems(newbieData.Temp, 0)
  self._mapNode.GachaNewBieShowRecordItem:SetItems(newbieData.Cards[idx], idx)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.animRoot:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
  self.bClose = false
end

return GachaNewBieReplaceResultCtrl
