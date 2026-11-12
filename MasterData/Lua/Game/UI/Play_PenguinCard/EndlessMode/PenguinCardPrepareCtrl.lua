local PenguinCardPrepareCtrl = class("PenguinCardPrepareCtrl", BaseCtrl)
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
local WwiseManger = CS.WwiseAudioManager.Instance
local _, Black = ColorUtility.TryParseHtmlString("#3E3C5B")
local _, Red = ColorUtility.TryParseHtmlString("#ef3d5c")
local _, Green = ColorUtility.TryParseHtmlString("#649c57")
local newDayTime = UTILS.GetDayRefreshTimeOffset()
local LocalData = require("GameCore.Data.LocalData")
local State = {Aide = 1, Card = 2}
PenguinCardPrepareCtrl._mapNodeConfig = {
  txtAddMax = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_AddBtnMax"
  },
  imgDiscount = {nCount = 3},
  imgIncrease = {nCount = 3},
  btnAddOption = {
    nCount = 3,
    sComponentName = "UIButton",
    callback = "OnBtnClick_AddOption"
  },
  txtBtnAddOption = {nCount = 3, sComponentName = "TMP_Text"},
  txtAddOptionCost = {nCount = 3, sComponentName = "TMP_Text"},
  goAddOptionOn = {nCount = 3},
  goAddOptionOff = {nCount = 3},
  txtScore = {sComponentName = "TMP_Text"},
  txtLeftTurn = {sComponentName = "TMP_Text"},
  txtAim = {sComponentName = "TMP_Text"},
  txtPhase = {sComponentName = "TMP_Text"},
  imgPhaseOn = {nCount = 2},
  imgPhaseOff = {nCount = 2},
  Roll = {sNodeName = "--Roll--"},
  Card = {sNodeName = "--Card--"},
  Aide = {sNodeName = "--Aide--"},
  PenguinCardItem = {
    nCount = 4,
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinCardItemCtrl"
  },
  btnRoll = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Roll"
  },
  txtBtnRoll = {sComponentName = "TMP_Text"},
  txtRollCost = {sComponentName = "TMP_Text"},
  trBtnRoll = {sNodeName = "btnRoll", sComponentName = "Transform"},
  AideItem = {
    nCount = 2,
    sCtrlName = "Game.UI.Play_PenguinCard.EndlessMode.PenguinCardAideItemCtrl"
  },
  btnStartTurn = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_StartTurn"
  },
  txtBtnStartTurn = {sComponentName = "TMP_Text"},
  goHp = {nCount = 3, sComponentName = "Animator"},
  txtHp = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Endless_HP"
  }
}
PenguinCardPrepareCtrl._mapEventConfig = {
  PenguinCard_AddRound = "OnEvent_AddRound",
  PenguinCard_AddAide = "OnEvent_AddAide",
  PenguinCard_AddAdditionScore = "OnEvent_AddAdditionScore",
  PenguinCard_ChangeScore = "OnEvent_ChangeScore",
  PenguinCard_RollPenguinCard = "OnEvent_RollPenguinCard",
  PenguinCard_SelectPenguinCard = "OnEvent_SelectPenguinCard",
  PenguinCard_SalePenguinCard = "OnEvent_SalePenguinCard",
  PenguinCard_ChangeHp = "OnEvent_ChangeHp",
  PenguinCard_ChangeUpgradeDiscount = "OnEvent_ChangeUpgradeDiscount",
  PenguinCard_SelectAide = "OnEvent_SelectAide",
  PenguinCard_UpgradeAide = "OnEvent_UpgradeAide",
  PenguinCard_SaleAide = "OnEvent_SaleAide",
  PenguinCard_ChangeAimScore = "OnEvent_ChangeAimScore"
}

function PenguinCardPrepareCtrl:Refresh()
  self:RefreshAddOption()
  self:RefreshScore()
  self:RefreshTitle()
  self:RefreshHp()
  self:RefreshAddOptionTitle()
  self:RefreshState(State.Aide)
end

function PenguinCardPrepareCtrl:RefreshState(nState)
  self.nState = nState
  self._mapNode.Roll:SetActive(nState == State.Card)
  self._mapNode.Card:SetActive(nState == State.Card)
  self._mapNode.Aide:SetActive(nState == State.Aide)
  if nState == State.Aide then
    self:RefreshAide()
    NovaAPI.SetTMPText(self._mapNode.txtBtnStartTurn, ConfigTable.GetUIText("PenguinCard_Btn_SkipAide"))
    NovaAPI.SetTMPText(self._mapNode.txtPhase, ConfigTable.GetUIText("PenguinCard_Endless_PhaseAide"))
    self._mapNode.imgPhaseOn[1]:SetActive(true)
    self._mapNode.imgPhaseOn[2]:SetActive(false)
    self._mapNode.imgPhaseOff[1]:SetActive(false)
    self._mapNode.imgPhaseOff[2]:SetActive(true)
  elseif nState == State.Card then
    self:RefreshRoll()
    NovaAPI.SetTMPText(self._mapNode.txtBtnStartTurn, ConfigTable.GetUIText("PenguinCard_Btn_NextTurn"))
    NovaAPI.SetTMPText(self._mapNode.txtPhase, ConfigTable.GetUIText("PenguinCard_Endless_PhaseCard"))
    self._mapNode.imgPhaseOn[1]:SetActive(false)
    self._mapNode.imgPhaseOn[2]:SetActive(true)
    self._mapNode.imgPhaseOff[1]:SetActive(true)
    self._mapNode.imgPhaseOff[2]:SetActive(false)
  end
end

function PenguinCardPrepareCtrl:RefreshAddOptionTitle()
  local tbOption = {
    "PenguinCard_Btn_AddRound",
    "PenguinCard_Btn_AddAide",
    "PenguinCard_Btn_AddAdditionScore"
  }
  for i = 1, 3 do
    NovaAPI.SetTMPText(self._mapNode.txtBtnAddOption[i], ConfigTable.GetUIText(tbOption[i]))
  end
  self:RefreshAddScoreTitle()
end

function PenguinCardPrepareCtrl:RefreshAddScoreTitle()
  local nScore = self._panel.mapLevel.tbAdditionScore[self._panel.mapLevel.nAdditionScoreLevel + 1]
  if nScore == nil then
    nScore = self._panel.mapLevel.tbAdditionScore[self._panel.mapLevel.nAdditionScoreLevel]
  end
  NovaAPI.SetTMPText(self._mapNode.txtBtnAddOption[3], orderedFormat(ConfigTable.GetUIText("PenguinCard_Btn_AddAdditionScore"), self:ThousandsNumber(nScore)))
end

function PenguinCardPrepareCtrl:RefreshAddOption()
  local tbOption = {
    self._panel.mapLevel.nRoundLimit >= self._panel.mapLevel.nMaxRound,
    self._panel.mapLevel.nAideLimit >= self._panel.mapLevel.nMaxAide,
    self._panel.mapLevel.nAdditionScoreLevel >= self._panel.mapLevel.nMaxAdditionScore
  }
  for i = 1, 3 do
    local bMax = tbOption[i]
    self._mapNode.goAddOptionOn[i]:SetActive(not bMax)
    self._mapNode.goAddOptionOff[i]:SetActive(bMax)
  end
  self:RefreshAddOptionCost()
end

function PenguinCardPrepareCtrl:GetAddOptionData()
  local tbOption = {
    self._panel.mapLevel.nRoundLimit >= self._panel.mapLevel.nMaxRound,
    self._panel.mapLevel.nAideLimit >= self._panel.mapLevel.nMaxAide,
    self._panel.mapLevel.nAdditionScoreLevel >= self._panel.mapLevel.nMaxAdditionScore
  }
  local tbCost = {
    self._panel.mapLevel.tbRoundUpgradeCost,
    self._panel.mapLevel.tbAideUpgradeCost,
    self._panel.mapLevel.tbScoreUpgradeCost
  }
  local tbHas = {
    self._panel.mapLevel.nRoundLimit,
    self._panel.mapLevel.nAideLimit,
    self._panel.mapLevel.nAdditionScoreLevel
  }
  return tbOption, tbCost, tbHas
end

function PenguinCardPrepareCtrl:RefreshAddOptionCost()
  local tbOption, tbCost, tbHas = self:GetAddOptionData()
  local nDiscount = self._panel.mapLevel:GetUpgradeDiscount()
  for i = 1, 3 do
    local bMax = tbOption[i]
    self._mapNode.imgDiscount[i]:SetActive(nDiscount < 1 and not bMax)
    self._mapNode.imgIncrease[i]:SetActive(1 < nDiscount and not bMax)
    if not bMax then
      local nAim = tbHas[i] + 1
      local nCost = tbCost[i][nAim] * nDiscount
      nCost = math.ceil(nCost)
      NovaAPI.SetTMPText(self._mapNode.txtAddOptionCost[i], self:ThousandsNumber(nCost))
      if nCost > self._panel.mapLevel.nScore then
        NovaAPI.SetTMPColor(self._mapNode.txtAddOptionCost[i], Red_Unable)
      elseif nDiscount < 1 then
        NovaAPI.SetTMPColor(self._mapNode.txtAddOptionCost[i], Green)
      else
        NovaAPI.SetTMPColor(self._mapNode.txtAddOptionCost[i], Black)
      end
    end
  end
  self:RefreshAddScoreTitle()
end

function PenguinCardPrepareCtrl:RefreshScore()
  local nScore = math.floor(self._panel.mapLevel.nScore)
  NovaAPI.SetTMPText(self._mapNode.txtScore, self:ThousandsNumber(nScore))
end

function PenguinCardPrepareCtrl:RefreshTitle()
  NovaAPI.SetTMPText(self._mapNode.txtLeftTurn, orderedFormat(ConfigTable.GetUIText("PenguinCard_Endless_LevelTittle"), self._panel.mapLevel.nEndlessLevel))
  local nScore = math.floor(self._panel.mapLevel:GetAimScore())
  NovaAPI.SetTMPText(self._mapNode.txtAim, orderedFormat(ConfigTable.GetUIText("PenguinCard_Endless_AimScoreTitle"), self:ThousandsNumber(nScore)))
end

function PenguinCardPrepareCtrl:RefreshHp()
  for i = 1, 3 do
    if i > self._panel.mapLevel.nHp then
      self._mapNode.goHp[i]:Play("PenguinCardHp_Null", 0, 0)
    end
  end
end

function PenguinCardPrepareCtrl:RefreshAide()
  local nMax = #self._panel.mapLevel.tbSelectableAide
  for i = 1, 2 do
    self._mapNode.AideItem[i].gameObject:SetActive(i <= nMax)
    if i <= nMax then
      self._mapNode.AideItem[i]:Refresh(self._panel.mapLevel.tbSelectableAide[i], i)
    end
  end
end

function PenguinCardPrepareCtrl:RefreshRoll(bRoll)
  self:RefreshRollCard(bRoll)
  self:RefreshRollDesc()
  self:RefreshRollCost()
end

function PenguinCardPrepareCtrl:RefreshRollCard(bRoll)
  local nMax = #self._panel.mapLevel.tbSelectablePenguinCard
  for i = 1, 4 do
    self._mapNode.PenguinCardItem[i].gameObject:SetActive(i <= nMax)
    if i <= nMax then
      self._mapNode.PenguinCardItem[i]:Refresh_Select(self._panel.mapLevel.tbSelectablePenguinCard[i], i, bRoll)
    end
  end
end

function PenguinCardPrepareCtrl:RefreshRollDesc()
  if self._panel.mapLevel.nBuyLimit == 0 then
    NovaAPI.SetTMPText(self._mapNode.txtBtnRoll, ConfigTable.GetUIText("PenguinCard_Btn_Roll"))
  elseif self._panel.mapLevel.nTurnBuyCount == self._panel.mapLevel.nBuyLimit then
    local sSuffix = orderedFormat(ConfigTable.GetUIText("PenguinCard_Btn_RollSuffix"), "<color=#bd3059>0</color>", self._panel.mapLevel.nBuyLimit)
    NovaAPI.SetTMPText(self._mapNode.txtBtnRoll, ConfigTable.GetUIText("PenguinCard_Btn_Roll") .. sSuffix)
  else
    local sSuffix = orderedFormat(ConfigTable.GetUIText("PenguinCard_Btn_RollSuffix"), self._panel.mapLevel.nBuyLimit - self._panel.mapLevel.nTurnBuyCount, self._panel.mapLevel.nBuyLimit)
    NovaAPI.SetTMPText(self._mapNode.txtBtnRoll, ConfigTable.GetUIText("PenguinCard_Btn_Roll") .. sSuffix)
  end
end

function PenguinCardPrepareCtrl:RefreshRollCost()
  if self._panel.mapLevel.nBuyLimit == 0 then
    self._mapNode.txtRollCost.gameObject:SetActive(false)
    return
  end
  if self._panel.mapLevel.nTurnBuyCount == self._panel.mapLevel.nBuyLimit then
    self._mapNode.txtRollCost.gameObject:SetActive(false)
    return
  end
  self._mapNode.txtRollCost.gameObject:SetActive(true)
  local nCost = self._panel.mapLevel:GetRollPenguinCardCost()
  NovaAPI.SetTMPText(self._mapNode.txtRollCost, self:ThousandsNumber(nCost))
  NovaAPI.SetTMPColor(self._mapNode.txtRollCost, nCost > self._panel.mapLevel.nScore and Red or White_Normal)
end

function PenguinCardPrepareCtrl:PlayOutAni()
  self.animator:Play("PengUinCard_Endless_Prepare_out", 0, 0)
  for i = 1, 4 do
    if self._mapNode.PenguinCardItem[i].gameObject.activeSelf == true then
      self._mapNode.PenguinCardItem[i]:PlayHideAni()
    end
  end
  for i = 1, 2 do
    if self._mapNode.AideItem[i].gameObject.activeSelf == true then
      self._mapNode.AideItem[i]:PlayHideAni()
    end
  end
end

function PenguinCardPrepareCtrl:PlayChangeStateAni()
  local nMax = #self._panel.mapLevel.tbSelectableAide
  local nAnimTime = 1
  for i = 1, nMax do
    nAnimTime = self._mapNode.AideItem[i]:PlayHideAni()
  end
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimTime)
  self:AddTimer(1, nAnimTime, function()
    self:RefreshState(State.Card)
  end, true, true, true)
end

function PenguinCardPrepareCtrl:StartTurn()
  local TipsTime = LocalData.GetPlayerLocalData("PenguinCardSelectTips_Card")
  local _tipDay = 0
  if TipsTime ~= nil then
    _tipDay = tonumber(TipsTime)
  end
  local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local fixedTimeStamp = curTimeStamp + newDayTime * 3600
  local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
  local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
  local nDay = tonumber(os.date("!%d", fixedTimeStamp))
  local nowD = nYear * 366 + nMonth * 31 + nDay
  if not self._panel.mapLevel.bSelectedPenguinCard and nowD ~= _tipDay then
    local isSelectAgain = false
    
    local function confirmCallback()
      if isSelectAgain then
        local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
        local _fixedTimeStamp = _curTimeStamp + newDayTime * 3600
        local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
        local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
        local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
        local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
        LocalData.SetPlayerLocalData("PenguinCardSelectTips_Card", tostring(_nowD))
      end
      self._panel.mapLevel:SwitchGameState()
    end
    
    local function againCallback(isSelect)
      isSelectAgain = isSelect
    end
    
    local msg = {
      sContent = ConfigTable.GetUIText("PenguinCard_Tip_NotSelectedPenguinCard"),
      callbackConfirm = confirmCallback,
      callbackAgain = againCallback
    }
    EventManager.Hit("PenguinCard_OpenConfirm", msg)
  else
    self._panel.mapLevel:SwitchGameState()
  end
end

function PenguinCardPrepareCtrl:SkipAide()
  local TipsTime = LocalData.GetPlayerLocalData("PenguinCardSelectTips_Aide")
  local _tipDay = 0
  if TipsTime ~= nil then
    _tipDay = tonumber(TipsTime)
  end
  local curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
  local fixedTimeStamp = curTimeStamp + newDayTime * 3600
  local nYear = tonumber(os.date("!%Y", fixedTimeStamp))
  local nMonth = tonumber(os.date("!%m", fixedTimeStamp))
  local nDay = tonumber(os.date("!%d", fixedTimeStamp))
  local nowD = nYear * 366 + nMonth * 31 + nDay
  if not self._panel.mapLevel.bSelectedAide and nowD ~= _tipDay then
    local isSelectAgain = false
    
    local function confirmCallback()
      if isSelectAgain then
        local _curTimeStamp = CS.ClientManager.Instance.serverTimeStampWithTimeZone
        local _fixedTimeStamp = _curTimeStamp + newDayTime * 3600
        local _nYear = tonumber(os.date("!%Y", _fixedTimeStamp))
        local _nMonth = tonumber(os.date("!%m", _fixedTimeStamp))
        local _nDay = tonumber(os.date("!%d", _fixedTimeStamp))
        local _nowD = _nYear * 366 + _nMonth * 31 + _nDay
        LocalData.SetPlayerLocalData("PenguinCardSelectTips_Aide", tostring(_nowD))
      end
      WwiseManger:PostEvent("Mode_Card_giveup")
      self:PlayChangeStateAni()
    end
    
    local function againCallback(isSelect)
      isSelectAgain = isSelect
    end
    
    local msg = {
      sContent = ConfigTable.GetUIText("PenguinCard_Tip_NotSelectedAide"),
      callbackConfirm = confirmCallback,
      callbackAgain = againCallback
    }
    EventManager.Hit("PenguinCard_OpenConfirm", msg)
  else
    WwiseManger:PostEvent("Mode_Card_giveup")
    self:PlayChangeStateAni()
  end
end

function PenguinCardPrepareCtrl:Awake()
  self.animator = self.gameObject:GetComponent("Animator")
end

function PenguinCardPrepareCtrl:OnEnable()
end

function PenguinCardPrepareCtrl:OnDisable()
end

function PenguinCardPrepareCtrl:OnBtnClick_AddOption(btn, nIndex)
  if nIndex == 1 then
    self._panel.mapLevel:AddRound()
  elseif nIndex == 2 then
    self._panel.mapLevel:AddAide()
  elseif nIndex == 3 then
    self._panel.mapLevel:AddAdditionScore()
  end
end

function PenguinCardPrepareCtrl:OnBtnClick_Roll(btn)
  self._panel.mapLevel:RollPenguinCard()
end

function PenguinCardPrepareCtrl:OnBtnClick_StartTurn(btn)
  if self.nState == State.Aide then
    self:SkipAide()
  else
    self:StartTurn()
  end
end

function PenguinCardPrepareCtrl:OnEvent_AddAide()
  self:RefreshAddOption()
end

function PenguinCardPrepareCtrl:OnEvent_AddAdditionScore()
  self:RefreshAddOption()
end

function PenguinCardPrepareCtrl:OnEvent_AddRound()
  self:RefreshAddOption()
end

function PenguinCardPrepareCtrl:OnEvent_ChangeScore(nBefore)
  if self._panel.mapLevel.nGameState ~= PenguinCardUtils.GameState.Prepare then
    return
  end
  self:RefreshAddOptionCost()
  self:RefreshRollCost()
  if nBefore < self._panel.mapLevel.nScore and self._panel.mapLevel.nGameState == PenguinCardUtils.GameState.Prepare then
    WwiseManger:PostEvent("Mode_Card_coin")
  end
  local callback = dotween_callback_handler(self, function()
    if nBefore < self._panel.mapLevel.nScore and self._panel.mapLevel.nGameState == PenguinCardUtils.GameState.Prepare then
      WwiseManger:PostEvent("Mode_Card_coin_stop")
    end
  end)
  DOTween.To(function()
    return nBefore
  end, function(v)
    local nScore = math.floor(v)
    NovaAPI.SetTMPText(self._mapNode.txtScore, self:ThousandsNumber(nScore))
  end, self._panel.mapLevel.nScore, 0.5):OnComplete(callback)
end

function PenguinCardPrepareCtrl:OnEvent_RollPenguinCard()
  self:RefreshRoll(true)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  WwiseManger:PostEvent("Mode_Card_refresh")
end

function PenguinCardPrepareCtrl:OnEvent_SelectPenguinCard()
  local nMax = #self._panel.mapLevel.tbSelectablePenguinCard
  for i = 1, nMax do
    self._mapNode.PenguinCardItem[i]:PlayFlipAni()
  end
  self:RefreshRollDesc()
end

function PenguinCardPrepareCtrl:OnEvent_SalePenguinCard(_, nGroupId)
  for i = 1, 4 do
    if self._mapNode.PenguinCardItem[i].gameObject.activeSelf == true then
      self._mapNode.PenguinCardItem[i]:RefreshUpgrade(nGroupId)
    end
  end
end

function PenguinCardPrepareCtrl:OnEvent_SelectAide()
  self:PlayChangeStateAni()
end

function PenguinCardPrepareCtrl:OnEvent_UpgradeAide()
  local nMax = #self._panel.mapLevel.tbSelectablePenguinCard
  for i = 1, nMax do
    self._mapNode.PenguinCardItem[i]:PlayFlipAni()
  end
end

function PenguinCardPrepareCtrl:OnEvent_SaleAide(nAideIndex)
  local nMax = #self._panel.mapLevel.tbSelectablePenguinCard
  for i = 1, nMax do
    self._mapNode.PenguinCardItem[i]:RefreshHead(nAideIndex)
  end
end

function PenguinCardPrepareCtrl:OnEvent_ChangeAimScore(nBeforeScore)
  nBeforeScore = math.floor(nBeforeScore)
  local nScore = math.floor(self._panel.mapLevel:GetAimScore())
  DOTween.To(function()
    return nBeforeScore
  end, function(v)
    local value = math.floor(v)
    NovaAPI.SetTMPText(self._mapNode.txtAim, orderedFormat(ConfigTable.GetUIText("PenguinCard_Endless_AimScoreTitle"), self:ThousandsNumber(value)))
  end, nScore, 0.5)
end

function PenguinCardPrepareCtrl:OnEvent_ChangeHp(nChange)
  local bSkipSound = self._panel.mapLevel.nGameState ~= PenguinCardUtils.GameState.Prepare
  if nChange < 0 then
    for i = self._panel.mapLevel.nHp + 1, self._panel.mapLevel.nHp - nChange do
      self._mapNode.goHp[i]:Play("PenguinCardHp_Del", 0, 0)
      if not bSkipSound then
        WwiseManger:PostEvent("Mode_Card_hurt")
      end
    end
  else
    for i = self._panel.mapLevel.nHp - nChange + 1, self._panel.mapLevel.nHp do
      self._mapNode.goHp[i]:Play("PenguinCardHp_Add")
      if not bSkipSound then
        WwiseManger:PostEvent("Mode_Card_heal")
      end
    end
  end
end

function PenguinCardPrepareCtrl:OnEvent_ChangeUpgradeDiscount(nBeforeDiscount)
  if self._panel.mapLevel.nGameState ~= PenguinCardUtils.GameState.Prepare then
    return
  end
  local tbOption, tbCost, tbHas = self:GetAddOptionData()
  local nDiscount = self._panel.mapLevel:GetUpgradeDiscount()
  for i = 1, 3 do
    local bMax = tbOption[i]
    self._mapNode.imgDiscount[i]:SetActive(nDiscount < 1 and not bMax)
    self._mapNode.imgIncrease[i]:SetActive(1 < nDiscount and not bMax)
    if not bMax then
      local nAim = tbHas[i] + 1
      local nCost = tbCost[i][nAim] * nDiscount
      nCost = math.ceil(nCost)
      local nBeforeCost = tbCost[i][nAim] * nBeforeDiscount
      nBeforeCost = math.ceil(nBeforeCost)
      DOTween.To(function()
        return nBeforeCost
      end, function(v)
        local nScore = math.floor(v)
        NovaAPI.SetTMPText(self._mapNode.txtAddOptionCost[i], self:ThousandsNumber(nScore))
      end, nCost, 0.5)
      if nCost > self._panel.mapLevel.nScore then
        NovaAPI.SetTMPColor(self._mapNode.txtAddOptionCost[i], Red_Unable)
      elseif nDiscount < 1 then
        NovaAPI.SetTMPColor(self._mapNode.txtAddOptionCost[i], Green)
      else
        NovaAPI.SetTMPColor(self._mapNode.txtAddOptionCost[i], Black)
      end
    end
  end
end

return PenguinCardPrepareCtrl
