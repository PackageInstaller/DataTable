_class("UICN13PerfectPuzzleRoadPointItem", UICustomWidget)
UICN13PerfectPuzzleRoadPointItem = UICN13PerfectPuzzleRoadPointItem

function UICN13PerfectPuzzleRoadPointItem:OnShow(uiParams)
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self:InitWidget()
end

function UICN13PerfectPuzzleRoadPointItem:InitWidget()
  self.roadPointNameText = self:GetUIComponent("UILocalizationText", "RoadPointNameText")
  self.gameObj = self:GetGameObject("gameObj")
  self.pass = self:GetUIComponent("Image", "Pass")
  self.pass.gameObject:SetActive(false)
  self.bg = self:GetUIComponent("Image", "bg")
  self.timeLockText = self:GetUIComponent("UILocalizationText", "TimeLockText")
  self.lockRoot = self:GetUIComponent("Image", "LockRoot")
  self._centerRect = self:GetUIComponent("RectTransform", "bg")
  self.idImg = self:GetUIComponent("Image", "IdImg")
  self.missionImg = self:GetUIComponent("Image", "MissionImg")
  self._atlas = self:GetAsset("UICN13PerfectPuzzle.spriteatlas", LoadType.SpriteAtlas)
  self.upRoadbj = self:GetGameObject("UpRoad")
  self.upRoadbj:SetActive(false)
  self.downRoadbj = self:GetGameObject("DownRoad")
  self.downRoadbj:SetActive(false)
  self.redPointbj = self:GetGameObject("RedPoint")
  self.redPointbj:SetActive(false)
end

function UICN13PerfectPuzzleRoadPointItem:SetData(cfg, index, component, data)
  self._cfg = cfg
  self._clientCfg = Cfg.cfg_cn13_client_mission[self._cfg.MissionID]
  self._index = index
  self._centerRect.anchoredPosition = Vector2(0, self._index % 2 * 210)
  if self._index % 2 == 0 then
    self.upRoadbj:SetActive(true)
  else
    self.downRoadbj:SetActive(true)
  end
  if self._index == 5 then
    self.upRoadbj:SetActive(false)
    self.downRoadbj:SetActive(false)
  end
  self._component = component
  self._componentInfo = self._component:GetComponentInfo()
  self._campaign = data
  self.roadPointNameText:SetText(StringTable.Get(self._cfg.Name))
  local unlock = self:RefreshUnlock()
  if unlock then
    self.timeLockText.gameObject:SetActive(false)
    self:RefreshComplete()
  else
    self:RefreshTimelock()
    self:RefreshPiecelock()
  end
  self.idImg.sprite = self._atlas:GetSprite("cn13_ptzjm_num0" .. index)
  self.missionImg.sprite = self._atlas:GetSprite("cn13_ptzjm_pt0" .. index)
end

function UICN13PerfectPuzzleRoadPointItem:RefreshComplete()
  local complete = false
  if self._componentInfo.m_pass_mission_info == nil then
    return
  end
  local passInfo = self._componentInfo.m_pass_mission_info[self._cfg.MissionID]
  if passInfo ~= nil then
    complete = true
  end
  if complete then
    self.pass.gameObject:SetActive(true)
    self.redPointbj:SetActive(false)
  else
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
    local timeStr = "PerfectPuzzle_RedCheck" .. day .. self._cfg.MissionID
    if not UIActivityHelper.HasLocalDB(timeStr) then
      self.redPointbj:SetActive(true)
    end
  end
end

function UICN13PerfectPuzzleRoadPointItem:RefreshTimelock()
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local time = GameGlobal.GetModule(LoginModule):GetTimeStampByTimeStr(self._cfg.UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local endTime = time
  if curTime < endTime then
    self.timeLockText.gameObject:SetActive(true)
    self.timeLockText:SetText(StringTable.Get("str_luckland_road_time_locked", UIActivityHelper.GetFormatTimerStr(endTime - curTime)))
  else
    self.timeLockText.gameObject:SetActive(false)
  end
end

function UICN13PerfectPuzzleRoadPointItem:RefreshPiecelock()
  if not self.timeLockText.gameObject.activeSelf and self:CheckPerMissionComplete() then
    self.lockRoot.gameObject:SetActive(false)
    local curTime = self._svrTimeModule:GetServerTime() * 0.001
    local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
    local timeStr = "PerfectPuzzle_RedCheck" .. day .. self._cfg.MissionID
    if not UIActivityHelper.HasLocalDB(timeStr) then
      self.redPointbj:SetActive(true)
    end
  end
end

function UICN13PerfectPuzzleRoadPointItem:RefreshUnlock()
  local unlock = false
  for i = 1, #self._componentInfo.m_unlock_missions do
    local id = self._componentInfo.m_unlock_missions[i]
    if id == self._cfg.MissionID then
      unlock = true
    end
  end
  if unlock then
    self.lockRoot.gameObject:SetActive(false)
    return true
  end
  return false
end

function UICN13PerfectPuzzleRoadPointItem:ClickBtnOnClick(go)
  if not self._campaign:CheckComponentOpen(ECampaignN13CenterComponentID.ECAMPAIGN_N13_CENTER_PERFECT_PUZZLE) then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    return
  end
  if self.timeLockText.gameObject.activeSelf then
    ToastManager.ShowToast(self.timeLockText.text)
    return
  end
  local curTime = self._svrTimeModule:GetServerTime() * 0.001
  local day, hour, min, second = UIActivityHelper.Time2Str(curTime)
  local timeStr = "PerfectPuzzle_RedCheck" .. day .. self._cfg.MissionID
  UIActivityHelper.SetLocalDB(timeStr)
  self.redPointbj:SetActive(false)
  if not self:CheckPerMissionComplete() then
    ToastManager.ShowToast(StringTable.Get("str_cn13_PerfectPuzzle_lock_level_tips_1"))
    return
  end
  self:ShowDialog("UICN13PerfectPuzzleMainGameController", self._cfg.MissionID, self._component, self._cfg, self._campaign)
end

function UICN13PerfectPuzzleRoadPointItem:CheckPerMissionComplete()
  local perId = self._cfg.NeedMissionId
  if perId == nil or perId == 0 then
    return true
  end
  local complete = false
  if self._componentInfo.m_pass_mission_info == nil then
    return false
  end
  local passInfo = self._componentInfo.m_pass_mission_info[perId]
  if passInfo ~= nil then
    complete = true
  end
  return complete
end
