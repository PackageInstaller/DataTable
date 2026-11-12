local VampireLevelSelect_questCtrl = class("VampireLevelSelect_questCtrl", BaseCtrl)
VampireLevelSelect_questCtrl._mapNodeConfig = {
  rtWindow = {
    sComponentName = "CanvasGroup"
  },
  rtWeekly = {},
  rtPass = {},
  rtPassHard = {},
  lsvWeekly = {
    sComponentName = "LoopScrollView"
  },
  lsvPass = {
    sComponentName = "LoopScrollView"
  },
  listPassHard = {
    sComponentName = "LoopScrollView"
  },
  TMPScoreQuest = {sComponentName = "TMP_Text"},
  TMPTitleQuest = {sComponentName = "TMP_Text"},
  btnClose = {sComponentName = "UIButton", callback = "ClosePanel"},
  aniWindow = {sNodeName = "rtWindow", sComponentName = "Animator"},
  btnReceiveWeekly = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveWeekly"
  },
  btnReceivePass = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceivePass"
  },
  btnReceivePassHard = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceivePassHard"
  },
  snapshot = {},
  snapshotBtn = {
    sNodeName = "snapshot",
    sComponentName = "Button",
    callback = "ClosePanel"
  },
  TMPReceiveTitle = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Fast_Receive_Btn_Text"
  },
  TMPScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "VampireWeekScoreTitle"
  },
  TMPTogQuest = {sComponentName = "TMP_Text", nCount = 3},
  TMPTogOpenQuest = {sComponentName = "TMP_Text", nCount = 3},
  TMPRemainTimeQuest = {sComponentName = "TMP_Text"},
  imgTogLockQuest = {nCount = 3},
  imgTogOpenQuest = {nCount = 3},
  btnTogBtnQuest = {
    sComponentName = "UIButton",
    nCount = 3,
    callback = "OnBtnClick_Tog"
  },
  imgTimeBgQuest = {},
  goRedDot1 = {},
  goRedDot2 = {},
  goRedDot3 = {}
}
VampireLevelSelect_questCtrl._mapEventConfig = {}
VampireLevelSelect_questCtrl._mapRedDotConfig = {
  [RedDotDefine.VampireQuest_Normal] = {sNodeName = "goRedDot1"},
  [RedDotDefine.VampireQuest_Hard] = {sNodeName = "goRedDot2"},
  [RedDotDefine.VampireQuest_Season] = {sNodeName = "goRedDot3"}
}

function VampireLevelSelect_questCtrl:Awake()
  self.tbCurQuest = {}
  self.tbCurQuestSeason = {}
  self.tbCurQuestHard = {}
  self._mapGridCtrl = {}
  self.tbLockTog = {}
end

function VampireLevelSelect_questCtrl:FadeIn()
end

function VampireLevelSelect_questCtrl:FadeOut()
end

function VampireLevelSelect_questCtrl:OnEnable()
  NovaAPI.SetTMPText(self._mapNode.TMPTogQuest[1], ConfigTable.GetUIText("Vampire_Hard1"))
  NovaAPI.SetTMPText(self._mapNode.TMPTogQuest[2], ConfigTable.GetUIText("Vampire_Hard2"))
  NovaAPI.SetTMPText(self._mapNode.TMPTogQuest[3], ConfigTable.GetUIText("Vampire_Hard3"))
  NovaAPI.SetTMPText(self._mapNode.TMPTogOpenQuest[1], ConfigTable.GetUIText("Vampire_Hard1"))
  NovaAPI.SetTMPText(self._mapNode.TMPTogOpenQuest[2], ConfigTable.GetUIText("Vampire_Hard2"))
  NovaAPI.SetTMPText(self._mapNode.TMPTogOpenQuest[3], ConfigTable.GetUIText("Vampire_Hard3"))
end

function VampireLevelSelect_questCtrl:OnDisable()
end

function VampireLevelSelect_questCtrl:OnDestroy()
end

function VampireLevelSelect_questCtrl:OnRelease()
end

function VampireLevelSelect_questCtrl:OpenPanel(nType, nLevelId, bAnim)
  local sKey = nType == 1 and "VampireQuestTitle_Season" or "VampireQuestTitle_Pass"
  NovaAPI.SetTMPText(self._mapNode.TMPTitleQuest, ConfigTable.GetUIText(sKey))
  self.tbScore, self.tbPass = PlayerData.Quest:GetVampireQuestData()
  self.nType = nType
  self.nLevelId = nLevelId
  self.gameObject:SetActive(true)
  self._mapNode.rtWindow.gameObject:SetActive(false)
  self.nScore = PlayerData.VampireSurvivor:GetCurScore()
  self.tbCurQuestSeason = {}
  self.tbCurQuest = {}
  self.tbCurQuestHard = {}
  self.nGroupIdSeason = 0
  local nCurSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
  if nCurSeasonId ~= nil then
    local mapSeasonData = ConfigTable.GetData("VampireRankSeason", nCurSeasonId)
    if mapSeasonData ~= nil then
      self.nGroupIdSeason = mapSeasonData.QuestGroup
    end
  end
  for _, mapQuest in ipairs(self.tbScore) do
    local mapQuestCfgData = ConfigTable.GetData("VampireSurvivorQuest", mapQuest.nTid)
    if mapQuestCfgData ~= nil then
      table.insert(self.tbCurQuestSeason, mapQuest)
    end
  end
  self.tbCurQuest = {}
  self.nGroupId = 0
  if nLevelId ~= 0 and nLevelId ~= nil then
    local mapLevelCfgData = ConfigTable.GetData("VampireSurvivor", nLevelId)
    if mapLevelCfgData ~= nil then
      self.nGroupId = mapLevelCfgData.FirstQuestGroupId
    end
  end
  for _, mapQuest in ipairs(self.tbPass) do
    local mapQuestCfgData = ConfigTable.GetData("VampireSurvivorQuest", mapQuest.nTid)
    if mapQuestCfgData ~= nil then
      if mapQuestCfgData.Type == GameEnum.vampireSurvivorType.Normal then
        table.insert(self.tbCurQuest, mapQuest)
      elseif mapQuestCfgData.Type == GameEnum.vampireSurvivorType.Hard then
        table.insert(self.tbCurQuestHard, mapQuest)
      end
    end
  end
  local statusOrder = {
    [0] = 1,
    [1] = 2,
    [2] = 0
  }
  
  local function sort(a, b)
    local mapQuestACfg = ConfigTable.GetData("VampireSurvivorQuest", a.nTid)
    local mapQuestBCfg = ConfigTable.GetData("VampireSurvivorQuest", b.nTid)
    if a.nStatus ~= b.nStatus then
      return statusOrder[a.nStatus] > statusOrder[b.nStatus]
    elseif mapQuestACfg.GroupId ~= mapQuestBCfg.GroupId and (mapQuestACfg.GroupId == self.nGroupId or mapQuestBCfg.GroupId == self.nGroupId) then
      return mapQuestBCfg.GroupId ~= self.nGroupId
    else
      return a.nTid < b.nTid
    end
  end
  
  table.sort(self.tbCurQuestSeason, sort)
  table.sort(self.tbCurQuest, sort)
  table.sort(self.tbCurQuestHard, sort)
  self._mapNode.lsvWeekly:Init(#self.tbCurQuestSeason, self, self.OnGridRefreshSeason)
  self._mapNode.lsvPass:Init(#self.tbCurQuest, self, self.OnGridRefreshNormal)
  self._mapNode.listPassHard:Init(#self.tbCurQuestHard, self, self.OnGridRefreshHard)
  NovaAPI.SetTMPText(self._mapNode.TMPScoreQuest, self.nScore)
  self.tbLockTog = PlayerData.VampireSurvivor:GetHardUnlock()
  self._mapNode.imgTogLockQuest[1]:SetActive(not self.tbLockTog[1])
  self._mapNode.imgTogLockQuest[2]:SetActive(not self.tbLockTog[2])
  self._mapNode.imgTogLockQuest[3]:SetActive(not self.tbLockTog[3])
  self._mapNode.imgTimeBgQuest:SetActive(self.tbLockTog[3])
  if not self.tbLockTog[3] then
    NovaAPI.SetTMPText(self._mapNode.TMPRemainTimeQuest, PlayerData.VampireSurvivor:GetRefreshTiem())
  end
  if nLevelId ~= 0 and nLevelId ~= nil then
    local mapLevelCfgData = ConfigTable.GetData("VampireSurvivor", nLevelId)
    if mapLevelCfgData ~= nil then
      if mapLevelCfgData.Type == GameEnum.vampireSurvivorType.Normal then
        self:OnBtnClick_Tog(nil, 1)
      elseif mapLevelCfgData.Type == GameEnum.vampireSurvivorType.Hard then
        self:OnBtnClick_Tog(nil, 2)
      else
        self:OnBtnClick_Tog(nil, 3)
      end
    end
  elseif self.nType == 1 then
    self:OnBtnClick_Tog(nil, 1)
  elseif self.nType == 2 then
    self:OnBtnClick_Tog(nil, 2)
  elseif self.nType == 3 then
    self:OnBtnClick_Tog(nil, 3)
  end
  
  local function wait()
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.snapshot)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.rtWindow.gameObject:SetActive(true)
    if bAnim ~= false then
      self._mapNode.aniWindow:Play("t_window_04_t_in")
    end
  end
  
  cs_coroutine.start(wait)
end

function VampireLevelSelect_questCtrl:ClosePanel()
  self.gameObject:SetActive(false)
  self:UnbindAllGrids()
  self.tbCurQuestSeason = {}
  self.tbCurQuest = {}
  self.tbCurQuestHard = {}
end

function VampireLevelSelect_questCtrl:OnGridRefreshSeason(goGrid, nIdx)
  local nIdx = nIdx + 1
  if self._mapGridCtrl[goGrid] == nil then
    local gridCtrl = self:BindCtrlByNode(goGrid, "Game.UI.VampireLevelSelect.VampireLevelSelect_questGridCtrl")
    self._mapGridCtrl[goGrid] = gridCtrl
  end
  local mapQuestData
  mapQuestData = self.tbCurQuestSeason[nIdx]
  self._mapGridCtrl[goGrid]:Refresh(mapQuestData, -1)
end

function VampireLevelSelect_questCtrl:OnGridRefreshNormal(goGrid, nIdx)
  local nIdx = nIdx + 1
  if self._mapGridCtrl[goGrid] == nil then
    local gridCtrl = self:BindCtrlByNode(goGrid, "Game.UI.VampireLevelSelect.VampireLevelSelect_questGridCtrl")
    self._mapGridCtrl[goGrid] = gridCtrl
  end
  local mapQuestData
  mapQuestData = self.tbCurQuest[nIdx]
  self._mapGridCtrl[goGrid]:Refresh(mapQuestData, self.nGroupId)
end

function VampireLevelSelect_questCtrl:OnGridRefreshHard(goGrid, nIdx)
  local nIdx = nIdx + 1
  if self._mapGridCtrl[goGrid] == nil then
    local gridCtrl = self:BindCtrlByNode(goGrid, "Game.UI.VampireLevelSelect.VampireLevelSelect_questGridCtrl")
    self._mapGridCtrl[goGrid] = gridCtrl
  end
  local mapQuestData
  mapQuestData = self.tbCurQuestHard[nIdx]
  self._mapGridCtrl[goGrid]:Refresh(mapQuestData, self.nGroupId)
end

function VampireLevelSelect_questCtrl:UnbindAllGrids()
  for go, ctrl in pairs(self._mapGridCtrl) do
    self:UnbindCtrlByNode(ctrl)
  end
  self._mapGridCtrl = {}
end

function VampireLevelSelect_questCtrl:OnBtnClick_ReceiveWeekly()
  local tbQuestList = {}
  for _, mapData in ipairs(self.tbCurQuestSeason) do
    if mapData.nStatus == 1 then
      table.insert(tbQuestList, mapData.nTid)
    end
  end
  if #tbQuestList == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("InfinityTower_Reward_Tips") or "")
    return
  end
  
  local function callback(changeInfo)
    local function RewardCallback()
      self.tbScore, self.tbPass = PlayerData.Quest:GetVampireQuestData()
      
      self:OpenPanel(3, self.nLevelId, false)
    end
    
    UTILS.OpenReceiveByChangeInfo(changeInfo, RewardCallback)
  end
  
  PlayerData.Quest:ReceiveVampireQuest(10, tbQuestList, callback)
end

function VampireLevelSelect_questCtrl:OnBtnClick_ReceivePass()
  local tbQuestList = {}
  for _, mapData in ipairs(self.tbCurQuest) do
    if mapData.nStatus == 1 then
      table.insert(tbQuestList, mapData.nTid)
    end
  end
  if #tbQuestList == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("InfinityTower_Reward_Tips") or "")
    return
  end
  
  local function callback(changeInfo)
    local function RewardCallback()
      self.tbScore, self.tbPass = PlayerData.Quest:GetVampireQuestData()
      
      self:OpenPanel(1, self.nLevelId, false)
    end
    
    UTILS.OpenReceiveByChangeInfo(changeInfo, RewardCallback)
  end
  
  PlayerData.Quest:ReceiveVampireQuest(8, tbQuestList, callback)
end

function VampireLevelSelect_questCtrl:OnBtnClick_ReceivePassHard()
  local tbQuestList = {}
  for _, mapData in ipairs(self.tbCurQuestHard) do
    if mapData.nStatus == 1 then
      table.insert(tbQuestList, mapData.nTid)
    end
  end
  if #tbQuestList == 0 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("InfinityTower_Reward_Tips") or "")
    return
  end
  
  local function callback(changeInfo)
    local function RewardCallback()
      self.tbScore, self.tbPass = PlayerData.Quest:GetVampireQuestData()
      
      self:OpenPanel(2, self.nLevelId, false)
    end
    
    UTILS.OpenReceiveByChangeInfo(changeInfo, RewardCallback)
  end
  
  PlayerData.Quest:ReceiveVampireQuest(9, tbQuestList, callback)
end

function VampireLevelSelect_questCtrl:OnBtnClick_Tog(_, nIdx)
  if not self.tbLockTog[nIdx] then
    local sTip = ConfigTable.GetUIText("Vampire_Unlock")
    if nIdx == 2 then
      sTip = ConfigTable.GetUIText("Vampire_UnlockTipNormal")
    elseif nIdx == 3 then
      local nCurSeasonId = PlayerData.VampireSurvivor:GetCurSeason()
      if nCurSeasonId == nil or nCurSeasonId == 0 then
        sTip = ConfigTable.GetUIText("Vampire_NotOpenHint")
      else
        sTip = ConfigTable.GetUIText("Vampire_UnlockTipHard")
      end
    end
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  self._mapNode.rtWeekly:SetActive(nIdx == 3)
  self._mapNode.rtPassHard:SetActive(nIdx == 2)
  self._mapNode.rtPass:SetActive(nIdx == 1)
  self._mapNode.imgTogOpenQuest[1].gameObject:SetActive(nIdx == 1)
  self._mapNode.imgTogOpenQuest[2].gameObject:SetActive(nIdx == 2)
  self._mapNode.imgTogOpenQuest[3].gameObject:SetActive(nIdx == 3)
  self._mapNode.btnReceivePassHard.gameObject:SetActive(nIdx == 2)
  self._mapNode.btnReceivePass.gameObject:SetActive(nIdx == 1)
  self._mapNode.btnReceiveWeekly.gameObject:SetActive(nIdx == 3)
end

return VampireLevelSelect_questCtrl
