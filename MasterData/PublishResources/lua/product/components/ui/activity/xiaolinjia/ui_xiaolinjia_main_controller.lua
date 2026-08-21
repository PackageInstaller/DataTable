_class("UIXiaoLinJiaMainController", UIController)
UIXiaoLinJiaMainController = UIXiaoLinJiaMainController

function UIXiaoLinJiaMainController:Constructor()
end

function UIXiaoLinJiaMainController:LoadDataOnEnter(TT, res, uiParams)
  local campaignModule = GameGlobal.GetModule(CampaignModule)
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, ECampaignType.CAMPAIGN_TYPE_INLAND_N7, ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST, ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST)
  self._localProcess = self._campaign:GetLocalProcess()
  if not self._localProcess then
    return
  end
  if res and not res:GetSucc() then
    campaignModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
  self._testComponent = self._localProcess:GetComponent(ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST)
  self._testComponentInfo = self._localProcess:GetComponentInfo(ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST)
  self._questComponent = self._localProcess:GetComponent(ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST)
  self._questComponentInfo = self._localProcess:GetComponentInfo(ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST)
end

function UIXiaoLinJiaMainController:OnShow(uiParams)
  local backBtns = self:GetUIComponent("UISelectObjectPath", "backBtns")
  self.anim = self:GetUIComponent("Animation", "anim")
  self._backBtns = backBtns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(function()
    self:Lock("UIXiaoLinJiaMainController_Close")
    self.anim:Play("uieffanim_UIXiaoLinJiaMainController_out")
    self:StartTask(function(TT)
      YIELD(TT, 500)
      self:CloseDialog()
      self:UnLock("UIXiaoLinJiaMainController_Close")
    end)
  end, nil, nil, false, nil, nil, nil)
  self.atlas = self:GetAsset("XiaoLinJia.spriteatlas", LoadType.SpriteAtlas)
  self.missionTitle = self:GetUIComponent("UILocalizationText", "missionTitle")
  self.missionContent = self:GetUIComponent("UILocalizationText", "missionContent")
  self.finishNode = self:GetGameObject("finishNode")
  self.hideNode = self:GetGameObject("hideNode")
  self.lockNode = self:GetGameObject("lockNode")
  self.missionsRoot = self:GetGameObject("missions")
  self.questionDBBtn = self:GetGameObject("questionDBBtn")
  self.videoPanel = self:GetGameObject("videoPanel")
  self.resultPanel = self:GetGameObject("resultPanel")
  self.resultHead = self:GetUIComponent("Image", "resultHead")
  self.starRoot = self:GetGameObject("starRoot")
  self.resultText = self:GetUIComponent("UILocalizationText", "resultText")
  self.lockText = self:GetUIComponent("UILocalizationText", "lockText")
  self.videoText = self:GetUIComponent("RollingText", "videoText")
  self.remainTimeText = self:GetUIComponent("UILocalizationText", "remainTimeText")
  self.missionIcon = self:GetUIComponent("Image", "missionIcon")
  self.startBtnHeadIcon = self:GetUIComponent("Image", "startBtnHeadIcon")
  self.missionLockIcon = self:GetUIComponent("Image", "missionLockIcon")
  self.questRed = self:GetGameObject("questRed")
  self.collectionRed = self:GetGameObject("collectionRed")
  self.missionsRootTrans = self:GetUIComponent("RectTransform", "missions")
  self.loginModule = GameGlobal.GetModule(LoginModule)
  self.svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self.MissionPos = {
    [1] = 540,
    [2] = 540,
    [3] = 1028,
    [4] = 1340,
    [5] = 1600,
    [6] = 1690
  }
  self:Refresh()
  self:AttachEvent(GameEventType.OnXiaoLinJiaMainPanelRefresh, self.Refresh)
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
  local mission = self:GetCurUnlockMission()
  mission:OnSelect()
  self.anim:Play("uieffanim_UIXiaoLinJiaMainController_in")
  self:StartTask(function(TT)
    self:Lock("UIXiaoLinJiaMainController_firstIn")
    YIELD(TT, 700)
    self:UnLock("UIXiaoLinJiaMainController_firstIn")
    UIActivityHelper.PlayFirstPlot_Component(self._campaign, ECampaignCN7ComponentID.ECAMPAIGN_N7_TACIT_TEST, false)
  end)
end

function UIXiaoLinJiaMainController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIXiaoLinJiaMainController:OnRootActiveChange(flag)
  if flag then
    self.anim:Play("uieffanim_UIXiaoLinJiaMainController_in")
  end
end

function UIXiaoLinJiaMainController:SetRemainTime()
  local closeTime = self._testComponentInfo.m_close_time
  local curTime = self:GetModule(SvrTimeModule):GetServerTime() / 1000
  local diff = closeTime - curTime
  self.remainTimeText:SetText(StringTable.Get("str_xiaolinjia_entry_7", UIActivityHelper.GetFormatTimerStr(diff)))
end

function UIXiaoLinJiaMainController:GetEvaluate(star)
  return "str_xiaolinjia_rank_" .. star
end

function UIXiaoLinJiaMainController:Refresh(force)
  self:RefreshMissionData()
  self:SetRemainTime()
  self:RefreshRed()
  if force then
    local tmpId = self.curSelectMissionID
    self.curSelectMissionID = 0
    self.missionList[tmpId]:OnSelect()
  end
end

function UIXiaoLinJiaMainController:RefreshRed()
  local questHasRed = self._campaign:CheckComponentRed(ECampaignCN7ComponentID.ECAMPAIGN_N7_QUEST)
  self.questRed:SetActive(questHasRed)
  local collectionCfg = Cfg.cfg_xiaolinjia_collection({
    ComponentID = self:GetTacitTestComponentCfgId()
  })
  local hasNew = false
  for _, v in pairs(collectionCfg) do
    self.itemModule = GameGlobal.GetModule(ItemModule)
    local items = self.itemModule:GetItemByTempId(v.ItemID)
    for _, v in pairs(items) do
      if v:IsNewOverlay() then
        hasNew = true
      end
    end
  end
  self.collectionRed:SetActive(hasNew)
end

function UIXiaoLinJiaMainController:GetTacitTestComponentCfgId()
  return self._testComponent:GetComponentCfgId()
end

function UIXiaoLinJiaMainController:GetQuestComponentCfgId()
  return self._questComponent:GetComponentCfgId()
end

function UIXiaoLinJiaMainController:GetHasHideMissionUnLock()
  local componentID = self:GetTacitTestComponentCfgId()
  local serverMissionCfg = Cfg.cfg_component_tacit_test_mission({ComponentID = componentID})
  local unLock = true
  for i = 1, #serverMissionCfg do
    if self._testComponentInfo.m_pass_mission_info[i] == nil and i ~= #serverMissionCfg then
      unLock = false
    end
  end
  return unLock
end

function UIXiaoLinJiaMainController:GetMissionList()
  return self.missionList
end

function UIXiaoLinJiaMainController:RefreshMissionData()
  self.missionList = {}
  local componentID = self:GetTacitTestComponentCfgId()
  local serverMissionCfg = Cfg.cfg_component_tacit_test_mission({ComponentID = componentID})
  if serverMissionCfg then
    for _, v in pairs(serverMissionCfg) do
      local clientData = self:GetClientMissionCfg(v.CampaignMissionId)
      local uiView = self.missionsRoot.transform:Find(v.CampaignMissionId .. "").gameObject:GetComponent("UIView")
      local missionItem = UIXiaoLinJiaMissionItem:New(uiView, self)
      missionItem:SetData(clientData, v, self._testComponentInfo.m_pass_mission_info[v.CampaignMissionId])
      self.missionList[v.CampaignMissionId] = missionItem
    end
  end
  self:RefreshCurAndNextUnlockMission()
  for _, missionItem in pairs(self.missionList) do
    missionItem:Refresh()
  end
end

function UIXiaoLinJiaMainController:RefreshCurAndNextUnlockMission()
  for i = 1, #self.missionList do
    if self.missionList[i]:GetIsLock() then
      self.nextUnlockMission = self.missionList[i]
      break
    else
      self.curUnlockMission = self.missionList[i]
    end
  end
end

function UIXiaoLinJiaMainController:GetComponentID()
  return self._testComponentInfo.m_component_id
end

function UIXiaoLinJiaMainController:GetCurUnlockMission()
  return self.curUnlockMission
end

function UIXiaoLinJiaMainController:GetNextUnlockMission()
  return self.nextUnlockMission
end

function UIXiaoLinJiaMainController:GetClientMissionCfg(missionID)
  local componentID = self:GetTacitTestComponentCfgId()
  local missionCfg = Cfg.cfg_xiaolinjia_mission({ComponentID = componentID})
  for _, v in pairs(missionCfg) do
    if v.ID == missionID then
      return v
    end
  end
  return nil
end

function UIXiaoLinJiaMainController:GetCheckTimeIsUnlock(timeStr)
  local startTime = self.loginModule:GetTimeStampByTimeStr(timeStr, Enum_DateTimeZoneType.E_ZoneType_GMT)
  local curTime = self:GetModule(SvrTimeModule):GetServerTime() / 1000
  return startTime - curTime
end

function UIXiaoLinJiaMainController:ShowMissionInfo(missionID, title, content, isLock, isHide, star, diff)
  if self.curSelectMissionID == missionID then
    return
  end
  local clientData = self:GetClientMissionCfg(missionID)
  self.curSelectMissionID = missionID
  self.missionTitle:SetText(StringTable.Get(title))
  self.missionContent:SetText(StringTable.Get(content))
  self.missionIcon.sprite = self.atlas:GetSprite(clientData.LevelIcon)
  if isHide then
    self.hideNode:SetActive(true)
    self.lockNode:SetActive(false)
    self.finishNode:SetActive(false)
  elseif isLock then
    local str = StringTable.Get("str_xiaolinjia_level_countdown_1", UIActivityHelper.GetFormatTimerStr(diff))
    self.missionLockIcon.sprite = self.atlas:GetSprite(clientData.LockIcon)
    self.lockText:SetText(str)
    self.lockNode:SetActive(true)
    self.hideNode:SetActive(false)
    self.finishNode:SetActive(false)
  else
    self.canOpenQuestionDB = star ~= nil
    self.canPlayMissionVideo = star == 3
    self.startBtnHeadIcon.sprite = self.atlas:GetSprite(clientData.ClosingHeadIcon)
    local roleName = StringTable.Get(clientData.RoleName)
    if star then
      if star == 3 then
        self.videoPanel:SetActive(true)
        self.videoText:RefreshText(StringTable.Get("str_xiaolinjia_story_unlock"))
      else
        self.videoPanel:SetActive(false)
        self.videoText:RefreshText(StringTable.Get("str_xiaolinjia_story_lock", roleName))
      end
      self.resultText:SetText(StringTable.Get(self:GetEvaluate(star)))
      for i = 1, 3 do
        local trans = self.starRoot.transform:GetChild(i - 1)
        trans:Find("full").gameObject:SetActive(star >= i)
      end
    else
      self.resultText:SetText(StringTable.Get("str_xiaolinjia_no_test"))
      self.videoPanel:SetActive(false)
      self.videoText:RefreshText(StringTable.Get("str_xiaolinjia_story_lock", roleName))
      self.videoPanel:SetActive(false)
      self.videoText:RefreshText(StringTable.Get("str_xiaolinjia_story_lock", roleName))
      for i = 1, 3 do
        local trans = self.starRoot.transform:GetChild(i - 1)
        trans:Find("full").gameObject:SetActive(false)
      end
    end
    self.resultHead.sprite = self.atlas:GetSprite(clientData.ClosingHeadIcon)
    self.finishNode:SetActive(true)
    self.lockNode:SetActive(false)
    self.hideNode:SetActive(false)
  end
  for _, v in pairs(self.missionList) do
    v:ShowSelectIcon(missionID)
  end
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.missionsRootTrans)
  local pos = self.missionsRootTrans.anchoredPosition
  local sizeY = self.missionsRootTrans.sizeDelta.y - 560
  local posY = sizeY < self.MissionPos[self.curSelectMissionID] and sizeY or self.MissionPos[self.curSelectMissionID]
  self.missionsRootTrans.anchoredPosition = Vector2(pos.x, posY)
end

function UIXiaoLinJiaMainController:GetCampaign()
  return self._campaign
end

function UIXiaoLinJiaMainController:PlayStoryBtnOnClick()
  self:ShowDialog("UIXiaoLinJiaStoryController", self.curSelectMissionID, self)
end

function UIXiaoLinJiaMainController:PlayHideBtnOnClick()
  local clientData = self:GetClientMissionCfg(self.curSelectMissionID)
  GameGlobal.UIStateManager():ShowDialog("UIStoryController", clientData.EndingStory, function()
    self:SaveTacitTestResult(self.curSelectMissionID, 3, function(reward)
      if reward and 0 < #reward then
        local id = reward[1].assetid
        local cfg
        local collectionCfg = Cfg.cfg_xiaolinjia_collection({
          ComponentID = self:GetTacitTestComponentCfgId()
        })
        for _, v in pairs(collectionCfg) do
          if v.ItemID == id then
            cfg = v
          end
        end
        local roleName = StringTable.Get(clientData.RoleName)
        self:ShowDialog("UIXiaoLinJiaGetCollectionController", function()
        end, cfg, clientData.ClosingHeadIcon, roleName)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.OnXiaoLinJiaMainPanelRefresh, true)
      end
    end)
  end, true)
end

function UIXiaoLinJiaMainController:IntroBtnOnClick()
  self:ShowDialog("UIXiaoLinJiaIntroController")
end

function UIXiaoLinJiaMainController:ReviewBtnOnClick()
  GameGlobal.UIStateManager():ShowDialog("UIStoryController", self._testComponentInfo.m_first_story_id, nil, true)
end

function UIXiaoLinJiaMainController:QuestionDBBtnOnClick()
  if self.canOpenQuestionDB then
    local record = self:GetMissionQuestionRecord(self.curSelectMissionID)
    self:ShowDialog("UIXiaoLinJiaQuestionDBController", self.curSelectMissionID, record)
  else
    ToastManager.ShowToast(StringTable.Get("str_xiaolinjia_text_qa_2"))
  end
end

function UIXiaoLinJiaMainController:GiftBtnOnClick()
  self:ShowDialog("UIXiaoLinJiaRewardController", self._campaign, self.missionList)
end

function UIXiaoLinJiaMainController:CollectionBtnOnClick()
  self:ShowDialog("UIXiaoLinJiaCollectionController", self)
end

function UIXiaoLinJiaMainController:VideoRecordBtnOnClick()
  if self.canPlayMissionVideo then
    local clientData = self:GetClientMissionCfg(self.curSelectMissionID)
    GameGlobal.UIStateManager():ShowDialog("UIStoryController", clientData.EndingStory, nil, true)
  end
end

function UIXiaoLinJiaMainController:GetMissionQuestionRecord(missionId)
  local missionInfo = self._testComponentInfo.m_pass_mission_info[missionId]
  if missionInfo then
    return missionInfo.answer_record, missionInfo.star
  end
  return nil
end

function UIXiaoLinJiaMainController:SaveTacitTestResult(missionId, star, callback)
  self:Lock("UIXiaoLinJiaMainController_SaveTacitTestResult")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local ret, reward = self._testComponent:HandleCompleteTacitTestMission(TT, res, missionId, star)
    self:UnLock("UIXiaoLinJiaMainController_SaveTacitTestResult")
    if not res:GetSucc() then
      self._campaign:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    else
      callback(reward)
    end
  end)
end

function UIXiaoLinJiaMainController:UpdateTacitTestAnswer(missionId, answerRecord)
  if table.count(answerRecord) == 0 then
    return
  end
  self:Lock("UIXiaoLinJiaMainController_UpdateTacitTestAnswer")
  self:StartTask(function(TT)
    local res = AsyncRequestRes:New()
    local ret = self._testComponent:HandleUpdateTacitTestAnswer(TT, res, missionId, answerRecord)
    self:UnLock("UIXiaoLinJiaMainController_UpdateTacitTestAnswer")
    if not res:GetSucc() then
      self._campaign:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    end
  end)
end

function UIXiaoLinJiaMainController.GetMainActivityEntryState(component)
  local componentCfgId = component:GetComponentCfgId()
  local serverMissionCfg = Cfg.cfg_component_tacit_test_mission({ComponentID = componentCfgId})
  local missionList = {}
  for _, v in pairs(serverMissionCfg) do
    missionList[v.CampaignMissionId] = v
  end
  local serverPassMissionData = component:GetComponentInfo().m_pass_mission_info
  local loginModule = GameGlobal.GetModule(LoginModule)
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local curTime = svrTimeModule:GetServerTime() / 1000
  local curUnlockMissionId = 1
  local curNextUnlockMissionId = 1
  local diffTime = 0
  local passAll = true
  local passHide = true
  local passCurrent = true
  for i = 1, #missionList do
    local unlockTime = loginModule:GetTimeStampByTimeStr(missionList[i].UnlockTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    if curTime > unlockTime then
      curUnlockMissionId = i
    else
      curNextUnlockMissionId = i
      diffTime = unlockTime - curTime
      break
    end
  end
  for i = 1, #missionList do
    if i ~= #missionList then
      if not serverPassMissionData[i] then
        passAll = false
      end
    elseif not serverPassMissionData[i] then
      passHide = false
    end
  end
  if serverPassMissionData[curUnlockMissionId] then
    passCurrent = true
  else
    passCurrent = false
  end
  return passAll, passHide, passCurrent, diffTime, curUnlockMissionId, curNextUnlockMissionId
end
