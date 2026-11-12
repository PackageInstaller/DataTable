local GachaNewBieObtainResultCtrl = class("GachaNewBieObtainResultCtrl", BaseCtrl)
GachaNewBieObtainResultCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieObtainTitle"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieObtainCancel"
  },
  txtBtnOk = {
    sComponentName = "TMP_Text",
    sLanguageId = "Gacha_NewBieObtainOk"
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
  rtItem = {
    sNodeName = "item",
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 10
  },
  imgRec = {sNodeName = "imgRec_", nCount = 10},
  rtItemText = {
    sNodeName = "item_name",
    sComponentName = "TMP_Text",
    nCount = 10
  },
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item",
    nCount = 10
  },
  CloseButton = {
    sComponentName = "Button",
    callback = "OnBtnClick_Close"
  }
}
GachaNewBieObtainResultCtrl._mapEventConfig = {}

function GachaNewBieObtainResultCtrl:Awake()
end

function GachaNewBieObtainResultCtrl:FadeIn()
end

function GachaNewBieObtainResultCtrl:FadeOut()
end

function GachaNewBieObtainResultCtrl:OnEnable()
  self.animRoot = self.gameObject:GetComponent("Animator")
  self.bClose = true
end

function GachaNewBieObtainResultCtrl:OnDisable()
end

function GachaNewBieObtainResultCtrl:OnDestroy()
end

function GachaNewBieObtainResultCtrl:OnBtnClick_Item(btn, nIndex)
  if self.items == nil then
    return
  end
  local item = self.items[nIndex]
  if item == nil then
    return
  end
  local mapItemCfgData = ConfigTable.GetData_Item(item)
  if mapItemCfgData == nil then
    return
  end
  if mapItemCfgData.Type == nil then
    return
  end
  if mapItemCfgData.Type == GameEnum.itemType.Disc then
    EventManager.Hit(EventId.OpenPanel, PanelId.DiscSample, item)
  elseif mapItemCfgData.Type == GameEnum.itemType.Char then
    EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, item)
  end
end

function GachaNewBieObtainResultCtrl:OnBtnClick_Close()
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

function GachaNewBieObtainResultCtrl:OnBtnClick_Confirm()
  if self.bClose then
    return
  end
  
  local function CheckNew(nTid)
    local mapItemCfgData = ConfigTable.GetData_Item(nTid)
    if mapItemCfgData == nil then
      return false
    end
    if mapItemCfgData.Type == GameEnum.itemType.Char then
      local mapChar = PlayerData.Char:GetCharDataByTid(nTid)
      return mapChar == nil
    elseif mapItemCfgData.Type == GameEnum.itemType.Disc then
      local mapDisc = PlayerData.Disc:GetDiscById(nTid)
      return mapDisc == nil
    else
      return false
    end
  end
  
  local tbItemId = {}
  local tbNew = {}
  for _, v in ipairs(self.items) do
    local bNewHandBood = CheckNew(v)
    local bNew = bNewHandBood and table.indexof(tbItemId, v) < 1
    table.insert(tbItemId, v)
    table.insert(tbNew, bNew)
  end
  
  local function Callback(mapData)
    EventManager.Hit("GachaNewbieObtainRecordOver", mapData, self.items, tbNew)
  end
  
  PlayerData.Gacha:SendGachaNewbieObtainReq(self.curPoolId, self.idx, Callback)
  self.bClose = true
end

function GachaNewBieObtainResultCtrl:SetItems(id, idx, items)
  self.idx = idx
  self.curPoolId = id
  self.items = items
  for idx, v in ipairs(items) do
    if v ~= 0 then
      local mapCfg = ConfigTable.GetData_Item(v)
      NovaAPI.SetTMPText(self._mapNode.rtItemText[idx], mapCfg.Title)
      self._mapNode.rtItem[idx].gameObject:SetActive(true)
      self._mapNode.rtItem[idx]:SetItem(v)
      local mapItemCfg = ConfigTable.GetData_Item(v)
      self._mapNode.imgRec[idx]:SetActive(mapItemCfg ~= nil and mapItemCfg.Rarity == GameEnum.itemRarity.SSR)
    else
      self._mapNode.rtItem[idx].gameObject:SetActive(false)
    end
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.animRoot:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
  self.bClose = false
end

return GachaNewBieObtainResultCtrl
