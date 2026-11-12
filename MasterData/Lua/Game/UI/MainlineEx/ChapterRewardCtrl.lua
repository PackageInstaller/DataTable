local ChapterRewardCtrl = class("ChapterRewardCtrl", BaseCtrl)
local barLength = 228
local tbColor = {
  Color(0.6078431372549019, 0.7176470588235294, 0.8274509803921568, 1),
  Color(0.9921568627450981, 0.7333333333333333, 0.2823529411764706, 1),
  Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764, 1)
}
ChapterRewardCtrl._mapNodeConfig = {
  imgChapterWindow = {sComponentName = "Image"},
  imgIconChapterWindow = {sComponentName = "Image"},
  imgProgressWindowF = {sComponentName = "Transform", nCount = 2},
  BubbleWindow = {sComponentName = "Transform", nCount = 3},
  TMPTotalStar = {sComponentName = "TMP_Text"},
  reward = {sComponentName = "Transform", nCount = 3},
  rtItem = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 3
  },
  rtItemBtn = {
    sNodeName = "rtItem",
    callback = "OnBtnClick_Item",
    sComponentName = "Button",
    nCount = 3
  },
  barProgressWindow = {sComponentName = "Image"},
  btnCloseWindow = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnConfirm2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GetReward"
  },
  btnNoReward = {}
}
ChapterRewardCtrl._mapEventConfig = {}

function ChapterRewardCtrl:Awake()
end

function ChapterRewardCtrl:FadeOut()
end

function ChapterRewardCtrl:OnEnable()
end

function ChapterRewardCtrl:OnDisable()
end

function ChapterRewardCtrl:OnDestroy()
end

function ChapterRewardCtrl:OnRelease()
end

function ChapterRewardCtrl:OpenPanel(mapChapterData, nTotalStar, nCurIdx, tbReward, nMaxStar)
  self.gameObject:SetActive(true)
  self:SetPngSprite(self._mapNode.imgChapterWindow, mapChapterData.ChapterImg)
  self:SetPngSprite(self._mapNode.imgIconChapterWindow, mapChapterData.ChapterIcon)
  NovaAPI.SetImageNativeSize(self._mapNode.imgIconChapterWindow)
  NovaAPI.SetTMPText(self._mapNode.TMPTotalStar, nTotalStar)
  self.tbReward = tbReward
  self.bReceive = false
  self.rewardIdx = 0
  local nCurStar = nTotalStar
  local nRewardCount = #tbReward
  local sum = 3 - nRewardCount
  if sum < 0 then
    sum = 0
  end
  NovaAPI.SetImageFillAmount(self._mapNode.barProgressWindow, nCurStar / nMaxStar)
  for index = 1, 2 do
    local rtF = self._mapNode.imgProgressWindowF[index]
    if index <= sum then
      rtF.gameObject:SetActive(false)
      self._mapNode.reward[4 - index].gameObject:SetActive(false)
    else
      self._mapNode.reward[4 - index].gameObject:SetActive(true)
      rtF.gameObject:SetActive(true)
      local nStar = tbReward[index].nStar
      rtF.anchoredPosition = Vector2(barLength * nStar / nMaxStar, 0)
    end
  end
  for idx, mapReward in ipairs(tbReward) do
    local nStar = mapReward.nStar
    local rtBubble = self._mapNode.BubbleWindow[sum + idx]
    local txtOn = rtBubble:Find("On/NumberOn"):GetComponent("TMP_Text")
    local txtOff = rtBubble:Find("Off/NumberOff"):GetComponent("TMP_Text")
    rtBubble:Find("On").gameObject:SetActive(nCurStar >= nStar)
    rtBubble:Find("Off").gameObject:SetActive(nCurStar < nStar)
    self:SetChapterItem(self._mapNode.reward[idx], nStar, nCurStar, idx <= nCurIdx)
    if nCurStar >= nStar and nCurIdx < idx then
      self.bReceive = true
      self.rewardIdx = idx
    end
    self._mapNode.btnNoReward:SetActive(not self.bReceive)
    self._mapNode.btnConfirm2.gameObject:SetActive(self.bReceive)
    NovaAPI.SetTMPText(txtOn, tostring(nStar))
    NovaAPI.SetTMPText(txtOff, tostring(nStar))
    self._mapNode.rtItem[idx]:SetItem(mapReward.nReward, nil, mapReward.nCount, nil, idx <= nCurIdx, false, false)
  end
end

function ChapterRewardCtrl:Refresh(mapChapterData, nTotalStar, nCurIdx, tbReward, nMaxStar)
  self:SetPngSprite(self._mapNode.imgChapterWindow, mapChapterData.ChapterImg)
  self:SetPngSprite(self._mapNode.imgIconChapterWindow, mapChapterData.ChapterIcon)
  NovaAPI.SetTMPText(self._mapNode.TMPTotalStar, nTotalStar)
  self.bReceive = false
  self.rewardIdx = 0
  local nCurStar = nTotalStar
  local nRewardCount = #tbReward
  local sum = 3 - nRewardCount
  if sum < 0 then
    sum = 0
  end
  NovaAPI.SetImageFillAmount(self._mapNode.barProgressWindow, nCurStar / nMaxStar)
  for index = 1, 2 do
    local rtF = self._mapNode.imgProgressWindowF[index]
    if index <= sum then
      rtF.gameObject:SetActive(false)
      self._mapNode.reward[4 - index].gameObject:SetActive(false)
    else
      self._mapNode.reward[4 - index].gameObject:SetActive(true)
      rtF.gameObject:SetActive(true)
      local nStar = tbReward[index].nStar
      rtF.anchoredPosition = Vector2(barLength * nStar / nMaxStar, 0)
    end
  end
  for idx, mapReward in ipairs(tbReward) do
    local nStar = mapReward.nStar
    local rtBubble = self._mapNode.BubbleWindow[sum + idx]
    local txtOn = rtBubble:Find("On/NumberOn"):GetComponent("TMP_Text")
    local txtOff = rtBubble:Find("Off/NumberOff"):GetComponent("TMP_Text")
    rtBubble:Find("On").gameObject:SetActive(nCurStar >= nStar)
    rtBubble:Find("Off").gameObject:SetActive(nCurStar < nStar)
    self:SetChapterItem(self._mapNode.reward[idx], nStar, nCurStar, idx <= nCurIdx)
    if nCurStar >= nStar and nCurIdx < idx then
      self.bReceive = true
      self.rewardIdx = idx
    end
    self._mapNode.btnNoReward:SetActive(not self.bReceive)
    self._mapNode.btnConfirm2.gameObject:SetActive(self.bReceive)
    NovaAPI.SetTMPText(txtOn, tostring(nStar))
    NovaAPI.SetTMPText(txtOff, tostring(nStar))
    self._mapNode.rtItem[idx]:SetItem(mapReward.nReward, nil, mapReward.nCount, nil, idx <= nCurIdx, false, false)
  end
end

function ChapterRewardCtrl:SetChapterItem(rtItem, nCondStar, nCurStar, bHasReceive)
  local imgStarOn = rtItem:Find("imgStarOn").gameObject
  local imgStarOff = rtItem:Find("imgStarOff").gameObject
  local TMPTitle = rtItem:Find("TMPTitle"):GetComponent("TMP_Text")
  local TMPCond = rtItem:Find("TMPCond"):GetComponent("TMP_Text")
  local imgReceive = rtItem:Find("imgReceive").gameObject
  local imgComplete = rtItem:Find("imgComplete").gameObject
  imgStarOn:SetActive(nCondStar <= nCurStar)
  imgStarOff:SetActive(nCurStar < nCondStar)
  NovaAPI.SetTMPText(TMPTitle, orderedFormat(ConfigTable.GetUIText("ChapterRewardCond") or "", nCondStar))
  if bHasReceive then
    NovaAPI.SetTMPColor(TMPTitle, tbColor[1])
  elseif nCondStar <= nCurStar then
    NovaAPI.SetTMPColor(TMPTitle, tbColor[2])
  else
    NovaAPI.SetTMPColor(TMPTitle, tbColor[3])
  end
  NovaAPI.SetTMPText(TMPCond, string.format("%d/%d", nCurStar, nCondStar))
  TMPCond.gameObject:SetActive(not bHasReceive and nCurStar < nCondStar)
  imgReceive:SetActive(bHasReceive)
  imgComplete:SetActive(not bHasReceive and nCondStar <= nCurStar)
end

function ChapterRewardCtrl:OnBtnClick_Close(btn)
  self.gameObject:SetActive(false)
  EventManager.Hit("GetChapterReward", true)
end

function ChapterRewardCtrl:OnBtnClick_GetReward()
  if not self.bReceive then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TitleNoChapterReward"))
    return
  end
  print("GetChapterReward")
  EventManager.Hit("GetChapterReward", false, self.rewardIdx)
end

function ChapterRewardCtrl:OnBtnClick_Item(btn)
  local nIdx = table.indexof(self._mapNode.rtItemBtn, btn)
  UTILS.ClickItemGridWithTips(self.tbReward[nIdx].nReward, btn.transform, true, true, false)
end

return ChapterRewardCtrl
