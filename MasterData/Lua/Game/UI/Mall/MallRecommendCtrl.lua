local MallRecommendCtrl = class("MallRecommendCtrl", BaseCtrl)
local TimerManager = require("GameCore.Timer.TimerManager")
local nBannerInterval = 5
MallRecommendCtrl._mapNodeConfig = {
  goBanner = {},
  goBannerList = {
    sComponentName = "RectTransform"
  },
  btnBanner = {
    sNodeName = "goBannerList",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Banner"
  },
  eventActBannerDrag = {
    sNodeName = "goBannerList",
    sComponentName = "UIDrag",
    callback = "OnDrag_Banner"
  },
  BannerItem = {
    nCount = 3,
    sComponentName = "RectTransform"
  },
  imgBanner = {nCount = 3, sComponentName = "Image"},
  goBannerDot = {
    sComponentName = "RectTransform"
  },
  imgPointBg = {nCount = 10},
  bannerTimeout = {nCount = 3},
  Recommend = {
    nCount = 5,
    sCtrlName = "Game.UI.Mall.MallRecommendItemCtrl"
  }
}
MallRecommendCtrl._mapEventConfig = {MallOrderClear = "Refresh"}

function MallRecommendCtrl:Refresh()
  if self._panel.nCurTog ~= AllEnum.MallToggle.Recommend then
    return
  end
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  self.nNextRefreshTime = 0
  EventManager.Hit("MallCloseDetail")
  local canvasGroup = self.gameObject:GetComponent("CanvasGroup")
  self:SetBanner()
  for i = 1, 5 do
    local RecommendCtrl = self._mapNode.Recommend[i]
    RecommendCtrl:Refresh(nil, nil)
  end
  if canvasGroup ~= nil then
    NovaAPI.SetCanvasGroupAlpha(canvasGroup, 0)
  end
  
  local function callback(tbList, nTime)
    self:RefreshRecommend(tbList)
    self:SetNextRefreshTime(nTime)
    self:SetTimer()
    if canvasGroup ~= nil then
      NovaAPI.SetCanvasGroupAlpha(canvasGroup, 1)
    end
  end
  
  PlayerData.Mall:SendMallPackageListReq(callback)
end

function MallRecommendCtrl:SetBanner()
  self.tbBannerList = {}
  self:AddBanner()
  if nil == self.tbBannerList or nil == next(self.tbBannerList) then
    self._mapNode.goBanner.gameObject:SetActive(false)
  else
    self._mapNode.goBanner:SetActive(true)
    for _, v in ipairs(self._mapNode.imgPointBg) do
      v.gameObject:SetActive(false)
    end
    for k, v in ipairs(self.tbBannerList) do
      if nil ~= self._mapNode.imgPointBg[k] then
        self._mapNode.imgPointBg[k]:SetActive(true)
        self._mapNode.imgPointBg[k].transform:Find("imgPoint").gameObject:SetActive(false)
      end
    end
    self.nBannerIdx = 1
    self.nLastBannerIdx = 1
    self:RefreshBanner()
  end
  self:StartBannerTimer()
  self._mapNode.eventActBannerDrag.enabled = #self.tbBannerList > 1
end

function MallRecommendCtrl:AddBanner()
  local function forEachMap(mapData)
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    
    if mapData.ItemType == GameEnum.MallAdvRecommendItemType.BattlePass then
      local id = tonumber(mapData.ItemId)
      local bpConfig = ConfigTable.GetData("BattlePass", id)
      if bpConfig == nil then
        return
      end
      local nStartTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(bpConfig.StartTime)
      local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(bpConfig.EndTime)
      if nCurTime > nStartTime then
        self:SetNextRefreshTime(nStartTime - nCurTime)
      end
      if nCurTime < nStartTime or nCurTime >= nEndTime then
        return
      end
      self:SetNextRefreshTime(nEndTime - nCurTime)
      table.insert(self.tbBannerList, {
        nId = mapData.Id,
        nType = GameEnum.MallAdvRecommendItemType.BattlePass,
        sBanner = mapData.Path,
        nItemId = mapData.ItemId,
        nStartTime = nStartTime,
        nEndTime = nEndTime
      })
    elseif mapData.ItemType == GameEnum.MallAdvRecommendItemType.Package or mapData.ItemType == GameEnum.MallAdvRecommendItemType.Skin then
      local packageConfig = ConfigTable.GetData("MallPackage", mapData.ItemId)
      if packageConfig == nil then
        return
      end
      if packageConfig.ListTime == "" then
        return
      end
      local nStartTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(packageConfig.ListTime)
      local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(packageConfig.DeListTime)
      if nCurTime > nStartTime then
        self:SetNextRefreshTime(nStartTime - nCurTime)
      end
      if nCurTime < nStartTime or nCurTime >= nEndTime then
        return
      end
      self:SetNextRefreshTime(nEndTime - nCurTime)
      table.insert(self.tbBannerList, {
        nId = mapData.Id,
        nType = mapData.ItemType,
        sBanner = mapData.Path,
        nItemId = mapData.ItemId,
        nStartTime = nStartTime,
        nEndTime = nEndTime
      })
    else
      table.insert(self.tbBannerList, {
        nId = mapData.Id,
        nType = mapData.ItemType,
        sBanner = mapData.Path,
        nItemId = mapData.ItemId,
        nStartTime = nil,
        nEndTime = nil
      })
    end
  end
  
  ForEachTableLine(DataTable.MallAdvRecommend, forEachMap)
  for _, v in ipairs(self.tbBannerList) do
    local nStartTime = v.nStartTime
    local nEndTime = v.nEndTime
    if nStartTime ~= nil and nEndTime ~= nil then
      v.nStartTime = nStartTime
      v.nEndTime = nEndTime
    end
  end
  table.sort(self.tbBannerList, function(a, b)
    local configA = ConfigTable.GetData("MallAdvRecommend", a.nId)
    local configB = ConfigTable.GetData("MallAdvRecommend", b.nId)
    if configA.Sort ~= configB.Sort then
      return configA.Sort < configB.Sort
    end
  end)
end

function MallRecommendCtrl:SetNextRefreshTime(nTime)
  if nTime < 0 then
    return
  end
  if self.nNextRefreshTime == 0 then
    self.nNextRefreshTime = nTime
  else
    self.nNextRefreshTime = math.min(self.nNextRefreshTime, nTime)
  end
  self.nNextRefreshTime = math.max(self.nNextRefreshTime, 0)
end

function MallRecommendCtrl:RefreshBanner()
  local lastIndex = self.nBannerIdx - 1 <= 0 and #self.tbBannerList or self.nBannerIdx - 1
  local nextIndex = self.nBannerIdx + 1 > #self.tbBannerList and 1 or self.nBannerIdx + 1
  local tbCurBannerList = {}
  table.insert(tbCurBannerList, self.tbBannerList[lastIndex])
  table.insert(tbCurBannerList, self.tbBannerList[self.nBannerIdx])
  table.insert(tbCurBannerList, self.tbBannerList[nextIndex])
  for k, v in ipairs(self._mapNode.imgBanner) do
    local bannerData = tbCurBannerList[k]
    self:SetPngSprite(v, bannerData.sBanner)
    local timeOut = self._mapNode.bannerTimeout[k]
    if bannerData.nEndTime ~= nil then
      timeOut:SetActive(true)
      local txt_Timeout = timeOut.transform:Find("txt_Timeout"):GetComponent("TMP_Text")
      NovaAPI.SetTMPText(txt_Timeout, self:GetTimeText(bannerData.nEndTime - CS.ClientManager.Instance.serverTimeStamp))
    else
      timeOut:SetActive(false)
    end
  end
  self._mapNode.imgPointBg[self.nLastBannerIdx].transform:Find("imgPoint").gameObject:SetActive(false)
  self.nLastBannerIdx = self.nBannerIdx
  self._mapNode.imgPointBg[self.nBannerIdx].transform:Find("imgPoint").gameObject:SetActive(true)
end

function MallRecommendCtrl:StartBannerTimer()
  if #self.tbBannerList > 1 then
    if nil ~= self.bannerTimer then
      self.bannerTimer:Cancel()
      self.bannerTimer = nil
    end
    self.bannerTimer = self:AddTimer(0, nBannerInterval, "PlayActBannerAnim", true, true, false)
  end
end

function MallRecommendCtrl:PlayActBannerAnim()
  local function onCompleteCb()
    self:BannerTweenerEnd()
  end
  
  for k, v in ipairs(self._mapNode.BannerItem) do
    if k == #self._mapNode.BannerItem then
      v:DOAnchorPosX(self.tbBannerInitPos[k].x - self.nBannerWidth, 0.5):SetUpdate(true):OnComplete(onCompleteCb)
    else
      v:DOAnchorPosX(self.tbBannerInitPos[k].x - self.nBannerWidth, 0.5):SetUpdate(true)
    end
  end
end

function MallRecommendCtrl:BannerTweenerEnd()
  for k, v in ipairs(self._mapNode.BannerItem) do
    v.anchoredPosition = self.tbBannerInitPos[k]
  end
  self.nBannerIdx = self.nBannerIdx + 1
  if self.nBannerIdx > #self.tbBannerList then
    self.nBannerIdx = 1
  end
  self:RefreshBanner()
end

function MallRecommendCtrl:ResetBannerTimer()
  if nil ~= self.BannerTimer then
    TimerManager.Remove(self.BannerTimer, false)
  end
  self.BannerTimer = nil
end

function MallRecommendCtrl:SetTimer()
  if self.timer ~= nil then
    self.timer:Cancel(false)
    self.timer = nil
  end
  if self.nNextRefreshTime > 0 then
    self.timer = self:AddTimer(1, self.nNextRefreshTime, function()
      self:Refresh()
    end, true, true, false)
  else
  end
end

function MallRecommendCtrl:RefreshRecommend(tbList)
  self.tbRecommendConfig = {}
  local tempMapBySort = {}
  local nCurTime = CS.ClientManager.Instance.serverTimeStamp
  ForEachTableLine(DataTable.MallRecommendGroup, function(mapData)
    if mapData.StartTime == "" or mapData.EndTime == "" then
      return
    end
    local nStartTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapData.StartTime)
    local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(mapData.EndTime)
    if nStartTime > nCurTime or nEndTime < nCurTime then
      return
    end
    local sortValue = mapData.Sort
    if tempMapBySort[sortValue] == nil or mapData.Id > tempMapBySort[sortValue].Id then
      tempMapBySort[sortValue] = mapData
      self:SetNextRefreshTime(nEndTime - nCurTime)
    end
  end)
  for _, mapData in pairs(tempMapBySort) do
    table.insert(self.tbRecommendConfig, mapData)
  end
  table.sort(self.tbRecommendConfig, function(a, b)
    return a.Sort < b.Sort
  end)
  self.tbRecommendPackageId = {}
  local tbRemoveGroupIndex = {}
  for i, v in ipairs(self.tbRecommendConfig) do
    if #v.PackageList > 0 then
      local sPackageId = ""
      for _, packageId in ipairs(v.PackageList) do
        if self:CheckPackageShow(packageId, tbList) then
          sPackageId = packageId
          break
        end
      end
      table.insert(self.tbRecommendPackageId, sPackageId)
    else
      table.insert(self.tbRecommendPackageId, "")
    end
  end
  for i = 1, 5 do
    local RecommendCtrl = self._mapNode.Recommend[i]
    if i <= #self.tbRecommendConfig then
      RecommendCtrl:Refresh(self.tbRecommendConfig[i], self.tbRecommendPackageId[i])
    else
      RecommendCtrl:Refresh(nil, nil)
    end
  end
end

function MallRecommendCtrl:CheckPackageShow(packageId, tbPackageList)
  local packageConfig = ConfigTable.GetData("MallPackage", packageId)
  if packageConfig == nil then
    return false
  end
  if packageConfig.ListCondType == GameEnum.shopCond.WorldClassSpecific then
    local worldClass = PlayerData.Base:GetWorldClass()
    local condParams = decodeJson(packageConfig.ListCondParams)
    if worldClass < tonumber(condParams[1]) then
      return false
    end
  elseif packageConfig.ListTime ~= "" then
    local nCurTime = CS.ClientManager.Instance.serverTimeStamp
    local nStartTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(packageConfig.ListTime)
    local nEndTime = CS.ClientManager.Instance:ISO8601StrToTimeStamp(packageConfig.DeListTime)
    if nCurTime < nStartTime or nCurTime > nEndTime then
      return false
    end
  end
  local bInlist = false
  for _, packageData in ipairs(tbPackageList) do
    if packageId == packageData.sId then
      bInlist = true
      if packageData.nCurStock <= 0 then
        return false
      end
    end
  end
  if not bInlist then
    return false
  end
  return true
end

function MallRecommendCtrl:GetTimeText(remainTime)
  local sTimeStr = ""
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Mall_Remain_Time_Sec") or "", sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Mall_Remain_Time_Min") or "", min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Mall_Remain_Time_Hour") or "", hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("Mall_Remain_Time_Day") or "", day, hour)
  end
  sTimeStr = sTimeStr .. ConfigTable.GetUIText("Mall_Package_Delist") or ""
  return sTimeStr
end

function MallRecommendCtrl:OnDrag_Banner(mDrag)
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nBannerDragPosX = 0
    self:ResetBannerTimer()
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    self.nBannerDragPosX = self.nBannerDragPosX + mDrag.EventData.delta.x
    for k, v in ipairs(self._mapNode.BannerItem) do
      v.anchoredPosition = Vector2(self.tbBannerInitPos[k].x + self.nBannerDragPosX, self.tbBannerInitPos[k].y)
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    local nPos = 0
    if self.nBannerDragPosX > 0 then
      nPos = self.nBannerWidth
      self.nBannerIdx = 0 >= self.nBannerIdx - 1 and #self.tbBannerList or self.nBannerIdx - 1
    elseif self.nBannerDragPosX < 0 then
      nPos = -self.nBannerWidth
      self.nBannerIdx = self.nBannerIdx + 1 > #self.tbBannerList and 1 or self.nBannerIdx + 1
    end
    local tweener
    for k, v in ipairs(self._mapNode.BannerItem) do
      tweener = v:DOAnchorPosX(self.tbBannerInitPos[k].x + nPos, 0.5):SetUpdate(true)
    end
    
    local function _cb()
      for k, v in ipairs(self._mapNode.BannerItem) do
        v.anchoredPosition = self.tbBannerInitPos[k]
      end
      self:RefreshBanner()
      self:StartBannerTimer()
    end
    
    tweener.onComplete = dotween_callback_handler(self, _cb)
    self.nBannerDragPosX = 0
  end
end

function MallRecommendCtrl:OnBtnClick_Banner()
  local bannerData = self.tbBannerList[self.nBannerIdx]
  if bannerData.nType == GameEnum.MallAdvRecommendItemType.BattlePass then
    local function callback()
      local function GetDataCallback(mapData)
        if mapData.nSeasonId == 0 then
          EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Mainview_BattlePassExpireHint"))
        else
          EventManager.Hit(EventId.OpenPanel, PanelId.BattlePass)
        end
      end
      
      PlayerData.BattlePass:GetBattlePassInfo(GetDataCallback)
    end
    
    PlayerData.Base:CheckFunctionBtn(GameEnum.OpenFuncType.BattlePass, callback)
  elseif bannerData.nType == GameEnum.MallAdvRecommendItemType.MonthlyCard then
    EventManager.Hit("OpenMallTog", AllEnum.MallToggle.MonthlyCard)
  elseif bannerData.nType == GameEnum.MallAdvRecommendItemType.Package then
    local nItemId = bannerData.nItemId
    local mapData = ConfigTable.GetData("MallPackage", nItemId)
    if mapData == nil then
      return
    end
    self._panel.nDefaultId = mapData.GroupId
    EventManager.Hit("OpenMallTog", AllEnum.MallToggle.Package)
  elseif bannerData.nType == GameEnum.MallAdvRecommendItemType.Skin then
    EventManager.Hit("OpenMallTog", AllEnum.MallToggle.Skin)
  elseif bannerData.nType == GameEnum.MallAdvRecommendItemType.Furniture then
    EventManager.Hit("OpenMallTog", AllEnum.MallToggle.Furniture)
  end
end

function MallRecommendCtrl:Awake()
  self.nNextRefreshTime = 0
  self.tbBannerInitPos = {}
  for _, v in ipairs(self._mapNode.BannerItem) do
    self.nBannerWidth = v.sizeDelta.x
    table.insert(self.tbBannerInitPos, v.anchoredPosition)
  end
end

function MallRecommendCtrl:OnEnable()
end

function MallRecommendCtrl:OnDisable()
end

function MallRecommendCtrl:OnDestroy()
end

return MallRecommendCtrl
