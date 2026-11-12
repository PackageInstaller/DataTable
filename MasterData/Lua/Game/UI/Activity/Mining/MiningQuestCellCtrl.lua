local MiningQuestCellCtrl = class("MiningQuestCellCtrl", BaseCtrl)
local barMinX = -505
local barMaxX = 0
MiningQuestCellCtrl._mapNodeConfig = {
  rtReward = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  TMPTitle = {sComponentName = "TMP_Text"},
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetReward"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Quest_Receive"
  },
  go_UnComplete = {
    sNodeName = "TMPUncomplete"
  },
  TMPUncomplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Quest_UnComplete"
  },
  imgComplete = {},
  imgCompleteMask = {},
  txt_process = {sComponentName = "TMP_Text"},
  imgBarFill = {
    sComponentName = "RectTransform"
  }
}
MiningQuestCellCtrl._mapEventConfig = {}
MiningQuestCellCtrl._mapRedDotConfig = {}

function MiningQuestCellCtrl:SetData(nActId, questData)
  self.nActId = nActId
  self.questData = questData
  self.MiningGameData = PlayerData.Activity:GetActivityDataById(self.nActId)
  local config = ConfigTable.GetData("MiningQuest", self.questData.nId)
  if config == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPTitle, config.QuestDes)
  if self.questData.nStatus == AllEnum.ActQuestStatus.Received then
    self._mapNode.imgBarFill.anchoredPosition = Vector2(barMaxX, self._mapNode.imgBarFill.anchoredPosition.y)
    NovaAPI.SetTMPText(self._mapNode.txt_process, questData.progress[1].Max .. "/" .. questData.progress[1].Max)
  else
    self._mapNode.imgBarFill.anchoredPosition = Vector2(barMinX + (barMaxX - barMinX) * (math.min(questData.progress[1].Cur, questData.progress[1].Max) / questData.progress[1].Max), self._mapNode.imgBarFill.anchoredPosition.y)
    NovaAPI.SetTMPText(self._mapNode.txt_process, questData.progress[1].Cur .. "/" .. questData.progress[1].Max)
  end
  self._mapNode.imgComplete:SetActive(self.questData.nStatus == AllEnum.ActQuestStatus.Received)
  self._mapNode.imgCompleteMask:SetActive(self.questData.nStatus == AllEnum.ActQuestStatus.Received)
  self._mapNode.go_UnComplete:SetActive(self.questData.nStatus == AllEnum.ActQuestStatus.UnComplete)
  self._mapNode.btnReceive.gameObject:SetActive(self.questData.nStatus == AllEnum.ActQuestStatus.Complete)
  self._mapNode.btnReward.gameObject:SetActive(true)
  self._mapNode.rtReward:SetItem(config.RewardId, nil, config.RewardQty, nil, self.questData.nStatus == AllEnum.ActQuestStatus.Received)
end

function MiningQuestCellCtrl:OnBtnClick_GetReward()
  if self.questData == nil then
    return
  end
  self.MiningGameData:SendQuestReceive(self.questData.nId, 0)
end

function MiningQuestCellCtrl:OnBtnClick_Reward()
  local config = ConfigTable.GetData("MiningQuest", self.questData.nId)
  if config == nil then
    return
  end
  if config.RewardId > 0 then
    UTILS.ClickItemGridWithTips(config.RewardId, self._mapNode.btnReward.transform, true, true, false)
  end
end

return MiningQuestCellCtrl
