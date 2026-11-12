local LevelMenuStarTowerCtrl = class("LevelMenuStarTowerCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
LevelMenuStarTowerCtrl._mapNodeConfig = {
  svStarTower = {
    sComponentName = "LoopScrollView"
  },
  btnHandBook = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HandBook"
  },
  TMPBtnHandBook = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_BtnHandBook"
  },
  btnDevelop = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Develop"
  },
  TMPBtnDevelop = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_BtnDevelope"
  },
  btnTask = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Task"
  },
  TMPBtnTask = {
    sComponentName = "TMP_Text",
    sLanguageId = "LevelMenu_BtnTask"
  },
  imgRankInfoBg = {},
  imgStarTowerInfoCoinIcon = {sComponentName = "Image"},
  txtLimitCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "STRanking_Ranking_Weekly_Limit"
  },
  txtRankCoin = {sComponentName = "TMP_Text"},
  txtTime = {sComponentName = "TMP_Text"},
  redDotHandBook = {},
  redDotGrowth = {},
  redDotStarTowerQuest = {}
}
LevelMenuStarTowerCtrl._mapEventConfig = {
  Guide_GetGoGridByGroupTheme = "GetGoGridByGroupTheme",
  Guide_PositionStarTowerPos = "OnEvent_PositionStarTowerPos"
}
LevelMenuStarTowerCtrl._mapRedDotConfig = {
  [RedDotDefine.StarTowerGrowth] = {
    sNodeName = "redDotGrowth"
  },
  [RedDotDefine.StarTowerQuest] = {
    sNodeName = "redDotStarTowerQuest"
  },
  [RedDotDefine.StarTowerBook] = {
    sNodeName = "redDotHandBook"
  }
}

function LevelMenuStarTowerCtrl:InitStarTower(mapAllStarTower, mapStarTowerGroup)
  self:RefreshStarTowerReward()
  self.mapAllStarTower = mapAllStarTower
  self.mapStarTowerGroup = mapStarTowerGroup
  self._mapNode.svStarTower:SetAnim(0.06)
  self._mapNode.svStarTower:Init(#self.mapAllStarTower, self, self.RefreshGrid, self.OnBtnClick_Grid)
  if self._panel.nCurStarTowerGroupId ~= nil then
    EventManager.Hit("SelectStarTowerGroup", self._panel.nCurStarTowerGroupId, true)
    local nIndex = 0
    for k, v in ipairs(self.mapAllStarTower) do
      if v.nGroupId == self._panel.nCurStarTowerGroupId then
        nIndex = k
        break
      end
    end
    self._mapNode.svStarTower:SetScrollGridPos(nIndex - 1, 0)
  end
  EventManager.Hit("Guide_InitStarTowerFinish")
end

function LevelMenuStarTowerCtrl:RefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceID] then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.StarTowerLevelSelect.StarTowerGroupItemCtrl")
  end
  local mapGroupData = self.mapAllStarTower[nIndex]
  self.tbGridCtrl[nInstanceID]:SetStarTowerGroup(mapGroupData)
  if self._panel.nCurStarTowerGroupId == nil then
    self._panel.nCurStarTowerGroupId = mapGroupData.nGroupId
  end
  if self._panel.nCurStarTowerGroupId == mapGroupData.nGroupId then
    self.nCurInsId = nInstanceID
    self.tbGridCtrl[nInstanceID]:SetSelect(true)
  else
    self.tbGridCtrl[nInstanceID]:SetSelect(false)
  end
end

function LevelMenuStarTowerCtrl:OnBtnClick_Grid(goGrid, gridIndex)
  local nIdx = gridIndex + 1
  local mapData = self.mapAllStarTower[nIdx]
  if mapData == nil then
    return
  end
  local nGroupId = mapData.nGroupId
  local mapStarTower = self.mapStarTowerGroup[nGroupId][GameEnum.diffculty.Diffculty_1]
  local bGridUnlock, sTip = PlayerData.StarTower:IsStarTowerUnlock(mapStarTower.Id)
  if not bGridUnlock then
    WwiseAudioMgr:PlaySound("ui_systerm_locked")
    if sTip == nil then
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("LevelSelect_NotOpen"))
      return
    else
      EventManager.Hit(EventId.OpenMessageBox, sTip)
      return
    end
  end
  if self.nCurInsId ~= nil then
    self.tbGridCtrl[self.nCurInsId]:SetSelect(false)
  end
  self.nCurInsId = goGrid:GetInstanceID()
  self._panel.nCurStarTowerGroupId = nGroupId
  self.tbGridCtrl[self.nCurInsId]:SetSelect(true)
  WwiseAudioMgr:PlaySound("ui_level_rogue_tog")
  EventManager.Hit("SelectStarTowerGroup", nGroupId)
end

function LevelMenuStarTowerCtrl:RefreshStarTowerReward()
  local nLimit = PlayerData.StarTower:GetStarTowerRewardLimit()
  local nCur = PlayerData.StarTower:GetStarTowerTicket()
  local nRewardId = AllEnum.CoinItemId.FRRewardCurrency
  local mapItemCfg = ConfigTable.GetData_Item(nRewardId)
  if mapItemCfg ~= nil then
    self:SetPngSprite(self._mapNode.imgStarTowerInfoCoinIcon, mapItemCfg.Icon)
  end
  NovaAPI.SetTMPText(self._mapNode.txtRankCoin, nCur .. "/" .. nLimit)
  self:RefreshRewardResetTime()
end

function LevelMenuStarTowerCtrl:RefreshRewardResetTime()
  local curTime = CS.ClientManager.Instance.serverTimeStamp
  local nNextRefreshTime = GetNextWeekRefreshTime()
  local sTimeStr = ""
  local remainTime = nNextRefreshTime - curTime
  if remainTime <= 60 then
    local sec = math.floor(remainTime)
    sTimeStr = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Sec"), sec)
  elseif 60 < remainTime and remainTime <= 3600 then
    local min = math.floor(remainTime / 60)
    local sec = math.floor(remainTime - min * 60)
    if sec == 0 then
      min = min - 1
      sec = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Min"), min, sec)
  elseif 3600 < remainTime and remainTime <= 86400 then
    local hour = math.floor(remainTime / 3600)
    local min = math.floor((remainTime - hour * 3600) / 60)
    if min == 0 then
      hour = hour - 1
      min = 60
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Hour"), hour, min)
  elseif 86400 < remainTime then
    local day = math.floor(remainTime / 86400)
    local hour = math.floor((remainTime - day * 86400) / 3600)
    if hour == 0 then
      day = day - 1
      hour = 24
    end
    sTimeStr = orderedFormat(ConfigTable.GetUIText("StarTower_Reward_Refresh_Remain_Time_Day"), day, hour)
  end
  NovaAPI.SetTMPText(self._mapNode.txtTime, orderedFormat(ConfigTable.GetUIText("StarTower_Weekly_Reward_Refresh"), sTimeStr))
end

function LevelMenuStarTowerCtrl:Awake()
  self.mapAllStarTower = {}
  self.mapStarTowerGroup = {}
  self.nCurInsId = nil
  self.tbGridCtrl = {}
end

function LevelMenuStarTowerCtrl:FadeIn()
end

function LevelMenuStarTowerCtrl:FadeOut()
end

function LevelMenuStarTowerCtrl:OnEnable()
end

function LevelMenuStarTowerCtrl:OnDisable()
  if nil ~= self.phoneTimer then
    self.phoneTimer:Cancel()
    self.phoneTimer = nil
  end
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
  self.nCurInsId = nil
end

function LevelMenuStarTowerCtrl:OnDestroy()
end

function LevelMenuStarTowerCtrl:OnRelease()
end

function LevelMenuStarTowerCtrl:OnBtnClick_Build(btn)
  local function func()
    EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildBriefList)
  end
  
  EventManager.Hit(EventId.SetTransition, 2, func)
end

function LevelMenuStarTowerCtrl:OnBtnClick_HandBook()
  EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBook)
end

function LevelMenuStarTowerCtrl:OnBtnClick_Develop()
  EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerGrowth)
end

function LevelMenuStarTowerCtrl:OnBtnClick_Task()
  EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerQuest)
end

function LevelMenuStarTowerCtrl:GetGoGridByGroupTheme(themeId)
  for i, v in pairs(self.tbGridCtrl) do
    if v:GetGroupTheme() == themeId then
      EventManager.Hit("Guide_LevelMenuGridByGroupThemeName", v.gameObject.name)
    end
  end
end

function LevelMenuStarTowerCtrl:OnEvent_PositionStarTowerPos(nGroupId)
  for i, v in ipairs(self.mapAllStarTower) do
    if v.nGroupId == nGroupId then
      self._mapNode.svStarTower:SetScrollGridPos(i - 1, 0, 0)
      EventManager.Hit("Positioning_StarTower_Grid", nGroupId, i - 1)
      break
    end
  end
end

return LevelMenuStarTowerCtrl
