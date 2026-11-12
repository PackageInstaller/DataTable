local DormQuestGridCtrl = class("DormQuestGridCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local totalLength = 616
local totalHeight = 37
DormQuestGridCtrl._mapNodeConfig = {
  txtQuestDesc = {sComponentName = "TMP_Text"},
  txtProgress = {sComponentName = "TMP_Text"},
  txtUnComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_undone"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive_Btn_Text"
  },
  txtBtnJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo_Text"
  },
  imgReceived = {},
  imgCompleteMask = {},
  rtProgressFill = {
    sComponentName = "RectTransform"
  },
  btnItem = {
    sComponentName = "UIButton",
    nCount = 2,
    callback = "OnBtnClick_Reward"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  btnJump = {sComponentName = "UIButton"},
  goRewardItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 2
  },
  imgRewardEmpty = {nCount = 2}
}
DormQuestGridCtrl._mapEventConfig = {}
DormQuestGridCtrl._mapRedDotConfig = {}

function DormQuestGridCtrl:Awake()
end

function DormQuestGridCtrl:FadeIn()
end

function DormQuestGridCtrl:FadeOut()
end

function DormQuestGridCtrl:OnEnable()
end

function DormQuestGridCtrl:OnDisable()
end

function DormQuestGridCtrl:OnDestroy()
end

function DormQuestGridCtrl:OnRelease()
end

function DormQuestGridCtrl:Refresh(mapDormQuest)
  if mapDormQuest == nil then
    self.gameObject:SetActive(false)
    return
  end
  local mapDormQuestCfgData = ConfigTable.GetData("DormQuest", mapDormQuest.nTid)
  if mapDormQuestCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.mapDormQuestCfgData = mapDormQuestCfgData
  self.mapDormQuest = mapDormQuest
  NovaAPI.SetTMPText(self._mapNode.txtQuestDesc, mapDormQuestCfgData.Title)
  self.tbRewardId = {
    mapDormQuestCfgData.Reward1,
    mapDormQuestCfgData.Reward2
  }
  for i = 1, 2 do
    self._mapNode.goRewardItem[i].gameObject:SetActive(mapDormQuestCfgData["Reward" .. i] ~= 0)
    self._mapNode.imgRewardEmpty[i].gameObject:SetActive(mapDormQuestCfgData["Reward" .. i] == 0)
    if mapDormQuestCfgData["Reward" .. i] ~= 0 then
      self._mapNode.goRewardItem[i]:SetItem(mapDormQuestCfgData["Reward" .. i], nil, mapDormQuestCfgData["RewardQty" .. i], nil, mapDormQuest.nStatus == 2, nil, nil, true)
    end
  end
  if mapDormQuest.nStatus ~= 2 then
    NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", mapDormQuest.nCurProgress, mapDormQuest.nGoal))
    self._mapNode.rtProgressFill.sizeDelta = Vector2(mapDormQuest.nCurProgress / mapDormQuest.nGoal * totalLength, totalHeight)
  else
    NovaAPI.SetTMPText(self._mapNode.txtProgress, ConfigTable.GetUIText("Quest_Complete"))
    self._mapNode.rtProgressFill.sizeDelta = Vector2(totalLength, totalHeight)
  end
  self._mapNode.imgReceived:SetActive(mapDormQuest.nStatus == 2)
  self._mapNode.imgCompleteMask:SetActive(mapDormQuest.nStatus == 2)
  self._mapNode.txtUnComplete.gameObject:SetActive(mapDormQuest.nStatus == 0 and mapDormQuestCfgData.JumpTo == 0)
  self._mapNode.btnJump.gameObject:SetActive(mapDormQuest.nStatus == 0 and mapDormQuestCfgData.JumpTo ~= 0)
  self._mapNode.btnReceive.gameObject:SetActive(mapDormQuest.nStatus == 1)
end

function DormQuestGridCtrl:ShowItemDetail(id, rtIcon)
  UTILS.ClickItemGridWithTips(id, rtIcon.transform, true, true, false)
end

function DormQuestGridCtrl:OnBtnClick_Receive()
  EventManager.Hit("DormQuestGridReceive", self.mapDormQuest.nTid)
end

function DormQuestGridCtrl:OnBtnClick_JumpTo()
  local nJumptoId = self.mapDormQuestCfgData.JumpTo
  JumpUtil.JumpTo(nJumptoId)
end

function DormQuestGridCtrl:OnBtnClick_Reward(btn, nIdx)
  if self.tbRewardId[nIdx] ~= 0 then
    self:ShowItemDetail(self.tbRewardId[nIdx], btn)
  end
end

return DormQuestGridCtrl
