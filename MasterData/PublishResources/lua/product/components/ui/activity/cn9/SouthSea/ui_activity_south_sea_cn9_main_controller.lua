_class("UIActivitySouthSeaCN9MainController", UISideEnterCenterContentBase)
UIActivitySouthSeaCN9MainController = UIActivitySouthSeaCN9MainController

function UIActivitySouthSeaCN9MainController:Constructor()
  self._componentState = {}
  self._move = {
    [1] = -600,
    [2] = -900,
    [3] = -1300,
    [4] = -1700,
    [5] = -2000,
    [6] = -2350
  }
end

function UIActivitySouthSeaCN9MainController:DoInit()
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

function UIActivitySouthSeaCN9MainController:DoShow()
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self:_GetComponents()
  self:_OnValue()
  self:RefreshRed()
  self:_SetTimer()
  self:_PlayAnim()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIActivitySouthSeaCN9MainController)
end

function UIActivitySouthSeaCN9MainController:DoHide()
end

function UIActivitySouthSeaCN9MainController:DoDestroy()
  if self._timeEvent then
    GameGlobal.Timer():CancelEvent(self._timeEvent)
    self._timeEvent = nil
  end
  UIActivitySouthSeaCN9MainController.super:Dispose()
end

function UIActivitySouthSeaCN9MainController:_GetComponents()
  self._roadPool = self:GetUIComponent("UISelectObjectPath", "RoadPointPool")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._RestTimeText = self:GetUIComponent("UILocalizationText", "RestTimeText")
  self._Red = self:GetGameObject("RedPoint")
  self._Text = self:GetUIComponent("UILocalizationText", "Text")
  self._RoadPointGuide = self:GetGameObject("RoadPointGuide")
end

function UIActivitySouthSeaCN9MainController:_OnValue()
  self._passmission = self._ASheeoComInfo.m_info.m_pass_mission_info
  local count = 0
  self.first = false
  if self._passmission then
    local passCount = table.count(self._passmission)
    if passCount == 0 then
      self.first = true
    end
    if passCount + 1 <= 6 then
      count = passCount + 1
    else
      count = passCount
    end
  else
    self.first = true
    count = 1
  end
  self._roadPool:SpawnObjects("UICN9RoadPointItem", count)
  local nodes = self._roadPool:GetAllSpawnList()
  for i, v in ipairs(nodes) do
    local pass = true
    if self.first or i == count then
      pass = false
    end
    v:SetData(i, pass, self._passmission, function(id)
      self:ShowDetail(id)
    end)
  end
  if not self.first then
    self._contentRect.anchoredPosition = Vector2(self._move[count], 0)
  else
    self._contentRect.anchoredPosition = Vector2(0, 0)
    self._RoadPointGuide.transform.position = nodes[1]:GetGameObject().transform.position
  end
end

function UIActivitySouthSeaCN9MainController:CheckInGuide()
  local guideModule = GameGlobal.GetModule(GuideModule)
  return guideModule:GuideInProgress()
end

function UIActivitySouthSeaCN9MainController:ShowDetail(id)
  local ActicityEnd = self:CheckActivityEnd()
  if ActicityEnd then
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:Move(id)
  self:ShowDialog("UIActivityCN9LevelDetail", self._ASheepCom, self._ASheeoComInfo, id, self._passmission, function()
    self:RefreshRoadPoint()
  end, function()
    self:RefreshRed()
  end)
end

function UIActivitySouthSeaCN9MainController:Move(id)
  local moveTime = 1
  local x = self._move[id]
  self._contentRect:DOAnchorPosX(x, moveTime)
end

function UIActivitySouthSeaCN9MainController:AfterUILayerChanged()
end

function UIActivitySouthSeaCN9MainController:RefreshRoadPoint()
  self:_ForceRefresh()
end

function UIActivitySouthSeaCN9MainController:_ForceRefresh()
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    res:SetSucc(true)
    self._campaign:ReLoadCampaignInfo_Force(TT, res)
    self:_OnValue()
  end, self)
end

function UIActivitySouthSeaCN9MainController:BookBtnOnClick()
  local ActicityEnd = self:CheckActivityEnd()
  if ActicityEnd then
    self:SwitchState(UIStateType.UIMain)
    return
  end
  self:ShowDialog("UIActivityCN9BookMain")
  local keyStr = "UIActivitySouthSeaCN9MainController_ItemCount" .. self.open_id
  local HaveCount = self:_GetHaveCount()
  LocalDB.SetInt(keyStr, HaveCount)
  self:RefreshRed()
end

function UIActivitySouthSeaCN9MainController:ActivityTipsbtnOnClick()
  local key = "UICN9SouthSeaIntro"
  self:ShowDialog("UIIntroLoader", key)
end

function UIActivitySouthSeaCN9MainController:_SetTimer()
  self._timeEvent = UIActivityHelper.StartTimerEvent(self._timeEvent, function()
    return self:_SetRemainingTimer()
  end)
end

function UIActivitySouthSeaCN9MainController:_SetRemainingTimer()
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

function UIActivitySouthSeaCN9MainController:_SetRemainTime(remaintime)
  self._RestTimeText:SetText(self:_GetRemainTime(remaintime))
end

function UIActivitySouthSeaCN9MainController:_GetRemainTime(time)
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

function UIActivitySouthSeaCN9MainController:RefreshRed()
  local status = self:CheckRed()
  self._Red:SetActive(status)
end

function UIActivitySouthSeaCN9MainController:CheckRed()
  local keyStr = "UIActivitySouthSeaCN9MainController_ItemCount" .. self.open_id
  local HaveCount = self:_GetHaveCount()
  local LastCount = LocalDB.GetInt(keyStr, 0)
  if LastCount == HaveCount then
    return false
  end
  return true
end

function UIActivitySouthSeaCN9MainController:_GetHaveCount()
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

function UIActivitySouthSeaCN9MainController:_CheckHave(ItemID)
  local count = self.itemModule:GetItemCount(ItemID)
  if not count or count == 0 then
    return false
  else
    return true
  end
end

function UIActivitySouthSeaCN9MainController:CheckActivityEnd()
  local sample = self._campaign:GetSample()
  if sample == nil then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    return true
  end
  return false
end

function UIActivitySouthSeaCN9MainController:_PlayAnim()
  self._Anim = self:GetUIComponent("Animation", "Anim")
  local LockName = "UIActivitySouthSeaCN9MainController_AnimIN"
  self:StartTask(function(TT)
    self:Lock(LockName)
    self._Anim:Play("uianim_UIActivitySouthSeaCN9MainController_in")
    YIELD(TT, 500)
    self:UnLock(LockName)
  end)
end
