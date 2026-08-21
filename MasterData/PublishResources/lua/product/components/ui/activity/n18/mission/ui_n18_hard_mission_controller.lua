_class("UIN18HardMissionController", UIController)
UIN18HardMissionController = UIN18HardMissionController

function UIN18HardMissionController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIN18HardMissionController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetAdvanceText("str_n18_activity_lasttime")
  obj:SetData(endTime, nil, nil)
end

function UIN18HardMissionController:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIN18HardMissionController:_SetText(widgetName, str)
  widgetName = widgetName or "text"
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(str)
end

function UIN18HardMissionController:Constructor()
  self._curShowType = 1
  self._curShowCount = 10
end

function UIN18HardMissionController:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN18Main, UIStateType.UIMain, nil, self._campaign._id)
  end)
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
  self._mapContentRect = self:GetUIComponent("RectTransform", "MapContent")
  self._contentRect = self:GetUIComponent("RectTransform", "Content")
  self._linesPool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodesPool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._shot = self:GetUIComponent("H3DUIBlurHelper", "screenShot")
  self._unlockImage = self:GetGameObject("unlockImage")
  self._lockImage = self:GetGameObject("lockImage")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._shot.width = self._safeAreaSize.x
  self._shot.height = self._safeAreaSize.y
  self._anim = self:GetUIComponent("Animation", "anim")
  self._hardBtnImage = self:GetUIComponent("Image", "hardBtn")
  self._evilBtnImage = self:GetUIComponent("Image", "evilBtn")
  self._hardBloom = self:GetGameObject("hardBloom")
  self._hardBtnMask = self:GetGameObject("hardBtnMask")
  self._evilBloom = self:GetGameObject("evilBloom")
  self._evilBtnMask = self:GetGameObject("evilBtnMask")
end

function UIN18HardMissionController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N18
  self._componentId_HardMission = ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_HARD
  self._componentId_HardMissionFixteam = ECampaignN18ComponentID.ECAMPAIGN_N18_LEVEL_FIXTEAM
  self._missionModule = self:GetModule(MissionModule)
  if not self.data then
    self.data = N18Data:New()
  end
  self._campModule = self.data:GetCampaignModule()
  self._campaign = self.data:GetActivityCampaign()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId_HardMission, self._componentId_HardMissionFixteam)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and res:GetSucc() then
    self._hard_component = self._campaign:GetComponent(self._componentId_HardMission)
    self._hard_info = self._hard_component:GetComponentInfo()
    if not self._campaign:CheckComponentOpen(self._componentId_HardMission) then
      res.m_result = self._campaign:CheckComponentOpenClientError(self._componentId_HardMission)
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIN18HardMissionController:OnShow(uiParams)
  self._firstShow = true
  self._timerHolder = UITimerHolder:New()
  self._atlas = self:GetAsset("UIN18.spriteatlas", LoadType.SpriteAtlas)
  self.NodeCfg = {
    [1] = {
      normal = "n18_gng_btn06",
      press = "n18_gng_btn06",
      lock = "n18_gng_btn07",
      textColor = Color(0.10980392156862745, 0.1411764705882353, 0.21568627450980393, 1.0),
      textShadow = Color(0.9921568627450981, 0.9921568627450981, 0.9921568627450981),
      normalStar = "",
      passStar = ""
    },
    [2] = {
      normal = "n18_gng_btn08",
      press = "n18_gng_btn08",
      lock = "n18_gng_btn09",
      textColor = Color(0.18823529411764706, 0.11764705882352941, 0.06274509803921569, 1.0),
      textShadow = Color(0.8156862745098039, 0.7568627450980392, 0.6666666666666666),
      normalStar = "",
      passStar = ""
    }
  }
  self.nodePos = {
    {
      x = -444,
      y = 216,
      angle = -5
    },
    {
      x = -82,
      y = 196,
      angle = 8
    },
    {
      x = 268,
      y = 215,
      angle = 2
    },
    {
      x = -466,
      y = -246,
      angle = -7
    },
    {
      x = -80,
      y = -245,
      angle = 9
    },
    {
      x = 269,
      y = -248,
      angle = 3
    }
  }
  self.nodeIcon = {
    [1] = {
      "n18_gng_ordinary01",
      "n18_gng_ordinary02",
      "n18_gng_ordinary03",
      "n18_gng_ordinary04",
      "n18_gng_ordinary05",
      "n18_gng_ordinary06"
    },
    [2] = {
      "n18_gng_difficulty01",
      "n18_gng_difficulty02",
      "n18_gng_difficulty03",
      "n18_gng_difficulty04",
      "n18_gng_difficulty05",
      "n18_gng_difficulty06"
    }
  }
  self.ButtonStateConf = {
    [1] = {
      normal = "n18_gng_btn01",
      select = "n18_gng_btn02",
      lock = ""
    },
    [2] = {
      normal = "n18_gng_btn03",
      select = "n18_gng_btn04",
      lock = ""
    }
  }
  self:AttachEvents()
  self:InitWidget()
  self:_Refresh()
  local lockName = "UIN18HardMissionController_Enter"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
end

function UIN18HardMissionController:OnHide()
  self._matRes = {}
  self.NodeCfg = nil
  self._firstShow = false
  self._timerHolder:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UIN18HardMissionController.super:Dispose()
  self:DetachEvents()
end

function UIN18HardMissionController:_Refresh()
  self:FlushNodes()
  self:_SetTimeInfo()
  self:doLevelBtnSwitch()
end

function UIN18HardMissionController:_SetTimeInfo()
  local endTime = self._hard_component:GetComponentInfo().m_close_time
  self:_SetRemainingTime("_remainingTimePool", nil, endTime)
end

function UIN18HardMissionController:FlushNodes()
  local cmpID = self._hard_component:GetComponentCfgId()
  self._passInfo = self._hard_info.m_pass_mission_info
  local extra_cfg = Cfg.cfg_component_line_mission_extra({ComponentID = cmpID})
  local missionCfgs_temp = Cfg.cfg_component_line_mission({ComponentID = cmpID})
  self._curShowCount = 6
  self.unlockName = StringTable.Get(Cfg.cfg_campaign_mission[5182006].Name)
  local cur = 0
  for i, cfg in pairs(self._passInfo) do
    cur = cur + 1
  end
  local missionCfgs = {}
  local curCount = 1
  self._curIndex = cur
  self._isLevel2UnLock = self._curIndex >= self._curShowCount
  self._isLevel2OnOpen = self._curIndex == self._curShowCount
  if self._firstShow then
    self._curShowType = self._isLevel2UnLock and 2 or 1
  end
  for _, cfg in ipairs(missionCfgs_temp) do
    if self._curShowType == 1 then
      missionCfgs[cfg.CampaignMissionId] = cfg
      if curCount >= self._curShowCount then
        break
      end
    elseif curCount > self._curShowCount then
      missionCfgs[cfg.CampaignMissionId] = cfg
    end
    curCount = curCount + 1
  end
  local unlockInfo = {}
  local firstMissionID
  for _, cfg in pairs(missionCfgs) do
    if unlockInfo[cfg.NeedMissionId] == nil then
      unlockInfo[cfg.NeedMissionId] = {}
    end
    unlockInfo[cfg.NeedMissionId][cfg.CampaignMissionId] = cfg
    if cfg.NeedMissionId == 0 then
      firstMissionID = cfg.CampaignMissionId
    end
  end
  local showMission = {}
  local levelCount = 0
  if next(self._hard_info.m_pass_mission_info) then
    for missionID, passInfo in pairs(self._hard_info.m_pass_mission_info) do
      if not showMission[missionID] then
        showMission[missionID] = missionCfgs[missionID]
        levelCount = levelCount + 1
      end
      if unlockInfo[missionID] then
        for id, cfg in pairs(unlockInfo[missionID]) do
          if not showMission[id] then
            showMission[id] = missionCfgs[id]
            levelCount = levelCount + 1
          end
        end
      end
    end
  else
    showMission[firstMissionID] = missionCfgs[firstMissionID]
    levelCount = 1
  end
  self._nodesPool:SpawnObjects("UIN18HardMissionMapNode", self._curShowCount)
  local nodes = self._nodesPool:GetAllSpawnList()
  local nodeIdx = 1
  local keylist = {}
  for missionID in pairs(missionCfgs) do
    table.insert(keylist, missionID)
  end
  table.sort(keylist, function(a, b)
    return tonumber(a) < tonumber(b)
  end)
  for i, v in pairs(keylist) do
    local missionID = v
    local cfg = missionCfgs[missionID]
    local uiNode = nodes[nodeIdx]
    uiNode:SetData(cfg, self._hard_info.m_pass_mission_info[missionID], function(stageId, isStory, worldPos)
      self:_onNodeClick(stageId, isStory, worldPos)
    end, self._curShowType, self.NodeCfg, showMission[missionID], missionCfgs, self.nodePos[nodeIdx], self.nodeIcon[self._curShowType][nodeIdx], nodeIdx)
    nodeIdx = nodeIdx + 1
  end
  local right = -11111
  local curShowPos = 0
  for i, cfg in pairs(self._passInfo) do
    if missionCfgs[cfg.mission_id] then
      curShowPos = math.max(curShowPos, missionCfgs[cfg.mission_id].MapPosX)
    end
  end
  for _, cfg in pairs(showMission) do
    right = math.max(right, cfg.MapPosX)
  end
  self._scrollRect.onValueChanged:AddListener(function()
    self._scroller:OnChange()
  end)
  self._allMissionCfgs = missionCfgs
end

function UIN18HardMissionController:_onNodeClick(stageId, isStory, worldPos)
  if isStory then
    local missionCfg = Cfg.cfg_campaign_mission[stageId]
    local titleId = StringTable.Get(missionCfg.Title)
    local titleName = StringTable.Get(missionCfg.Name)
    local storyId = self._missionModule:GetStoryByStageIdStoryType(stageId, StoryTriggerType.Node)
    if not storyId then
      Log.exception("配置错误,找不到剧情,关卡id:", stageId)
      return
    end
    self:ShowDialog("UIActivityPlotEnter", titleId, titleName, storyId, function()
      self:PlotEndCallback(stageId)
    end)
    return
  end
  local pos = self._allMissionCfgs[stageId].MapPosX
  local curPos = self._contentRect.anchoredPosition.x
  local areaWidth = 408
  local halfScreen = self._safeAreaSize.x / 2
  local targetPos
  local left, right = -curPos + areaWidth, -curPos + self._safeAreaSize.x - areaWidth
  if pos < left then
    targetPos = curPos + left - pos
  elseif pos > right then
    targetPos = curPos + right - pos
  end
  self._scrollRect:StopMovement()
  if self._tweener then
    self._tweener:Kill()
    self._tweener = nil
  end
  if targetPos then
    local _moveTime = 0.5
    self._tweener = self._contentRect:DOAnchorPosX(targetPos, _moveTime)
    local moveLockName = "UILineMissionControllerMoveToStage"
    self:Lock(moveLockName)
    self._timerHolder:StartTimer(moveLockName, _moveTime * 1000, function()
      self:UnLock(moveLockName)
      self:_EnterStage(stageId, worldPos)
    end)
  else
    self:_EnterStage(stageId, worldPos)
  end
end

function UIN18HardMissionController:_EnterStage(stageId, worldPos)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = self:_CheckSerialAutoFightShow(missionCfg.Type, stageId)
  self:ShowDialog("UIActivityLevelStageNew", stageId, self._hard_info.m_pass_mission_info[stageId], self._hard_component, autoFightShow, nil)
end

function UIN18HardMissionController:PlotEndCallback(stageId)
  local isActive = self._hard_component:IsPassCamMissionID(stageId)
  if isActive then
    return
  end
  self:StartTask(function(TT)
    self._hard_component:SetMissionStoryActive(TT, stageId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    local res = AsyncRequestRes:New()
    local award = self._hard_component:HandleCompleteStoryMission(TT, res, stageId)
    if not res:GetSucc() then
      self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    elseif table.count(award) ~= 0 then
      self:ShowDialog("UIGetItemController", award, function()
        self:SwitchState(UIStateType.UIN18HardMissionController)
      end)
    else
      self:SwitchState(UIStateType.UIN18HardMissionController)
    end
  end, self)
end

function UIN18HardMissionController:_CheckSerialAutoFightShow(stageType, stageId)
  local autoFightShow = false
  if stageType == DiscoveryStageType.Plot then
    autoFightShow = false
  else
    local missionCfg = Cfg.cfg_campaign_mission[stageId]
    if missionCfg then
      local enableParam = missionCfg.EnableSerialAutoFight
      if enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_DISABLE then
        autoFightShow = false
      elseif enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_ENABLE or enableParam == CampainMissionCanSerialAutoFightType.E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_NEED_UNLOCK then
        autoFightShow = true
      end
    end
  end
  return autoFightShow
end

function UIN18HardMissionController:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIN18HardMissionController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIN18HardMissionController:DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIN18HardMissionController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIN18HardMissionController:hardBtnOnClick()
  if self._curShowType == 1 then
    return
  end
  self._curShowType = 1
  self:FlushNodes()
  self:doLevelBtnSwitch()
end

function UIN18HardMissionController:evilBtnOnClick()
  if not self._isLevel2UnLock then
    ToastManager.ShowToast(StringTable.Get("str_activity_common_will_open_after_clearance", self.unlockName))
    return
  end
  if self._curShowType == 2 then
    return
  end
  self._curShowType = 2
  self:FlushNodes()
  self:doLevelBtnSwitch()
end

function UIN18HardMissionController:doLevelBtnSwitch()
  if self._curShowType == 1 then
    self._hardBloom:SetActive(true)
    self._hardBtnMask:SetActive(false)
    self._evilBloom:SetActive(false)
    self._evilBtnMask:SetActive(true)
    self:_SetIcon("bg1", "n18_gng_bg01")
  else
    self._hardBloom:SetActive(false)
    self._hardBtnMask:SetActive(true)
    self._evilBloom:SetActive(true)
    self._evilBtnMask:SetActive(false)
    self:_SetIcon("bg1", "n18_gng_bg02")
  end
  self._lockImage:SetActive(not self._isLevel2UnLock)
  self:StartTask(function(TT)
    if self._firstShow then
      local playerPrefsKey = self.data.GetPstId()
      if self._isLevel2UnLock and self._curIndex == 7 and not UnityEngine.PlayerPrefs.HasKey("UIActivityN18HardMission:" .. playerPrefsKey) then
        self._unlockImage:SetActive(true)
        UnityEngine.PlayerPrefs.SetInt("UIActivityN18HardMission:" .. playerPrefsKey, 1)
        YIELD(TT, 300)
        self._unlockImage:SetActive(false)
      end
    elseif self._curShowType == 1 then
      self._anim:Play("UIN18HardMissionController_Switching02")
    else
      self._anim:Play("UIN18HardMissionController_Switching01")
    end
    self:Lock(self:GetName())
    YIELD(TT, 300)
    self._firstShow = false
    self:UnLock(self:GetName())
  end)
end

function UIN18HardMissionController:unlockImageBtnOnClick()
end

function UIN18HardMissionController:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  table.insert(self._matRes, res)
  if not res then
    return
  end
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end
