local PenguinCardLogCtrl = class("PenguinCardLogCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
local _, Success = ColorUtility.TryParseHtmlString("#FFF9EF")
local _, Fail = ColorUtility.TryParseHtmlString("#CB698A")
PenguinCardLogCtrl._mapNodeConfig = {
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
  window = {},
  txtTurn = {sComponentName = "TMP_Text"},
  txtTurnScore = {sComponentName = "TMP_Text"},
  txtTurnGet = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Log_OwnScore"
  },
  sv = {
    sComponentName = "LoopScrollView"
  },
  txtAim = {sComponentName = "TMP_Text"},
  txtComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Endless_Complete"
  },
  txtFailDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Endless_LossHP"
  },
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  txtClick = {
    sComponentName = "TMP_Text",
    sLanguageId = "Tips_Continue"
  },
  btnRetry = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Retry"
  },
  txtBtnRetry = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_Retry"
  },
  btnQuit = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quit"
  },
  txtBtnQuit = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_Quit"
  },
  goHp = {nCount = 3, sComponentName = "Animator"},
  txtHp = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Endless_HP"
  }
}
PenguinCardLogCtrl._mapEventConfig = {PenguinCard_OpenLog = "Open"}

function PenguinCardLogCtrl:Open(nTurn, bAll, callback)
  self.nMax = self._panel.mapLevel.nCurTurn
  self.nTurn = nTurn
  self.callback = callback
  if self._panel.mapLevel.mapLog[self.nMax] == nil then
    self.nMax = self.nMax - 1
    if self.nTurn > self.nMax then
      self.nTurn = self.nMax
    end
  end
  self.bWin = self._panel.mapLevel.nScore >= self._panel.mapLevel:GetAimScore()
  self._mapNode.btnRight.gameObject:SetActive(bAll and self.nMax > 1)
  self._mapNode.btnLeft.gameObject:SetActive(bAll and self.nMax > 1)
  self:PlayInAni()
  self:Refresh()
end

function PenguinCardLogCtrl:Refresh()
  local mapTurn = self._panel.mapLevel.mapLog[self.nTurn]
  NovaAPI.SetTMPText(self._mapNode.txtTurn, orderedFormat(ConfigTable.GetUIText("PenguinCard_Endless_LevelTittle"), self._panel.mapLevel.nEndlessLevel))
  local nBeforeScore = self._panel.mapLevel.nScore - mapTurn.nTurnScore
  nBeforeScore = math.floor(nBeforeScore)
  NovaAPI.SetTMPText(self._mapNode.txtTurnScore, self:ThousandsNumber(nBeforeScore))
  self:AddTimer(1, 0.5, function()
    DOTween.To(function()
      return nBeforeScore
    end, function(v)
      local nScore = math.floor(v)
      NovaAPI.SetTMPText(self._mapNode.txtTurnScore, self:ThousandsNumber(nScore))
    end, self._panel.mapLevel.nScore, 0.5)
  end, true, true, true)
  NovaAPI.SetTMPColor(self._mapNode.txtTurnScore, self.bWin and Success or Fail)
  local nScore = math.floor(self._panel.mapLevel:GetAimScore())
  NovaAPI.SetTMPText(self._mapNode.txtAim, orderedFormat(ConfigTable.GetUIText("PenguinCard_Endless_AimScoreTitleShort"), self:ThousandsNumber(nScore)))
  self.tbRound = mapTurn.tbRound
  local nCount = #self.tbRound
  self._mapNode.sv.gameObject:SetActive(0 < nCount)
  if 0 < nCount then
    self._mapNode.sv:SetAnim(0.08)
    self._mapNode.sv:Init(nCount, self, self.OnGridRefresh)
  end
  local bBlockRetry = self._panel.mapLevel.bRetryLimit and not self._panel.mapLevel.bNewLevel
  self._mapNode.btnRetry.gameObject:SetActive(not self.bWin and 0 < self._panel.mapLevel.nHp and not bBlockRetry)
  self._mapNode.btnQuit.gameObject:SetActive(not self.bWin)
  self._mapNode.txtClick.gameObject:SetActive(self.bWin)
  self._mapNode.txtComplete.gameObject:SetActive(self.bWin)
  self._mapNode.txtFailDesc.gameObject:SetActive(not self.bWin)
  NovaAPI.SetButtonInteractable(self._mapNode.btnCloseBg, self.bWin)
  self:RefreshHp()
end

function PenguinCardLogCtrl:RefreshHp()
  for i = 1, 3 do
    if i > self._panel.mapLevel.nCheckHp then
      self._mapNode.goHp[i]:Play("PenguinCardHp_Null", 0, 0)
    end
  end
end

function PenguinCardLogCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapRound = self.tbRound[nIndex]
  local rtGrid = goGrid.transform:Find("btnGrid/AnimRoot")
  local txtHandRank = rtGrid.transform:Find("txtHandRank"):GetComponent("TMP_Text")
  local txtRoundScore = rtGrid.transform:Find("txtRoundScore"):GetComponent("TMP_Text")
  local mapCfg = ConfigTable.GetData("PenguinCardHandRank", mapRound.nHandRankId)
  if mapCfg then
    NovaAPI.SetTMPText(txtHandRank, mapCfg.Title)
  end
  local nRoundScore = math.floor(mapRound.nRoundScore)
  NovaAPI.SetTMPText(txtRoundScore, self:ThousandsNumber(nRoundScore))
  local nAll = #mapRound.tbHandRank
  for i = 1, 6 do
    local imgSuit = rtGrid.transform:Find("goSuit/imgSuitCount" .. i):GetComponent("Image")
    imgSuit.gameObject:SetActive(i <= nAll)
    if i <= nAll then
      local sName = AllEnum.PenguinCardSuitSprite[mapRound.tbHandRank[i]]
      self:SetSprite(imgSuit, "UI/Play_PenguinCard/SpriteAtlas/Sprite/" .. sName .. "_small")
    end
  end
end

function PenguinCardLogCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self._mapNode.blur:SetActive(true)
  self._mapNode.window:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    WwiseManger:PostEvent("Mode_Card_sum")
    WwiseManger:PostEvent("Mode_Card_coin_stop")
  end
  
  cs_coroutine.start(wait)
  local nAnimTime = NovaAPI.GetAnimClipLength(self.animator, {
    "PengUinCard_Log_in"
  })
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  self:AddTimer(1, nAnimTime, function()
    local nChange = self._panel.mapLevel.nHp - self._panel.mapLevel.nCheckHp
    if nChange < 0 then
      for i = self._panel.mapLevel.nHp + 1, self._panel.mapLevel.nHp - nChange do
        self._mapNode.goHp[i]:Play("PenguinCardHp_Del", 0, 0)
        WwiseManger:PostEvent("Mode_Card_hurt")
      end
    else
      for i = self._panel.mapLevel.nHp - nChange + 1, self._panel.mapLevel.nHp do
        self._mapNode.goHp[i]:Play("PenguinCardHp_Add")
        WwiseManger:PostEvent("Mode_Card_heal")
      end
    end
  end, true, true, true)
end

function PenguinCardLogCtrl:PlayCloseAni(callbackOption)
  self.animator:Play("PengUinCard_Log_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.333)
  self:AddTimer(1, 0.333, function()
    self._mapNode.window:SetActive(false)
    self.gameObject:SetActive(false)
    if callbackOption then
      callbackOption()
    end
  end, true, true, true)
end

function PenguinCardLogCtrl:Awake()
  self._mapNode.window:SetActive(false)
  self.animator = self.gameObject:GetComponent("Animator")
end

function PenguinCardLogCtrl:OnEnable()
end

function PenguinCardLogCtrl:OnDisable()
end

function PenguinCardLogCtrl:OnBtnClick_Right()
  if self.nTurn == self.nMax then
    self.nTurn = 1
  else
    self.nTurn = self.nTurn + 1
  end
  self:Refresh()
end

function PenguinCardLogCtrl:OnBtnClick_Left()
  if self.nTurn == 1 then
    self.nTurn = self.nMax
  else
    self.nTurn = self.nTurn - 1
  end
  self:Refresh()
end

function PenguinCardLogCtrl:OnBtnClick_Retry()
  if self._panel.mapLevel.bRetryLimit and not self._panel.mapLevel.bNewLevel then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      sSound = "Mode_Card_refresh_falied",
      sContent = ConfigTable.GetUIText("PenguinCard_Tip_RetryLimit")
    })
    return
  end
  
  local function callbackOption()
    self._panel.mapLevel:CheckAllRound()
  end
  
  self:PlayCloseAni(callbackOption)
end

function PenguinCardLogCtrl:OnBtnClick_Quit()
  local bBlockRetry = self._panel.mapLevel.bRetryLimit and not self._panel.mapLevel.bNewLevel
  
  local function callbackOption()
    if self._panel.mapLevel.nHp <= 0 or bBlockRetry then
      self._panel.mapLevel:SwitchGameState()
    else
      self._panel.mapLevel:CompleteGame()
    end
  end
  
  self:PlayCloseAni(callbackOption)
end

function PenguinCardLogCtrl:OnBtnClick_Close()
  local function callbackOption()
    self._panel.mapLevel:EnterNextLevel()
  end
  
  self:PlayCloseAni(callbackOption)
end

return PenguinCardLogCtrl
