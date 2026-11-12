local SoldierLevelCtrl = class("SoldierLevelCtrl", BaseCtrl)
SoldierLevelCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  txtLevel = {sComponentName = "TMP_Text"},
  txtLevelCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_RewardLevel_Title"
  },
  txtExp = {sComponentName = "TMP_Text"},
  imgLevelProgressFill = {
    sComponentName = "RectTransform"
  },
  ActiveContainer = {
    sComponentName = "LoopScrollView"
  }
}
SoldierLevelCtrl._mapEventConfig = {
  [EventId.Soldier_Level_GetReward] = "Refresh"
}
SoldierLevelCtrl._mapRedDotConfig = {}
local nFillerLength = 226

function SoldierLevelCtrl:Awake()
  self.nScrollPosition = 0
end

function SoldierLevelCtrl:OnEnable()
  self.tbGridCtrl = {}
  self:Refresh()
end

function SoldierLevelCtrl:OnDisable()
  if self.tbGridCtrl ~= nil then
    for _, v in pairs(self.tbGridCtrl) do
      self:UnbindCtrlByNode(v)
    end
    self.tbGridCtrl = nil
  end
end

function SoldierLevelCtrl:Refresh()
  local nTotalRewardLevel, nCurLevelExp, nNextLevelExp = PlayerData.SoldierData:GetTotalRewardLevel()
  self.nCurExpFill = nCurLevelExp / nNextLevelExp
  NovaAPI.SetTMPText(self._mapNode.txtLevel, nTotalRewardLevel)
  NovaAPI.SetTMPText(self._mapNode.txtExp, nCurLevelExp .. "/" .. nNextLevelExp)
  local nRatio = math.ceil(self.nCurExpFill * 100) / 100
  self._mapNode.imgLevelProgressFill.sizeDelta = Vector2(nRatio * nFillerLength, self._mapNode.imgLevelProgressFill.sizeDelta.y)
  self.tbTotalReward = {}
  ForEachTableLine(ConfigTable.Get("SoldierTotalReward"), function(mapData)
    table.insert(self.tbTotalReward, mapData)
  end)
  table.sort(self.tbTotalReward, function(a, b)
    return a.Level < b.Level
  end)
  self._mapNode.ActiveContainer:Init(#self.tbTotalReward + 1, self, self.OnGridRefresh, nil, false, nil, false, true)
  local nReceivedTotalRewardLevel = PlayerData.SoldierData:GetReceivedTotalRewardLevel()
  self._mapNode.ActiveContainer:SetScrollGridPos(nReceivedTotalRewardLevel - 1, 0.5, 0)
end

function SoldierLevelCtrl:OnGridRefresh(goGrid, nGridIndex)
  local nIndex = nGridIndex + 1
  local nInstanceID = goGrid:GetInstanceID()
  if self.tbGridCtrl[nInstanceID] == nil then
    self.tbGridCtrl[nInstanceID] = self:BindCtrlByNode(goGrid, "Game.UI.Soldier.SoldierLevelNodeItemCtrl")
  end
  local nType = 1
  local nActProgress = 0
  local nReceivedTotalRewardLevel = PlayerData.SoldierData:GetReceivedTotalRewardLevel()
  local nCurRewardLv = PlayerData.SoldierData:GetCurRewardLv()
  if nIndex == #self.tbTotalReward + 1 then
    if nCurRewardLv == self.tbTotalReward[#self.tbTotalReward].Level then
      nActProgress = 1
    else
      nActProgress = 0
    end
    self.tbGridCtrl[nInstanceID]:SetNode(nil, nIndex, #self.tbTotalReward + 1, nType, nActProgress)
  else
    if nReceivedTotalRewardLevel >= self.tbTotalReward[nIndex].Level then
      nType = 1
      nActProgress = 1
    elseif nCurRewardLv >= self.tbTotalReward[nIndex].Level then
      nType = 2
      nActProgress = 1
    elseif self.tbTotalReward[nIndex].Level == nCurRewardLv + 1 then
      nType = 3
      nActProgress = math.ceil(self.nCurExpFill * 100) / 100
    else
      nType = 3
      nActProgress = 0
    end
    self.tbGridCtrl[nInstanceID]:SetNode(self.tbTotalReward[nIndex], nIndex, #self.tbTotalReward + 1, nType, nActProgress)
  end
end

return SoldierLevelCtrl
