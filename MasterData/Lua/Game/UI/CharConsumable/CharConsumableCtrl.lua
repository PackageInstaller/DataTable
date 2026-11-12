local CharConsumableCtrl = class("CharConsumableCtrl", BaseCtrl)
CharConsumableCtrl._mapNodeConfig = {
  rtItem = {
    sNodeName = "rtItem_",
    nCount = 10,
    sCtrlName = "Game.UI.CharConsumable.CharConsumableItemCtrl"
  },
  btnItem = {
    sNodeName = "rtItem_",
    nCount = 10,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  TMPTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterYO_Title"
  },
  TMPSubTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterYO_SubTitle"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
  btnConfirmPreview = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txtBtnConfirmPreview = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  }
}
CharConsumableCtrl._mapEventConfig = {}
CharConsumableCtrl._mapRedDotConfig = {}

function CharConsumableCtrl:Awake()
end

function CharConsumableCtrl:FadeIn()
end

function CharConsumableCtrl:FadeOut()
end

function CharConsumableCtrl:OnEnable()
  self.nItemId = 0
  self.curSelect = 0
  self.bPreview = false
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nItemId = tbParam[1]
    if tbParam[2] == nil then
    end
    self.bPreview = tbParam[2]
  end
  self.state = self:Refresh(self.nItemId)
  if not self.state then
    for i = 1, 10 do
      self._mapNode.rtItem[i].gameObject:SetActive(false)
    end
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      EventManager.Hit(EventId.ClosePanel, PanelId.CharConsumablePanel)
    end
    
    cs_coroutine.start(wait)
  end
  self._mapNode.btnConfirmPreview.gameObject:SetActive(self.bPreview)
  self._mapNode.btnConfirm.gameObject:SetActive(not self.bPreview)
  self._mapNode.btnCancel.gameObject:SetActive(not self.bPreview)
  if self.bPreview then
    NovaAPI.SetTMPText(self._mapNode.TMPTitle, ConfigTable.GetUIText("CharacterYO_Title_Preview"))
  end
end

function CharConsumableCtrl:OnDisable()
end

function CharConsumableCtrl:OnDestroy()
end

function CharConsumableCtrl:OnRelease()
end

function CharConsumableCtrl:Refresh(nItemId)
  self.curSelect = 0
  self.tbChar = {}
  local mapItemCfgData = ConfigTable.GetData_Item(nItemId)
  if mapItemCfgData == nil then
    return false
  end
  if mapItemCfgData.Stype ~= GameEnum.itemStype.CharacterYO then
    return false
  end
  local mapUseCfg = decodeJson(mapItemCfgData.UseArgs)
  if mapUseCfg == nil then
    return false
  end
  for charId, _ in pairs(mapUseCfg) do
    table.insert(self.tbChar, tonumber(charId))
  end
  
  local function sort(a, b)
    local mapCharCfgA = ConfigTable.GetData_Character(a)
    local mapCharCfgB = ConfigTable.GetData_Character(b)
    if mapCharCfgA == nil or mapCharCfgB == nil then
      return mapCharCfgA ~= nil
    end
    if mapCharCfgA.Grade ~= mapCharCfgB.Grade then
      return mapCharCfgA.Grade < mapCharCfgB.Grade
    end
    return a < b
  end
  
  table.sort(self.tbChar, sort)
  for i = 1, 10 do
    if self.tbChar[i] == nil then
      self._mapNode.rtItem[i].gameObject:SetActive(false)
    else
      self._mapNode.rtItem[i].gameObject:SetActive(true)
      self._mapNode.rtItem[i]:SetChar(self.tbChar[i])
      self._mapNode.rtItem[i]:SetSelect(false)
    end
  end
  return true
end

function CharConsumableCtrl:OnBtnClick_Confirm()
  if not self.state then
    return
  end
  local tbItem = PlayerData.Item:GetItemSortByExpire(self.nItemId)
  if #tbItem == 0 then
    printError("没有可使用的道具：" .. self.nItemId)
    return
  end
  local nChooseTid = self.tbChar[self.curSelect]
  local tbUseItem = {}
  if nChooseTid ~= nil then
    table.insert(tbUseItem, {
      Id = tbItem[1][1],
      Tid = self.nItemId,
      SelectTid = nChooseTid,
      Qty = 1
    })
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("CharacterSelect_NoSelectCharHint"))
    return
  end
  
  local function callback()
    EventManager.Hit("ConsumableUsed")
    EventManager.Hit(EventId.ClosePanel, PanelId.CharConsumablePanel)
  end
  
  local function Confirm()
    PlayerData.Item:SendPickItemMsg(tbUseItem, callback, true)
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Char,
    nCharId = nChooseTid,
    sContent = ConfigTable.GetUIText("CharacterYO_TipContent"),
    sTitle = ConfigTable.GetUIText("CharacterYO_TipTitle"),
    callbackConfirm = Confirm,
    bDisableSnap = false
  }
  EventManager.Hit(EventId.OpenMessageBox, msg)
end

function CharConsumableCtrl:OnBtnClick_Cancel()
  if not self.state then
    return
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.CharConsumablePanel)
end

function CharConsumableCtrl:OnBtnClick_Item(btn, idx)
  if idx == self.curSelect or self.bPreview then
    return
  end
  if self._mapNode.rtItem[self.curSelect] ~= nil then
    self._mapNode.rtItem[self.curSelect]:SetSelect(false)
  end
  self.curSelect = idx
  self._mapNode.rtItem[self.curSelect]:SetSelect(true)
end

return CharConsumableCtrl
