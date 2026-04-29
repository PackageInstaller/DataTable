require("ui_side_enter_center_content_base")
_class("UICampaignCenterDanTang", UISideEnterCenterContentBase)
UICampaignCenterDanTang = UICampaignCenterDanTang

function UICampaignCenterDanTang:DoInit()
  self:InitWidget()
  self._campaign = self._data
end

function UICampaignCenterDanTang:DoShow()
  if self:CheckShareBtnActive() then
    self:AttachEvent(GameEventType.OnFocusAfterShareBack, self.OnShareResult)
  end
  self:StartTask(function(TT)
    self._campaign:ClearCampaignNew(TT)
  end)
  self._lineCmptId = ECCampaignInlandS1ComponentID.Line_MISSION
  self._lineCpt = self._campaign:GetComponent(self._lineCmptId)
  self._lineCptInfo = self._lineCpt:GetComponentInfo()
  self._timeHolder = UITimerHolder:New()
  local closeTime = self._lineCptInfo.m_close_time
  
  local function countDown()
    local now = GetSvrTimeNow()
    local time = math.ceil(closeTime - now)
    if time <= 0 then
      self._timeHolder:StopTimer("CountDown")
      self._timeString = nil
      local str = StringTable.Get("str_activity_common_less_minute")
      self.remainTime:SetText(StringTable.Get("str_activity_dantang_remain_time", str))
    else
      local timeStr = HelperProxy:GetInstance():FormatTime_3(time)
      if self._timeString ~= timeStr then
        self.remainTime:SetText(StringTable.Get("str_activity_dantang_remain_time", timeStr))
        self._timeString = timeStr
      end
    end
  end
  
  countDown()
  self._timeHolder:StartTimerInfinite("CountDown", 1000, countDown)
  self:_ResetMap()
  if self:_CheckPreRed() then
    self:AttachEvent(GameEventType.DanTangPreAwardCollected, self._CheckPreRed)
  end
  self:SetShareBtnActive()
end

function UICampaignCenterDanTang:DoHide()
  if self._timeHolder then
    self._timeHolder:Dispose()
    self._timeHolder = nil
  end
  self:DetachEvent(GameEventType.OnFocusAfterShareBack, self.OnShareResult)
end

function UICampaignCenterDanTang:DoDestroy()
end

function UICampaignCenterDanTang:InitWidget()
  self.remainTime = self:GetUIComponent("UILocalizedTMP", "remainTime")
  self.title = self:GetUIComponent("RawImageLoader", "title")
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._viewpotSize = self:GetUIComponent("RectTransform", "Viewport").rect.size
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self.preRed = self:GetGameObject("PreRed")
  self.shareRoot = self:GetGameObject("shareRoot")
  self.ShareBtnGo = self:GetGameObject("ShareBtn")
end

function UICampaignCenterDanTang:CheckShareBtnActive()
  self._shareActive = GameGlobal.GetModule(ShareModule):CanShare()
  if not self._shareActive then
    self.ShareBtnGo:SetActive(false)
    return self._shareActive
  end
  local localProcess = self._campaign:GetLocalProcess()
  local storyInfo = localProcess:GetComponentInfo(ECCampaignInlandS1ComponentID.STORY)
  local storyid = self:GetStoryID()
  local dataActive
  if storyInfo.m_recieved_reward_story and table.count(storyInfo.m_recieved_reward_story) > 0 then
    dataActive = not table.icontains(storyInfo.m_recieved_reward_story, storyid)
  else
    dataActive = true
  end
  self._shareActive = dataActive and self._shareActive
  self.ShareBtnGo:SetActive(self._shareActive)
  return self._shareActive
end

function UICampaignCenterDanTang:GetStoryID()
  local com = self._campaign:GetComponent(ECCampaignInlandS1ComponentID.STORY)
  local comcfgid = com:GetComponentCfgId()
  local cfg = Cfg.cfg_component_story[comcfgid]
  if not cfg then
    Log.error("###[UICampaignCenterDanTang] cfg is nil ! id --> ", comcfgid)
    return
  end
  local storyList = cfg.StoryID
  if not storyList or not next(storyList) then
    Log.error("###[UICampaignCenterDanTang] storyList is nil !")
    return
  end
  return storyList[1]
end

function UICampaignCenterDanTang:SetShareBtnActive()
  self.shareRoot:SetActive(self._shareActive)
end

function UICampaignCenterDanTang:DetailBtnOnClick(go)
  self:ShowDialog("UICampaignCenterDanTangIntro")
end

function UICampaignCenterDanTang:_SetContentSize(showMission, unlockInfo)
  local viewHeight = self._viewpotSize.y
  local height = UIActivityLineMissionHelper.CalcContentHeight(self._line_component, showMission, viewHeight)
  self._contentRect.sizeDelta = Vector2(self._contentRect.sizeDelta.x, height)
  local down = math.maxinteger
  for _, cfg in pairs(showMission) do
    if unlockInfo[cfg.CampaignMissionId] then
      down = math.min(down, cfg.MapPosY)
    end
  end
  local y = math.abs(down) - viewHeight / 2
  y = Mathf.Clamp(y, 0, height - viewHeight)
  self._contentRect.anchoredPosition = Vector2(0, y)
end

function UICampaignCenterDanTang:_SetNodeAndLine(levelCount, lineCount, showMission, unlockInfo)
  local nodes = UIWidgetHelper.SpawnObjects(self, "Nodes", "UIDantangLineMissionMapNode", levelCount)
  local lines = UIWidgetHelper.SpawnObjects(self, "Lines", "UIDantangLineMissionMapLine", lineCount)
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    uiNode:SetData(cfg, self._lineCpt:GetComponentInfo().m_pass_mission_info[missionID], unlockInfo[missionID], function(stageId, isStory)
      self:_OnNodeClick(stageId, isStory)
    end)
    nodeIdx = nodeIdx + 1
    if cfg.WayPointType ~= 4 and cfg.NeedMissionId ~= 0 then
      local n1 = showMission[cfg.NeedMissionId]
      local n2 = cfg
      local line = lines[lineIdx]
      line:Flush(Vector2(n2.MapPosX, n2.MapPosY), Vector2(n1.MapPosX, n1.MapPosY))
      lineIdx = lineIdx + 1
    end
  end
end

function UICampaignCenterDanTang:_OnNodeClick(stageId, isStory)
  if not self._lineCpt:ComponentIsOpen() then
    local result = self._campaign:CheckComponentOpenClientError(self._lineCmptId)
    self._campaign:CheckErrorCode(result)
    return
  end
  if isStory then
    UIActivityLineMissionHelper.EnterStage_Story(self._campaign, self._lineCpt, stageId, function()
      self._lineCpt = self._campaign:GetComponent(self._lineCmptId)
      self._lineCptInfo = self._lineCpt:GetComponentInfo()
      self:_ResetMap()
    end)
  else
    UIActivityLineMissionHelper.EnterStage_Battle(self._campaign, self._lineCpt, stageId, false)
  end
end

function UICampaignCenterDanTang:_ResetMap()
  local missionCfgs = UIActivityLineMissionHelper.GetMissionCfgs(self._lineCpt)
  local levelCount, lineCount, showMission = UIActivityLineMissionHelper.GetNodeLineInfoVertical(self._lineCpt, missionCfgs)
  local unlockInfo = UIActivityLineMissionHelper.GetUnlockInfoVertical(self._lineCpt, missionCfgs)
  self:_SetContentSize(showMission, unlockInfo)
  self:_SetNodeAndLine(levelCount, lineCount, showMission, unlockInfo)
  self._allMissionCfgs = missionCfgs
end

function UICampaignCenterDanTang:PreAwardBtnOnClick()
  self:ShowDialog("UICampaignCenterDanTangPreAwards", self._campaign._id)
end

function UICampaignCenterDanTang:VideoButtonOnClick()
  self:ShowDialog("UICriVideoControllerNowrap", "dantang_op", "card_pool_pic_210003_bg")
end

function UICampaignCenterDanTang:_CheckPreRed()
  local module = self:GetModule(CampaignModule)
  local preSample = module:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_INLAND_S0)
  local preRed = false
  if preSample then
    preRed = preSample:GetStepStatus(ECampaignStep.CAMPAIGN_STEP_REWARD)
  end
  self.preRed:SetActive(preRed)
  return preRed
end

function UICampaignCenterDanTang:ShareBtnOnClick(go)
  if self._shareActive then
    Log.debug("###[UICampaignCenterDanTang] 开始分享")
  else
    Log.debug("###[UICampaignCenterDanTang] 已经领奖")
  end
  self:ShowDialog("UICampaignCenterDanTangShare", self._shareActive)
end

function UICampaignCenterDanTang:OnShareResult(RetCode)
  Log.debug("###[UICampaignCenterDanTang] OnShareResult RetCode:", RetCode)
  if not self._shareActive then
    Log.debug("###[UICampaignCenterDanTang] 已经领奖")
    return
  end
  Log.debug("###[UICampaignCenterDanTang] 开始领奖表现")
  local storyid = self:GetStoryID()
  self:FinishStory(storyid)
end

function UICampaignCenterDanTang:FinishStory(id)
  self:Lock("UICampaignCenterDanTang:OnFinishStory")
  GameGlobal.TaskManager():StartTask(self.OnFinishStory, self, id)
end

function UICampaignCenterDanTang:OnFinishStory(TT, storyid)
  local res = AsyncRequestRes:New()
  local localProcess = self._campaign:GetLocalProcess()
  local storyCom = localProcess:GetComponent(ECCampaignInlandS1ComponentID.STORY)
  local rewards = storyCom:HandleStoryTake(TT, res, storyid)
  self:UnLock("UICampaignCenterDanTang:OnFinishStory")
  self._rewards = nil
  if res:GetSucc() then
    Log.error("###[UICampaignCenterDanTang] OnFinishStory succ")
    self:ShowRewards(rewards)
  else
    Log.error("###[UICampaignCenterDanTang] OnFinishStory fail, result:", res:GetResult(), " storyid:", storyid)
  end
end

function UICampaignCenterDanTang:ShowRewards(rewards)
  if not rewards then
    Log.debug("###[UICampaignCenterDanTang] rewards is nil !")
    return
  end
  if self.view == nil then
    return
  end
  self:ShowDialog("UIGetItemController", rewards, function()
    self:CheckShareBtnActive()
    self:SetShareBtnActive()
  end)
  GameGlobal.UIStateManager():CallUIMethod("UIShare", "HideTipsTex")
end
