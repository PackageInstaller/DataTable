_class("UIMainLobbyScroll", UICustomWidget)
UIMainLobbyScroll = UIMainLobbyScroll
local UIMainCarourselType = {
  None = 0,
  Mission = 1,
  ExtMission = 2,
  DrawCardNewPool = 3,
  Activity = 4,
  Gift = 5,
  TempSignIn = 6,
  Skin = 7,
  Campaign = 8
}
_enum("UIMainCarourselType", UIMainCarourselType)

function UIMainLobbyScroll:OnShow()
  self._roleModule = GameGlobal.GetModule(RoleModule)
  self._missionModule = GameGlobal.GetModule(MissionModule)
  self._shopModule = GameGlobal.GetModule(ShopModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self.OnAfterUILayerChanged)
end

function UIMainLobbyScroll:OnHide()
  if self._scrollEvent then
    GameGlobal.Timer():CancelEvent(self._scrollEvent)
    self._scrollEvent = nil
  end
  if self._spRequest ~= nil then
    self._spRequest:Dispose()
    self._spRequest = nil
  end
end

function UIMainLobbyScroll:SetData(inited)
  return true
end

function UIMainLobbyScroll:InitScrollView()
  self._isDarging = false
  self._currIdx = 1
  self:_CreateScrollData()
  self:_CreateScrollItem()
  self:_CreateScrollEvent()
  self._grid = self:GetUIComponent("UISelectObjectPath", "grid")
  self._grid:SpawnObjects("UIMainLobbyScrollIdx", self._count)
  self._idxItems = self._grid:GetAllSpawnList()
  for i = 1, #self._idxItems do
    self._idxItems[i]:SetData(i, self._currIdx)
  end
  self._inited = true
end

function UIMainLobbyScroll:OnAfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self.uiOwner:GetName())
  if topui then
    self:InitScrollView()
    if self._spRequest ~= nil then
      self._spRequest:Request()
    end
  end
end

function UIMainLobbyScroll:_CreateScrollData()
  self._cfg_main_carousel = {}
  self._carouselTab = {}
  local tmp_cfg_main_carousel = {}
  local max = Cfg.cfg_global.MainBannerMaxCount.IntValue or 6
  local cfg_main_c_all = Cfg.cfg_main_caroursel({})
  local t_cfg_main_c_all = {}
  for key, value in pairs(cfg_main_c_all) do
    table.insert(t_cfg_main_c_all, value)
  end
  table.sort(t_cfg_main_c_all, function(a, b)
    return a.Order < b.Order
  end)
  if EngineGameHelper.EnableAppleVerifyBulletin() then
    table.insert(self._cfg_main_carousel, Cfg.cfg_main_caroursel[101])
  else
    for i = 1, table.count(t_cfg_main_c_all) do
      local info = t_cfg_main_c_all[i]
      if not info.Minimum then
        local closeTime = info.CloseTime
        if info.IsResident then
          closeTime = HelperProxy:GetInstance():ResidentTimeString()
        end
        if self:_CheckMainCarourseEventIsOpen(info.ModuleID, info.OpenType, info.OpenParam, info.OpenTime, closeTime, info.PrivateZoneID, info.ID) then
          table.insert(tmp_cfg_main_carousel, info)
        end
      end
    end
  end
  local insertCount
  if max > #tmp_cfg_main_carousel then
    insertCount = #tmp_cfg_main_carousel
  else
    insertCount = max
  end
  for i = 1, insertCount do
    local data = tmp_cfg_main_carousel[i]
    table.insert(self._cfg_main_carousel, data)
  end
  local count = table.count(self._cfg_main_carousel)
  if count == 0 then
    Log.debug("###[UIMainLobbyController] _cfg_main_carousel count == 0 ! minimum start !")
    local minimumCfg = Cfg.cfg_main_caroursel({Minimum = 1})
    if minimumCfg and table.count(minimumCfg) > 0 then
      table.insert(self._cfg_main_carousel, minimumCfg[1])
    end
  end
  count = table.count(self._cfg_main_carousel)
  if count == 0 then
    Log.error("###mainlobby cfg_main_caroursel count == 0")
  end
  self._count = count
  local cfg_item_left = {}
  cfg_item_left.idx = 1
  cfg_item_left.data = self._cfg_main_carousel[self._count]
  table.insert(self._carouselTab, cfg_item_left)
  for i = 1, self._count do
    local cfg_item_middle = {}
    cfg_item_middle.idx = i + 1
    cfg_item_middle.data = self._cfg_main_carousel[i]
    table.insert(self._carouselTab, cfg_item_middle)
  end
  local cfg_item_right = {}
  cfg_item_right.idx = self._count + 1
  cfg_item_right.data = self._cfg_main_carousel[1]
  table.insert(self._carouselTab, cfg_item_right)
end

function UIMainLobbyScroll:_CheckMainCarourseEventIsOpen(ModuleID, OpenType, OpenParam, OpenTime, CloseTime, PrivateZoneID, ID)
  if PrivateZoneID and next(PrivateZoneID) then
    local have = false
    for i = 1, #PrivateZoneID do
      if PrivateZoneID[i] == self._roleModule:GetZoneIdType() then
        have = true
      end
    end
    if not have then
      return false
    end
  end
  if ModuleID ~= nil then
    if ModuleID == GameModuleID.MD_QuestGrowth then
      local questModule = self:GetModule(QuestModule)
      return questModule:IsGrowthVisible()
    else
      local state = self._roleModule:CheckModuleUnlock(ModuleID)
      if not state then
        return false
      end
    end
  end
  if OpenType ~= nil then
    if OpenType == UIMainCarourselType.Mission then
      local pass = self._missionModule:IsPassMissionID(OpenParam[1])
      if not pass then
        return false
      end
    elseif OpenType == UIMainCarourselType.DrawCardNewPool then
      local poolid = OpenParam[1]
      local gambleModule = self:GetModule(GambleModule)
      local pools = gambleModule:GetPrizePools()
      local have = false
      for i = 1, #pools do
        local pool = pools[i]
        if pool.prize_pool_id == poolid then
          have = true
          break
        end
      end
      if not have then
        return false
      end
    elseif OpenType == UIMainCarourselType.Activity then
      local id = OpenParam[1]
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      local sample = campaignModule.m_campaign_manager:GetSampleByID(id)
      if not sample then
        return false
      end
    elseif OpenType == UIMainCarourselType.Gift then
      local ids = OpenParam
      local giftInfo, giftCfg = self._shopModule:GetGiftMarketData()
      local giftList = giftInfo.goods
      local have = false
      for i = 1, #ids do
        local id = ids[i]
        for _, v in pairs(giftList) do
          if v.gift_id == id then
            local id_giftCfg = giftCfg[id]
            if id_giftCfg and id_giftCfg[ConfigKey.ConfigKey_SaleNum] then
              local maxTimes = tonumber(id_giftCfg[ConfigKey.ConfigKey_SaleNum])
              if maxTimes > v.selled_num then
                have = true
                break
              end
            end
          end
        end
        if have == true then
          break
        end
      end
      if have == false then
        return false
      end
    elseif OpenType == UIMainCarourselType.TempSignIn then
      return false
    elseif OpenType == UIMainCarourselType.Skin then
      if not OpenParam then
        goto lbl_242
      end
      local ids = OpenParam
      local skinsInfo, skinsCfg = self._shopModule:GetSkinsMarketData()
      local skinsList = skinsInfo
      local svrTime = self._svrTimeModule:GetServerTime() / 1000
      local have = false
      for i = 1, #ids do
        local id = ids[i]
        for _, v in pairs(skinsList) do
          if v.goodid == id and svrTime < v.endtime then
            have = true
            break
          end
        end
        if have == true then
          break
        end
      end
      if have == false then
        return false
      end
    elseif OpenType == UIMainCarourselType.Campaign and OpenParam then
      local campaignType = OpenParam[1]
      local campaignStep = OpenParam[2]
      if campaignStep == ECampaignStep.CAMPAIGN_STEP_HIDE then
        local c_module = GameGlobal.GetModule(CampaignModule)
        local mainSample = c_module:GetSampleByType(campaignType)
        if not mainSample then
          return false
        end
        local svrTime = self._svrTimeModule:GetServerTime() * 0.001
        if not mainSample:IsShow(svrTime) then
          return false
        end
        local hide = mainSample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_HIDE)
        if hide then
          return false
        end
      else
      end
    end
  end
  ::lbl_242::
  if OpenTime ~= nil and CloseTime ~= nil then
    local open = self._loginModule:GetTimeStampByTimeStr(OpenTime)
    local close = self._loginModule:GetTimeStampByTimeStr(CloseTime)
    local svrTime = self._svrTimeModule:GetServerTime() / 1000
    if open > svrTime or close < svrTime then
      return false
    end
  end
  return true
end

function UIMainLobbyScroll:_CreateScrollItem()
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._scroll = self:GetGameObject("scroll")
  local scrollRect = self:GetUIComponent("RectTransform", "scroll")
  self._width = scrollRect.sizeDelta.x
  self._targetPosX = self._currIdx * self._width * -1
  if self._spRequest ~= nil then
    self._spRequest:Dispose()
    self._spRequest = nil
  end
  self._spRequest = MainLobbyShopPriceRequest:New()
  local itemPool = self:GetUIComponent("UISelectObjectPath", "Content")
  itemPool:ClearWidgets()
  itemPool:SpawnObjects("UIMainLobbyScrollItem", #self._carouselTab)
  local items = itemPool:GetAllSpawnList()
  for i = 1, #self._carouselTab do
    items[i]:SetData(self._carouselTab[i], function(idx)
      GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_SCROLL)
      GameGlobal.UAReportForceGuideEvent("UIMainClick", {
        "Click_Advertising_" .. idx
      }, true)
      local jumpType = self._carouselTab[idx].data.JumpType
      local jumpParam = self._carouselTab[idx].data.JumpParam
      if jumpType then
        local jumpModule = self:GetUIModule(QuestModule)
        jumpModule:SetJumpUIData(jumpType, jumpParam)
        jumpModule:Jump()
      end
    end, function(eventData)
      if self._count <= 1 then
        return
      end
      self._bDragPosX = eventData.position.x
      self._isDarging = true
      if self._scrollEvent then
        GameGlobal.Timer():CancelEvent(self._scrollEvent)
        self._scrollEvent = nil
      end
      self._tmpContentPosX = self._content.anchoredPosition.x
    end, function(eventData)
      if self._count <= 1 then
        return
      end
      local t_x = eventData.delta.x
      self._content.anchoredPosition = Vector2(self._content.anchoredPosition.x + t_x, 0)
      if self._content.anchoredPosition.x > self._width * -0.5 then
        self._content.anchoredPosition = Vector2(self._content.anchoredPosition.x - self._count * self._width, 0)
      end
      if self._content.anchoredPosition.x <= -(self._count * self._width + self._width * 0.5) then
        self._content.anchoredPosition = Vector2(self._content.anchoredPosition.x + self._count * self._width, 0)
      end
    end, function(eventData)
      if self._count <= 1 then
        return
      end
      local posx = math.abs(self._content.anchoredPosition.x)
      local c, d = math.modf(posx / self._width)
      local tmpIdx = self._currIdx
      self._eDragPosX = eventData.position.x
      if self._eDragPosX < self._bDragPosX then
        if 0.1 < d then
          tmpIdx = c + 1
        else
          tmpIdx = c
        end
      elseif d < 0.9 then
        tmpIdx = c
      else
        tmpIdx = c + 1
      end
      if tmpIdx > self._count then
        self._currIdx = tmpIdx % self._count
      elseif tmpIdx <= 0 then
        self._currIdx = self._count
      else
        self._currIdx = tmpIdx
      end
      for i = 1, #self._idxItems do
        self._idxItems[i]:Flush(self._currIdx)
      end
      self._targetPosX = self:_CalcPosX(tmpIdx)
      self._isDarging = false
      self:_CreateScrollEvent()
    end)
    items[i]:BookPrice(self._spRequest)
  end
end

function UIMainLobbyScroll:_CreateScrollEvent()
  local deltaTime = 5000
  local dir = 1
  if self._scrollEvent then
    GameGlobal.Timer():CancelEvent(self._scrollEvent)
    self._scrollEvent = nil
  end
  if 1 < self._count then
    self._scrollEvent = GameGlobal.Timer():AddEventTimes(deltaTime, TimerTriggerCount.Infinite, function()
      if not self._isDarging then
        local idx = self._currIdx
        if dir == 1 then
          idx = self._currIdx + 1
        else
          idx = self._currIdx - 1
        end
        if idx < 1 then
          idx = self._count
        elseif idx > self._count then
          idx = 1
        end
        self._currIdx = idx
        for i = 1, #self._idxItems do
          self._idxItems[i]:Flush(self._currIdx)
        end
        self._targetPosX = self:_CalcPosX(self._currIdx)
      end
    end)
  end
end

function UIMainLobbyScroll:_CalcPosX(idx)
  local posx = 0
  if not idx or self._count <= 1 then
    return posx
  end
  posx = idx * self._width
  return -posx
end

function UIMainLobbyScroll:OnUpdate(dms)
  if not self._inited then
    return
  end
  if self._count <= 1 then
    return
  end
  if not self._isDarging then
    if 1 < math.abs(math.abs(self._content.anchoredPosition.x) - math.abs(self._targetPosX)) then
      self._content.anchoredPosition = Vector2(Mathf.Lerp(self._content.anchoredPosition.x, self._targetPosX, 0.5), 0)
      if self._content.anchoredPosition.x > self._width * -0.5 then
        self._content.anchoredPosition = Vector2(self._content.anchoredPosition.x - self._count * self._width, 0)
        self._targetPosX = self._targetPosX - self._count * self._width
      end
      if self._content.anchoredPosition.x <= -(self._count * self._width + self._width * 0.5) then
        self._content.anchoredPosition = Vector2(self._content.anchoredPosition.x + self._count * self._width, 0)
        self._targetPosX = self._targetPosX + self._count * self._width
      end
    else
      self._content.anchoredPosition = Vector2(self._targetPosX, self._content.anchoredPosition.y)
    end
  end
end
