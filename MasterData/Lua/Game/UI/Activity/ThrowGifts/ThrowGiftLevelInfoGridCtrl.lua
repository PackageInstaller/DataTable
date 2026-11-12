local ThrowGiftLevelInfoGridCtrl = class("ThrowGiftLevelInfoGridCtrl", BaseCtrl)
local tbColor = {
  "#8cac59",
  "#da8d2a",
  "#e65454",
  "#d255ed"
}
ThrowGiftLevelInfoGridCtrl._mapNodeConfig = {
  TMPScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Activity_ThrowGifts_BestScore"
  },
  TMPUnlock = {
    sComponentName = "TMP_Text",
    sLanguageId = "ThrowGift_LevelInfo_Unlock"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "ThrowGift_LevelInfo_Go"
  },
  imgLevelIcon = {sComponentName = "Image"},
  TMPLevelName = {sComponentName = "TMP_Text"},
  TMPScore = {sComponentName = "TMP_Text"},
  TMPLevelTime = {sComponentName = "TMP_Text"},
  TMPDifficutly = {sComponentName = "TMP_Text"},
  TMPTarget = {sComponentName = "TMP_Text"},
  imgUnlockMask = {},
  rtItemReward = {
    nCount = 2,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btnReward = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_Reward"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  rtTime = {},
  rtDifficutly = {},
  imgDifficutly = {
    sNodeName = "rtDifficutly",
    sComponentName = "Image"
  },
  imgNew = {}
}
ThrowGiftLevelInfoGridCtrl._mapEventConfig = {}
ThrowGiftLevelInfoGridCtrl._mapRedDotConfig = {}

function ThrowGiftLevelInfoGridCtrl:Awake()
end

function ThrowGiftLevelInfoGridCtrl:FadeIn()
end

function ThrowGiftLevelInfoGridCtrl:FadeOut()
end

function ThrowGiftLevelInfoGridCtrl:OnEnable()
end

function ThrowGiftLevelInfoGridCtrl:OnDisable()
end

function ThrowGiftLevelInfoGridCtrl:OnDestroy()
end

function ThrowGiftLevelInfoGridCtrl:OnRelease()
end

function ThrowGiftLevelInfoGridCtrl:Refresh(nLevelId, bUnlock, nMaxScore, bPass, bShowRedDot, nOpenTime)
  self.nLevelId = nLevelId
  self.nOpenTime = nOpenTime
  local mapLevelCfgData = ConfigTable.GetData("ThrowGiftLevel", nLevelId)
  if mapLevelCfgData == nil then
    self.gameObject:SetActive(false)
    return
  end
  self.gameObject:SetActive(true)
  self:SetPngSprite(self._mapNode.imgLevelIcon, mapLevelCfgData.Icon)
  NovaAPI.SetTMPText(self._mapNode.TMPLevelName, mapLevelCfgData.LevelName)
  NovaAPI.SetTMPText(self._mapNode.TMPScore, nMaxScore)
  NovaAPI.SetTMPText(self._mapNode.TMPDifficutly, mapLevelCfgData.DifficultyName)
  self._mapNode.imgUnlockMask:SetActive(not bUnlock)
  self._mapNode.btnGo.gameObject:SetActive(bUnlock)
  self._mapNode.TMPUnlock.gameObject:SetActive(not bUnlock)
  if mapLevelCfgData.CountDownLimit > 0 then
    self._mapNode.rtTime.gameObject:SetActive(true)
    local m = math.floor(mapLevelCfgData.CountDownLimit / 60)
    local s = mapLevelCfgData.CountDownLimit % 60
    NovaAPI.SetTMPText(self._mapNode.TMPLevelTime, string.format("%d:%02d", m, s))
  else
    self._mapNode.rtTime.gameObject:SetActive(false)
  end
  NovaAPI.SetTMPText(self._mapNode.TMPTarget, mapLevelCfgData.ThrowGiftLevelCondDesc)
  local _, difficultyColor = ColorUtility.TryParseHtmlString(tbColor[mapLevelCfgData.Difficulty])
  NovaAPI.SetImageColor(self._mapNode.imgDifficutly, difficultyColor)
  if 0 < mapLevelCfgData.FirstCompleteReward1Tid then
    self._mapNode.rtItemReward[1].gameObject:SetActive(true)
    self._mapNode.rtItemReward[1]:SetItem(mapLevelCfgData.FirstCompleteReward1Tid, nil, mapLevelCfgData.FirstCompleteReward1Qty, nil, bPass, true, nil, true)
  else
    self._mapNode.rtItemReward[1].gameObject:SetActive(false)
  end
  if 0 < mapLevelCfgData.FirstCompleteReward2Tid then
    self._mapNode.rtItemReward[2].gameObject:SetActive(true)
    self._mapNode.rtItemReward[2]:SetItem(mapLevelCfgData.FirstCompleteReward2Tid, nil, mapLevelCfgData.FirstCompleteReward2Qty, nil, bPass, true, nil, true)
  else
    self._mapNode.rtItemReward[2].gameObject:SetActive(false)
  end
  self._mapNode.imgNew:SetActive(bShowRedDot)
end

function ThrowGiftLevelInfoGridCtrl:OnBtnClick_Go()
  EventManager.Hit("ThrowGiftStartBtnClick")
  
  local function callback()
    EventManager.Hit(EventId.OpenPanel, self._panel.nLevelPanelId, self.nLevelId, self.nOpenTime)
  end
  
  EventManager.Hit(EventId.SetTransition, self._panel.nTransition, callback)
end

function ThrowGiftLevelInfoGridCtrl:OnBtnClick_Reward(goBtn, nIdx)
  local mapLevelCfgData = ConfigTable.GetData("ThrowGiftLevel", self.nLevelId)
  if mapLevelCfgData == nil then
    return
  end
  local nItemId = nIdx == 1 and mapLevelCfgData.FirstCompleteReward1Tid or mapLevelCfgData.FirstCompleteReward2Tid
  local rtItem = nIdx == 1 and self._mapNode.rtItemReward[1].gameObject.transform or self._mapNode.rtItemReward[2].gameObject.transform
  if nItemId == 0 then
    return
  end
  UTILS.ClickItemGridWithTips(nItemId, rtItem, true, true, false)
end

return ThrowGiftLevelInfoGridCtrl
