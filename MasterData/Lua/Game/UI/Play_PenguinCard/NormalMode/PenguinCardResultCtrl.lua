local PenguinCardResultCtrl = class("PenguinCardResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
PenguinCardResultCtrl._mapNodeConfig = {
  blur = {
    sNodeName = "t_fullscreen_blur_blue"
  },
  aniBlur = {
    sNodeName = "t_fullscreen_blur_blue",
    sComponentName = "Animator"
  },
  btnCloseBg = {
    sNodeName = "snapshot",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnLog = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Log"
  },
  txtClick = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_ClickClose"
  },
  goResult = {},
  goBgOn = {},
  goBgOff = {},
  goTitleOff = {},
  goTitleOn = {},
  txtNeedCount = {sComponentName = "TMP_Text"},
  imgStarOff = {nCount = 3},
  imgStarOn = {nCount = 3},
  txtScoreTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_GetScore"
  },
  txtScore = {sComponentName = "TMP_Text"},
  txtStatisticsTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_Statistics"
  },
  CardList = {},
  imgCard = {nCount = 6, sComponentName = "Image"},
  txtTotalTurn = {sComponentName = "TMP_Text"},
  txtTotalRound = {sComponentName = "TMP_Text"},
  txtBestTurn = {sComponentName = "TMP_Text"},
  txtBestRound = {sComponentName = "TMP_Text"},
  txtMostHandRank = {sComponentName = "TMP_Text"},
  txtMostSuit = {sComponentName = "TMP_Text"},
  txtGetCardCount = {sComponentName = "TMP_Text"},
  txtBestCard = {sComponentName = "TMP_Text"},
  imgMostSuit = {sComponentName = "Image"},
  txtTotalTurnCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_TotalTurn"
  },
  txtTotalRoundCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_TotalRound"
  },
  txtBestTurnCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_BestTurn"
  },
  txtBestRoundCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_BestRound"
  },
  txtMostHandRankCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_MostHandRank"
  },
  txtMostSuitCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_MostSuit"
  },
  txtGetCardCountCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_GetCardCount"
  },
  txtBestCardCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_BestCard"
  },
  goTotalTurn = {},
  goTotalRound = {},
  goBestTurn = {},
  goBestRound = {},
  goMostHandRank = {},
  goMostSuit = {},
  goGetCardCount = {},
  goBestCard = {}
}
PenguinCardResultCtrl._mapEventConfig = {}

function PenguinCardResultCtrl:Open()
  self.bWin = self._panel.mapLevel.nStar > 0
  self:PlayInAni()
  self:Refresh()
end

function PenguinCardResultCtrl:Refresh()
  self:RefreshState()
  self:RefreshTitle()
  self:RefreshCard()
  self:RefreshStatistics()
end

function PenguinCardResultCtrl:RefreshState()
  self._mapNode.goBgOn:SetActive(self.bWin)
  self._mapNode.goBgOff:SetActive(not self.bWin)
  self._mapNode.goTitleOn:SetActive(self.bWin)
  self._mapNode.goTitleOff:SetActive(not self.bWin)
  self._mapNode.txtNeedCount.gameObject:SetActive(not self.bWin)
  if not self.bWin then
    local nMax = self._panel.mapLevel.tbStarScore[1]
    local nNeed = nMax - self._panel.mapLevel.nScore
    nNeed = math.floor(nNeed)
    NovaAPI.SetTMPText(self._mapNode.txtNeedCount, orderedFormat(ConfigTable.GetUIText("PenguinCard_Result_NeedScore"), self:ThousandsNumber(nNeed)))
  end
end

function PenguinCardResultCtrl:RefreshTitle()
  for i = 1, 3 do
    self._mapNode.imgStarOff[i]:SetActive(i > self._panel.mapLevel.nStar)
    self._mapNode.imgStarOn[i]:SetActive(i <= self._panel.mapLevel.nStar)
  end
  local nScore = math.floor(self._panel.mapLevel.nScore)
  NovaAPI.SetTMPText(self._mapNode.txtScore, self:ThousandsNumber(nScore))
end

function PenguinCardResultCtrl:RefreshCard()
  local nCount = self._panel.mapLevel:GetOwnPenguinCardCount()
  self._mapNode.CardList:SetActive(0 < nCount)
  if 0 < nCount then
    for i = 1, 6 do
      local mapCard = self._panel.mapLevel.tbPenguinCard[i]
      self._mapNode.imgCard[i].gameObject:SetActive(mapCard ~= 0)
      if mapCard ~= 0 then
        self:SetSprite(self._mapNode.imgCard[i], "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. mapCard.sIcon)
      end
    end
  end
end

function PenguinCardResultCtrl:RefreshStatistics()
  NovaAPI.SetTMPText(self._mapNode.txtTotalTurn, self._panel.mapLevel.nCurTurn)
  NovaAPI.SetTMPText(self._mapNode.txtTotalRound, self._panel.mapLevel.nTotalRound)
  local nBestTurnScore = math.floor(self._panel.mapLevel.nBestTurnScore)
  local nBestRoundScore = math.floor(self._panel.mapLevel.nBestRoundScore)
  NovaAPI.SetTMPText(self._mapNode.txtBestTurn, self:ThousandsNumber(nBestTurnScore))
  NovaAPI.SetTMPText(self._mapNode.txtBestRound, self:ThousandsNumber(nBestRoundScore))
  local nHandRankId, nHandRankCount = self._panel.mapLevel:GetMostHandRank()
  if 0 < nHandRankId then
    local mapHandRankCfg = ConfigTable.GetData("PenguinCardHandRank", nHandRankId)
    if mapHandRankCfg then
      self._mapNode.goMostHandRank:SetActive(true)
      local sSuf = orderedFormat(ConfigTable.GetUIText("PenguinCard_Result_CountSuffix"), nHandRankCount)
      NovaAPI.SetTMPText(self._mapNode.txtMostHandRank, mapHandRankCfg.Title .. sSuf)
    else
      self._mapNode.goMostHandRank:SetActive(false)
    end
  else
    self._mapNode.goMostHandRank:SetActive(false)
  end
  local nSuit, nSuitCount = self._panel.mapLevel:GetMostSuit()
  if 0 < nSuit then
    self._mapNode.goMostSuit:SetActive(true)
    self:SetSprite(self._mapNode.imgMostSuit, "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. AllEnum.PenguinCardSuitSprite[nSuit])
    NovaAPI.SetTMPText(self._mapNode.txtMostSuit, orderedFormat(ConfigTable.GetUIText("PenguinCard_Result_CountSuffix"), nSuitCount))
  else
    self._mapNode.goMostSuit:SetActive(false)
  end
  NovaAPI.SetTMPText(self._mapNode.txtGetCardCount, self._panel.mapLevel.nGetPenguinCardCount)
  local mapCard = self._panel.mapLevel:GetBestPenguinCard()
  if mapCard then
    self._mapNode.goBestCard:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtBestCard, mapCard.sName)
  else
    self._mapNode.goBestCard:SetActive(false)
  end
  self._mapNode.btnLog.gameObject:SetActive(next(self._panel.mapLevel.mapLog) ~= nil)
end

function PenguinCardResultCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self._mapNode.blur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.goResult:SetActive(true)
    if self.bWin then
      self.animator:Play("PengUinCard_Result_Win_in")
      WwiseManger:PostEvent("Mode_Card_victory")
    else
      self.animator:Play("PengUinCard_Result_Finish_in")
      WwiseManger:PostEvent("Mode_Card_compelete")
    end
  end
  
  cs_coroutine.start(wait)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function PenguinCardResultCtrl:Close()
  if self.bWin then
    self.animator:Play("PengUinCard_Result_Win_out")
  else
    self.animator:Play("PengUinCard_Result_Finish_out")
  end
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.333)
  self:AddTimer(1, 0.333, function()
    self._mapNode.goResult:SetActive(false)
    self.gameObject:SetActive(false)
    
    local function callback(bClose)
      WwiseManger:PostEvent("Mode_Card_stop")
      if bClose then
        PanelManager.Home()
      else
        EventManager.Hit(EventId.ClosePanel, PanelId.PenguinCard)
      end
    end
    
    self._panel.mapLevel:QuitGame(callback)
  end, true, true, true)
end

function PenguinCardResultCtrl:Awake()
  self._mapNode.goResult:SetActive(false)
  self.animator = self.gameObject:GetComponent("Animator")
end

function PenguinCardResultCtrl:OnEnable()
end

function PenguinCardResultCtrl:OnDisable()
end

function PenguinCardResultCtrl:OnBtnClick_Close()
  self:Close()
end

function PenguinCardResultCtrl:OnBtnClick_Log()
  EventManager.Hit("PenguinCard_OpenLog", self._panel.mapLevel.nCurTurn, true)
end

return PenguinCardResultCtrl
