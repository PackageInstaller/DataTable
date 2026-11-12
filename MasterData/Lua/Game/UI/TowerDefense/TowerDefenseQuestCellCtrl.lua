local TowerDefenseQuestCellCtrl = class("TowerDefenseQuestCellCtrl", BaseCtrl)
local barMinX = -505
local barMaxX = 0
TowerDefenseQuestCellCtrl._mapNodeConfig = {
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
TowerDefenseQuestCellCtrl._mapEventConfig = {}
TowerDefenseQuestCellCtrl._mapRedDotConfig = {}

function TowerDefenseQuestCellCtrl:SetData(nActId, questData)
  self.nActId = nActId
  self.questData = questData
  self.TowerDefenseData = PlayerData.Activity:GetActivityDataById(self.nActId)
  local config = ConfigTable.GetData("TowerDefenseQuest", self.questData.nId)
  if config == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPTitle, config.Desc)
  self._mapNode.imgBarFill.anchoredPosition = Vector2(barMinX + (barMaxX - barMinX) * (questData.progress[1].Cur / questData.progress[1].Max), self._mapNode.imgBarFill.anchoredPosition.y)
  NovaAPI.SetTMPText(self._mapNode.txt_process, questData.progress[1].Cur .. "/" .. questData.progress[1].Max)
  self._mapNode.imgComplete:SetActive(self.questData.nState == AllEnum.ActQuestStatus.Received)
  self._mapNode.imgCompleteMask:SetActive(self.questData.nState == AllEnum.ActQuestStatus.Received)
  self._mapNode.go_UnComplete:SetActive(self.questData.nState == AllEnum.ActQuestStatus.UnComplete)
  self._mapNode.btnReceive.gameObject:SetActive(self.questData.nState == AllEnum.ActQuestStatus.Complete)
  if config.Item1 > 0 then
    self._mapNode.btnReward.gameObject:SetActive(true)
    self._mapNode.rtReward:SetItem(config.Item1, nil, config.Qty1, nil, self.questData.nState == AllEnum.ActQuestStatus.Received)
  else
    self._mapNode.btnReward.gameObject:SetActive(false)
  end
end

function TowerDefenseQuestCellCtrl:OnBtnClick_GetReward()
  if self.questData == nil then
    return
  end
  self.TowerDefenseData:RequestReceiveQuest(0, self.questData.nId)
end

function TowerDefenseQuestCellCtrl:OnBtnClick_Reward()
  local config = ConfigTable.GetData("TowerDefenseQuest", self.questData.nId)
  if config == nil then
    return
  end
  if config.Item1 > 0 then
    UTILS.ClickItemGridWithTips(config.Item1, self._mapNode.btnReward.transform, true, true, false)
  end
end

function TowerDefenseQuestCellCtrl:OnEvent_AAA()
end

return TowerDefenseQuestCellCtrl
