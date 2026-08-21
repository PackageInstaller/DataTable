_class("UISeasonTalentLineMissionGroup", UICustomWidget)
UISeasonTalentLineMissionGroup = UISeasonTalentLineMissionGroup

function UISeasonTalentLineMissionGroup:OnShow()
  self._loginModule = GameGlobal.GetModule(LoginModule)
  self._svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  self._openGo = self:GetGameObject("open")
  self._closeGo = self:GetGameObject("close")
  self._openAlpha = self:GetUIComponent("CanvasGroup", "open")
  self._closeAlpha = self:GetUIComponent("CanvasGroup", "close")
  self._anim = self:GetUIComponent("Animation", "UISeasonTalentLineMission_Group")
  self._singlePool = self:GetUIComponent("UISelectObjectPath", "single")
  self._pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self:AttachEvent(GameEventType.OnTalentTreeRedLineChange, self.OnTalentTreeRedLineChange)
  self.anim2name = {
    open = "uianim_UISeasonTalentLineMission_Group_open",
    close = "uianim_UISeasonTalentLineMission_Group_out"
  }
end

function UISeasonTalentLineMissionGroup:SetData(missionID, component, showMissionList, loadSeasonCb)
  self.selectMissionID = missionID
  self.lineCom = component
  self.componentID = self.lineCom:GetComponentCfgId()
  self.lineComInfo = self.lineCom:GetComponentInfo()
  self.showMissionList = showMissionList
  self.loadSeasonCb = loadSeasonCb
  self:GetOpenState()
  self:CreateData()
  self:CreateItems()
  self:RefreshUI()
end

function UISeasonTalentLineMissionGroup:OnTalentTreeRedLineChange()
  self:CreateItems()
  self:RefreshUI()
end

function UISeasonTalentLineMissionGroup:RefreshUI()
  if self._isOpen then
    self._openAlpha.alpha = 1
    self._openAlpha.blocksRaycasts = true
    self._closeAlpha.alpha = 0
    self._closeAlpha.blocksRaycasts = false
  else
    self._openAlpha.alpha = 0
    self._openAlpha.blocksRaycasts = false
    self._closeAlpha.alpha = 1
    self._closeAlpha.blocksRaycasts = true
  end
end

function UISeasonTalentLineMissionGroup:CreateData()
  local cfgs = Cfg.cfg_season_talent_line_ware({
    ComponentID = self.componentID
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

function UISeasonTalentLineMissionGroup:CreateItems()
  self._singleIdx = self:GetWareIdx()
  self._singleItem = self._singlePool:SpawnObject("UISeasonTalentLineMissionGroupItem")
  self:ShowSingleWare()
  self._pool:SpawnObjects("UISeasonTalentLineMissionGroupItem", #self.wares)
  self._items = self._pool:GetAllSpawnList()
  for i = 1, #self.wares do
    local item = self._items[i]
    local ware = self.wares[i]
    local m_s1, m_s2 = self:GetStarWithIdx(i)
    local m_starTex = m_s1 .. "/" .. m_s2
    local m_wareLock, m_lockTime = self:GetWareLock(i)
    local red = false
    if not m_wareLock then
      red = self:GetWareRed(i)
    end
    item:SetData(i, ware, m_starTex, red, m_wareLock, m_lockTime, function(idx)
      self:OnGroupItemClick(idx)
    end, self.loadSeasonCb)
    item:Select(i == self._singleIdx)
  end
end

function UISeasonTalentLineMissionGroup:ShowSingleWare()
  local s1, s2 = self:GetStarWithIdx(self._singleIdx)
  local starTex = s1 .. "/" .. s2
  local wareLock, lockTime = self:GetWareLock(self._singleIdx)
  local red = false
  if not wareLock then
    red = self:GetWareRed(self._singleIdx)
  end
  self._singleItem:SetData(1, self.wares[self._singleIdx], starTex, red, wareLock, lockTime)
end

function UISeasonTalentLineMissionGroup:GetWareRed(idx)
  local ware = self.wares[idx]
  local passInfo = self.lineComInfo.m_pass_mission_info
  for i = 1, #ware.missionList do
    local missionid = ware.missionList[i]
    if not passInfo[missionid] then
      return true
    end
  end
  return false
end

function UISeasonTalentLineMissionGroup:OnGroupItemClick(idx)
  if self.showMissionList then
    self.showMissionList(idx)
  end
  self._singleIdx = idx
  self:ShowSingleWare()
  for i = 1, #self.wares do
    local item = self._items[i]
    item:Select(i == idx)
  end
end

function UISeasonTalentLineMissionGroup:GetWareLock(idx)
  local lock = false
  local lockTime
  local curWare = self.wares[idx]
  local firstMissionID = curWare.missionList[1]
  local cfg_com_line_mission = Cfg.cfg_component_line_mission({CampaignMissionId = firstMissionID})
  if cfg_com_line_mission and next(cfg_com_line_mission) then
    local cfg = cfg_com_line_mission[1]
    local openTime = cfg.OpenTime
    if openTime then
      local open = self._loginModule:GetTimeStampByTimeStr(openTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
      local nowTime = self._svrTimeModule:GetServerTime() * 0.001
      if open > nowTime then
        lockTime = open
        lock = true
      end
    end
  else
    Log.error("###[UISeasonTalentLineMissionGroup] cfg is nil ! id : ", firstMissionID)
  end
  if not lock and idx ~= 1 then
    local lastWare = self.wares[idx - 1]
    local lastMissionID = lastWare.missionList[#lastWare.missionList]
    local passInfo = self.lineComInfo.m_pass_mission_info
    if passInfo[lastMissionID] and passInfo[lastMissionID].star > 0 then
    else
      lock = true
    end
  end
  return lock, lockTime
end

function UISeasonTalentLineMissionGroup:GetStarWithIdx(idx)
  local curStar = 0
  local allStar = 0
  if idx then
    local ware = self.wares[idx]
    local missionList = ware.missionList
    local passInfo = self.lineComInfo.m_pass_mission_info
    for index, value in ipairs(missionList) do
      if passInfo[value] then
        curStar = curStar + GameGlobal.GetModule(MissionModule):ParseStarInfo(passInfo[value].star)
      end
      allStar = allStar + 3
    end
    return curStar, allStar
  end
end

function UISeasonTalentLineMissionGroup:GetWareIdx()
  if self.selectMissionID then
    for index, value in ipairs(self.wares) do
      for key, val in pairs(value.missionList) do
        if val == self.selectMissionID then
          return index
        end
      end
    end
    Log.error("###[UISeasonTalentLineMissionGroup] have select id : ", self.selectMissionID, "| cant find !")
  end
end

function UISeasonTalentLineMissionGroup:GetOpenState()
  self._isOpen = false
end

function UISeasonTalentLineMissionGroup:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self:UnLock("UISeasonTalentLineMissionGroup:PlayAnim")
end

function UISeasonTalentLineMissionGroup:OpenBtnOnClick(go)
  self._isOpen = true
  self:PlayAnim("open")
end

function UISeasonTalentLineMissionGroup:CloseBtnOnClick(go)
  self._isOpen = false
  self:PlayAnim("close")
end

function UISeasonTalentLineMissionGroup:PlayAnim(anim)
  self._anim:Stop()
  local animName = self.anim2name[anim]
  self._anim:Play(animName)
  self._openAlpha.blocksRaycasts = false
  self._closeAlpha.blocksRaycasts = false
  if anim == "open" then
    self._openAlpha.alpha = 0
    self._closeAlpha.alpha = 1
    if self._items then
      for i = 1, #self.wares do
        local item = self._items[i]
        local yieldTime = (i - 1) * 70
        item:PlayAnim(yieldTime)
      end
    end
  else
    self._openAlpha.alpha = 1
    self._closeAlpha.alpha = 0
    if self._singleItem then
      self._singleItem:PlayAnim(0)
    end
  end
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
  self:Lock("UISeasonTalentLineMissionGroup:PlayAnim")
  self._timer = GameGlobal.Timer():AddEvent(333, function()
    self:RefreshUI()
    self:UnLock("UISeasonTalentLineMissionGroup:PlayAnim")
  end)
end
