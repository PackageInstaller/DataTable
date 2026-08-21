_class("UISeasonTalentLineMission", UIController)
UISeasonTalentLineMission = UISeasonTalentLineMission

function UISeasonTalentLineMission:LoadDataOnEnter(TT, res)
  self._componentId_LineMission = ECCampaignSeasonComponentID.LINE_MISSION
  self._componentId_TalentTree = ECCampaignSeasonComponentID.TALENT_TREE
  self._seasonObj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  self._line_component = self._seasonObj:GetComponent(self._componentId_LineMission)
  if self._line_component:ComponentIsOpen() then
    res:SetSucc(true)
    self._tree_component = self._seasonObj:GetComponent(self._componentId_TalentTree)
    self._line_info = self._line_component:GetComponentInfo()
    self._endTime = self._line_info.m_close_time
  else
    Log.error("###[UISeasonTalentLineMission] line com is close !")
    res:SetSucc(false)
  end
  self._loading = false
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self:CreateData()
end

function UISeasonTalentLineMission:GetComponents()
  local backBtn = self:GetUIComponent("UISelectObjectPath", "backBtn")
  self._backBtn = backBtn:SpawnObject("UICommonTopButton")
  self._backBtn:SetData(function()
    self:CloseDialog()
  end, function()
    UISeasonHelper.ShowSeasonHelperBook(UISeasonHelperTabIndex.TalentTree)
  end, function()
    GameGlobal.GetUIModule(SeasonModule):ExitSeasonTo(UIStateType.UIMain)
  end)
  self._skillTreePool = self:GetUIComponent("UISelectObjectPath", "SlotPool")
  self._timerTexPool = self:GetUIComponent("UISelectObjectPath", "timerTexPool")
  self._missionWarePool = self:GetUIComponent("UISelectObjectPath", "groupPool")
  self._contentRT = self:GetUIComponent("RectTransform", "Content")
  self._safeAreaSize = self:GetUIComponent("RectTransform", "SafeArea").rect.size
  self._linePool = self:GetUIComponent("UISelectObjectPath", "Lines")
  self._nodePool = self:GetUIComponent("UISelectObjectPath", "Nodes")
  self._scrollRect = self:GetUIComponent("ScrollRect", "MapContent")
end

function UISeasonTalentLineMission:CreateData()
  local cfgs = Cfg.cfg_season_talent_line_ware({
    ComponentID = self._line_component:GetComponentCfgId()
  })
  self.wares = {}
  for key, value in pairs(cfgs) do
    local obj = UISeasonTalentLineMissionWareCls:New(value)
    table.insert(self.wares, obj)
  end
  table.sort(self.wares, function(a, b)
    return a.sortid < b.sortid
  end)
end

function UISeasonTalentLineMission:OnShow(uiParams)
  GameGlobal.EngineInput().multiTouchEnabled = false
  self:AttachEvent(GameEventType.OnTalentTreeChange, self.SkillTreeInfo)
  self:GetComponents()
  self:CurrentMissionID()
  self:CurrentWareIdx()
  self:LineMissionGroup()
  self:LineMissionList()
  self:LineMissionTimer()
  self:SkillTreeInfo()
  self:Lock("UISeasonTalentLineMission:OnShow")
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self._timer = GameGlobal.Timer():AddEvent(700, function()
    self:UnLock("UISeasonTalentLineMission:OnShow")
  end)
end

function UISeasonTalentLineMission:TimerClose()
  local tips = StringTable.Get("str_activity_error_107")
  ToastManager.ShowToast(tips)
  GameGlobal.GetUIModule(SeasonModule):ExitSeasonTo(UIStateType.UIMain)
end

function UISeasonTalentLineMission:SkillTreeInfo()
  if not self._skillTreeItem then
    self._skillTreeItem = self._skillTreePool:SpawnObject("UISeasonTalentLineMissionSlot")
  end
  self._skillTreeItem:SetData(self._tree_component)
end

function UISeasonTalentLineMission:OnHide()
  GameGlobal.EngineInput().multiTouchEnabled = true
  if self._tweener then
    self._tweener:Kill()
    self._tweener = nil
  end
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self:UnLock("UISeasonTalentLineMission:OnShow")
end

function UISeasonTalentLineMission:LineMissionGroup()
  self._missionWareItem = self._missionWarePool:SpawnObject("UISeasonTalentLineMissionGroup")
  self._missionWareItem:SetData(self.currentMissionID, self._line_component, function(wareIdx)
    self.wareIdx = wareIdx
    self:LineMissionList()
  end, function()
    self:LoadSeasonInfo()
  end)
end

function UISeasonTalentLineMission:LoadSeasonInfo()
  if self._loading then
    return
  end
  self._loading = true
  self:Lock("UISeasonTalentLineMission:LoadSeasonInfo")
  GameGlobal.TaskManager():StartTask(self.OnLoadSeasonInfo, self)
end

function UISeasonTalentLineMission:OnLoadSeasonInfo(TT)
  Log.debug("###[UISeasonTalentLineMission] start load season info !")
  local res = GameGlobal.GetModule(SeasonModule):ForceRequestCurSeasonData(TT)
  self:UnLock("UISeasonTalentLineMission:LoadSeasonInfo")
  self._loading = false
  if res and res:GetSucc() then
    Log.debug("###[UISeasonTalentLineMission] start load season info succ!")
    self._seasonObj = GameGlobal.GetModule(SeasonModule):GetCurSeasonObj()
  end
  Log.debug("###[UISeasonTalentLineMission] start load season info end!")
end

function UISeasonTalentLineMission:LineMissionList()
  local ware = self.wares[self.wareIdx]
  local missionList = ware.missionList
  self._nodePool:SpawnObjects("UISeasonTalentLineMissionNode", #missionList)
  self._linePool:SpawnObjects("UISeasonTalentLineMissionLine", #missionList)
  local pools = self._nodePool:GetAllSpawnList()
  local lines = self._linePool:GetAllSpawnList()
  local maxWidth = 0
  local pos
  for i = 1, #missionList do
    local node = pools[i]
    local line = lines[i]
    local missionid = missionList[i]
    local cfg = Cfg.cfg_component_line_mission({CampaignMissionId = missionid})[1]
    node:SetData(i, cfg, self._line_info, function(idx)
      self:OnNodeClick(idx)
    end)
    if i == 1 then
      line:Flush(nil)
    else
      local fromCfg = Cfg.cfg_component_line_mission({
        CampaignMissionId = cfg.NeedMissionId
      })[1]
      line:Flush(Vector2(fromCfg.MapPosX, fromCfg.MapPosY), Vector2(cfg.MapPosX, cfg.MapPosY))
    end
    maxWidth = math.max(maxWidth, cfg.MapPosX + 300)
    if missionid == self.currentMissionID then
      pos = cfg.MapPosX
    end
  end
  self._contentRT.sizeDelta = Vector2(maxWidth + 200, 0)
  self:ContentPos(pos)
end

function UISeasonTalentLineMission:OnNodeClick(idx)
  local ware = self.wares[self.wareIdx]
  local missionid = ware.missionList[idx]
  self:ShowDialog("UISeasonTalentLineStage", missionid, self._line_info.m_pass_mission_info, self._line_component)
  if not self._line_info.m_pass_mission_info[missionid] then
    GameGlobal.GetUIModule(SeasonModule):SetTalentTreeTreeClientTag(missionid)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnTalentTreeRedLineChange)
  end
  local info_cur_id = self._line_info.m_cur_mission
  GameGlobal.GetUIModule(SeasonModule):SetTalentTreeLineSelectMission(missionid, info_cur_id)
end

function UISeasonTalentLineMission:LineMissionTimer()
  self._timerTexItem = self._timerTexPool:SpawnObject("UISeasonTalentTimeBase")
  self._timerTexItem:SetData(self._endTime, function()
    self:TimerClose()
  end)
end

function UISeasonTalentLineMission:CurrentWareIdx()
  for index, ware in ipairs(self.wares) do
    for key, value in pairs(ware.missionList) do
      if value == self.currentMissionID then
        self.wareIdx = index
        return
      end
    end
  end
end

function UISeasonTalentLineMission:CurrentMissionID()
  local cache, info_cur_id = GameGlobal.GetUIModule(SeasonModule):GetTalentTreeLineSelectMission()
  if info_cur_id == self:ServerNewMission() then
    if cache then
      self.currentMissionID = cache
    else
      local passInfo = self._line_info.m_pass_mission_info
      for index, value in ipairs(self.wares) do
        for idx, id in ipairs(value.missionList) do
          if self:IsTimeUnLock(id) then
            self.currentMissionID = id
            if not passInfo[id] then
              return
            end
          else
            return
          end
        end
      end
    end
  else
    local passInfo = self._line_info.m_pass_mission_info
    for index, value in ipairs(self.wares) do
      for idx, id in ipairs(value.missionList) do
        if self:IsTimeUnLock(id) then
          self.currentMissionID = id
          if not passInfo[id] then
            return
          end
        else
          return
        end
      end
    end
  end
end

function UISeasonTalentLineMission:ServerNewMission()
  return self._line_info.m_cur_mission
end

function UISeasonTalentLineMission:ContentPos(pos)
  if not pos then
    self._contentRT.anchoredPosition = Vector2(0, 0)
    return
  end
  local curPos = self._contentRT.anchoredPosition.x
  local areaWidth = 408
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
    local moveTime = 0.5
    self._contentRT.anchoredPosition = Vector2(targetPos, 0)
  end
end

function UISeasonTalentLineMission:IsTimeUnLock(id)
  local cfg_com_line_mission = Cfg.cfg_component_line_mission({CampaignMissionId = id})
  if cfg_com_line_mission and next(cfg_com_line_mission) then
    local cfg = cfg_com_line_mission[1]
    local openTime = cfg.OpenTime
    if openTime then
      local open = self._loginModule:GetTimeStampByTimeStr(openTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      local nowTime = self._svrTimeModule:GetServerTime() * 0.001
      if open > nowTime then
        return false
      else
        return true
      end
    else
      return true
    end
  else
    Log.error("###[UISeasonTalentLineMission] cfg is nil ! id : ", id)
    return false
  end
end
