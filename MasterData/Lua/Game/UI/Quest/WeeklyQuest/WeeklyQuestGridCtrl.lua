local WeeklyQuestGridCtrl = class("WeeklyQuestGridCtrl", BaseCtrl)
local totalLength = 517
local totalHeight = 37
local JumpUtil = require("Game.Common.Utils.JumpUtil")
WeeklyQuestGridCtrl._mapNodeConfig = {
  imgDb = {nCount = 2},
  btnGrid = {},
  txtQuestDesc = {sComponentName = "TMP_Text"},
  txtProgress = {sComponentName = "TMP_Text"},
  rtProgressFill = {
    sComponentName = "RectTransform"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  btnJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_JumpTo"
  },
  txtBtnJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo_Text"
  },
  txtUnComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_undone"
  },
  imgReceived = {},
  imgCompleteMask = {},
  btnRewardItem = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardItem"
  },
  goRewardItem = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  }
}
WeeklyQuestGridCtrl._mapEventConfig = {}

function WeeklyQuestGridCtrl:OnEnable()
  self._mapNode.btnGrid:SetActive(false)
  
  local function waitOpen()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.btnGrid:SetActive(true)
  end
  
  cs_coroutine.start(waitOpen)
end

function WeeklyQuestGridCtrl:Refresh(nQuestId, nState, nCur, nTotal, bAllComplete)
  self.nQuestId = nQuestId
  local mapQuest = ConfigTable.GetData("WeeklyQuest", nQuestId)
  if mapQuest == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtQuestDesc, mapQuest.Title)
  if nState ~= 2 then
    NovaAPI.SetTMPText(self._mapNode.txtProgress, string.format("%d/%d", nCur, nTotal))
  else
    NovaAPI.SetTMPText(self._mapNode.txtProgress, ConfigTable.GetUIText("Quest_Complete"))
  end
  self.mapQuest = mapQuest
  self._mapNode.rtProgressFill.sizeDelta = Vector2(nCur / nTotal * totalLength, totalHeight)
  self._mapNode.btnReceive.gameObject:SetActive(nState == 1 and not bAllComplete)
  self._mapNode.btnJump.gameObject:SetActive(nState == 0 and 0 < mapQuest.JumpTo)
  self._mapNode.txtUnComplete.gameObject:SetActive(nState == 0 and mapQuest.JumpTo == 0)
  self._mapNode.imgReceived:SetActive(nState == 2)
  self._mapNode.imgCompleteMask:SetActive(nState == 2)
  local bApear = mapQuest.Apear
  self._mapNode.imgDb[1].gameObject:SetActive(bApear)
  self._mapNode.imgDb[2].gameObject:SetActive(not bApear)
  self.tbRewardId = {
    AllEnum.CoinItemId.WeeklyQuestActive,
    mapQuest.ItemTid
  }
  self._mapNode.goRewardItem[1]:SetItem(AllEnum.CoinItemId.WeeklyQuestActive, nil, mapQuest.Active, nil, nil, nil, nil, true)
  self._mapNode.goRewardItem[2]:SetItem(mapQuest.ItemTid, nil, mapQuest.ItemQty, nil, nil, nil, nil, true)
end

function WeeklyQuestGridCtrl:OnBtnClick_Receive()
  PlayerData.Quest:ReceiveWeeklyReward(self.nQuestId)
end

function WeeklyQuestGridCtrl:OnBtnClick_JumpTo()
  local nJumptoId = self.mapQuest.JumpTo
  JumpUtil.JumpTo(nJumptoId)
end

function WeeklyQuestGridCtrl:OnBtnClick_RewardItem(btn, nIndex)
  local nRewardId = self.tbRewardId[nIndex]
  if nRewardId ~= nil then
    local bShowDepot = true
    if nRewardId == AllEnum.CoinItemId.WeeklyQuestActive then
      bShowDepot = false
    end
    UTILS.ClickItemGridWithTips(nRewardId, btn.transform, true, bShowDepot, false)
  end
end

return WeeklyQuestGridCtrl
