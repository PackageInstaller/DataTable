local SoldierShopCtrl = class("SoldierShopCtrl", BaseCtrl)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
SoldierShopCtrl._mapNodeConfig = {
  btn_CloseShop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_CloseShop"
  },
  SoldierCharCardShopItem = {
    nCount = 5,
    sCtrlName = "Game.UI.Soldier.Sandtable.Items.SoldierCharCardShopItemCtrl"
  },
  btnRefreshShop = {
    sComponentName = "NaviButton",
    sAction = "SoldierRefreshShop",
    callback = "OnBtnClick_RefreshShop"
  },
  txtBtnRefreshShop = {nCount = 4, sComponentName = "TMP_Text"},
  imgBtnRefreshShopMask = {},
  goCoinRaidUnlock = {},
  txtRefreshCount = {sComponentName = "TMP_Text"},
  goCoinRaidFree = {},
  txtRefreshFreeCount = {sComponentName = "TMP_Text"},
  btnLock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  imgLocked = {},
  imgUnlocked = {},
  goProbabilityBarItem = {nCount = 5},
  imgTickets = {},
  btn_Probability = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Probability"
  },
  goSell = {},
  btnShopSell = {sComponentName = "UIButton"},
  txtShopSell = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Sandtable_ShopCell"
  },
  txtShopSellPrice = {sComponentName = "TMP_Text"},
  imgShopSellIcon = {sComponentName = "Image"}
}
SoldierShopCtrl._mapEventConfig = {
  SoldierItemChange = "OnEvent_SoldierItemChange"
}
SoldierShopCtrl._mapRedDotConfig = {}

function SoldierShopCtrl:Awake()
end

function SoldierShopCtrl:OnEnable()
  self._panel:AddGamepadUINode(self:GetGamepadUINode())
  self.nFreeCount = 0
  self.nReRollPrice = 0
  self.levelData = PlayerData.SoldierData:GetCurLevelData()
  self.timer = nil
  self._mapNode.btn_CloseShop.gameObject:SetActive(false)
end

function SoldierShopCtrl:OnDisable()
  if self.timer ~= nil then
    self.timer:_Stop()
    self.timer = nil
  end
end

function SoldierShopCtrl:ShowShopPanel()
  if self.levelData == nil then
    self.levelData = PlayerData.SoldierData:GetCurLevelData()
  end
  self:RefreshShopData()
  self._mapNode.goSell:SetActive(false)
  self.gameObject:SetActive(true)
  if not PlayerData.Guide:CheckGuideFinishById(507) then
    EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_507")
  end
end

function SoldierShopCtrl:GetSellBtnInstanceId()
  return self._mapNode.btnShopSell.gameObject:GetInstanceID()
end

function SoldierShopCtrl:SetSellMode(bShow, nPrice)
  self._mapNode.goSell:SetActive(bShow)
  if bShow and nPrice ~= nil then
    NovaAPI.SetTMPText(self._mapNode.txtShopSellPrice, tostring(nPrice))
  end
end

function SoldierShopCtrl:IsShopOpen()
  return self.gameObject.activeSelf
end

function SoldierShopCtrl:RefreshShopData()
  local shopData = self.levelData:GetShopData()
  if shopData == nil then
    return
  end
  self.tbChessData = shopData.tbGoods
  self.tbProbability = shopData.tbWeightList
  self.bLock = shopData.bLock
  self.nFreeCount = shopData.nFreeCount
  self.nReRollPrice = shopData.nReRollPrice
  self.bDisablePurchase = shopData.bDisablePurchase
  self.bDisableRefresh = shopData.bDisableRefresh
  self:RefreshRefreshBtnState()
  self:RefreshGoodsData()
  self:RefreshProbabilityData()
  self:RefreshTicketsData()
  self._mapNode.imgLocked:SetActive(self.bLock)
  self._mapNode.imgUnlocked:SetActive(not self.bLock)
  EventManager.Hit("RefreshPurchaseExpPrice")
end

function SoldierShopCtrl:HideShopPanel()
  self.gameObject:SetActive(false)
end

function SoldierShopCtrl:RefreshRefreshBtnState()
  self._mapNode.imgBtnRefreshShopMask.gameObject:SetActive(self.bDisableRefresh)
  self._mapNode.goCoinRaidUnlock.gameObject:SetActive(self.nFreeCount <= 0 and not self.bDisableRefresh)
  self._mapNode.goCoinRaidFree.gameObject:SetActive(self.nFreeCount > 0 and not self.bDisableRefresh)
  NovaAPI.SetTMPText(self._mapNode.txtRefreshFreeCount, self.nFreeCount)
  local sBtn = ConfigTable.GetUIText("Soldier_Shop_Refresh")
  if self.bDisableRefresh then
    sBtn = ConfigTable.GetUIText("Soldier_Shop_Refresh_Disable")
  elseif self.nFreeCount > 0 then
    sBtn = ConfigTable.GetUIText("Soldier_Shop_Refresh_Free")
  end
  for _, v in ipairs(self._mapNode.txtBtnRefreshShop) do
    NovaAPI.SetTMPText(v, sBtn)
  end
end

function SoldierShopCtrl:RefreshGoodsData()
  local tbGoodsData = {
    nil,
    nil,
    nil,
    nil,
    nil
  }
  local tbGuideChess = {}
  local bHasStar2 = false
  local bGuide = PlayerData.Guide:CheckGuideFinishById(509)
  local nNodeIndex = self.levelData:GetNodeIndex()
  for i = 1, 5 do
    if self.tbChessData[i] ~= nil then
      local bCombine = false
      local nNextStar = 0
      if self.tbChessData[i].Id ~= 0 then
        bCombine, nNextStar = self.levelData:CheckSoldierCombine(self.tbChessData[i].Id, self.tbChessData[i].Star)
        if not bGuide and 3 <= nNodeIndex then
          local tbAllChess = self.levelData:GetAllChess()
          for _, v in ipairs(tbAllChess) do
            if v.nId == self.tbChessData[i].Id then
              table.insert(tbGuideChess, {
                nId = v.nId,
                nIndex = i,
                nCost = self.tbChessData[i].Price
              })
            end
            if v.nStar >= 2 then
              bHasStar2 = true
            end
          end
        end
      end
      if nNextStar == 0 and 1 < self.tbChessData[i].Star then
        nNextStar = self.tbChessData[i].Star
      end
      tbGoodsData[i] = {
        nCharId = self.tbChessData[i].Id,
        nStar = nNextStar,
        nCost = self.tbChessData[i].Price
      }
    end
  end
  for i = 1, 5 do
    self._mapNode.SoldierCharCardShopItem[i]:SetData(tbGoodsData[i].nCharId, tbGoodsData[i].nCost, tbGoodsData[i].nStar, self.bDisablePurchase)
    self._mapNode.SoldierCharCardShopItem[i]:SetClickCallback(_, function()
      self:OnBtnClick_Char(i)
    end)
  end
  if not bGuide and not bHasStar2 then
    table.sort(tbGuideChess, function(a, b)
      if a.nCost == b.nCost then
        return a.nIndex < b.nIndex
      end
      return a.nCost > b.nCost
    end)
    if 0 < #tbGuideChess then
      PlayerData.SoldierData:SetGuideData(509, tbGuideChess[1].nId)
    else
      PlayerData.SoldierData:SetGuideData(509, nil)
    end
    local nGuideData = PlayerData.SoldierData:GetGuideData(509)
    if nGuideData ~= nil then
      EventManager.Hit("Guide_PassiveCheck_Msg", "Guide_Solider_509")
    end
  end
end

function SoldierShopCtrl:RefreshProbabilityData()
  for i = 1, 5 do
    local TextRatio = self._mapNode.goProbabilityBarItem[i].transform:Find("TextRatio"):GetComponent("TMP_Text")
    local goFx = self._mapNode.goProbabilityBarItem[i].transform:Find("Fx_Upgrade")
    local nWeight = self.tbProbability[i].nWeight
    local bDouble = self.tbProbability[i].bDouble
    NovaAPI.SetTMPText(TextRatio, tostring(nWeight) .. "%")
    goFx.gameObject:SetActive(bDouble)
  end
end

function SoldierShopCtrl:RefreshTicketsData()
  self._mapNode.imgTickets:SetActive(self.nFreeCount <= 0)
  if self.nFreeCount > 0 then
    NovaAPI.SetTMPText(self._mapNode.txtRefreshCount, tostring(self.nFreeCount))
  else
    NovaAPI.SetTMPText(self._mapNode.txtRefreshCount, tostring(self.nReRollPrice))
  end
  local coinCount = self.levelData:GetItem(AllEnum.CoinItemId.SoldierCurrency)
  if coinCount < self.nReRollPrice then
    NovaAPI.SetTMPColor(self._mapNode.txtRefreshCount, Color(0.8431372549019608, 0.3568627450980392, 0.4392156862745098, 1))
  else
    NovaAPI.SetTMPColor(self._mapNode.txtRefreshCount, Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764, 1))
  end
end

function SoldierShopCtrl:OnBtnClick_CloseShop()
  self:HideShopPanel()
  EventManager.Hit("SoldierShopClose")
end

function SoldierShopCtrl:OnBtnClick_Lock()
  self.levelData:SendShopLock(not self.bLock, function()
    self.bLock = not self.bLock
    self._mapNode.imgLocked:SetActive(self.bLock)
    self._mapNode.imgUnlocked:SetActive(not self.bLock)
  end)
end

function SoldierShopCtrl:OnBtnClick_RefreshShop()
  if self.bDisableRefresh then
    return
  end
  local coinCount = self.levelData:GetItem(AllEnum.CoinItemId.SoldierCurrency)
  if coinCount < self.nReRollPrice and self.nFreeCount <= 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_BuyExp_Tips2"))
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_shop_refresh_poor")
    return
  end
  self.levelData:SendShopRefresh(function(callbackData)
    EventManager.Hit("SoldierShopRefresh")
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_shop_refresh")
    if self.timer ~= nil then
      self.timer:_Stop()
      self.timer = nil
    end
    local data = callbackData.shopBecomeAnother
    if callbackData.shopBecomeAnother ~= nil then
      self._mapNode.SoldierCharCardShopItem[data.nGoodsIndex]:PlayRandomRefreshOneShot()
    end
    EventManager.Hit("SoldierSandtableRefreshStep", callbackData.tbChessChangeStep)
    self.timer = self:AddTimer(1, 0.23, function()
      self:RefreshShopData()
    end, true, true, true)
  end)
end

function SoldierShopCtrl:OnBtnClick_Char(nIndex)
  local chessData = self.tbChessData[nIndex]
  if chessData == nil then
    return
  end
  if chessData.Id == 0 then
    return
  end
  local coinCount = self.levelData:GetItem(AllEnum.CoinItemId.SoldierCurrency)
  if coinCount < chessData.Price then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_InsufficientCoin_Tips"))
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_shop_buy_poor")
    return
  end
  local _, tbWaiting, _ = self.levelData:GetDeploy()
  local bWaitingMax = true
  for _, v in ipairs(tbWaiting) do
    if v.nId == 0 then
      bWaitingMax = false
      break
    end
  end
  local bCombine, _ = self.levelData:CheckSoldierCombine(chessData.Id, chessData.Star)
  if bWaitingMax and not bCombine then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Soldier_OverBench_Tips"))
    return
  end
  self.levelData:SendShopPurchase(nIndex, function(tbChange)
    CS.WwiseAudioManager.Instance:PostEvent("mode_900001_chess_shop_buy")
    self:RefreshShopData()
    EventManager.Hit("SoldierCharItemChange", tbChange.tbChessChangeStep, self._mapNode.SoldierCharCardShopItem[nIndex].gameObject.transform)
  end)
end

function SoldierShopCtrl:OnBtnClick_Probability()
  EventManager.Hit(EventId.OpenPanel, PanelId.SoldierShopProbabilityPanel)
end

function SoldierShopCtrl:OnEvent_SoldierItemChange()
  self:RefreshTicketsData()
end

return SoldierShopCtrl
