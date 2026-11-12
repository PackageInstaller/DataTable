local PenguinCardLogCtrl = class("PenguinCardLogCtrl", BaseCtrl)
local WwiseManger = CS.WwiseAudioManager.Instance
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
    sLanguageId = "PenguinCard_Log_TurnScore"
  },
  sv = {
    sComponentName = "LoopScrollView"
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
  self._mapNode.btnRight.gameObject:SetActive(bAll and self.nMax > 1)
  self._mapNode.btnLeft.gameObject:SetActive(bAll and self.nMax > 1)
  self:PlayInAni()
  self:Refresh()
end

function PenguinCardLogCtrl:Refresh()
  local mapTurn = self._panel.mapLevel.mapLog[self.nTurn]
  NovaAPI.SetTMPText(self._mapNode.txtTurn, orderedFormat(ConfigTable.GetUIText("PenguinCard_Log_TurnCount"), self.nTurn))
  local nTurnScore = math.floor(mapTurn.nTurnScore)
  NovaAPI.SetTMPText(self._mapNode.txtTurnScore, self:ThousandsNumber(nTurnScore))
  self.tbRound = mapTurn.tbRound
  local nCount = #self.tbRound
  self._mapNode.sv.gameObject:SetActive(0 < nCount)
  if 0 < nCount then
    self._mapNode.sv:SetAnim(0.08)
    self._mapNode.sv:Init(nCount, self, self.OnGridRefresh)
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
  end
  
  cs_coroutine.start(wait)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function PenguinCardLogCtrl:Close()
  self.animator:Play("PengUinCard_Log_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.333)
  self:AddTimer(1, 0.333, function()
    self._mapNode.window:SetActive(false)
    self.gameObject:SetActive(false)
    if self.callback then
      self.callback()
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

function PenguinCardLogCtrl:OnBtnClick_Close()
  self:Close()
end

return PenguinCardLogCtrl
