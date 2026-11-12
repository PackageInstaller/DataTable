local TravelerDuelQuestSeasonGridCtrl = class("TravelerDuelQuestSeasonGridCtrl", BaseCtrl)
local totalLength = 517
local totalHeight = 37
local JumpUtil = require("Game.Common.Utils.JumpUtil")
TravelerDuelQuestSeasonGridCtrl._mapNodeConfig = {
  TMPTitle = {sComponentName = "TMP_Text"},
  TMPUncomplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_undone"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  txtBtnJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  rtBarFill = {
    sComponentName = "RectTransform"
  },
  TMPProcess = {sComponentName = "TMP_Text"},
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  btnJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_JumpTo"
  },
  rtReward = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  imgComplete = {},
  imgCompleteMask = {}
}
TravelerDuelQuestSeasonGridCtrl._mapEventConfig = {}

function TravelerDuelQuestSeasonGridCtrl:Refresh(mapSeasonQuest, mapSeasonQuestCfgData)
  if mapSeasonQuest == nil then
    self.gameObject:SetActive(false)
    return
  end
  if mapSeasonQuestCfgData == nil then
    printError("guide quest data missing:" .. mapSeasonQuest.nTid)
    self.gameObject:SetActive(false)
    return
  end
  self.mapSeasonQuestCfgData = mapSeasonQuestCfgData
  self.mapSeasonQuest = mapSeasonQuest
  NovaAPI.SetTMPText(self._mapNode.TMPTitle, mapSeasonQuestCfgData.Desc)
  self._mapNode.rtReward:SetItem(mapSeasonQuestCfgData.AwardItemTid1, nil, mapSeasonQuestCfgData.AwardItemNum1, nil, nil, nil, nil, true)
  if mapSeasonQuest.nStatus ~= 2 then
    NovaAPI.SetTMPText(self._mapNode.TMPProcess, string.format("%d/%d", mapSeasonQuest.nCurProgress, mapSeasonQuest.nGoal))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPProcess, ConfigTable.GetUIText("Quest_Complete"))
  end
  self._mapNode.rtBarFill.sizeDelta = Vector2(mapSeasonQuest.nCurProgress / mapSeasonQuest.nGoal * totalLength, totalHeight)
  self._mapNode.imgComplete:SetActive(mapSeasonQuest.nStatus == 2)
  self._mapNode.imgCompleteMask:SetActive(mapSeasonQuest.nStatus == 2)
  self._mapNode.imgCompleteMask:SetActive(mapSeasonQuest.nStatus == 2)
  self._mapNode.TMPUncomplete.gameObject:SetActive(mapSeasonQuest.nStatus == 0 and mapSeasonQuestCfgData.JumpTo == 0)
  self._mapNode.btnJump.gameObject:SetActive(mapSeasonQuest.nStatus == 0 and mapSeasonQuestCfgData.JumpTo ~= 0)
  self._mapNode.btnReceive.gameObject:SetActive(mapSeasonQuest.nStatus == 1)
end

function TravelerDuelQuestSeasonGridCtrl:OnBtnClick_Receive()
  PlayerData.Quest:ReceiveTravelerDuelChallengeReward(self.mapSeasonQuest.nTid, nil)
end

function TravelerDuelQuestSeasonGridCtrl:OnBtnClick_JumpTo()
  local nJumptoId = self.mapSeasonQuestCfgData.JumpTo
  JumpUtil.JumpTo(nJumptoId)
end

function TravelerDuelQuestSeasonGridCtrl:OnBtnClick_Reward(btn)
  UTILS.ClickItemGridWithTips(self.mapSeasonQuestCfgData.AwardItemTid1, btn.transform, true, true, false)
end

return TravelerDuelQuestSeasonGridCtrl
