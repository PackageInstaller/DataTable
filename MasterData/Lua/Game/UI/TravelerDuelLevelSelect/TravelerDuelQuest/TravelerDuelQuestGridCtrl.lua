local TravelerDuelQuestGridCtrl = class("TravelerDuelQuestGridCtrl", BaseCtrl)
local totalLength = 517
local totalHeight = 37
local JumpUtil = require("Game.Common.Utils.JumpUtil")
TravelerDuelQuestGridCtrl._mapNodeConfig = {
  TMPTitle = {sComponentName = "TMP_Text"},
  TMPUncomplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_undone"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  TMPComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Complete"
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
TravelerDuelQuestGridCtrl._mapEventConfig = {}

function TravelerDuelQuestGridCtrl:Refresh(mapNormalQuest, mapNormalQuestCfgData)
  if mapNormalQuest == nil then
    self.gameObject:SetActive(false)
    return
  end
  if mapNormalQuestCfgData == nil then
    printError("guide quest data missing:" .. mapNormalQuest.nTid)
    self.gameObject:SetActive(false)
    return
  end
  self.mapNormalQuestCfgData = mapNormalQuestCfgData
  self.mapNormalQuest = mapNormalQuest
  NovaAPI.SetTMPText(self._mapNode.TMPTitle, mapNormalQuestCfgData.Desc)
  self._mapNode.rtReward:SetItem(mapNormalQuestCfgData.AwardItemTid1, nil, mapNormalQuestCfgData.AwardItemNum1, nil, nil, nil, nil, true)
  if mapNormalQuest.nStatus ~= 2 then
    NovaAPI.SetTMPText(self._mapNode.TMPProcess, string.format("%d/%d", mapNormalQuest.nCurProgress, mapNormalQuest.nGoal))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPProcess, ConfigTable.GetUIText("Quest_Complete"))
  end
  self._mapNode.rtBarFill.sizeDelta = Vector2(mapNormalQuest.nCurProgress / mapNormalQuest.nGoal * totalLength, totalHeight)
  self._mapNode.imgComplete:SetActive(mapNormalQuest.nStatus == 2)
  self._mapNode.imgCompleteMask:SetActive(mapNormalQuest.nStatus == 2)
  self._mapNode.imgCompleteMask:SetActive(mapNormalQuest.nStatus == 2)
  self._mapNode.TMPUncomplete.gameObject:SetActive(mapNormalQuest.nStatus == 0 and mapNormalQuestCfgData.JumpTo == 0)
  self._mapNode.btnJump.gameObject:SetActive(mapNormalQuest.nStatus == 0 and mapNormalQuestCfgData.JumpTo ~= 0)
  self._mapNode.btnReceive.gameObject:SetActive(mapNormalQuest.nStatus == 1)
end

function TravelerDuelQuestGridCtrl:OnBtnClick_Receive()
  PlayerData.Quest:ReceiveTravelerDuelReward(self.mapNormalQuest.nTid, nil)
end

function TravelerDuelQuestGridCtrl:OnBtnClick_JumpTo()
  local nJumptoId = self.mapNormalQuestCfgData.JumpTo
  JumpUtil.JumpTo(nJumptoId)
end

function TravelerDuelQuestGridCtrl:OnBtnClick_Reward(btn)
  UTILS.ClickItemGridWithTips(self.mapNormalQuestCfgData.AwardItemTid1, btn.transform, true, true, false)
end

return TravelerDuelQuestGridCtrl
