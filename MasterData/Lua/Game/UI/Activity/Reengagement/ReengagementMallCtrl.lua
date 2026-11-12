local ReengagementMallCtrl = class("ReengagementMallCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local SDKManager = CS.SDKManager.Instance
ReengagementMallCtrl._mapNodeConfig = {
  txtReMallEndTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_Mall_EndTip"
  },
  txtLabelValue = {sComponentName = "TMP_Text"},
  txtRemainDay = {sComponentName = "TMP_Text"},
  txtWeeklyCardName = {sComponentName = "TMP_Text"},
  txtWeeklyCardDesc = {sComponentName = "TMP_Text"},
  txtGetNow = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_GetNow"
  },
  txtGetDaily = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_GetDaily"
  },
  btnBuyWeeklyCard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BuyWeeklyCard"
  },
  txtBtnBuy = {sComponentName = "TMP_Text"},
  txtBtnReceiveWeeklyCard = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive_Btn_Text"
  },
  txtAlreadyReceived = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharPlot_Task_Received"
  },
  btnReceiveWeeklyCard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveWeeklyCard"
  },
  btnAlreadyReceived = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AlreadyReceived"
  },
  MallItem = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnMallItem = {nCount = 3, sComponentName = "UIButton"},
  txtBannerTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Reengagement_Mall_BannerTitle"
  },
  goActivityBanner = {},
  goActBannerList = {
    sComponentName = "RectTransform"
  },
  btnActBanner = {
    sNodeName = "goActBannerList",
    sComponentName = "UIButton",
    callback = "OnBtnClick_btnActBanner"
  },
  eventActBannerDrag = {
    sNodeName = "goActBannerList",
    sComponentName = "UIDrag",
    callback = "OnDrag_ActBanner"
  },
  activityBannerItem = {
    nCount = 3,
    sComponentName = "RectTransform"
  },
  imgActBanner = {nCount = 3, sComponentName = "Image"},
  goBannerDot = {
    sComponentName = "RectTransform"
  },
  imgPointBg = {nCount = 10},
  PkgItem = {
    nCount = 3,
    sCtrlName = "Game.UI.Activity.Reengagement.ReengagementMallPackageItemCtrl"
  }
}
ReengagementMallCtrl._mapEventConfig = {
  MallOrderClear = "OnEvent_MallOrderClear",
  RefreshReengagementWeeklyCard = "OnEvent_RefreshReengagementWeeklyCard"
}

function ReengagementMallCtrl:OnEnable()
  self.tbPackagePage = {}
  self.tbBannerInitPos = {}
  for _, v in ipairs(self._mapNode.activityBannerItem) do
    self.nBannerWidth = v.sizeDelta.x
    table.insert(self.tbBannerInitPos, v.anchoredPosition)
  end
  self.nBannerInterval = ConfigTable.GetConfigNumber("Activity_Banner_Interval_Time")
end

function ReengagementMallCtrl:OnDisable()
  self._mapNode.btnMallItem[1].onClick:RemoveAllListeners()
  self._mapNode.btnMallItem[2].onClick:RemoveAllListeners()
  self._mapNode.btnMallItem[3].onClick:RemoveAllListeners()
  self:ResetTimer()
end

function ReengagementMallCtrl:Refresh(nCurTog)
  if nCurTog ~= AllEnum.ReengagementTog.ShopMall then
    return
  end
  self:SetBanner()
  self:RefreshWeeklyCard()
  self:RefreshPkgItem()
end

function ReengagementMallCtrl:RefreshWeeklyCard()
  local mapWeeklyCard = PlayerData.Reengagement:GetWeeklyCardData()
  local nActId = PlayerData.Reengagement:GetActId()
  local bHasWeeklyCard = mapWeeklyCard.Id ~= nil and mapWeeklyCard.Id ~= ""
  
  local function foreach(mapData)
    if mapData ~= nil and mapData.ReturneeId == nActId then
      self.mapCurWeeklyCard = mapData
    end
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityReturneeCard"), foreach)
  local sCanBuy = ConfigTable.GetUIText("Mall_Package_LimitTitle") .. ":1/1"
  local sOut = ConfigTable.GetUIText("Mall_Package_SoldOut")
  local bDisabled = mapWeeklyCard.Received or mapWeeklyCard.Remaining <= 0
  NovaAPI.SetTMPText(self._mapNode.txtLabelValue, bHasWeeklyCard and sOut or sCanBuy)
  NovaAPI.SetTMPText(self._mapNode.txtWeeklyCardDesc, self.mapCurWeeklyCard.Desc)
  NovaAPI.SetTMPText(self._mapNode.txtWeeklyCardName, self.mapCurWeeklyCard.Name)
  self._mapNode.btnReceiveWeeklyCard.gameObject:SetActive(not bDisabled and bHasWeeklyCard)
  self._mapNode.btnAlreadyReceived.gameObject:SetActive(bDisabled and bHasWeeklyCard)
  self._mapNode.btnBuyWeeklyCard.gameObject:SetActive(not bHasWeeklyCard)
  NovaAPI.SetTMPText(self._mapNode.txtBtnBuy, self.mapCurWeeklyCard.ShowPrice)
  if bHasWeeklyCard then
    local sRemain = orderedFormat(ConfigTable.GetUIText("Mall_MonthlyCard_RemainDay") or "", mapWeeklyCard.Remaining)
    local sReceived = ""
    if mapWeeklyCard.Received then
      sReceived = ConfigTable.GetUIText("Mall_MonthlyCard_Received")
    else
      sReceived = ConfigTable.GetUIText("Mall_MonthlyCard_Unreceived")
    end
    local sToday = "<color=#08D3D4>" .. sReceived .. "</color>"
    if mapWeeklyCard.Remaining > 0 then
      sRemain = sRemain .. " " .. sToday
    end
    NovaAPI.SetTMPText(self._mapNode.txtRemainDay, sRemain)
  end
  self._mapNode.txtRemainDay.gameObject:SetActive(bHasWeeklyCard)
  self._mapNode.MallItem[1]:SetItem(self.mapCurWeeklyCard.BaseItemId, nil, self.mapCurWeeklyCard.BaseItemQty)
  self._mapNode.MallItem[2]:SetItem(self.mapCurWeeklyCard.DailyItemId1, nil, self.mapCurWeeklyCard.DailyItemQty1)
  self._mapNode.MallItem[3]:SetItem(self.mapCurWeeklyCard.DailyItemId2, nil, self.mapCurWeeklyCard.DailyItemQty2)
  self._mapNode.btnMallItem[1].onClick:RemoveAllListeners()
  self._mapNode.btnMallItem[2].onClick:RemoveAllListeners()
  self._mapNode.btnMallItem[3].onClick:RemoveAllListeners()
  self._mapNode.btnMallItem[1].onClick:AddListener(function()
    UTILS.ClickItemGridWithTips(self.mapCurWeeklyCard.BaseItemId, self._mapNode.btnMallItem[1].transform, true, true, false)
  end)
  self._mapNode.btnMallItem[2].onClick:AddListener(function()
    UTILS.ClickItemGridWithTips(self.mapCurWeeklyCard.DailyItemId1, self._mapNode.btnMallItem[2].transform, true, true, false)
  end)
  self._mapNode.btnMallItem[3].onClick:AddListener(function()
    UTILS.ClickItemGridWithTips(self.mapCurWeeklyCard.DailyItemId2, self._mapNode.btnMallItem[3].transform, true, true, false)
  end)
end

function ReengagementMallCtrl:RefreshPkgItem()
  local nActId = PlayerData.Reengagement:GetActId()
  self.tbPackagePage = {}
  
  local function foreach(mapData)
    if mapData ~= nil and mapData.ReturneeId == nActId then
      table.insert(self.tbPackagePage, mapData)
    end
  end
  
  ForEachTableLine(ConfigTable.Get("ActivityReturneePack"), foreach)
  table.sort(self.tbPackagePage, function(a, b)
    return a.Sort < b.Sort
  end)
  local tbPurchasedBundles = PlayerData.Reengagement:GetPurchasedBundles()
  for i = 1, 3 do
    local mapData = self.tbPackagePage[i]
    if mapData ~= nil then
      local bPurchased = table.indexof(tbPurchasedBundles, mapData.Id) > 0
      self._mapNode.PkgItem[i].gameObject:SetActive(true)
      self._mapNode.PkgItem[i]:RefreshReengagement(mapData, bPurchased)
    else
      self._mapNode.PkgItem[i].gameObject:SetActive(false)
    end
  end
end

function ReengagementMallCtrl:SetBanner()
  self.bannerRefreshTimer = nil
  self.tbBannerList = {}
  self:AddGachaBanner()
  if nil == self.tbBannerList or nil == next(self.tbBannerList) then
    self._mapNode.goActivityBanner.gameObject:SetActive(false)
  else
    self._mapNode.goActivityBanner:SetActive(true)
    for _, v in ipairs(self._mapNode.imgPointBg) do
      v.gameObject:SetActive(false)
    end
    for k, v in pairs(self.tbBannerList) do
      if nil ~= self._mapNode.imgPointBg[k] then
        self._mapNode.imgPointBg[k]:SetActive(true)
        self._mapNode.imgPointBg[k].transform:Find("imgPoint").gameObject:SetActive(false)
      end
    end
    self.nActBannerIdx = 1
    self.nLastActBannerIdx = 1
    self:RefreshActivityBanner()
  end
  self:StartActBannerTimer()
  self._mapNode.eventActBannerDrag.enabled = #self.tbBannerList > 1
end

function ReengagementMallCtrl:AddGachaBanner()
  local tbOpenedPool = PlayerData.Gacha:GetOpenedPool()
  
  local function comp(a, b)
    local mapGachaA = ConfigTable.GetData("Gacha", a)
    local mapGachaB = ConfigTable.GetData("Gacha", b)
    return mapGachaA.Sort < mapGachaB.Sort
  end
  
  table.sort(tbOpenedPool, comp)
  for _, nPoolId in ipairs(tbOpenedPool) do
    local mapPoolCfgData = ConfigTable.GetData("Gacha", nPoolId)
    if mapPoolCfgData ~= nil and mapPoolCfgData.BannerRes ~= nil and mapPoolCfgData.BannerRes ~= "" then
      table.insert(self.tbBannerList, {
        nId = nPoolId,
        nType = GameEnum.bannerType.Gacha,
        sBanner = mapPoolCfgData.BannerRes,
        nJumpTo = nPoolId,
        nFuncType = GameEnum.OpenFuncType.Gacha
      })
    end
  end
end

function ReengagementMallCtrl:RefreshActivityBanner()
  local lastIndex = self.nActBannerIdx - 1 <= 0 and #self.tbBannerList or self.nActBannerIdx - 1
  local nextIndex = self.nActBannerIdx + 1 > #self.tbBannerList and 1 or self.nActBannerIdx + 1
  local tbCurBannerList = {}
  table.insert(tbCurBannerList, self.tbBannerList[lastIndex])
  table.insert(tbCurBannerList, self.tbBannerList[self.nActBannerIdx])
  table.insert(tbCurBannerList, self.tbBannerList[nextIndex])
  for k, v in ipairs(self._mapNode.imgActBanner) do
    local bannerData = tbCurBannerList[k]
    if bannerData ~= nil then
      if bannerData.nType == GameEnum.bannerType.Activity then
        if nil ~= bannerData.actData then
          self:SetPngSprite(v, "Icon/Banner/" .. bannerData.actData:GetBannerPng())
        end
      else
        self:SetPngSprite(v, "Icon/Banner/" .. bannerData.sBanner)
      end
    end
  end
  self._mapNode.imgPointBg[self.nLastActBannerIdx].transform:Find("imgPoint").gameObject:SetActive(false)
  self.nLastActBannerIdx = self.nActBannerIdx
  self._mapNode.imgPointBg[self.nActBannerIdx].transform:Find("imgPoint").gameObject:SetActive(true)
end

function ReengagementMallCtrl:StartActBannerTimer()
  if nil == self.actBannerTimer and #self.tbBannerList > 1 then
    self.actBannerTimer = self:AddTimer(0, self.nBannerInterval, "PlayActBannerAnim", true, true, false)
  end
end

function ReengagementMallCtrl:ResetActBannerTimer()
  if nil ~= self.actBannerTimer then
    self.actBannerTimer:Cancel(false)
  end
  self.actBannerTimer = nil
end

function ReengagementMallCtrl:PlayActBannerAnim()
  local function onCompleteCb()
    self:BannerTweenerEnd()
  end
  
  for k, v in ipairs(self._mapNode.activityBannerItem) do
    if k == #self._mapNode.activityBannerItem then
      v:DOAnchorPosX(self.tbBannerInitPos[k].x - self.nBannerWidth, 0.5):SetUpdate(true):OnComplete(onCompleteCb)
    else
      v:DOAnchorPosX(self.tbBannerInitPos[k].x - self.nBannerWidth, 0.5):SetUpdate(true)
    end
  end
end

function ReengagementMallCtrl:BannerTweenerEnd()
  for k, v in ipairs(self._mapNode.activityBannerItem) do
    v.anchoredPosition = self.tbBannerInitPos[k]
  end
  self.nActBannerIdx = self.nActBannerIdx + 1
  if self.nActBannerIdx > #self.tbBannerList then
    self.nActBannerIdx = 1
  end
  self:RefreshActivityBanner()
end

function ReengagementMallCtrl:OnBtnClick_btnActBanner()
  local bannerData = self.tbBannerList[self.nActBannerIdx]
  if bannerData.nType == GameEnum.bannerType.Activity then
    local function openCallback()
      if nil ~= bannerData.actData then
        PlayerData.Activity:OpenActivityPanel(bannerData.actData:GetActId())
      end
    end
    
    PlayerData.Base:CheckFunctionBtn(bannerData.nFuncType, openCallback)
  elseif bannerData.nType == GameEnum.bannerType.OpenFunc or bannerData.nType == GameEnum.bannerType.TimeLimit_Func then
    local function openCallback()
      JumpUtil.JumpTo(bannerData.nJumpTo)
    end
    
    PlayerData.Base:CheckFunctionBtn(bannerData.nFuncType, openCallback)
  elseif bannerData.nType == GameEnum.bannerType.Gacha then
    local function openCallback()
      local function getInfoCallback()
        local function func()
          EventManager.Hit(EventId.OpenPanel, PanelId.GachaSpin, bannerData.nJumpTo)
        end
        
        EventManager.Hit(EventId.SetTransition, 6, func, AllEnum.MainViewCorner.Recruit)
      end
      
      PlayerData.Gacha:GetGachaInfomation(getInfoCallback)
    end
    
    PlayerData.Base:CheckFunctionBtn(bannerData.nFuncType, openCallback)
  elseif bannerData.nType == GameEnum.bannerType.Community then
    local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
    local channelName = CS.ClientConfig.ClientPublishChannelName
    if SDKManager:IsSDKInit() and clientPublishRegion == CS.ClientPublishRegion.CN and (channelName == "Official" or channelName == "TEST_1" or channelName == "Taptap") then
      local hasUrl, url = UTILS.GetBBSUrl()
      if hasUrl then
        local bbsTitle = ConfigTable.GetUIText("BBSTitle")
        SDKManager:ShowBBS(false, bbsTitle, url, "CN-BBS", false, 2)
      else
        printLog(NovaAPI.GetClientChannel() .. "——平台取不到地址")
      end
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  elseif bannerData.nType == GameEnum.bannerType.Payment then
    local clientPublishRegion = CS.ClientConfig.ClientPublishRegion
    local channelName = CS.ClientConfig.ClientPublishChannelName
    if SDKManager:IsSDKInit() and clientPublishRegion == CS.ClientPublishRegion.CN and (channelName == "Official" or channelName == "TEST_1" or channelName == "Taptap" or channelName == "TEST_2") then
      SDKManager:ShowWebView(false, "", "https://payment.yostar.cn/", 1, 1, false, "CN-PAYMENT")
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  elseif bannerData.nType == GameEnum.bannerType.Mall then
    local nJumpId = tonumber(bannerData.sParam)
    JumpUtil.JumpTo(nJumpId)
  elseif bannerData.nType == GameEnum.bannerType.MallSkin then
    local sMallPackageId = bannerData.sParam
    local mapCfg = ConfigTable.GetData("MallPackage", sMallPackageId)
    if mapCfg == nil then
      return
    end
    
    local function callback(tbList, nTime)
      local bInMall = false
      for _, v in ipairs(tbList) do
        if v.sId == sMallPackageId then
          bInMall = true
          break
        end
      end
      if not bInMall then
        return
      end
      local tbMallList = {}
      table.insert(tbMallList, {sId = sMallPackageId})
      
      local function func()
        EventManager.Hit(EventId.OpenPanel, PanelId.MallSkinPreview, tbMallList)
      end
      
      EventManager.Hit(EventId.SetTransition, 5, func)
    end
    
    PlayerData.Mall:SendMallPackageListReq(callback)
  elseif bannerData.nType == GameEnum.bannerType.JumpToUrl then
    local sUrl = bannerData.sUrl
    local bInside = bannerData.bInside
    local bUseOpenUrl = bannerData.bUseOpenUrl
    if bUseOpenUrl then
      NovaAPI.OpenURL(sUrl)
    elseif SDKManager:IsSDKInit() then
      if bInside then
        SDKManager:ShowWebView(false, "", sUrl, 1, 0, true)
      else
        SDKManager:ShowWebView(false, "", sUrl, 1, 1, true)
      end
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Function_NotAvailable"))
    end
  elseif bannerData.nType == GameEnum.bannerType.SeaPayment then
    local sUrl = bannerData.sUrl
    local bInside = bannerData.bInside
    local sPid = bannerData.sPid
    if SDKManager:IsSDKInit() then
      if bInside then
        SDKManager:ShowWebView(false, "", sUrl, 1, 0, false, sPid)
      else
        SDKManager:ShowWebView(false, "", sUrl, 1, 1, false, sPid)
      end
    end
  end
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tab, {
    "banner_type",
    tostring(bannerData.nType)
  })
  table.insert(tab, {
    "banner_id",
    tostring(bannerData.nId)
  })
  NovaAPI.UserEventUpload("scrolling_banner_click", tab)
end

function ReengagementMallCtrl:OnDrag_ActBanner(mDrag)
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nBannerDragPosX = 0
    self:ResetActBannerTimer()
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    self.nBannerDragPosX = self.nBannerDragPosX + mDrag.EventData.delta.x
    for k, v in ipairs(self._mapNode.activityBannerItem) do
      v.anchoredPosition = Vector2(self.tbBannerInitPos[k].x + self.nBannerDragPosX, self.tbBannerInitPos[k].y)
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    local nPos = 0
    if self.nBannerDragPosX > 0 then
      nPos = self.nBannerWidth
      self.nActBannerIdx = 0 >= self.nActBannerIdx - 1 and #self.tbBannerList or self.nActBannerIdx - 1
    elseif self.nBannerDragPosX < 0 then
      nPos = -self.nBannerWidth
      self.nActBannerIdx = self.nActBannerIdx + 1 > #self.tbBannerList and 1 or self.nActBannerIdx + 1
    end
    local tweener
    for k, v in ipairs(self._mapNode.activityBannerItem) do
      tweener = v:DOAnchorPosX(self.tbBannerInitPos[k].x + nPos, 0.5):SetUpdate(true)
    end
    
    local function _cb()
      for k, v in ipairs(self._mapNode.activityBannerItem) do
        v.anchoredPosition = self.tbBannerInitPos[k]
      end
      self:RefreshActivityBanner()
      self:StartActBannerTimer()
    end
    
    tweener.onComplete = dotween_callback_handler(self, _cb)
    self.nBannerDragPosX = 0
  end
end

function ReengagementMallCtrl:ResetTimer()
  if self.actBannerTimer ~= nil then
    self.actBannerTimer:Cancel(false)
    self.actBannerTimer = nil
  end
  if self.actBannerRefreshTimer ~= nil then
    self.actBannerRefreshTimer:Cancel(false)
    self.actBannerRefreshTimer = nil
  end
  if self.bannerRefreshTimer ~= nil then
    self.bannerRefreshTimer:Cancel(false)
    self.bannerRefreshTimer = nil
  end
end

function ReengagementMallCtrl:OnBtnClick_BuyWeeklyCard()
  PlayerData.Reengagement:BuyWeeklyCard(self.mapCurWeeklyCard.Id, self.mapCurWeeklyCard.StatisticalGroup)
end

function ReengagementMallCtrl:OnBtnClick_ReceiveWeeklyCard()
  PlayerData.Reengagement:RequestReceiveWeeklyCard()
end

function ReengagementMallCtrl:OnEvent_RefreshReengagementWeeklyCard()
  self:RefreshWeeklyCard()
end

function ReengagementMallCtrl:OnBtnClick_AlreadyReceived()
end

function ReengagementMallCtrl:OnEvent_MallOrderClear()
  PlayerData.Reengagement:RequestReengagementInfo(function()
    self:RefreshWeeklyCard()
    self:RefreshPkgItem()
  end)
end

return ReengagementMallCtrl
