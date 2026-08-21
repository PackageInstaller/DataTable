_class("UIMainLobbySeasonEntry", UICustomWidget)
UIMainLobbySeasonEntry = UIMainLobbySeasonEntry

function UIMainLobbySeasonEntry:OnShow()
  self._new = self:GetGameObject("new")
  self._red = self:GetGameObject("red")
  self._mainLobbyBG = self:GetUIComponent("RawImageLoader", "BtnView")
  self._mainLobbyTex = self:GetUIComponent("RawImageLoader", "mainLobbyTex")
end

function UIMainLobbySeasonEntry:PlayEnterAnim()
  local anim = self:GetUIComponent("Animation", "UIMainLobbySeasonEntry")
  anim:Play("uieff_UIMainLobbySeasonEntry_in")
end

function UIMainLobbySeasonEntry:OnHide()
end

function UIMainLobbySeasonEntry:SetData()
  self:ShowUI()
  self:CheckOpen()
  self:PlayEnterAnim()
end

function UIMainLobbySeasonEntry:ShowUI()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonid = seasonModule:GetCurSeasonID()
  if 0 < seasonid then
    Log.debug("###[UIMainLobbySeasonEntry] 直接获取到了赛季id：", seasonid)
  else
    Log.debug("###[UIMainLobbySeasonEntry] 没有获取到赛季id，读取配置")
    local cfg_campaings = Cfg.cfg_campaign({
      CampaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON
    })
    local season_cfg
    local loginModule = GameGlobal.GetModule(LoginModule)
    if cfg_campaings and next(cfg_campaings) then
      local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
      for key, value in pairs(cfg_campaings) do
        local openTime = value.BeginTime
        local closeTime = value.EndTime
        local openTimeType = 0
        if value.OpenTimeTransform == 1 then
          openTimeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
        else
          openTimeType = Enum_DateTimeZoneType.E_ZoneType_GMT
        end
        local closeTimeType = 0
        if value.EndTimeTransform == 1 then
          closeTimeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
        else
          closeTimeType = Enum_DateTimeZoneType.E_ZoneType_GMT
        end
        local open = loginModule:GetTimeStampByTimeStr(openTime, openTimeType)
        local close = loginModule:GetTimeStampByTimeStr(closeTime, closeTimeType)
        if svrTime >= open and svrTime < close then
          season_cfg = value
          break
        end
      end
    end
    if season_cfg then
      seasonid = season_cfg.CampaignID
      Log.debug("###[UIMainLobbySeasonEntry] 获取到了赛季的配置，id：", seasonid)
    else
      Log.debug("###[UIMainLobbySeasonEntry] 配置里也没获取到赛季的id，遍历取下一次赛季")
      do
        local sortTab = {}
        for key, value in pairs(cfg_campaings) do
          table.insert(sortTab, value)
        end
        table.sort(sortTab, function(a, b)
          local openTimeType_a = 0
          if a.OpenTimeTransform == 1 then
            openTimeType_a = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
          else
            openTimeType_a = Enum_DateTimeZoneType.E_ZoneType_GMT
          end
          local openTimeType_b = 0
          if b.OpenTimeTransform == 1 then
            openTimeType_b = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
          else
            openTimeType_b = Enum_DateTimeZoneType.E_ZoneType_GMT
          end
          local openTime_a = a.BeginTime
          local open_a = loginModule:GetTimeStampByTimeStr(openTime_a, openTimeType_a)
          local openTime_b = b.BeginTime
          local open_b = loginModule:GetTimeStampByTimeStr(openTime_b, openTimeType_b)
          return open_a < open_b
        end)
        Log.debug("###[UIMainLobbySeasonEntry] 配置排序结束，获取到赛季的配置：", #sortTab)
        local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
        for index, value in ipairs(sortTab) do
          local closeTime = value.EndTime
          local closeTimeType = 0
          if value.EndTimeTransform == 1 then
            closeTimeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
          else
            closeTimeType = Enum_DateTimeZoneType.E_ZoneType_GMT
          end
          local close = loginModule:GetTimeStampByTimeStr(closeTime, closeTimeType)
          if svrTime < close then
            seasonid = value.CampaignID
            Log.debug("###[UIMainLobbySeasonEntry] 排序之后重新获取赛季id：", seasonid)
            break
          end
        end
      end
    end
  end
  if seasonid and 0 < seasonid then
    local cfg_client = Cfg.cfg_season_campaign_client[seasonid]
    local mainBg = cfg_client.MainLobbyBG
    local mainTex = cfg_client.MainLobbyTex
    self._mainLobbyBG:LoadImage(mainBg)
    self._mainLobbyTex:LoadImage(mainTex)
  else
    Log.debug("###[UIMainLobbySeasonEntry] 最后也没获取到赛季id，有bug,暂时处理没有的话就用默认的图")
    local mainBg = "main_zjm_new_di48"
    local mainTex = "main_zjm_new_wenzi7"
    self._mainLobbyBG:LoadImage(mainBg)
    self._mainLobbyTex:LoadImage(mainTex)
  end
end

function UIMainLobbySeasonEntry:BtnOnClick(go)
  GameGlobal.GetModule(RoleModule):OnHomePageEnter(CLICKENTRANCE.CE_SEASON)
  local isLock, isTime, isMission = self:GetLockReason()
  if isLock then
    if isTime then
      local tips = StringTable.Get("str_activity_error_110")
      ToastManager.ShowToast(tips)
    elseif isMission then
      local tips = StringTable.Get("str_function_lock_season_tips")
      ToastManager.ShowToast(tips)
    else
      Log.error("###[UIMainLobbySeasonEntry] season is lock , reason is other ?")
    end
  else
    local screenShot = self.uiOwner._screenShot
    if screenShot then
      UIWidgetHelper.BlurHelperShot(self.uiOwner, "screenShot", self.uiOwner:GetName(), function(cache_rt)
        GameGlobal.GetUIModule(SeasonModule):OpenSeasonThemeUI(cache_rt)
      end)
    else
      GameGlobal.GetUIModule(SeasonModule):OpenSeasonThemeUI()
    end
  end
end

function UIMainLobbySeasonEntry:OnAfterUILayerChanged()
  local topui = GameGlobal.UIStateManager():IsTopUI(self.uiOwner:GetName())
  if topui then
    self:ShowUI()
    self:CheckOpen()
  end
end

function UIMainLobbySeasonEntry:GetLockReason()
  local isTime = false
  local isMission = false
  local lock = false
  Log.debug("###[UIMainLobbySeasonEntry] start check season entry open .")
  local cfg_campaings = Cfg.cfg_campaign({
    CampaignType = ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON
  })
  local season_cfg
  if cfg_campaings and next(cfg_campaings) then
    local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
    for key, value in pairs(cfg_campaings) do
      local loginModule = GameGlobal.GetModule(LoginModule)
      local openTime = value.BeginTime
      local closeTime = value.EndTime
      local openTimeType = 0
      if value.OpenTimeTransform == 1 then
        openTimeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
      else
        openTimeType = Enum_DateTimeZoneType.E_ZoneType_GMT
      end
      local closeTimeType = 0
      if value.EndTimeTransform == 1 then
        closeTimeType = Enum_DateTimeZoneType.E_ZoneType_ServerTimeZone
      else
        closeTimeType = Enum_DateTimeZoneType.E_ZoneType_GMT
      end
      local open = loginModule:GetTimeStampByTimeStr(openTime, openTimeType)
      local close = loginModule:GetTimeStampByTimeStr(closeTime, closeTimeType)
      if svrTime >= open and svrTime < close then
        season_cfg = value
        break
      end
    end
  end
  if season_cfg then
    local missionid = season_cfg.NeedMissionID
    local missionModule = GameGlobal.GetModule(MissionModule)
    local ispass = missionModule:IsPassMissionID(missionid)
    if ispass then
      Log.debug("###[UIMainLobbySeasonEntry] season entry is open !")
    else
      lock = true
      isMission = true
    end
  else
    lock = true
    isTime = true
  end
  return lock, isTime, isMission
end

function UIMainLobbySeasonEntry:CheckOpen()
  local isLock, isTime, isMission = self:GetLockReason()
  local lock = self:GetGameObject("lock")
  lock:SetActive(isLock)
  local new = false
  local red = false
  if not isLock then
    local uimodule = self:GetUIModule(SeasonModule)
    new = uimodule:GetCurrentSeasonNew()
    red = uimodule:GetCurrentSeasonRed()
  end
  self._new:SetActive(new)
  self._red:SetActive(not new and red)
end
