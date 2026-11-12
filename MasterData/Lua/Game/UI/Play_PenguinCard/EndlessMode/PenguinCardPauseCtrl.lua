local PenguinCardPauseCtrl = class("PenguinCardPauseCtrl", BaseCtrl)
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
PenguinCardPauseCtrl._mapNodeConfig = {
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
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Title_Pause"
  },
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtTurnTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_EndlessPause_Level"
  },
  txtTurnCount = {sComponentName = "TMP_Text"},
  txtLeftTurn = {sComponentName = "TMP_Text"},
  txtTargetTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_EndlessPause_Target"
  },
  goStar = {nCount = 3},
  imgStarOff = {nCount = 3},
  imgStarOn = {nCount = 3},
  txtTarget = {nCount = 3, sComponentName = "TMP_Text"},
  txtGameTarget = {sComponentName = "TMP_Text"},
  btnGiveup = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Giveup"
  },
  txtBtnGiveup = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_EndlessGiveup"
  },
  btnRestart = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtBtnRestart = {
    sComponentName = "TMP_Text",
    sLanguageId = "PenguinCard_Btn_EndlessContinue"
  }
}
PenguinCardPauseCtrl._mapEventConfig = {}

function PenguinCardPauseCtrl:Open()
  self._panel.mapLevel:Pause()
  self:PlayInAni()
  self:Refresh()
end

function PenguinCardPauseCtrl:Refresh()
  NovaAPI.SetTMPText(self._mapNode.txtTurnCount, orderedFormat(ConfigTable.GetUIText("PenguinCard_EndlessPause_LevelTitle"), self._panel.mapLevel.nEndlessLevel))
  local nScore = math.floor(self._panel.mapLevel:GetAimScore())
  NovaAPI.SetTMPText(self._mapNode.txtGameTarget, orderedFormat(ConfigTable.GetUIText("PenguinCard_EndlessPause_TargetDesc"), self:ThousandsNumber(nScore)))
end

function PenguinCardPauseCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self._mapNode.blur:SetActive(true)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.window:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
  end
  
  cs_coroutine.start(wait)
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function PenguinCardPauseCtrl:Close()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, function()
    self._mapNode.window:SetActive(false)
    self.gameObject:SetActive(false)
    self._panel.mapLevel:Resume()
  end, true, true, true)
end

function PenguinCardPauseCtrl:Awake()
  self._mapNode.window:SetActive(false)
end

function PenguinCardPauseCtrl:OnEnable()
end

function PenguinCardPauseCtrl:OnDisable()
end

function PenguinCardPauseCtrl:OnBtnClick_Close()
  self:Close()
end

function PenguinCardPauseCtrl:OnBtnClick_Giveup()
  self:Close()
  EventManager.Hit("PenguinCard_Pause_SwitchGame")
  self:AddTimer(1, 0.2, function()
    self._panel.mapLevel:CompleteGame()
  end, true, true, true)
end

return PenguinCardPauseCtrl
