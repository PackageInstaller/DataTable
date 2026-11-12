local BookQuestItemCtrl = class("BookQuestItemCtrl", BaseCtrl)
BookQuestItemCtrl._mapNodeConfig = {
  imgPoint = {},
  btnItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Item"
  },
  goRewardItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  txtQuestDesc = {nCount = 3, sComponentName = "TMP_Text"},
  imgBarBg = {
    sComponentName = "RectTransform"
  },
  imgBar = {
    sComponentName = "RectTransform"
  },
  txtProgress = {sComponentName = "TMP_Text"},
  goUnComplete = {},
  goComplete = {},
  goReceived = {}
}
BookQuestItemCtrl._mapEventConfig = {}
BookQuestItemCtrl._mapRedDotConfig = {}

function BookQuestItemCtrl:InitPotentialItem(questData)
  for _, v in ipairs(self._mapNode.txtQuestDesc) do
    NovaAPI.SetTMPText(v, questData.Desc)
  end
  self:SetProgress(questData.CurProgress, questData.AllProgress, questData.Status)
  local mapReward = questData.Reward
  self.nRewardTid = mapReward.RewardId
  local bReceived = questData.Status == AllEnum.BookQuestStatus.Received
  self._mapNode.goRewardItem:SetItem(mapReward.RewardId, nil, mapReward.RewardCount, nil, bReceived, false, false, true, false)
end

function BookQuestItemCtrl:InitFateCardItem(questData)
  for _, v in ipairs(self._mapNode.txtQuestDesc) do
    NovaAPI.SetTMPText(v, questData.Desc)
  end
  self:SetProgress(questData.CurProgress, questData.AllProgress, questData.Status)
  local mapReward = questData.Reward[1]
  self.nRewardTid = mapReward.RewardId
  local bReceived = questData.Status == AllEnum.BookQuestStatus.Received
  self._mapNode.goRewardItem:SetItem(mapReward.RewardId, nil, mapReward.RewardCount, nil, bReceived, false, false, true, false)
end

function BookQuestItemCtrl:SetProgress(nProgress, nAllProgress, nStatus)
  self._mapNode.goUnComplete.gameObject:SetActive(nStatus == AllEnum.BookQuestStatus.UnComplete)
  self._mapNode.goComplete.gameObject:SetActive(nStatus == AllEnum.BookQuestStatus.Complete)
  self._mapNode.goReceived.gameObject:SetActive(nStatus == AllEnum.BookQuestStatus.Received)
  if nStatus == AllEnum.BookQuestStatus.UnComplete then
    local fRatio = 0 < nAllProgress and nProgress / nAllProgress or 0
    self._mapNode.imgBar.sizeDelta = Vector2(fRatio * self.nAllWidth, self._mapNode.imgBar.sizeDelta.y)
    NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%s/%s", nProgress, nAllProgress))
  else
    self._mapNode.imgBar.sizeDelta = Vector2(self.nAllWidth, self._mapNode.imgBar.sizeDelta.y)
    NovaAPI.SetTMPText(self._mapNode.txtProgress, ConfigTable.GetUIText("StarTower_Book_Quest_Complete"))
  end
end

function BookQuestItemCtrl:Awake()
  self.nAllWidth = self._mapNode.imgBarBg.sizeDelta.x
end

function BookQuestItemCtrl:OnBtnClick_Item(btn)
  local mapData = {
    nTid = self.nRewardTid,
    bShowDepot = true,
    bShowJumpto = false
  }
  EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
end

return BookQuestItemCtrl
