local MallFurnitureSetCtrl = class("MallFurnitureSetCtrl", BaseCtrl)
MallFurnitureSetCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Shop_TitleBuy"
  },
  txtTagName = {sComponentName = "TMP_Text"},
  imgTag = {},
  goFurniture = {},
  txtFurnitureValue = {sComponentName = "TMP_Text"},
  txtName = {sComponentName = "TMP_Text"},
  goCurrency = {},
  imgCurrency = {sComponentName = "Image"},
  txtPrice = {sComponentName = "TMP_Text"},
  txtPriceCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_PriceTitle"
  },
  svList = {
    sNodeName = "lsvList",
    sComponentName = "LoopScrollView"
  },
  goTime = {},
  txtLimit = {sComponentName = "TMP_Text"},
  txtLimitCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_LimitTitle"
  },
  txtTime = {sComponentName = "TMP_Text"},
  txtTimeCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_TimeTitle"
  },
  txtTitleFurnitureList = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Package_FurnitureList"
  },
  btnBuy1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  },
  btnBuy2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Disable"
  },
  txtBtnBuy = {
    nCount = 2,
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Btn_Buy"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  goTitleList = {
    sComponentName = "RectTransform"
  },
  eventDrag = {
    sNodeName = "goTitleList",
    sComponentName = "UIDrag",
    callback = "OnDrag_Banner"
  },
  goTitleItem = {
    nCount = 3,
    sComponentName = "RectTransform"
  },
  imgTitleImg = {nCount = 3, sComponentName = "Image"},
  imgPointBg = {nCount = 4},
  imgPoint = {nCount = 4}
}
MallFurnitureSetCtrl._mapEventConfig = {}

function MallFurnitureSetCtrl:Refresh(mapData)
  self.sId = mapData.sId
  local mapCfg = ConfigTable.GetData("MallPackage", mapData.sId)
  self:PlayInAni()
  self:RefreshInfo(mapCfg)
  self:RefreshPrice(mapCfg)
  self:RefreshLimit(mapCfg, mapData)
  self:RefreshTime(mapData)
  self:RefreshFurnitureValue(mapCfg)
  self:RefreshItem(mapCfg)
  self:RefreshBuy(mapCfg, mapData)
end

function MallFurnitureSetCtrl:RefreshInfo(mapCfg)
  NovaAPI.SetTMPText(self._mapNode.txtName, mapCfg.DetailName)
  self.tbIcon = {}
  local tbItem = decodeJson(mapCfg.Items)
  if next(tbItem) == nil then
    return
  end
  local tbSet = {}
  for sSetId in pairs(tbItem) do
    table.insert(tbSet, tonumber(sSetId))
  end
  local mapDormCfg = ConfigTable.GetData("DormLayoutReward", tbSet[1])
  if not mapDormCfg then
    return
  end
  self._mapNode.imgTag:SetActive(mapDormCfg.RoomLayoutTag ~= "")
  if mapDormCfg.RoomLayoutTag ~= "" then
    NovaAPI.SetTMPText(self._mapNode.txtTagName, mapDormCfg.RoomLayoutTag)
  end
  table.insert(self.tbIcon, mapDormCfg.RoomLayoutListIcon)
  self:SetBanner()
end

function MallFurnitureSetCtrl:SetBanner()
  self:ResetBannerTimer()
  self.nBannerIdx = 1
  self.nBannerDragPosX = 0
  for k, v in ipairs(self._mapNode.goTitleItem) do
    v.anchoredPosition = self.tbBannerInitPos[k]
  end
  self._mapNode.eventDrag.enabled = 1 < #self.tbIcon
  for k, v in ipairs(self._mapNode.imgPointBg) do
    v:SetActive(false)
  end
  if next(self.tbIcon) == nil then
    return
  end
  self:RefreshBanner()
  self:StartBannerTimer()
end

function MallFurnitureSetCtrl:RefreshBanner()
  local nCount = #self.tbIcon
  local nLastIdx = self.nBannerIdx - 1 <= 0 and nCount or self.nBannerIdx - 1
  local nNextIdx = nCount < self.nBannerIdx + 1 and 1 or self.nBannerIdx + 1
  local tbCurIcon = {
    self.tbIcon[nLastIdx],
    self.tbIcon[self.nBannerIdx],
    self.tbIcon[nNextIdx]
  }
  for k, v in ipairs(self._mapNode.imgTitleImg) do
    if tbCurIcon[k] ~= nil then
      self:SetPngSprite(v, tbCurIcon[k] .. "_big")
    end
  end
  for k, v in ipairs(self._mapNode.imgPoint) do
    v:SetActive(k == self.nBannerIdx)
  end
end

function MallFurnitureSetCtrl:StartBannerTimer()
  if self.bannerTimer == nil and #self.tbIcon > 1 then
    self.bannerTimer = self:AddTimer(0, self.nBannerInterval, "PlayBannerAnim", true, true, false)
  end
end

function MallFurnitureSetCtrl:ResetBannerTimer()
  if self.bannerTimer ~= nil then
    self.bannerTimer:Cancel(false)
  end
  self.bannerTimer = nil
end

function MallFurnitureSetCtrl:PlayBannerAnim()
  local function onCompleteCb()
    self:BannerTweenerEnd()
  end
  
  for k, v in ipairs(self._mapNode.goTitleItem) do
    if k == #self._mapNode.goTitleItem then
      v:DOAnchorPosX(self.tbBannerInitPos[k].x - self.nBannerWidth, 0.5):SetUpdate(true):OnComplete(onCompleteCb)
    else
      v:DOAnchorPosX(self.tbBannerInitPos[k].x - self.nBannerWidth, 0.5):SetUpdate(true)
    end
  end
end

function MallFurnitureSetCtrl:BannerTweenerEnd()
  for k, v in ipairs(self._mapNode.goTitleItem) do
    v.anchoredPosition = self.tbBannerInitPos[k]
  end
  self.nBannerIdx = self.nBannerIdx + 1 > #self.tbIcon and 1 or self.nBannerIdx + 1
  self:RefreshBanner()
end

function MallFurnitureSetCtrl:OnDrag_Banner(mDrag)
  if #self.tbIcon <= 1 then
    return
  end
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nBannerDragPosX = 0
    self:ResetBannerTimer()
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    self.nBannerDragPosX = self.nBannerDragPosX + mDrag.EventData.delta.x
    for k, v in ipairs(self._mapNode.goTitleItem) do
      v.anchoredPosition = Vector2(self.tbBannerInitPos[k].x + self.nBannerDragPosX, self.tbBannerInitPos[k].y)
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    local nPos = 0
    if self.nBannerDragPosX > 0 then
      nPos = self.nBannerWidth
      self.nBannerIdx = 0 >= self.nBannerIdx - 1 and #self.tbIcon or self.nBannerIdx - 1
    elseif self.nBannerDragPosX < 0 then
      nPos = -self.nBannerWidth
      self.nBannerIdx = self.nBannerIdx + 1 > #self.tbIcon and 1 or self.nBannerIdx + 1
    end
    local tweener
    for k, v in ipairs(self._mapNode.goTitleItem) do
      tweener = v:DOAnchorPosX(self.tbBannerInitPos[k].x + nPos, 0.5):SetUpdate(true)
    end
    
    local function _cb()
      for k, v in ipairs(self._mapNode.goTitleItem) do
        v.anchoredPosition = self.tbBannerInitPos[k]
      end
      self:RefreshBanner()
      self:StartBannerTimer()
    end
    
    tweener.onComplete = dotween_callback_handler(self, _cb)
    self.nBannerDragPosX = 0
  end
end

function MallFurnitureSetCtrl:RefreshPrice(mapCfg)
  if mapCfg.CurrencyType == GameEnum.currencyType.Cash then
    self._mapNode.goCurrency:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtPrice, tostring(mapCfg.CurrencyShowPrice))
  elseif mapCfg.CurrencyType == GameEnum.currencyType.Item then
    self._mapNode.goCurrency:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtPrice, mapCfg.CurrencyItemQty)
    self:SetPngSprite(self._mapNode.imgCurrency, ConfigTable.GetData_Item(mapCfg.CurrencyItemId).Icon2)
  elseif mapCfg.CurrencyType == GameEnum.currencyType.Free then
    self._mapNode.goCurrency:SetActive(false)
    NovaAPI.SetTMPText(self._mapNode.txtPrice, ConfigTable.GetUIText("Mall_Package_Free"))
  end
end

function MallFurnitureSetCtrl:RefreshLimit(mapCfg, mapData)
  NovaAPI.SetTMPText(self._mapNode.txtLimit, mapData.nCurStock .. "/" .. mapCfg.Stock)
  if mapCfg.RefreshType == GameEnum.mallPackageRefreshType.None then
    NovaAPI.SetTMPText(self._mapNode.txtLimitCn, ConfigTable.GetUIText("Mall_Package_LimitTitle"))
  elseif mapCfg.RefreshType == GameEnum.mallPackageRefreshType.Day then
    NovaAPI.SetTMPText(self._mapNode.txtLimitCn, ConfigTable.GetUIText("Mall_Package_DayLimitTitle"))
  elseif mapCfg.RefreshType == GameEnum.mallPackageRefreshType.Week then
    NovaAPI.SetTMPText(self._mapNode.txtLimitCn, ConfigTable.GetUIText("Mall_Package_WeekLimitTitle"))
  elseif mapCfg.RefreshType == GameEnum.mallPackageRefreshType.Month then
    NovaAPI.SetTMPText(self._mapNode.txtLimitCn, ConfigTable.GetUIText("Mall_Package_MonthLimitTitle"))
  end
end

function MallFurnitureSetCtrl:GetTimeStr(nRemainTime)
  local str = ""
  if nRemainTime <= 3600 then
    str = ConfigTable.GetUIText("Mall_Package_WithinHour")
  elseif 3600 < nRemainTime and nRemainTime <= 86400 then
    str = orderedFormat(ConfigTable.GetUIText("Mall_Package_Hour") or "", math.floor(nRemainTime / 3600))
  elseif 86400 < nRemainTime then
    str = orderedFormat(ConfigTable.GetUIText("Mall_Package_Day") or "", math.floor(nRemainTime / 86400))
  end
  return str
end

function MallFurnitureSetCtrl:RefreshTime(mapData)
  self._mapNode.goTime:SetActive(mapData.nNextRefreshTime > 0)
  if mapData.nNextRefreshTime <= 0 then
    return
  end
  local sSuffix = mapData.bPrioritizeDeList and ConfigTable.GetUIText("Mall_Package_Delist") or ConfigTable.GetUIText("Mall_Package_Refresh")
  local sPrefix = self:GetTimeStr(mapData.nNextRefreshTime - CS.ClientManager.Instance.serverTimeStamp)
  NovaAPI.SetTMPText(self._mapNode.txtTime, sPrefix .. sSuffix)
end

function MallFurnitureSetCtrl:RefreshFurnitureValue(mapCfg)
  local nValue = PlayerData.Mall:GetFurnitureSetCollectionValue(mapCfg)
  NovaAPI.SetTMPText(self._mapNode.txtFurnitureValue, tostring(nValue))
end

function MallFurnitureSetCtrl:RefreshItem(mapCfg)
  self.tbFurniture = {}
  local mapIndex = {}
  for sSetId in pairs(decodeJson(mapCfg.Items) or {}) do
    local itemCfg = ConfigTable.GetData_Item(tonumber(sSetId))
    if itemCfg ~= nil then
      for sItemId, nCount in pairs(decodeJson(itemCfg.UseArgs) or {}) do
        local nId = tonumber(sItemId)
        local furnitureCfg = ConfigTable.GetData("DormFurniture", nId)
        local furnitureItemCfg = ConfigTable.GetData_Item(nId)
        if furnitureCfg ~= nil and furnitureItemCfg ~= nil then
          local nIndex = mapIndex[nId]
          if nIndex == nil then
            table.insert(self.tbFurniture, {
              nId = nId,
              nCount = nCount,
              nRarity = furnitureItemCfg.Rarity
            })
            mapIndex[nId] = #self.tbFurniture
          else
            self.tbFurniture[nIndex].nCount = self.tbFurniture[nIndex].nCount + nCount
          end
        end
      end
    end
  end
  table.sort(self.tbFurniture, function(a, b)
    if a.nRarity ~= b.nRarity then
      return a.nRarity < b.nRarity
    else
      return a.nId < b.nId
    end
  end)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.svList:Init(#self.tbFurniture, self, self.OnGridRefresh, self.OnGridClick)
end

function MallFurnitureSetCtrl:OnGridRefresh(goGrid, nIdx)
  local mapItem = self.tbFurniture[nIdx + 1]
  if mapItem == nil then
    return
  end
  local nInstanceId = goGrid:GetInstanceID()
  if self.tbGridCtrl[nInstanceId] == nil then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Dorm.DormEditor.TemplateDormFurnitureItem")
  end
  self.tbGridCtrl[nInstanceId]:Refresh(mapItem.nId, mapItem.nCount, 0)
end

function MallFurnitureSetCtrl:OnGridClick(goGrid, nIdx)
  local mapItem = self.tbFurniture[nIdx + 1]
  if mapItem == nil then
    return
  end
  self._mapNode.svList:SetScrollGridPos(nIdx, 0.1, 1)
  EventManager.Hit(EventId.BlockInput, true)
  self:AddTimer(1, 0.1, function()
    EventManager.Hit(EventId.BlockInput, false)
    UTILS.ClickItemGridWithTips(mapItem.nId, goGrid.transform:Find("btnGrid"), false, false, false)
  end, true, true, true)
end

function MallFurnitureSetCtrl:RefreshBuy(mapCfg, mapData)
  local tbCond = decodeJson(mapCfg.OrderCondParams)
  local bPurchaseAble = PlayerData.Shop:CheckShopCond(mapCfg.OrderCondType, tbCond)
  local bAble = bPurchaseAble and mapData.nCurStock > 0
  self._mapNode.btnBuy1.gameObject:SetActive(bAble)
  self._mapNode.btnBuy2.gameObject:SetActive(not bAble)
  if not bPurchaseAble then
    self.sDisableTip = ConfigTable.GetUIText("Shop_Condition")
  elseif mapData.nCurStock == 0 then
    self.sDisableTip = ConfigTable.GetUIText("Shop_GoodsEmpty")
  end
end

function MallFurnitureSetCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self.ani:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function MallFurnitureSetCtrl:PlayOutAni()
  self.ani:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, "Close", true, true, true)
end

function MallFurnitureSetCtrl:Close()
  self.gameObject:SetActive(false)
end

function MallFurnitureSetCtrl:Awake()
  self.ani = self.gameObject.transform:GetComponent("Animator")
  self.tbGridCtrl = {}
  self.tbIcon = {}
  self.tbBannerInitPos = {}
  for _, v in ipairs(self._mapNode.goTitleItem) do
    self.nBannerWidth = v.sizeDelta.x
    table.insert(self.tbBannerInitPos, v.anchoredPosition)
  end
  self.nBannerInterval = ConfigTable.GetConfigNumber("Activity_Banner_Interval_Time")
  self._mapNode.eventDrag:SetStrictDrag(true)
end

function MallFurnitureSetCtrl:OnEnable()
end

function MallFurnitureSetCtrl:OnDisable()
  self:ResetBannerTimer()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function MallFurnitureSetCtrl:OnDestroy()
end

function MallFurnitureSetCtrl:OnBtnClick_Buy()
  local mapCfg = ConfigTable.GetData("MallPackage", self.sId)
  if not mapCfg then
    return
  end
  local nCurrencyType = mapCfg.CurrencyType
  if nCurrencyType == GameEnum.currencyType.Cash then
    PlayerData.Mall:BuyPackage(self.sId, mapCfg.StatisticalGroup)
  else
    local bShowConfirm = false
    if nCurrencyType == GameEnum.currencyType.Item then
      local nHas = 0
      if mapCfg.CurrencyItemId == AllEnum.CoinItemId.FREESTONE or mapCfg.CurrencyItemId == AllEnum.CoinItemId.STONE then
        bShowConfirm = true
        nHas = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.FREESTONE) + PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.STONE)
      else
        nHas = PlayerData.Coin:GetCoinCount(mapCfg.CurrencyItemId)
      end
      if nHas < mapCfg.CurrencyItemQty then
        local function funcOpenBuyGem()
          EventManager.Hit("MallCloseDetail")
          
          EventManager.Hit("OpenMallTog", AllEnum.MallToggle.Gem)
        end
        
        if mapCfg.CurrencyItemId == AllEnum.CoinItemId.FREESTONE or mapCfg.CurrencyItemId == AllEnum.CoinItemId.STONE then
          local msg = {
            nType = AllEnum.MessageBox.Confirm,
            sContent = orderedFormat(ConfigTable.GetUIText("Recruit_Charge") or "", ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE).Id),
            callbackConfirm = funcOpenBuyGem,
            bBlur = false
          }
          EventManager.Hit(EventId.OpenMessageBox, msg)
        elseif mapCfg.CurrencyItemId == AllEnum.CoinItemId.Furniture then
          PlayerData.Coin:ExchangeFurnitureCoin(mapCfg.CurrencyItemQty, funcOpenBuyGem)
        end
        return
      end
    end
    if bShowConfirm then
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = orderedFormat(ConfigTable.GetUIText("Mall_Package_Buy_Confirm") or "", mapCfg.CurrencyItemQty, mapCfg.CurrencyItemId, mapCfg.DetailName),
        callbackConfirm = function()
          PlayerData.Mall:SendMallPackageOrderReq(self.sId)
        end,
        bBlur = false
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
    else
      PlayerData.Mall:SendMallPackageOrderReq(self.sId)
    end
  end
end

function MallFurnitureSetCtrl:OnBtnClick_Disable()
  EventManager.Hit(EventId.OpenMessageBox, self.sDisableTip)
end

function MallFurnitureSetCtrl:OnBtnClick_Close()
  EventManager.Hit("MallCloseDetail")
end

return MallFurnitureSetCtrl
