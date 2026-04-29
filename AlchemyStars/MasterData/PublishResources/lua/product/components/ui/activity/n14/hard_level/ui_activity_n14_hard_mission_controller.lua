_class("UIActivityN14HardMissionController", UIController)
UIActivityN14HardMissionController = UIActivityN14HardMissionController

function UIActivityN14HardMissionController:_SpawnObject(widgetName, className)
  local pool = self:GetUIComponent("UISelectObjectPath", widgetName)
  local obj = pool:SpawnObject(className)
  return obj
end

function UIActivityN14HardMissionController:_SetRemainingTime(widgetName, descId, endTime)
  local obj = self:_SpawnObject(widgetName, "UIActivityCommonRemainingTime")
  obj:SetCustomTimeStr_Common_1()
  obj:SetExtraRollingText()
  obj:SetAdvanceText(descId)
  obj:SetData(endTime, nil, nil)
end

function UIActivityN14HardMissionController:_SetIcon(widgetName, icon)
  widgetName = widgetName or "icon"
  local obj = self:GetUIComponent("RawImageLoader", widgetName)
  obj:LoadImage(icon)
end

function UIActivityN14HardMissionController:_SetText(widgetName, str)
  widgetName = widgetName or "text"
  local obj = self:GetUIComponent("UILocalizationText", widgetName)
  obj:SetText(str)
end

function UIActivityN14HardMissionController:Constructor()
  self._curShowType = 1
  self._curShowCount = 10
end

function UIActivityN14HardMissionController:InitWidget()
  local backBtns = self:GetUIComponent("UISelectObjectPath", "_backBtns")
  self._backBtns = backBtns:SpawnObject("UICommonTopButton")
  self._backBtns:SetData(function()
    local campaignModule = GameGlobal.GetModule(CampaignModule)
    campaignModule:CampaignSwitchState(true, UIStateType.UIN14Main, UIStateType.UIMain, nil, self._campaign._id)
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
  self._hardBtnImage = self:GetUIComponent("Image", "hardBtn")
  self._evilBtnImage = self:GetUIComponent("Image", "evilBtn")
  self._hardBtnTMP = self:GetUIComponent("UILocalizedTMP", "hardBtnTMP")
  self._evilBtnTMP = self:GetUIComponent("UILocalizedTMP", "evilBtnTMP")
  self._matRes = {}
  self:SetFontMat(self._hardBtnTMP, "uieff_n14_hardmission.mat")
  self:SetFontMat(self._evilBtnTMP, "uieff_n14_evilmission.mat")
end

function UIActivityN14HardMissionController:LoadDataOnEnter(TT, res, uiParams)
  self._campaignType = ECampaignType.CAMPAIGN_TYPE_N14
  self._componentId_TreeMission = ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_HARD
  self._componentId_TreeMissionFixteam = ECampaignN14ComponentID.ECAMPAIGN_N14_LEVEL_FIXTEAM
  self._missionModule = self:GetModule(MissionModule)
  if not self.data then
    self.data = N14Data:New()
  end
  self._campModule = self.data:GetCampaignModule()
  self._campaign = self.data:GetActivityCampaign()
  self._campaign:LoadCampaignInfo(TT, res, self._campaignType, self._componentId_TreeMission, self._componentId_TreeMissionFixteam)
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and res:GetSucc() then
    self._tree_component = self._campaign:GetComponent(self._componentId_TreeMission)
    self._tree_info = self._tree_component:GetComponentInfo()
    if not self._campaign:CheckComponentOpen(self._componentId_TreeMission) then
      res.m_result = self._campaign:CheckComponentOpenClientError(self._componentId_TreeMission)
      local campaignModule = GameGlobal.GetModule(CampaignModule)
      campaignModule:ShowErrorToast(res.m_result, true)
      return
    end
  end
  if res and not res:GetSucc() then
    self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
  end
end

function UIActivityN14HardMissionController:OnShow(uiParams)
  self._firstShow = true
  self._timerHolder = UITimerHolder:New()
  self._atlas = self:GetAsset("UIN14.spriteatlas", LoadType.SpriteAtlas)
  self.NodeCfg = {
    [DiscoveryStageType.FightNormal] = {
      [1] = {
        normal = "n14_kng_spot1",
        press = "n14_kng_spot1_close",
        lock = "n13_zjm_btn09",
        textColor = Color(1.0, 0.9529411764705882, 0.7568627450980392, 1.0),
        textShadow = Color.New(0.19215686274509805, 0.1607843137254902, 0.16470588235294117),
        normalStar = "",
        passStar = ""
      },
      [2] = {
        normal = "n14_kng_spot1",
        press = "n14_kng_spot1_close",
        lock = "n13_zjm_btn09",
        textColor = Color(1.0, 0.9529411764705882, 0.7568627450980392, 1.0),
        textShadow = Color.New(0.19215686274509805, 0.1607843137254902, 0.16470588235294117),
        normalStar = "",
        passStar = ""
      }
    },
    [DiscoveryStageType.FightBoss] = {
      [1] = {
        normal = "n14_kng_spot2",
        press = "n14_kng_spot2_close",
        lock = "n13_zjm_btn09",
        textColor = Color(1.0, 0.9529411764705882, 0.7568627450980392, 1.0),
        textShadow = Color.New(0.19215686274509805, 0.1607843137254902, 0.16470588235294117),
        normalStar = "",
        passStar = ""
      },
      [2] = {
        normal = "n14_kng_spot2",
        press = "n14_kng_spot2_close",
        lock = "n13_zjm_btn09",
        textColor = Color(1.0, 0.9529411764705882, 0.7568627450980392, 1.0),
        textShadow = Color.New(0.19215686274509805, 0.1607843137254902, 0.16470588235294117),
        normalStar = "",
        passStar = ""
      }
    },
    [DiscoveryStageType.Plot] = {
      [1] = {
        normal = "n14_kng_spot3",
        press = "n14_kng_spot3_close",
        lock = "n13_zjm_btn09",
        textColor = Color(1.0, 0.9529411764705882, 0.7568627450980392, 1.0),
        textShadow = Color.New(0.19215686274509805, 0.1607843137254902, 0.16470588235294117),
        normalStar = "",
        passStar = ""
      },
      [2] = {
        normal = "n14_kng_spot3",
        press = "n14_kng_spot3_close",
        lock = "n13_zjm_btn09",
        textColor = Color(1.0, 0.9529411764705882, 0.7568627450980392, 1.0),
        textShadow = Color.New(0.19215686274509805, 0.1607843137254902, 0.16470588235294117),
        normalStar = "",
        passStar = ""
      }
    },
    [DiscoveryStageType.Node] = {
      [1] = {
        normal = "n14_kng_spot4",
        press = "n14_kng_spot4_close",
        lock = "n13_zjm_btn09",
        textColor = Color.New(1.0, 1.0, 1.0, 1.0),
        textShadow = Color.New(0.19215686274509805, 0.1607843137254902, 0.16470588235294117),
        normalStar = "",
        passStar = ""
      },
      [2] = {
        normal = "n14_kng_spot4",
        press = "n14_kng_spot4_close",
        lock = "n13_zjm_btn09",
        textColor = Color.New(1.0, 1.0, 1.0, 1.0),
        textShadow = Color.New(0.19215686274509805, 0.1607843137254902, 0.16470588235294117),
        normalStar = "",
        passStar = ""
      }
    }
  }
  self.ButtonStateConf = {
    [1] = {
      normal = "n14_kng_hard1",
      select = "n14_kng_hard2",
      lock = ""
    },
    [2] = {
      normal = "n14_kng_hard3",
      select = "n14_kng_hard4",
      lock = "n14_kng_hard5"
    }
  }
  self.lineConf = {
    normal = self._atlas:GetSprite("n14_kng_line1"),
    unnormal = self._atlas:GetSprite("n14_kng_line2")
  }
  self:AttachEvents()
  self:InitWidget()
  self:_Refresh()
  local lockName = "UIActivityN14_HardMissionController_Enter"
  self:Lock(lockName)
  self._timerHolder:StartTimer(lockName, 500, function()
    self:UnLock(lockName)
  end)
end

function UIActivityN14HardMissionController:OnHide()
  self._matRes = {}
  self.NodeCfg = nil
  self._firstShow = false
  self._timerHolder:Dispose()
  if self._shot then
    self._shot:CleanRenderTexture()
    self._shot = nil
  end
  UIActivityN14HardMissionController.super:Dispose()
  self._scroller:Dispose()
  self:DetachEvents()
end

function UIActivityN14HardMissionController:_Refresh()
  self:FlushNodes()
  self:_SetTimeInfo()
  self:doLevelBtnSwitch()
end

function UIActivityN14HardMissionController:_SetTimeInfo()
  local endTime = self._tree_component:GetComponentInfo().m_close_time
  self:_SetRemainingTime("_remainingTimePool", nil, endTime)
end

function UIActivityN14HardMissionController:_SetActionPoint()
  local componentId = ECampaignN14ComponentID.ECAMPAIGN_N14_ACTION_POINT
  local component = self._campaign:GetComponent(componentId)
  local icon = component:GetItemIcon()
  if icon then
    self:_SetIcon("_iconActionPoint", icon)
  end
  local n1, n2 = component:GetItemCount()
  self:_SetText("_txtActionPoint", n1 .. "/" .. n2)
  local endTime = component:GetRegainEndTime()
  self:_SetRemainingTime("_actionPointPool", nil, endTime)
  local state_time = self:GetGameObject("state_time")
  local state_max = self:GetGameObject("state_max")
  state_time:SetActive(n1 < n2)
  state_max:SetActive(n2 <= n1)
end

function UIActivityN14HardMissionController:FlushNodes()
  local cmpID = self._tree_component:GetComponentCfgId()
  self._passInfo = self._tree_info.m_pass_mission_info
  self._levelCfgs = Cfg.cfg_component_tree_mission({ComponentID = cmpID})
  local extra_cfg = Cfg.cfg_component_line_mission_extra({ComponentID = cmpID})
  local extra_width = extra_cfg[1].MarginRight
  local missionCfgs_temp = Cfg.cfg_component_tree_mission({ComponentID = cmpID})
  self._curShowCount = 6
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
  local showMission = {}
  local levelCount, lineCount = 0, 0
  for key, cfg in pairs(missionCfgs) do
    if not table.intable(showMission, key) then
      showMission[key] = cfg
      levelCount = levelCount + 1
      if #cfg.NeedMissionList ~= 0 then
        lineCount = lineCount + #cfg.NeedMissionList
      end
    end
  end
  
  local function checkFun(NeedList)
    if not self._tree_info.m_pass_mission_info then
      return false
    end
    for i, v in pairs(NeedList) do
      if not self._tree_info.m_pass_mission_info[v] then
        return false
      end
    end
    return true
  end
  
  self._nodesPool:SpawnObjects("UIActivityN14HardMissionMapNode", levelCount)
  local nodes = self._nodesPool:GetAllSpawnList()
  self._linesPool:SpawnObjects("UIActivityN14HardMissionMapLine", lineCount)
  local lines = self._linesPool:GetAllSpawnList()
  local nodeIdx, lineIdx = 1, 1
  for missionID, cfg in pairs(showMission) do
    local uiNode = nodes[nodeIdx]
    uiNode:SetData(cfg, self._tree_info.m_pass_mission_info[missionID], function(stageId, isStory, worldPos)
      self:_onNodeClick(stageId, isStory, worldPos)
    end, self._curShowType, self.NodeCfg, checkFun(cfg.NeedMissionList), missionCfgs)
    nodeIdx = nodeIdx + 1
    local condition = checkFun(cfg.NeedMissionList)
    if #cfg.NeedMissionList ~= 0 then
      for index, value in ipairs(cfg.NeedMissionList) do
        local n1 = showMission[value]
        local n2 = cfg
        local line = lines[lineIdx]
        if n1 and n2 then
          line:Show()
          line:Flush(Vector2(n2.MapPosX, n2.MapPosY), Vector2(n1.MapPosX, n1.MapPosY), condition, self.lineConf)
        else
          line:Hide()
        end
        lineIdx = lineIdx + 1
      end
    end
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
  local width = math.abs(right + extra_width)
  width = math.max(self._safeAreaSize.x, width)
  self._contentRect.sizeDelta = Vector2(width, self._contentRect.sizeDelta.y)
  if curShowPos <= self._safeAreaSize.x then
    curShowPos = 0
  elseif self._safeAreaSize.x / 2 - curShowPos < self._safeAreaSize.x - width then
    curShowPos = self._safeAreaSize.x - width
  else
    curShowPos = self._safeAreaSize.x / 2 - curShowPos
  end
  self._contentRect.anchoredPosition = Vector2(curShowPos, 0)
  local posx = {}
  for _, cfg in pairs(missionCfgs) do
    posx[#posx + 1] = cfg.MapPosX
  end
  table.sort(posx)
  local sp1, sp2 = 12, 12
  local bgLoader1 = self:GetUIComponent("RawImageLoader", "bg1")
  local bgLoader2 = self:GetUIComponent("RawImageLoader", "bg2")
  self._scroller = UILevelScroller:New(self._contentRect, bgLoader1, bgLoader2, {
    "n14_kng_bg",
    "n14_kng_bg",
    "n14_kng_bg"
  }, {
    posx[sp1],
    posx[sp1 + 1],
    posx[sp2],
    posx[sp2 + 1]
  })
  self._scrollRect.onValueChanged:AddListener(function()
    self._scroller:OnChange()
  end)
  self._allMissionCfgs = missionCfgs
end

function UIActivityN14HardMissionController:_onNodeClick(stageId, isStory, worldPos)
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
    local moveLockName = "UIActivityLineMissionController_MoveToStage"
    self:Lock(moveLockName)
    self._timerHolder:StartTimer(moveLockName, _moveTime * 1000, function()
      self:UnLock(moveLockName)
      self:_EnterStage(stageId, worldPos)
    end)
  else
    self:_EnterStage(stageId, worldPos)
  end
end

function UIActivityN14HardMissionController:_EnterStage(stageId, worldPos)
  self._shot.OwnerCamera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  self._shot:CleanRenderTexture()
  local rt = self._shot:RefreshBlurTexture()
  local scale = 1.3
  local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
  local screenPos = camera:WorldToScreenPoint(worldPos)
  local offset = -(Vector2(screenPos.x, screenPos.y) - Vector2(UnityEngine.Screen.width, UnityEngine.Screen.height) / 2)
  local missionCfg = Cfg.cfg_campaign_mission[stageId]
  local autoFightShow = self:_CheckSerialAutoFightShow(missionCfg.Type, stageId)
  local pointComponent = self._campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_ACTION_POINT, 1)
  self:ShowDialog("UIActivityLevelStage", stageId, self._tree_info.m_pass_mission_info[stageId], self._tree_component, rt, offset, self._safeAreaSize.x, self._safeAreaSize.y, scale, autoFightShow, pointComponent)
end

function UIActivityN14HardMissionController:PlotEndCallback(stageId)
  local isActive = self._tree_component:IsPassCamMissionID(stageId)
  if isActive then
    return
  end
  self:StartTask(function(TT)
    self._tree_component:SetMissionStoryActive(TT, stageId, ActiveStoryType.ActiveStoryType_BeforeBattle)
    local res = AsyncRequestRes:New()
    local award = self._tree_component:HandleCompleteStoryTreeMission(TT, res, stageId)
    if not res:GetSucc() then
      self._campModule:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    elseif table.count(award) ~= 0 then
      self:ShowDialog("UIGetItemController", award, function()
        self:SwitchState(UIStateType.UIActivityN14HardMissionController)
      end)
    else
      self:SwitchState(UIStateType.UIActivityN14HardMissionController)
    end
  end, self)
end

function UIActivityN14HardMissionController:_CheckSerialAutoFightShow(stageType, stageId)
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

function UIActivityN14HardMissionController:ShowSerialRewards()
  self:ShowDialog("UISerialAutoFightInfo", OpenUISerialFightInfoState.Finished)
end

function UIActivityN14HardMissionController:ActionPointBtnOnClick(go)
  local componentId = ECampaignN14ComponentID.ECAMPAIGN_N14_ACTION_POINT
  local component = self._campaign:GetComponent(componentId)
  self:ShowDialog("UIActivityN14ActionPointDetail", component:GetItemIcon())
end

function UIActivityN14HardMissionController:AttachEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN14HardMissionController:DetachEvents()
  self:DetachEvent(GameEventType.ActivityCloseEvent, self._CheckActivityClose)
end

function UIActivityN14HardMissionController:_CheckActivityClose(id)
  if self._campaign and self._campaign._id == id then
    self:SwitchState(UIStateType.UIMain)
  end
end

function UIActivityN14HardMissionController:hardBtnOnClick()
  if self._curShowType == 1 then
    return
  end
  self._curShowType = 1
  self:FlushNodes()
  self:doLevelBtnSwitch()
end

function UIActivityN14HardMissionController:evilBtnOnClick()
  if not self._isLevel2UnLock then
    ToastManager.ShowToast(StringTable.Get("str_n14_evil_lock"))
    return
  end
  if self._curShowType == 2 then
    return
  end
  self._curShowType = 2
  self:FlushNodes()
  self:doLevelBtnSwitch()
end

function UIActivityN14HardMissionController:doLevelBtnSwitch()
  self._hardBtnImage.sprite = self._curShowType == 1 and self._atlas:GetSprite(self.ButtonStateConf[1].select) or self._atlas:GetSprite(self.ButtonStateConf[1].normal)
  if self._isLevel2UnLock then
    self._evilBtnImage.sprite = self._curShowType == 2 and self._atlas:GetSprite(self.ButtonStateConf[2].select) or self._atlas:GetSprite(self.ButtonStateConf[2].normal)
  else
    self._evilBtnImage.sprite = self._atlas:GetSprite(self.ButtonStateConf[2].lock)
  end
  self._lockImage:SetActive(not self._isLevel2UnLock)
  self._evilBtnTMP.color = self._isLevel2UnLock and Color(1, 1, 1, 1) or Color(1, 1, 1, 0.4)
  self:StartTask(function(TT)
    if self._firstShow then
      local playerPrefsKey = self.data.GetPstId()
      if self._isLevel2UnLock and self._curIndex == 7 and not UnityEngine.PlayerPrefs.HasKey("UIActivityN14HardMission:" .. playerPrefsKey) then
        self._unlockImage:SetActive(true)
        UnityEngine.PlayerPrefs.SetInt("UIActivityN14HardMission:" .. playerPrefsKey, 1)
        YIELD(TT, 300)
        self._unlockImage:SetActive(false)
      end
    else
    end
    self:Lock(self:GetName())
    YIELD(TT, 300)
    self._firstShow = false
    self:UnLock(self:GetName())
  end)
end

function UIActivityN14HardMissionController:unlockImageBtnOnClick()
end

function UIActivityN14HardMissionController:SetFontMat(lable, resname)
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
