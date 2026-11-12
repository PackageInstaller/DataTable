local StarTowerTokenBuyMainCtrl = class("StarTowerTokenBuyMainCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local tbResidentTokenItemId = {81011}

local function GetTokenValue(nItemId)
  local mapItemCfg = ConfigTable.GetData_Item(nItemId)
  if mapItemCfg == nil then
    return 0
  end
  local mapUseCfg = decodeJson(mapItemCfg.UseArgs) or {}
  local nTokenValue = mapUseCfg[tostring(AllEnum.CoinItemId.AutoDecisionToken)] or mapUseCfg[AllEnum.CoinItemId.AutoDecisionToken]
  return tonumber(nTokenValue) or 0
end

local function GetItemInstances(mapItemData)
  local mapId = {}
  local nTotalCount = 0
  for _, mapInstanceGroup in pairs(mapItemData.mapExpires or {}) do
    for nInstanceId, nCount in pairs(mapInstanceGroup.mapId or {}) do
      mapId[nInstanceId] = (mapId[nInstanceId] or 0) + nCount
      nTotalCount = nTotalCount + nCount
    end
  end
  return mapId, nTotalCount
end

StarTowerTokenBuyMainCtrl._mapNodeConfig = {
  goWindow = {},
  animWindow = {sNodeName = "goWindow", sComponentName = "Animator"},
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TokenBuy_WindowTitle"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goBuyItem = {},
  txtBuyName = {
    sComponentName = "TMP_Text",
    sLanguageId = "TokenBuy_Desc"
  },
  imgEnergyBg = {},
  txtBuyCount = {sComponentName = "TMP_Text"},
  btnBuy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  },
  btnBuyGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BuyGray"
  },
  txtBuyButton = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Use_Btn_Text"
  },
  txtBuyButtonGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Energy_Item_Use_Btn_Text"
  },
  imgBuyCoin = {sComponentName = "Image"},
  txtBuyCost = {sComponentName = "TMP_Text"},
  goItemContent = {sComponentName = "Transform"},
  rtItemContent = {
    sNodeName = "goItemContent",
    sComponentName = "RectTransform"
  },
  goItem = {},
  goItemList = {
    sComponentName = "RectTransform"
  }
}
StarTowerTokenBuyMainCtrl._mapEventConfig = {
  RefreshTokenItemList = "RefreshTokenItem"
}

function StarTowerTokenBuyMainCtrl:Awake()
end

function StarTowerTokenBuyMainCtrl:OnEnable()
  self.tbItemCtrl = {}
end

function StarTowerTokenBuyMainCtrl:OnDisable()
  for _, v in ipairs(self.tbItemCtrl) do
    local obj = v.gameObject
    self:UnbindCtrlByNode(v)
    destroy(obj)
  end
  self.tbItemCtrl = {}
end

function StarTowerTokenBuyMainCtrl:OnDestroy()
end

function StarTowerTokenBuyMainCtrl:ShowPanel()
  self._mapNode.goItem.gameObject:SetActive(false)
  self._mapNode.animWindow:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:RefreshTokenItem()
  local mapVitaTokenPrice = ConfigTable.GetConfigArray("TowerVitaEnergyPurchasedPrice")
  self.nTokenPrice = tonumber(mapVitaTokenPrice[2])
  self.nCoinId = tonumber(mapVitaTokenPrice[1])
  local nRecoverValue = ConfigTable.GetConfigNumber("TowerVitaEnergyPurchasedValue")
  local nCountTemp = nRecoverValue * 100 / self._panel.nMaxToken
  if nCountTemp < 1 and 0 < nCountTemp then
    nCountTemp = 1
  end
  local nRecoverRatio = math.floor(nCountTemp)
  self:SetSprite_Coin(self._mapNode.imgBuyCoin, self.nCoinId)
  NovaAPI.SetTMPText(self._mapNode.txtBuyCost, self.nTokenPrice)
  NovaAPI.SetTMPText(self._mapNode.txtBuyCount, "+" .. nRecoverRatio .. "%")
  local hasCount = PlayerData.Coin:GetCoinCount(self.nCoinId)
  NovaAPI.SetTMPColor(self._mapNode.txtBuyCost, hasCount < self.nTokenPrice and Red_Unable or Blue_Normal)
  self._mapNode.btnBuy.gameObject:SetActive(true)
  self._mapNode.btnBuyGray.gameObject:SetActive(false)
end

function StarTowerTokenBuyMainCtrl:RefreshTokenItem()
  self.tbItems = {}
  local tbItems = PlayerData.Item:GetItemsByStype(GameEnum.itemStype.TokenItem)
  local mapResidentItem = {}
  for _, nItemId in ipairs(tbResidentTokenItemId) do
    mapResidentItem[nItemId] = false
  end
  for _, mapItemData in ipairs(tbItems) do
    local nTokenValue = GetTokenValue(mapItemData.Tid)
    if 0 < nTokenValue then
      local mapId, nCount = GetItemInstances(mapItemData)
      if 0 < nCount then
        table.insert(self.tbItems, {
          nTid = mapItemData.Tid,
          mapId = mapId,
          nTokenValue = nTokenValue,
          nCount = nCount,
          nSort = 0
        })
        if mapResidentItem[mapItemData.Tid] ~= nil then
          mapResidentItem[mapItemData.Tid] = true
        end
      end
    end
  end
  for _, nItemId in ipairs(tbResidentTokenItemId) do
    if mapResidentItem[nItemId] == false and ConfigTable.GetData_Item(nItemId) ~= nil then
      table.insert(self.tbItems, {
        nTid = nItemId,
        mapId = {},
        nCount = 0,
        nTokenValue = GetTokenValue(nItemId),
        nSort = -1
      })
    end
  end
  table.sort(self.tbItems, function(a, b)
    if a.nSort == b.nSort then
      return a.nTid < b.nTid
    end
    return a.nSort > b.nSort
  end)
  for _, v in ipairs(self.tbItemCtrl) do
    v.gameObject:SetActive(false)
  end
  for k, v in ipairs(self.tbItems) do
    if nil == self.tbItemCtrl[k] then
      local obj = instantiate(self._mapNode.goItem, self._mapNode.goItemList)
      obj.gameObject:SetActive(true)
      local objCtrl = self:BindCtrlByNode(obj, "Game.UI.StarTowerFastBattle.StarTowerTokenBuyItemCtrl")
      objCtrl:SetItem(v)
      self.tbItemCtrl[k] = objCtrl
    else
      self.tbItemCtrl[k].gameObject:SetActive(true)
      self.tbItemCtrl[k]:SetItem(v)
    end
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtItemContent)
end

function StarTowerTokenBuyMainCtrl:Close()
  self._mapNode.animWindow:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function StarTowerTokenBuyMainCtrl:OnBtnClick_Close()
  EventManager.Hit("CloseTokenBuyPanel")
end

function StarTowerTokenBuyMainCtrl:OnBtnClick_Buy()
  local nHasCoin = PlayerData.Coin:GetCoinCount(self.nCoinId)
  if nHasCoin < self.nTokenPrice then
    local itemCfg = ConfigTable.GetData_Item(self.nCoinId)
    local itemCostCfg = ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE)
    if not itemCfg or not itemCostCfg then
      return
    end
    local sTip = orderedFormat(ConfigTable.GetUIText("Recruit_ExchangeGemZero"), itemCfg.Id, self.nTokenPrice - nHasCoin, itemCostCfg.Id)
    
    local function confirmCallback()
      local nStoneCount = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.STONE)
      nStoneCount = nStoneCount + PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.FREESTONE)
      if nStoneCount < self.nTokenPrice - nHasCoin then
        local msg = {
          nType = AllEnum.MessageBox.Confirm,
          sContent = orderedFormat(ConfigTable.GetUIText("Recruit_Charge") or "", itemCostCfg.Id),
          callbackConfirm = function()
            self._panel:JumpToRecharge()
          end,
          bBlur = false
        }
        EventManager.Hit(EventId.OpenMessageBox, msg)
      else
        PlayerData.Coin:SendGemConvertReqReq(self.nTokenPrice - nHasCoin, nil)
      end
      EventManager.Hit("ShowTokenTopRes", false)
    end
    
    local function cancelCallback()
      EventManager.Hit("ShowTokenTopRes", false)
    end
    
    local msg = {
      nType = AllEnum.MessageBox.Confirm,
      sContent = sTip,
      callbackConfirm = confirmCallback,
      callbackCancel = cancelCallback,
      bBlur = false
    }
    EventManager.Hit(EventId.OpenMessageBox, msg)
    EventManager.Hit("ShowTokenTopRes", false)
    return
  end
  local nCurToken = PlayerData.StarTowerAutoPlan:GetTokenCount()
  if nCurToken >= self._panel.nMaxToken then
    local sTip = ConfigTable.GetUIText("TokenBuy_HitLimit")
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sContent = sTip
    })
    return
  end
  EventManager.Hit("ChangeTokenBuyPanel", AllEnum.TokenBuyPanelType.BuyConfirm)
end

function StarTowerTokenBuyMainCtrl:OnBtnClick_BuyGray()
  local sTip = ConfigTable.GetUIText("TokenBuy_NoCoin")
  EventManager.Hit(EventId.OpenMessageBox, {
    nType = AllEnum.MessageBox.Tips,
    bPositive = true,
    sContent = sTip
  })
end

return StarTowerTokenBuyMainCtrl
