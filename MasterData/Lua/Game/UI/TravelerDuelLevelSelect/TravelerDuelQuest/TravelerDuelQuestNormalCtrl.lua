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
  TMPProcessGroup = {sComponentName = "TMP_Text"},
  rtBarFillGroup = {
    sComponentName = "RectTransform"
  },
  srNormalQuest = {
    sComponentName = "LoopScrollView"
  },
  TMPGroupTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_QusetTitle"
  }
}
TravelerDuelQuestSeasonCtrl._mapEventConfig = {}

function TravelerDuelQuestSeasonCtrl:Awake()
  self.mapQuestsGrids = {}
  self.AllQuests = {}
  
  local function forEachTravelerDuelQuest(mapData)
    table.insert(self.AllQuests, mapData)
  end
  
  ForEachTableLine(DataTable.TravelerDuelQuest, forEachTravelerDuelQuest)
end

function TravelerDuelQuestSeasonCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.mapQuestsGrids) do
    self:UnbindCtrlByNode(objCtrl)
    self.mapQuestsGrids[nInstanceId] = nil
  end
  self.mapQuestsGrids = {}
end

function TravelerDuelQuestSeasonCtrl:Refresh(mapQuest)
  self.mapQuest = mapQuest
  local statusOrder = {
    [0] = 1,
    [1] = 2,
    [2] = 0
  }
  self.curAllQuests = {}
  for _, mapQuestData in ipairs(self.AllQuests) do
    if self.mapQuest[mapQuestData.Id] ~= nil then
      table.insert(self.curAllQuests, mapQuestData)
    end
  end
  
  local function sort(a, b)
    if mapQuest[a.Id] ~= nil and mapQuest[b.Id] ~= nil and mapQuest[a.Id].nStatus ~= mapQuest[b.Id].nStatus then
      return statusOrder[mapQuest[a.Id].nStatus] > statusOrder[mapQuest[b.Id].nStatus]
    end
    return a.Id < b.Id
  end
  
  table.sort(self.curAllQuests, sort)
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
  if self.gameObject.activeInHierarchy then
    self._mapNode.srNormalQuest:SetAnim(0.08)
  end
  self._mapNode.srNormalQuest:Init(#self.curAllQuests, self, self.OnQuestGridRefresh, nil, false)
end

function TravelerDuelQuestSeasonCtrl:OnQuestGridRefresh(goGrid, gridIndex)
  if self.mapQuestsGrids[goGrid] == nil then
    self.mapQuestsGrids[goGrid] = self:BindCtrlByNode(goGrid, "Game.UI.TravelerDuelLevelSelect.TravelerDuelQuest.TravelerDuelQuestGridCtrl")
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
  PlayerData.Quest:ReceiveTravelerDuelReward(0, nil)
end

return TravelerDuelQuestSeasonCtrl
