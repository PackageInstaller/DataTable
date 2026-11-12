local GuideQuestGridCtrl = class("GuideQuestGridCtrl", BaseCtrl)
local JumpUtil = require("Game.Common.Utils.JumpUtil")
local totalLength = 517
local totalHeight = 37
GuideQuestGridCtrl._mapNodeConfig = {
  btnGrid = {},
  txtQuestDesc = {sComponentName = "TMP_Text"},
  txtUnComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_undone"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  txtBtnJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo_Text"
  },
  rtProgressFill = {
    sComponentName = "RectTransform"
  },
  txtProgress = {sComponentName = "TMP_Text"},
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  btnJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_JumpTo"
  },
  goRewardItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 2
  },
  imgRewardEmpty = {nCount = 2},
  imgReceived = {},
  imgCompleteMask = {},
  btnItem = {
    sComponentName = "UIButton",
    nCount = 2,
    callback = "OnBtnClick_Reward"
  }
}
GuideQuestGridCtrl._mapEventConfig = {}

function GuideQuestGridCtrl:Refresh(mapGuideQuest)
  if mapGuideQuest == nil then
    self.gameObject:SetActive(false)
    return
  end
  local mapGuideQuestCfgData = ConfigTable.GetData("TourGuideQuest", mapGuideQuest.nTid)
  if mapGuideQuestCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.mapGuideQuestCfgData = mapGuideQuestCfgData
  self.mapGuideQuest = mapGuideQuest
  NovaAPI.SetTMPText(self._mapNode.txtQuestDesc, mapGuideQuestCfgData.Title)
  self.tbRewardId = {
    mapGuideQuestCfgData.Reward1,
    mapGuideQuestCfgData.Reward2
  }
  for i = 1, 2 do
    self._mapNode.goRewardItem[i].gameObject:SetActive(mapGuideQuestCfgData["Reward" .. i] ~= 0)
    self._mapNode.imgRewardEmpty[i].gameObject:SetActive(mapGuideQuestCfgData["Reward" .. i] == 0)
    if mapGuideQuestCfgData["Reward" .. i] ~= 0 then
      self._mapNode.goRewardItem[i]:SetItem(mapGuideQuestCfgData["Reward" .. i], nil, mapGuideQuestCfgData["RewardQty" .. i], nil, nil, nil, nil, true)
    end
  end
  if mapGuideQuest.nStatus ~= 2 then
    NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", mapGuideQuest.nCurProgress, mapGuideQuest.nGoal))
  else
    NovaAPI.SetTMPText(self._mapNode.txtProgress, ConfigTable.GetUIText("Quest_Complete"))
  end
  self._mapNode.rtProgressFill.sizeDelta = Vector2(mapGuideQuest.nCurProgress / mapGuideQuest.nGoal * totalLength, totalHeight)
  self._mapNode.imgReceived:SetActive(mapGuideQuest.nStatus == 2)
  self._mapNode.imgCompleteMask:SetActive(mapGuideQuest.nStatus == 2)
  self._mapNode.txtUnComplete.gameObject:SetActive(mapGuideQuest.nStatus == 0 and mapGuideQuestCfgData.JumpTo == 0)
  self._mapNode.btnJump.gameObject:SetActive(mapGuideQuest.nStatus == 0 and mapGuideQuestCfgData.JumpTo ~= 0)
  self._mapNode.btnReceive.gameObject:SetActive(mapGuideQuest.nStatus == 1)
end

function GuideQuestGridCtrl:ShowItemDetail(id, rtIcon)
  UTILS.ClickItemGridWithTips(id, rtIcon.transform, true, true, false)
end

function GuideQuestGridCtrl:OnEnable()
  self._mapNode.btnGrid:SetActive(false)
  
  local function waitOpen()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.btnGrid:SetActive(true)
  end
  
  cs_coroutine.start(waitOpen)
end

function GuideQuestGridCtrl:OnBtnClick_Receive()
  PlayerData.Quest:ReceiveTourReward(self.mapGuideQuest.nTid, nil)
end

function GuideQuestGridCtrl:OnBtnClick_JumpTo()
  local nJumptoId = self.mapGuideQuestCfgData.JumpTo
  JumpUtil.JumpTo(nJumptoId)
end

function GuideQuestGridCtrl:OnBtnClick_Reward(btn, nIdx)
  if self.tbRewardId[nIdx] ~= 0 then
    self:ShowItemDetail(self.tbRewardId[nIdx], btn)
  end
end

return GuideQuestGridCtrl
