require("ui_side_enter_item_campaign")
_class("UIS1SeasonEnter", UISideEnterItem_Campaign)
UIS1SeasonEnter = UIS1SeasonEnter

function UIS1SeasonEnter:Constructor()
  self._timeOpen = false
  self._missionOpen = false
end

function UIS1SeasonEnter:_LoadCampaign(TT)
  UISideEnterItem_Campaign._LoadCampaign(self, TT)
  self:CompleteCampaign()
end

function UIS1SeasonEnter:_CheckOpen(TT)
  self._timeOpen = self:_BtnCheckFunc(TT)
  UISideEnterItem_Campaign._CheckOpen(self, TT)
  return self._timeOpen
end

function UIS1SeasonEnter:DoShow()
  UISideEnterItem_Campaign.DoShow(self)
  self._missionOpen = self:IsMissionOpen()
  self._uiLocked = self:GetUIComponent("RectTransform", "locked")
  self._uiLocked.gameObject:SetActive(not self._missionOpen)
  self:_CheckPoint()
end

function UIS1SeasonEnter:CompleteCampaign()
  if not self._timeOpen then
    return
  elseif self._campaign._type == -1 then
    local cfgSeason = Cfg.cfg_campaign[self._campaign._id]
    self._campaign._type = cfgSeason.CampaignType
  elseif self._campaign._id == -1 then
    local loginModule = GameGlobal.GetModule(LoginModule)
    local svrTime = GameGlobal.GetModule(SvrTimeModule):GetServerTime() * 0.001
    local allSeason = Cfg.cfg_campaign({
      CampaignType = self._campaign._type
    })
    local cfgSeason
    for k, v in pairs(allSeason) do
      local openTime = v.BeginTime
      local closeTime = v.EndTime
      local open = loginModule:GetTimeStampByTimeStr(openTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      local close = loginModule:GetTimeStampByTimeStr(closeTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      if svrTime >= open and svrTime < close then
        cfgSeason = v
        break
      end
    end
    if cfgSeason ~= nil then
      self._campaign._id = cfgSeason.CampaignID
    else
      Log.exception("cfg_campaign 与 cfg_main_side_enter_btn 赛季时间配置不匹配 CampaignType --> ", self._campaign._type)
    end
  end
end

function UIS1SeasonEnter:IsMissionOpen()
  if self._timeOpen then
    local cfgSeason = Cfg.cfg_campaign[self._campaign._id]
    local missionid = cfgSeason.NeedMissionID
    local missionModule = GameGlobal.GetModule(MissionModule)
    local ispass = missionModule:IsPassMissionID(missionid)
    return ispass
  end
  return false
end

function UIS1SeasonEnter:_CalcNew()
  if not self._timeOpen then
    return false
  end
  if not self._missionOpen then
    return false
  end
  local uimodule = self:GetUIModule(SeasonModule)
  local isNew = uimodule:GetCurrentSeasonNew()
  return isNew
end

function UIS1SeasonEnter:_CalcRed()
  if not self._timeOpen then
    return false
  end
  if not self._missionOpen then
    return false
  end
  local uimodule = self:GetUIModule(SeasonModule)
  local isRed = uimodule:GetCurrentSeasonRed()
  return isRed
end

function UIS1SeasonEnter:BtnOnClick(go)
  local tips
  if not self._timeOpen then
    tips = StringTable.Get("str_activity_error_110")
  elseif not self._missionOpen then
    tips = StringTable.Get("str_function_lock_season_tips")
  end
  if tips ~= nil then
    ToastManager.ShowToast(tips)
  else
    self._timeOpen = GameGlobal.GetModule(SeasonModule):GetCurSeasonID() ~= -1
    if self._timeOpen then
      GameGlobal.GetModule(SeasonModule):UIModule():OpenSeasonThemeUI()
    else
      self._setShowCallback(false)
      ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    end
  end
end
