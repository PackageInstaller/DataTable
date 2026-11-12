local TravelerDuelQuestSeasonCtrl = class("TravelerDuelQuestSeasonCtrl", BaseCtrl)
local totalLength = 130
local totalHeight = 19
TravelerDuelQuestSeasonCtrl._mapNodeConfig = {
  btnFastReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FastReceive"
  },
  txtBtnFastReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_ReceiveAll"
  },
  TMPGroupTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_QusetTitle"
  },
  TMP_SeasonEndTime = {sComponentName = "TMP_Text"},
  imgCover = {sComponentName = "Image"},
  TMPProcessGroup = {sComponentName = "TMP_Text"},
  TMP_QuestHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_SeasonQuestHint"
  },
  rtBarFillGroup = {
    sComponentName = "RectTransform"
  },
  srSeasonQuests = {
    sComponentName = "LoopScrollView"
  }
}
TravelerDuelQuestSeasonCtrl._mapEventConfig = {}

function TravelerDuelQuestSeasonCtrl:Awake()
  self.mapQuestsGrids = {}
  self.mapAllQuests = {}
  
  local function forEachTravelerDuelChallengeQuest(mapData)
    if self.mapAllQuests[mapData.GroupId] == nil then
      self.mapAllQuests[mapData.GroupId] = {}
    end
    table.insert(self.mapAllQuests[mapData.GroupId], mapData)
  end
  
  ForEachTableLine(DataTable.TravelerDuelChallengeQuest, forEachTravelerDuelChallengeQuest)
end

function TravelerDuelQuestSeasonCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.mapQuestsGrids) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapQuestsGrids[nInstanceId] = nil
  end
  self.mapQuestsGrids = {}
end

function TravelerDuelQuestSeasonCtrl:Refresh(mapQuest, mapSeasonData)
  local mapSeason = ConfigTable.GetData("TravelerDuelChallengeSeason", mapSeasonData.nIdx)
  if mapSeason == nil then
    return
  end
  self.curGroup = mapSeason.QuestGroupId
  self.mapQuest = mapQuest
  self.curAllQuests = {}
  for _, mapQuestData in ipairs(self.mapAllQuests[self.curGroup]) do
    if self.mapQuest[mapQuestData.Id] ~= nil then
      table.insert(self.curAllQuests, mapQuestData)
    end
  end
  local statusOrder = {
    [0] = 1,
    [1] = 2,
    [2] = 0
  }
  
  local function sort(a, b)
    if mapQuest[a.Id] ~= nil and mapQuest[b.Id] ~= nil and mapQuest[a.Id].nStatus ~= mapQuest[b.Id].nStatus then
      return statusOrder[mapQuest[a.Id].nStatus] > statusOrder[mapQuest[b.Id].nStatus]
    end
    return a.Id < b.Id
  end
  
  table.sort(self.curAllQuests, sort)
  self:SetPngSprite(self._mapNode.imgCover, "Icon/ZZZOther/" .. mapSeason.BackGroundSource)
  local nDay = math.floor((mapSeasonData.nCloseTime - CS.ClientManager.Instance.serverTimeStamp) / 3600 / 24)
  local nHour = math.floor((mapSeasonData.nCloseTime - CS.ClientManager.Instance.serverTimeStamp) / 3600)
  local nMin = math.ceil((mapSeasonData.nCloseTime - CS.ClientManager.Instance.serverTimeStamp) / 60)
  if 1 < nDay then
    NovaAPI.SetTMPText(self._mapNode.TMP_SeasonEndTime, orderedFormat(ConfigTable.GetUIText("TDQuest_Day"), nDay))
  elseif 1 < nHour then
    NovaAPI.SetTMPText(self._mapNode.TMP_SeasonEndTime, orderedFormat(ConfigTable.GetUIText("TDQuest_Hour"), nHour))
  else
    NovaAPI.SetTMPText(self._mapNode.TMP_SeasonEndTime, orderedFormat(ConfigTable.GetUIText("TDQuest_Min"), nMin))
  end
  local nTotal = #self.curAllQuests
  local nCur = 0
  for _, mapData in pairs(mapQuest) do
    if mapQuest ~= nil and mapData.nStatus == 2 then
      nCur = nCur + 1
    end
  end
  local bFastReceive = false
  for _, mapData in pairs(self.mapQuest) do
    if mapData.nStatus == 1 then
      bFastReceive = true
      break
    end
  end
  self._mapNode.btnFastReceive.gameObject:SetActive(bFastReceive)
  NovaAPI.SetTMPText(self._mapNode.TMPProcessGroup, string.format("<color=#FFA2D8>%d</color>/%d", nCur, nTotal))
  self._mapNode.rtBarFillGroup.sizeDelta = Vector2(nCur / nTotal * totalLength, totalHeight)
  self._mapNode.srSeasonQuests.gameObject:SetActive(#self.curAllQuests > 0)
  self._mapNode.srSeasonQuests:SetAnim(0.08)
  self._mapNode.srSeasonQuests:Init(#self.curAllQuests, self, self.OnQuestGridRefresh, nil, false)
end

function TravelerDuelQuestSeasonCtrl:OnQuestGridRefresh(goGrid, gridIndex)
  if self.mapQuestsGrids[goGrid] == nil then
    self.mapQuestsGrids[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.TravelerDuelLevelSelect.TravelerDuelQuest.TravelerDuelQuestSeasonGridCtrl")
  end
  local nIdx = gridIndex + 1
  local mapQuestCfgData = self.curAllQuests[nIdx]
  if mapQuestCfgData == nil then
    printError("GuideQuestData missing" .. nIdx)
    self.mapQuestsGrids[goGrid]:Refresh(nil, nil)
    return
  end
  self.mapQuestsGrids[goGrid]:Refresh(self.mapQuest[mapQuestCfgData.Id], mapQuestCfgData)
end

function TravelerDuelQuestSeasonCtrl:OnBtnClick_FastReceive()
  PlayerData.Quest:ReceiveTravelerDuelChallengeReward(0, nil)
end

return TravelerDuelQuestSeasonCtrl
