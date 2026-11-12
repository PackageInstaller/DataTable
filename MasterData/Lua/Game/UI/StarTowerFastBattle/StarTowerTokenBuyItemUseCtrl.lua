local StarTowerTokenBuyItemUseCtrl = class("StarTowerTokenBuyItemUseCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
StarTowerTokenBuyItemUseCtrl._mapNodeConfig = {
  goWindow = {},
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Use_Title"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  ctrlItem = {
    sNodeName = "goItem",
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txtItemName = {sComponentName = "TMP_Text"},
  txtItemDesc = {sComponentName = "TMP_Text"},
  txtHaveCount = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Count_Text"
  },
  txtHaveCountValue = {sComponentName = "TMP_Text"},
  txtAddValue = {sComponentName = "TMP_Text"},
  txtPermanent = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Permanent_Time"
  },
  txtStock = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Use_Count"
  },
  goQuantitySelector = {
    sNodeName = "tc_quantity_selector",
    sCtrlName = "Game.UI.TemplateEx.TemplateQuantitySelectorCtrl"
  },
  txtHave = {
    sComponentName = "TMP_Text",
    sLanguageId = "TokenBuy_Confirm_Text"
  },
  imgArrow = {},
  txtBeforeValue = {sComponentName = "TMP_Text"},
  txtAfterValue = {sComponentName = "TMP_Text"},
  goMaxValue = {},
  txtMaxValue = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Count_Max"
  },
  rtCountBg = {
    sNodeName = "imgCountBg",
    sComponentName = "RectTransform"
  },
  btnConfirm2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtConfirmBtn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Use_Btn_Text"
  }
}
StarTowerTokenBuyItemUseCtrl._mapEventConfig = {}

function StarTowerTokenBuyItemUseCtrl:Awake()
end

function StarTowerTokenBuyItemUseCtrl:OnEnable()
end

function StarTowerTokenBuyItemUseCtrl:ShowPanel()
  self.mapItemData = self._panel.mapItemData
  self.bBlur = self._panel.bBlur
  self.nUseCount = 1
  self.nMaxCount = 0
  self.nMinCount = 0
  self._mapNode.animWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:RefreshItem()
  
  local function callback(nCount)
    self.nUseCount = nCount
    self:RefreshAddCount()
  end
  
  self._mapNode.goQuantitySelector:Init(callback, self.nUseCount, self.nUseCountLimit)
  self:RefreshAddCount()
end

function StarTowerTokenBuyItemUseCtrl:OnDisable()
end

function StarTowerTokenBuyItemUseCtrl:OnDestroy()
end

function StarTowerTokenBuyItemUseCtrl:RefreshItem()
  local itemId = self.mapItemData.nTid
  self._mapNode.ctrlItem:SetItem(itemId, nil, nil, nil, nil, nil, nil, true, nil, true)
  local mapItemCfg = ConfigTable.GetData_Item(itemId)
  if mapItemCfg then
    NovaAPI.SetTMPText(self._mapNode.txtItemName, mapItemCfg.Title)
    NovaAPI.SetTMPText(self._mapNode.txtItemDesc, mapItemCfg.Desc)
  end
  NovaAPI.SetTMPText(self._mapNode.txtHaveCountValue, self.mapItemData.nCount)
  self.nMaxCount = self.mapItemData.nCount
  local nCountTemp = self.mapItemData.nTokenValue * 100 / self._panel.nMaxToken
  if nCountTemp < 1 and 0 < nCountTemp then
    nCountTemp = 1
  end
  local nRatio = math.floor(nCountTemp)
  NovaAPI.SetTMPText(self._mapNode.txtAddValue, string.format("+%s", nRatio .. "%"))
  self.nUseCountLimit = 0
  local nCurToken = PlayerData.StarTowerAutoPlan:GetTokenCount()
  for i = 1, self.nMaxCount do
    nCurToken = nCurToken + self.mapItemData.nTokenValue
    self.nUseCountLimit = i
    if nCurToken >= self._panel.nMaxToken then
      break
    end
  end
end

function StarTowerTokenBuyItemUseCtrl:RefreshAddCount()
  local nCurToken = PlayerData.StarTowerAutoPlan:GetTokenCount()
  local nCountTemp = nCurToken * 100 / self._panel.nMaxToken
  if nCountTemp < 1 and 0 < nCountTemp then
    nCountTemp = 1
  end
  local nRatio = math.floor(nCountTemp)
  NovaAPI.SetTMPText(self._mapNode.txtBeforeValue, nRatio .. "%")
  local nAfterValue = nCurToken + self.mapItemData.nTokenValue * self.nUseCount
  nCountTemp = nAfterValue * 100 / self._panel.nMaxToken
  if nCountTemp < 1 and 0 < nCountTemp then
    nCountTemp = 1
  end
  nRatio = math.floor(nCountTemp)
  NovaAPI.SetTMPText(self._mapNode.txtAfterValue, nRatio .. "%")
  self._mapNode.imgArrow.gameObject:SetActive(0 < self.nUseCount)
  self._mapNode.txtAfterValue.gameObject:SetActive(0 < self.nUseCount)
  self._mapNode.goMaxValue.gameObject:SetActive(nAfterValue >= self._panel.nMaxToken)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtCountBg)
end

function StarTowerTokenBuyItemUseCtrl:Close()
  self._mapNode.animWindow:Play("t_window_04_t_out")
  EventManager.Hit("ConsumableUsed")
end

function StarTowerTokenBuyItemUseCtrl:OnBtnClick_Close()
  EventManager.Hit("CloseTokenBuyPanel")
end

function StarTowerTokenBuyItemUseCtrl:OnBtnClick_Confirm()
  if self.nUseCount <= 0 then
    return
  end
  local itemList = {}
  local nUseCount = 0
  for id, count in pairs(self.mapItemData.mapId) do
    if nUseCount < self.nUseCount then
      local tbItem = {}
      tbItem.Tid = self.mapItemData.nTid
      tbItem.Id = id
      if nUseCount + count > self.nUseCount then
        tbItem.Qty = self.nUseCount - nUseCount
      else
        tbItem.Qty = count
      end
      table.insert(itemList, tbItem)
    else
      break
    end
    nUseCount = nUseCount + count
  end
  local nMaxCount = 0
  local nCurToken = PlayerData.StarTowerAutoPlan:GetTokenCount()
  for i = 1, self.nUseCount do
    nMaxCount = i
    nCurToken = nCurToken + self.mapItemData.nTokenValue
    if nCurToken >= self._panel.nMaxToken then
      break
    end
  end
  if nMaxCount < self.nUseCount then
    local sTip = ConfigTable.GetUIText("Energy_Use_Tip_2")
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = sTip,
      bBlur = false
    })
    return
  end
  if nil ~= next(itemList) then
    local function msgCallback()
      local nCountTemp = self.mapItemData.nTokenValue * self.nUseCount * 100 / self._panel.nMaxToken
      
      if nCountTemp < 1 and 0 < nCountTemp then
        nCountTemp = 1
      end
      local nRatio = math.floor(nCountTemp)
      EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("TokenBuy_Success"), nRatio))
      EventManager.Hit("CloseTokenBuyPanel")
      EventManager.Hit("RefreshTokenItemList")
    end
    
    PlayerData.Item:SendUseItemMsg(itemList, msgCallback)
  end
end

function StarTowerTokenBuyItemUseCtrl:OnBtnClick_Item(btn)
  local mapData = {
    nTid = self.mapItemData.nTid,
    bShowDepot = true,
    bShowJumpto = false
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

return StarTowerTokenBuyItemUseCtrl
