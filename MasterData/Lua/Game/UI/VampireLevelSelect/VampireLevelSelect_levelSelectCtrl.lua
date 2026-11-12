local VampireLevelSelect_levelSelectCtrl = class("VampireLevelSelect_levelSelectCtrl", BaseCtrl)
VampireLevelSelect_levelSelectCtrl._mapNodeConfig = {
  rtList = {},
  rtListHard = {},
  svLevelList = {
    sComponentName = "LoopScrollView"
  },
  svLevelListHard = {
    sComponentName = "LoopScrollView"
  },
  rtDisaster = {},
  TMPTog = {sComponentName = "TMP_Text", nCount = 3},
  TMPTogOpen = {sComponentName = "TMP_Text", nCount = 3},
  imgTogLock = {nCount = 3},
  imgTogOpen = {nCount = 3},
  btnTogBtn = {
    sComponentName = "UIButton",
    nCount = 3,
    callback = "OnBtnClick_Tog"
  },
  gridDisaster = {
    sCtrlName = "Game.UI.VampireLevelSelect.VampireLevelSelect_levelGridCtrl_Disaster"
  },
  imgTimeBgLevelSelect = {},
  TMPRemainTimeLevelSelect = {sComponentName = "TMP_Text"},
  TMPWeekScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Vampire_Season_Score"
  },
  TMPWeekScore = {sComponentName = "TMP_Text"}
}
VampireLevelSelect_levelSelectCtrl._mapEventConfig = {
  VampireQuestRefresh = "OnEvent_VampireQuestRefresh"
}
VampireLevelSelect_levelSelectCtrl._mapRedDotConfig = {}

function VampireLevelSelect_levelSelectCtrl:Awake()
  self.mapGrid = {}
  self.tbNormalLevel = {}
  self.tbHardLevel = {}
  self.mapSeasonLevel = nil
  self.curToggle = 0
  self.tbTogUnlock = {}
  local nCurSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
  local nCurSeasonLevel = 0
  if nCurSeasonId ~= nil then
    local mapSeasonData = ConfigTable.GetData("VampireRankSeason", nCurSeasonId)
    if mapSeasonData ~= nil then
      nCurSeasonLevel = mapSeasonData.MissionId
    end
  end
  
  local function forEachVampireLevel(mapData)
    if mapData.Type == GameEnum.vampireSurvivorType.Normal then
      table.insert(self.tbNormalLevel, mapData)
    elseif mapData.Type == GameEnum.vampireSurvivorType.Hard then
      table.insert(self.tbHardLevel, mapData)
    elseif mapData.Id == nCurSeasonLevel then
      self.mapSeasonLevel = mapData
    end
  end
  
  ForEachTableLine(DataTable.VampireSurvivor, forEachVampireLevel)
  
  local function sort(a, b)
    return a.Id < b.Id
  end
  
  table.sort(self.tbNormalLevel, sort)
  table.sort(self.tbHardLevel, sort)
end

function VampireLevelSelect_levelSelectCtrl:FadeIn()
end

function VampireLevelSelect_levelSelectCtrl:FadeOut()
end

function VampireLevelSelect_levelSelectCtrl:OnEnable()
  self._mapNode.imgTogOpen[1]:SetActive(true)
  self._mapNode.imgTogOpen[2]:SetActive(false)
  self._mapNode.imgTogOpen[3]:SetActive(false)
  self._mapNode.rtList.gameObject:SetActive(true)
  self._mapNode.rtListHard.gameObject:SetActive(false)
  self._mapNode.rtDisaster:SetActive(false)
  self:Refresh()
  NovaAPI.SetTMPText(self._mapNode.TMPTog[1], ConfigTable.GetUIText("Vampire_Hard1"))
  NovaAPI.SetTMPText(self._mapNode.TMPTog[2], ConfigTable.GetUIText("Vampire_Hard2"))
  NovaAPI.SetTMPText(self._mapNode.TMPTog[3], ConfigTable.GetUIText("Vampire_Hard3"))
  NovaAPI.SetTMPText(self._mapNode.TMPTogOpen[1], ConfigTable.GetUIText("Vampire_Hard1"))
  NovaAPI.SetTMPText(self._mapNode.TMPTogOpen[2], ConfigTable.GetUIText("Vampire_Hard2"))
  NovaAPI.SetTMPText(self._mapNode.TMPTogOpen[3], ConfigTable.GetUIText("Vampire_Hard3"))
  local bUnlock1 = self:CheckHardUnlock(1)
  local bUnlock2 = self:CheckHardUnlock(2)
  local bUnlock3 = self:CheckHardUnlock(3)
  self.bShowTog1 = false
  self.bShowTog2 = false
  self._mapNode.imgTogLock[1]:SetActive(not bUnlock1)
  self._mapNode.imgTogLock[2]:SetActive(not bUnlock2)
  self._mapNode.imgTogLock[3]:SetActive(not bUnlock3)
  self.tbTogUnlock = {
    bUnlock1,
    bUnlock2,
    bUnlock3
  }
  self._mapNode.imgTimeBgLevelSelect:SetActive(PlayerData.VampireSurvivor:GetCurSeason() ~= 0 and bUnlock3)
  if self.curToggle == 0 then
    if bUnlock3 then
      self:OnBtnClick_Tog(nil, 3)
      EventManager.Hit("VampireQuestTitle", 3)
    elseif bUnlock2 then
      self:OnBtnClick_Tog(nil, 2)
      EventManager.Hit("VampireQuestTitle", 2)
    else
      self:OnBtnClick_Tog(nil, 1)
      EventManager.Hit("VampireQuestTitle", 1)
    end
  else
    local nIdx = self.curToggle
    self.curToggle = 0
    self:OnBtnClick_Tog(nil, nIdx)
    EventManager.Hit("VampireQuestTitle", self.curToggle)
  end
  NovaAPI.SetTMPText(self._mapNode.TMPRemainTimeLevelSelect, PlayerData.VampireSurvivor:GetRefreshTiem())
  NovaAPI.SetTMPText(self._mapNode.TMPWeekScore, string.formatnumberthousands(PlayerData.VampireSurvivor:GetCurScore()))
end

function VampireLevelSelect_levelSelectCtrl:Refresh()
  self._mapNode.svLevelList:Init(#self.tbNormalLevel, self, self.OnGridRefresh, self.OnBtnClickGrid, false)
  self._mapNode.svLevelListHard:Init(#self.tbHardLevel, self, self.OnGridRefreshHard, self.OnBtnClickGrid, false)
  if self.mapSeasonLevel ~= nil then
    self._mapNode.gridDisaster:Refresh(self.mapSeasonLevel)
  end
end

function VampireLevelSelect_levelSelectCtrl:RefreshWithPosSet(nCurLevel)
  self:Refresh()
  local bUnlock1 = self:CheckHardUnlock(1)
  local bUnlock2 = self:CheckHardUnlock(2)
  local bUnlock3 = self:CheckHardUnlock(3)
  self.bShowTog1 = true
  self.bShowTog2 = true
  self._mapNode.imgTogLock[1]:SetActive(not bUnlock1)
  self._mapNode.imgTogLock[2]:SetActive(not bUnlock2)
  self._mapNode.imgTogLock[3]:SetActive(not bUnlock3)
  self.tbTogUnlock = {
    bUnlock1,
    bUnlock2,
    bUnlock3
  }
  self._mapNode.imgTimeBgLevelSelect:SetActive(PlayerData.VampireSurvivor:GetCurSeason() ~= 0 and bUnlock3)
  if self.curToggle == 0 then
    if bUnlock3 then
      self:OnBtnClick_Tog(nil, 3)
      EventManager.Hit("VampireQuestTitle", 3)
    elseif bUnlock2 then
      self:OnBtnClick_Tog(nil, 2)
      EventManager.Hit("VampireQuestTitle", 2)
    else
      self:OnBtnClick_Tog(nil, 1)
      EventManager.Hit("VampireQuestTitle", 1)
    end
  else
    self:OnBtnClick_Tog(nil, self.curToggle)
    EventManager.Hit("VampireQuestTitle", self.curToggle)
  end
  if self.curToggle == 1 then
    local nFirstLevel = 1
    for index, value in ipairs(self.tbNormalLevel) do
      if value.Id == nCurLevel then
        nFirstLevel = index
      end
    end
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self._mapNode.svLevelList:SetScrollGridPos(nFirstLevel - 1, 0.5, 0)
    end
    
    cs_coroutine.start(wait)
    self.bShowTog1 = true
  end
  if self.curToggle == 2 then
    local nFirstLevel = 1
    for index, value in ipairs(self.tbHardLevel) do
      if value.Id == nCurLevel then
        nFirstLevel = index
      end
    end
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self._mapNode.svLevelListHard:SetScrollGridPos(nFirstLevel - 1, 0.5, 0)
    end
    
    cs_coroutine.start(wait)
    self.bShowTog2 = true
  end
  NovaAPI.SetTMPText(self._mapNode.TMPRemainTimeLevelSelect, PlayerData.VampireSurvivor:GetRefreshTiem())
  NovaAPI.SetTMPText(self._mapNode.TMPWeekScore, string.formatnumberthousands(PlayerData.VampireSurvivor:GetCurScore()))
  self.bShowTog1 = false
  self.bShowTog2 = false
end

function VampireLevelSelect_levelSelectCtrl:NewSeason()
  self.mapSeasonLevel = nil
  local nCurSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
  local nCurSeasonLevel = 0
  if nCurSeasonId ~= nil then
    local mapSeasonData = ConfigTable.GetData("VampireRankSeason", nCurSeasonId)
    if mapSeasonData ~= nil then
      nCurSeasonLevel = mapSeasonData.MissionId
    end
  end
  
  local function forEachVampireLevel(mapData)
    if mapData.Id == nCurSeasonLevel then
      self.mapSeasonLevel = mapData
    end
  end
  
  ForEachTableLine(DataTable.VampireSurvivor, forEachVampireLevel)
  self:Refresh()
  local bUnlock1 = self:CheckHardUnlock(1)
  local bUnlock2 = self:CheckHardUnlock(2)
  local bUnlock3 = self:CheckHardUnlock(3)
  self.bShowTog1 = false
  self.bShowTog2 = false
  self._mapNode.imgTogLock[1]:SetActive(not bUnlock1)
  self._mapNode.imgTogLock[2]:SetActive(not bUnlock2)
  self._mapNode.imgTogLock[3]:SetActive(not bUnlock3)
  self.tbTogUnlock = {
    bUnlock1,
    bUnlock2,
    bUnlock3
  }
  self._mapNode.imgTimeBgLevelSelect:SetActive(PlayerData.VampireSurvivor:GetCurSeason() ~= 0 and bUnlock3)
  if self.curToggle == 0 then
    if bUnlock3 then
      self:OnBtnClick_Tog(nil, 3)
      EventManager.Hit("VampireQuestTitle", 3)
    elseif bUnlock2 then
      self:OnBtnClick_Tog(nil, 2)
      EventManager.Hit("VampireQuestTitle", 2)
    else
      self:OnBtnClick_Tog(nil, 1)
      EventManager.Hit("VampireQuestTitle", 1)
    end
  else
    self:OnBtnClick_Tog(nil, self.curToggle)
    EventManager.Hit("VampireQuestTitle", self.curToggle)
  end
  NovaAPI.SetTMPText(self._mapNode.TMPRemainTimeLevelSelect, PlayerData.VampireSurvivor:GetRefreshTiem())
  NovaAPI.SetTMPText(self._mapNode.TMPWeekScore, string.formatnumberthousands(PlayerData.VampireSurvivor:GetCurScore()))
end

function VampireLevelSelect_levelSelectCtrl:CheckHardUnlock(nHard)
  local bUnLock, param1, param2
  if nHard == 1 then
    for _, mapData in ipairs(self.tbNormalLevel) do
      bUnLock, param1, param2 = PlayerData.VampireSurvivor:CheckLevelUnlock(mapData.Id)
      if bUnLock then
        return true, 0, 0
      end
    end
  elseif nHard == 2 then
    for _, mapData in ipairs(self.tbHardLevel) do
      bUnLock, param1, param2 = PlayerData.VampireSurvivor:CheckLevelUnlock(mapData.Id)
      if bUnLock then
        return true, 0, 0
      end
    end
  elseif self.mapSeasonLevel ~= nil then
    bUnLock, param1, param2 = PlayerData.VampireSurvivor:CheckLevelUnlock(self.mapSeasonLevel.Id)
    if bUnLock then
      return true, 0, 0
    end
  end
  return false, param1, param2
end

function VampireLevelSelect_levelSelectCtrl:OnGridRefresh(goGrid, gridIndex)
  if self.mapGrid[goGrid] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.VampireLevelSelect.VampireLevelSelect_levelGridCtrl")
    self.mapGrid[goGrid] = mapCtrl
  end
  local nIdx = gridIndex
  if nIdx == nil then
    return
  end
  nIdx = nIdx + 1
  local mapData = self.tbNormalLevel[nIdx]
  self.mapGrid[goGrid]:Refresh(mapData)
end

function VampireLevelSelect_levelSelectCtrl:OnGridRefreshHard(goGrid, gridIndex)
  if self.mapGrid[goGrid] == nil then
    local mapCtrl = self:BindCtrlByNode(goGrid, "Game.UI.VampireLevelSelect.VampireLevelSelect_levelGridCtrl")
    self.mapGrid[goGrid] = mapCtrl
  end
  local nIdx = gridIndex
  if nIdx == nil then
    return
  end
  nIdx = nIdx + 1
  local mapData = self.tbHardLevel[nIdx]
  self.mapGrid[goGrid]:Refresh(mapData)
end

function VampireLevelSelect_levelSelectCtrl:OnBtnClickGrid(goGrid, gridIndex)
  local WwiseManger = CS.WwiseAudioManager.Instance
  local nIdx = gridIndex
  if nIdx == nil then
    return
  end
  nIdx = nIdx + 1
  local mapData = self.tbNormalLevel[nIdx]
  if self.curToggle == 1 then
    mapData = self.tbNormalLevel[nIdx]
  elseif self.curToggle == 2 then
    mapData = self.tbHardLevel[nIdx]
  else
    mapData = self.mapSeasonLevel
  end
  local bUnLock, nType, content = PlayerData.VampireSurvivor:CheckLevelUnlock(mapData.Id)
  if not bUnLock then
    local sKey = "VampireTalent_LockCond" .. nType
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText(sKey), content))
  else
    EventManager.Hit("VampireLevelSelect_ClickLevelGrid", mapData)
    WwiseManger:PostEvent("ui_vampire_level_select")
  end
end

function VampireLevelSelect_levelSelectCtrl:UnbindAllCtrl()
  for _, mapCtrl in pairs(self.mapGrid) do
    self:UnbindCtrlByNode(mapCtrl)
  end
  self.mapGrid = {}
end

function VampireLevelSelect_levelSelectCtrl:OnDisable()
  self:UnbindAllCtrl()
end

function VampireLevelSelect_levelSelectCtrl:OnDestroy()
end

function VampireLevelSelect_levelSelectCtrl:OnRelease()
end

function VampireLevelSelect_levelSelectCtrl:OnBtnClick_Tog(btn, nIdx)
  local bUnLock, param1, param2 = self:CheckHardUnlock(nIdx)
  if not bUnLock then
    local sTip = ConfigTable.GetUIText("Vampire_Unlock")
    if nIdx == 2 then
      sTip = ConfigTable.GetUIText("Vampire_UnlockTipNormal")
    elseif nIdx == 3 then
      local nCurSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
      if nCurSeasonId == nil or nCurSeasonId == 0 then
        sTip = ConfigTable.GetUIText("Vampire_NotOpenHint")
      elseif param1 ~= nil and 0 < param1 then
        local sKey = "VampireTalent_LockCond" .. param1
        sTip = orderedFormat(ConfigTable.GetUIText(sKey), param2)
      end
    end
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  self.curToggle = nIdx
  self._mapNode.imgTogOpen[1]:SetActive(self.curToggle == 1)
  self._mapNode.imgTogOpen[2]:SetActive(self.curToggle == 2)
  self._mapNode.imgTogOpen[3]:SetActive(self.curToggle == 3)
  self._mapNode.rtList.gameObject:SetActive(self.curToggle == 1)
  self._mapNode.rtListHard.gameObject:SetActive(self.curToggle == 2)
  self._mapNode.rtDisaster:SetActive(self.curToggle == 3)
  EventManager.Hit("VampireQuestTitle", nIdx)
  EventManager.Hit("VampireToggleChange", nIdx)
  if not self.bShowTog1 and self.curToggle == 1 then
    local nFirstLevel = 1
    for index, value in ipairs(self.tbNormalLevel) do
      local bUnLock, nType, content = PlayerData.VampireSurvivor:CheckLevelUnlock(value.Id)
      if bUnLock then
        nFirstLevel = index
      end
    end
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self._mapNode.svLevelList:SetScrollGridPos(nFirstLevel - 1, 0.5, 0)
    end
    
    cs_coroutine.start(wait)
    self.bShowTog1 = true
  end
  if not self.bShowTog2 and self.curToggle == 2 then
    local nFirstLevel = 1
    for index, value in ipairs(self.tbHardLevel) do
      local bUnLock, nType, content = PlayerData.VampireSurvivor:CheckLevelUnlock(value.Id)
      if bUnLock then
        nFirstLevel = index
      end
    end
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self._mapNode.svLevelListHard:SetScrollGridPos(nFirstLevel - 1, 0.5, 0)
    end
    
    cs_coroutine.start(wait)
    self.bShowTog2 = true
  end
end

function VampireLevelSelect_levelSelectCtrl:OnEvent_VampireQuestRefresh()
  EventManager.Hit("VampireQuestTitle", self.curToggle)
end

return VampireLevelSelect_levelSelectCtrl
