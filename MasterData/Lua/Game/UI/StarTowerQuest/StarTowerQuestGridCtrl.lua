local StarTowerQuestGridCtrl = class("StarTowerQuestGridCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
local totalLength = 472
local totalHeight = 37
local JumpUtil = require("Game.Common.Utils.JumpUtil")
StarTowerQuestGridCtrl._mapNodeConfig = {
  rtTitle = {
    sComponentName = "RectTransform"
  },
  btnGrid = {},
  TMPTitle = {sComponentName = "TMP_Text"},
  TMPProcess = {sComponentName = "TMP_Text"},
  rtBarFill = {
    sComponentName = "RectTransform"
  },
  btnReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Receive"
  },
  btnJump = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_JumpTo"
  },
  txtBtnReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  txtBtnJump = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_JumpTo"
  },
  TMPUncomplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_undone"
  },
  imgComplete = {},
  imgCompleteMask = {},
  btnReward = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  goItem = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  }
}
StarTowerQuestGridCtrl._mapEventConfig = {}

function StarTowerQuestGridCtrl:OnEnable()
  self._mapNode.btnGrid:SetActive(false)
  
  local function waitOpen()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    if self._mapNode == nil then
      return
    end
    self._mapNode.btnGrid:SetActive(true)
    LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTitle)
  end
  
  cs_coroutine.start(waitOpen)
end

function StarTowerQuestGridCtrl:Refresh(nQuestId, nState, nCur, nTotal, gridIndex)
  self.nQusetId = nQuestId
  self.gridIndex = gridIndex
  local mapQuest = ConfigTable.GetData("StarTowerQuest", nQuestId)
  if mapQuest == nil then
    printError("QuestData missing：" .. nQuestId)
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPTitle, mapQuest.Title)
  if nState ~= 2 then
    NovaAPI.SetTMPText(self._mapNode.TMPProcess, string.format("%d/%d", nCur, nTotal))
  else
    NovaAPI.SetTMPText(self._mapNode.TMPProcess, ConfigTable.GetUIText("Quest_Complete"))
  end
  self.mapQuset = mapQuest
  self._mapNode.rtBarFill.sizeDelta = Vector2(nCur / nTotal * totalLength, totalHeight)
  self._mapNode.btnReceive.gameObject:SetActive(nState == 1)
  self._mapNode.btnJump.gameObject:SetActive(nState == 0 and 0 < mapQuest.JumpTo)
  self._mapNode.TMPUncomplete.gameObject:SetActive(nState == 0 and mapQuest.JumpTo == 0)
  self._mapNode.imgComplete:SetActive(nState == 2)
  self._mapNode.imgCompleteMask:SetActive(nState == 2)
  for i = 1, 2 do
    self._mapNode.btnReward[i].gameObject:SetActive(0 < mapQuest["Reward" .. i])
    if 0 < mapQuest["Reward" .. i] then
      self._mapNode.goItem[i]:SetItem(mapQuest["Reward" .. i], nil, mapQuest["RewardQty" .. i], nil, nil, nil, nil, true)
    end
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rtTitle)
end

function StarTowerQuestGridCtrl:OnBtnClick_Receive()
  PlayerData.Quest:ReceiveStarTowerReward(self.nQusetId)
end

function StarTowerQuestGridCtrl:OnBtnClick_JumpTo()
  local nJumptoId = self.mapQuset.JumpTo
  JumpUtil.JumpTo(nJumptoId)
end

function StarTowerQuestGridCtrl:OnBtnClick_Reward(btn, nIndex)
  local function callback()
    local mapData = {
      nTid = self.mapQuset["Reward" .. nIndex],
      
      bShowDepot = true,
      bShowJumpto = true
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, btn.transform, mapData)
  end
  
  EventManager.Hit("StarTowerQuestClickGrid", self.gridIndex, callback)
end

return StarTowerQuestGridCtrl
