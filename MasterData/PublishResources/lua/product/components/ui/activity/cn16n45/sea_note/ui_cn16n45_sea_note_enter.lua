_class("UICN16N45SeaNoteEnter", UISideEnterCenterContentBase)
UICN16N45SeaNoteEnter = UICN16N45SeaNoteEnter

function UICN16N45SeaNoteEnter:Constructor()
  self._componentState = {}
  self._move = {
    [1] = 0,
    [2] = 0,
    [3] = -260,
    [4] = -640,
    [5] = -1000,
    [6] = -1450,
    [7] = -1800,
    [8] = -2000,
    [9] = -2400,
    [10] = -2800,
    [11] = -3200,
    [12] = -2800,
    [13] = -3000,
    [14] = -2350,
    [15] = -2350,
    [16] = -2350,
    [17] = -2350
  }
end

function UICN16N45SeaNoteEnter:DoInit()
  self._svrTimeModule = self:GetModule(SvrTimeModule)
  self._campaignModule = self:GetModule(CampaignModule)
  self._campaign = self._data
  local sample = self._campaign:GetSample()
  self._activeEndTime = sample.end_time
  local localProcess = self._campaign:GetLocalProcess()
  self._ASheepCom = localProcess:GetComponent(ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP)
  self._ASheeoComInfo = localProcess:GetComponentInfo(ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP)
  self.itemModule = GameGlobal.GetModule(ItemModule)
  self.open_id = GameGlobal.GameLogic():GetOpenId()
end

function UICN16N45SeaNoteEnter:DoShow()
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self:_GetComponents()
  self:_OnValue()
  self:RefreshRed()
  self:_SetTimer()
  self:_PlayAnim()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UICN16N45SeaNoteEnter)
  self:RefreshItemTask()
end

function UICN16N45SeaNoteEnter:RefreshItemTask()
  self.taskId = self:StartTask(function(TT)
    while true do
      local nodes = self._roadPool:GetAllSpawnList()
      for i = 1, #nodes do
        local single = nodes[i]
        single:RefreshTimelock()
      end
      YIELD(TT, 1000)
    end
  end)
end

function UICN16N45SeaNoteEnter:DoHide()
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
  if self._taskUnkLockid then
    GameGlobal.TaskManager():KillTask(self._taskUnkLockid)
    self._taskUnkLockid = nil
  end
end

function UICN16N45SeaNoteEnter:DoDestroy()
  if self._timeEvent then
    GameGlobal.Timer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
  if self.taskId then
    GameGlobal.TaskManager():KillTask(self.taskId)
    self.taskId = nil
  end
  if self._taskUnkLockid then
    GameGlobal.TaskManager():KillTask(self._taskUnkLockid)
    self._taskUnkLockid = nil
  end
  UICN16N45SeaNoteEnter.super:Dispose()
end

function UICN16N45SeaNoteEnter:_GetComponents()
  self._roadPool = self:GetUIComponent("UISelectObjectPath", "RoadPointPool")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._RestTimeText = self:GetUIComponent("UILocalizationText", "RestTimeText")
  self._Red = self:GetGameObject("RedPoint")
  self._Text = self:GetUIComponent("UILocalizationText", "Text")
  self._RoadPointGuide = self:GetGameObject("RoadPointGuide")
  self._RankMissionBtn = self:GetGameObject("RankMissionBtn")
  self._RankMissionNameText = self:GetUIComponent("UILocalizationText", "RankMissionName")
  self._RankLock = self:GetGameObject("RankLock")
  self._RankBtn = self:GetGameObject("RankBtn")
  self.rankMissionBtnAnimation = self:GetUIComponent("Animation", "RankMissionBtn")
end

function UICN16N45SeaNoteEnter:_SortCfg(items)
  table.sort(items, function(a, b)
    return a.ID < b.ID
  end)
  return items
end

function UICN16N45SeaNoteEnter:_OnValue()
  self._passmission = self._ASheeoComInfo.m_info.m_pass_mission_info
  local count = 0
  self.first = false
  local campaignId = self._ASheepCom:GetComponentCfgId()
  local sheepComCfg = Cfg.cfg_campaign_component({ComponentID = campaignId})[1]
  local rankMissionId = sheepComCfg.RankSubKey[1]
  local cfgs = Cfg.cfg_component_asheep_mission({ComponentID = campaignId})
  cfgs = self:_SortCfg(cfgs)
  local missionCount = 0
  for i = 1, #cfgs do
    local cfg = cfgs[i]
    if cfg.Type == 1 then
      missionCount = missionCount + 1
    end
  end
  local allClear = false
  if self._passmission then
    local passCount = table.count(self._passmission)
    if passCount == 0 then
      self.first = true
    end
    count = passCount
    if self._passmission[rankMissionId] ~= nil then
      count = count - 1
    end
    if missionCount >= count + 1 then
      count = count + 1
    else
      allClear = true
    end
  else
    self.first = true
    count = 1
  end
  self._roadPool:SpawnObjects("UICN16N45SeaNoteRoadPointItem", count)
  local nodes = self._roadPool:GetAllSpawnList()
  for i, v in ipairs(nodes) do
    local pass = true
    if self.first or i == count then
      pass = false
    end
    if allClear then
      pass = true
    end
    local index = cfgs[i].ID
    v:SetData(index, pass, self._passmission, function(index)
      self:ShowDetail(index)
    end, cfgs[i], self._campaign)
  end
  if #nodes == 0 then
    return
  end
  if not self.first then
    self._contentRect.anchoredPosition = Vector2(self._move[count], 0)
  else
    self._contentRect.anchoredPosition = Vector2(0, 0)
    self._RoadPointGuide.transform.position = nodes[1]:GetGameObject().transform.position
  end
  local width = 400 * (#nodes + 2)
  if 0 < width then
    if 4750 < width then
      width = 4750
    end
    local delta = self._contentRect.sizeDelta
    delta.x = width
    self._contentRect.sizeDelta = delta
  end
  if table.count(self._passmission) == 0 then
    self._RankLock:SetActive(true)
    self._RankMissionBtn:SetActive(false)
    self._RankBtn:SetActive(false)
    LocalDB.SetInt("UICN16N45SeaNoteEnter:LockRank5", 1)
  else
    self._RankMissionBtn:SetActive(true)
    self._RankBtn:SetActive(true)
    self._RankLock:SetActive(true)
    if LocalDB.GetInt("UICN16N45SeaNoteEnter:LockRank5") == 1 or LocalDB.GetInt("UICN16N45SeaNoteEnter:LockRank5") == 0 then
      LocalDB.SetInt("UICN16N45SeaNoteEnter:LockRank5", 2)
      self._taskUnkLockid = self:StartTask(self.Task_UnLockRank, self)
    elseif self._taskUnkLockid == nil then
      self._RankLock:SetActive(false)
    end
    local lastCfg = cfgs[#cfgs]
    self._RankMissionNameText:SetText(StringTable.Get(lastCfg.MissionName))
  end
end

function UICN16N45SeaNoteEnter:Task_UnLockRank()
  YIELD(TT, 1000)
  while GameGlobal.UIStateManager():IsShow("UIGetItemController") do
    YIELD(TT)
  end
  YIELD(TT, 500)
  self.rankMissionBtnAnimation:Play("uianim_UICN16N45SeaNoteEnter_RankMissionName_unlock")
  YIELD(TT, 500)
  self._taskUnkLockid = nil
end

function UICN16N45SeaNoteEnter:CheckInGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  return guideModule:GuideInProgress()
end

function UICN16N45SeaNoteEnter:ShowDetail(id)
  local ActicityEnd = self:CheckActivityEnd()
  if ActicityEnd then
    self:CheckClose()
    return
  end
  self:Move(id)
  self:ShowDialog("UICN16N45SeaNoteLevelDetail", self._ASheepCom, self._ASheeoComInfo, id, self._passmission, function()
    self:RefreshRoadPoint()
    local ActicityEnd = self:CheckActivityEnd()
    if ActicityEnd then
      self:CheckClose()
      return
    end
  end, function()
    self:RefreshRed()
  end, self._campaign)
end

function UICN16N45SeaNoteEnter:Move(id)
  local moveTime = 1
  id = id - 17
  local x = self._move[id]
  self._contentRect:DOAnchorPosX(x, moveTime)
end

function UICN16N45SeaNoteEnter:AfterUILayerChanged()
end

function UICN16N45SeaNoteEnter:RefreshRoadPoint()
  self:_ForceRefresh()
end

function UICN16N45SeaNoteEnter:_ForceRefresh()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self:_OnValue()
  end, self)
end

function UICN16N45SeaNoteEnter:BookBtnOnClick()
end

function UICN16N45SeaNoteEnter:CheckClose()
  if not self._campaign:CheckComponentOpen(ECampaignN9CenterComponentID.ECAMPAIGN_N9_ASHEEP) then
    if GameGlobal.UIStateManager():IsShow("UICN16N45SeaNoteLevelDetail") then
      GameGlobal.UIStateManager():CloseDialog("UICN16N45SeaNoteLevelDetail")
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityCloseEvent, self._campaign._id)
    ToastManager.ShowToast(StringTable.Get("str_activity_common_notice_content"))
    return true
  end
  return false
end

function UICN16N45SeaNoteEnter:RankMissionBtnOnClick()
  if self._RankLock.activeSelf then
  end
  local ActicityEnd = self:CheckActivityEnd()
  if ActicityEnd then
    self:CheckClose()
    return
  end
  local id = 28
  self:ShowDialog("UICN16N45SeaNoteLevelDetail", self._ASheepCom, self._ASheeoComInfo, id, self._passmission, function()
    self:RefreshRoadPoint()
  end, function()
    self:RefreshRed()
  end, self._campaign)
end

function UICN16N45SeaNoteEnter:RankBtnOnClick()
  local ActicityEnd = self:CheckActivityEnd()
  if ActicityEnd then
    self:CheckClose()
    return
  end
  self:ShowDialog("UICN16N45SeaNoteRankingList", self._campaign)
end

function UICN16N45SeaNoteEnter:ActivityTipsbtnOnClick()
  local ActicityEnd = self:CheckActivityEnd()
  if ActicityEnd then
    self:CheckClose()
    return
  end
  local key = "UICN16N45SeaNoteIntro"
  self:ShowDialog("UIIntroLoader", key)
end

function UICN16N45SeaNoteEnter:_SetTimer()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer()
  end)
end

function UICN16N45SeaNoteEnter:_SetRemainingTimer()
  local remaintime = 0
  local curtime = math.floor(self._svrTimeModule:GetServerTime() * 0.001)
  local sample = self._campaign:GetSample()
  if sample == nil then
    self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
    self._RestTimeText:SetText("")
    self._Text:SetText(StringTable.Get("str_activity_finished"))
    return true
  end
  local endtime = sample.end_time
  remaintime = endtime - curtime
  local pre_remaining = ""
  if remaintime < 0 then
    self._RestTimeText.gameObject:SetActive(false)
  else
    self:_SetRemainTime(remaintime)
  end
  if remaintime <= 0 then
    self._timeEvent = UIActivityHelper.CancelTimerEvent(self._timeEvent)
    self._RestTimeText:SetText("")
    self._Text:SetText(StringTable.Get("str_activity_finished"))
    return true
  end
end

function UICN16N45SeaNoteEnter:_SetRemainTime(remaintime)
  self._RestTimeText:SetText(self:_GetRemainTime(remaintime))
end

function UICN16N45SeaNoteEnter:_GetRemainTime(time)
  local day, hour, minute
  day = math.floor(time / 86400)
  hour = math.floor(time / 3600) % 24
  minute = math.floor(time / 60) % 60
  local timestring = ""
  if 0 < day then
    timestring = day .. StringTable.Get("str_activity_common_day") .. hour .. StringTable.Get("str_activity_common_hour")
  elseif 0 < hour then
    timestring = hour .. StringTable.Get("str_activity_common_hour") .. minute .. StringTable.Get("str_activity_common_minute")
  elseif 0 < minute then
    timestring = minute .. StringTable.Get("str_activity_common_minute")
  else
    timestring = StringTable.Get("str_activity_common_less_minute")
  end
  return string.format(StringTable.Get("str_activity_common_over"), timestring)
end

function UICN16N45SeaNoteEnter:RefreshRed()
  local status = self:CheckRed()
  self._Red:SetActive(status)
end

function UICN16N45SeaNoteEnter:CheckRed()
  local keyStr = "UICN16N45SeaNoteEnter_ItemCount" .. self.open_id
  local HaveCount = self:_GetHaveCount()
  local LastCount = LocalDB.GetInt(keyStr, 0)
  if LastCount == HaveCount then
    return false
  end
  return true
end

function UICN16N45SeaNoteEnter:_GetHaveCount()
  local cfg = Cfg.cfg_south_sea_antique({})
  local HaveCount = 0
  for i, v in ipairs(cfg) do
    local have = self:_CheckHave(v.ItemID)
    if have then
      HaveCount = HaveCount + 1
    end
  end
  return HaveCount
end

function UICN16N45SeaNoteEnter:_CheckHave(ItemID)
  local count = self.itemModule:GetItemCount(ItemID)
  if not count or count == 0 then
    return false
  else
    return true
  end
end

function UICN16N45SeaNoteEnter:CheckActivityEnd()
  local sample = self._campaign:GetSample()
  if sample == nil then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return true
  end
  return false
end

function UICN16N45SeaNoteEnter:_PlayAnim()
  self._Anim = self:GetUIComponent("Animation", "Anim")
  local LockName = "UICN16N45SeaNoteEnter_AnimIN"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._Anim:Play("uianim_UIActivitySouthSeaCN9MainController_in")
    YIELD(TT, 500)
    self:UnLock(LockName)
  end)
end
