local PenguinCardResultCtrl = class("PenguinCardResultCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local _, NotMaxLevel = ColorUtility.TryParseHtmlString("#FFF7EA")
local _, MaxLevel = ColorUtility.TryParseHtmlString("#ffe075")
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
  AideList = {},
  AideSlot = {nCount = 3},
  imgAideIcon = {nCount = 3, sComponentName = "Image"},
  txtAideLevel = {nCount = 3, sComponentName = "TMP_Text"},
  txtHardTurn = {sComponentName = "TMP_Text"},
  txtMostSuit = {sComponentName = "TMP_Text"},
  txtBestCard = {sComponentName = "TMP_Text"},
  imgMostSuit = {sComponentName = "Image"},
  txtHardCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_BestHard"
  },
  txtMostSuitCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_MostSuit"
  },
  txtBestCardCn = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Result_BestCard"
  },
  goHard = {},
  goMostSuit = {},
  goBestCard = {}
}
PenguinCardResultCtrl._mapEventConfig = {}

function PenguinCardResultCtrl:Open()
  self.bWin = true
  self:PlayInAni()
  self:Refresh()
end

function PenguinCardResultCtrl:Refresh()
  self:RefreshState()
  self:RefreshTitle()
  self:RefreshCard()
  self:RefreshAide()
  self:RefreshStatistics()
end

function PenguinCardResultCtrl:RefreshState()
  self._mapNode.goBgOn:SetActive(self.bWin)
  self._mapNode.goBgOff:SetActive(not self.bWin)
  self._mapNode.goTitleOn:SetActive(self.bWin)
  self._mapNode.goTitleOff:SetActive(not self.bWin)
  self._mapNode.txtNeedCount.gameObject:SetActive(not self.bWin)
  if not self.bWin then
    local nMax = self._panel.mapLevel:GetAimScore()
    local nNeed = nMax - self._panel.mapLevel.nScore
    nNeed = math.floor(nNeed)
    NovaAPI.SetTMPText(self._mapNode.txtNeedCount, orderedFormat(ConfigTable.GetUIText("PenguinCard_Result_NeedScore"), self:ThousandsNumber(nNeed)))
  end
end

function PenguinCardResultCtrl:RefreshTitle()
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

function PenguinCardResultCtrl:RefreshAide()
  local nCount = self._panel.mapLevel:GetOwnAideCount()
  self._mapNode.AideList:SetActive(0 < nCount)
  if 0 < nCount then
    for i = 1, 3 do
      local mapAide = self._panel.mapLevel.tbAide[i]
      self._mapNode.AideSlot[i].gameObject:SetActive(mapAide ~= 0)
      if mapAide ~= 0 then
        self:SetPngSprite(self._mapNode.imgAideIcon[i], mapAide.sIcon .. AllEnum.CharHeadIconSurfix.Q)
        if mapAide.nLevel == mapAide.nMaxLevel then
          NovaAPI.SetTMPColor(self._mapNode.txtAideLevel[i], MaxLevel)
          NovaAPI.SetTMPText(self._mapNode.txtAideLevel[i], orderedFormat(ConfigTable.GetUIText("PenguinCard_AideLevel"), mapAide.nLevel))
        else
          NovaAPI.SetTMPColor(self._mapNode.txtAideLevel[i], NotMaxLevel)
          NovaAPI.SetTMPText(self._mapNode.txtAideLevel[i], orderedFormat(ConfigTable.GetUIText("PenguinCard_AideLevel"), mapAide.nLevel))
        end
      end
    end
  end
end

function PenguinCardResultCtrl:RefreshStatistics()
  NovaAPI.SetTMPText(self._mapNode.txtHardTurn, orderedFormat(ConfigTable.GetUIText("PenguinCard_Endless_LevelTittle"), self._panel.mapLevel.nEndlessLevel))
  local nSuit, nSuitCount = self._panel.mapLevel:GetMostSuit()
  if 0 < nSuit then
    self._mapNode.goMostSuit:SetActive(true)
    self:SetSprite(self._mapNode.imgMostSuit, "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. AllEnum.PenguinCardSuitSprite[nSuit])
    NovaAPI.SetTMPText(self._mapNode.txtMostSuit, orderedFormat(ConfigTable.GetUIText("PenguinCard_Result_CountSuffix"), nSuitCount))
  else
    self._mapNode.goMostSuit:SetActive(false)
  end
  local mapCard = self._panel.mapLevel:GetBestPenguinCard()
  if mapCard then
    self._mapNode.goBestCard:SetActive(true)
    NovaAPI.SetTMPText(self._mapNode.txtBestCard, mapCard.sName)
  else
    self._mapNode.goBestCard:SetActive(false)
  end
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

function PenguinCardResultCtrl:PlayCloseAni(callbackOption)
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
    callbackOption()
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
  local function callbackOption()
    local function callback(bClose)
      WwiseManger:PostEvent("Mode_Card_stop")
      
      if bClose then
        PanelManager.Home()
      else
        EventManager.Hit(EventId.ClosePanel, PanelId.PenguinCardEndless)
      end
    end
    
    self._panel.mapLevel:QuitGame(callback)
  end
  
  self:PlayCloseAni(callbackOption)
end

return PenguinCardResultCtrl
