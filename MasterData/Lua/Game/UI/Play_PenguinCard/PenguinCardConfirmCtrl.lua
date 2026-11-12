local PenguinCardConfirmCtrl = class("PenguinCardConfirmCtrl", BaseCtrl)
PenguinCardConfirmCtrl._mapNodeConfig = {
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
    sLanguageId = "MessageBox_Title"
  },
  window = {},
  aniWindow = {sNodeName = "window", sComponentName = "Animator"},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  txtContentMain = {sComponentName = "TMP_Text"},
  btnCancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnConfirm = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnCancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Cancel"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  btnAgain = {
    sComponentName = "NaviButton",
    callback = "OnBtnClick_Again"
  },
  againSelect = {},
  texAgainTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_TodayWarning"
  },
  goAgain = {}
}
PenguinCardConfirmCtrl._mapEventConfig = {PenguinCard_OpenConfirm = "Open"}

function PenguinCardConfirmCtrl:Open(mapMsg)
  self._panel.mapLevel:Pause()
  self:PlayInAni()
  self:Refresh(mapMsg)
end

function PenguinCardConfirmCtrl:Refresh(mapMsg)
  local sContent = mapMsg.sContent
  self.callbackConfirm = mapMsg.callbackConfirm
  self.callbackAgain = mapMsg.callbackAgain
  self._mapNode.btnAgain.gameObject:SetActive(self.callbackAgain ~= nil)
  self._mapNode.againSelect:SetActive(false)
  self._mapNode.goAgain.gameObject:SetActive(self.callbackAgain ~= nil)
  NovaAPI.SetTMPText(self._mapNode.txtContentMain, sContent)
end

function PenguinCardConfirmCtrl:PlayInAni()
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

function PenguinCardConfirmCtrl:Close(callback)
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  self._mapNode.aniBlur:SetTrigger("tOut")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.2)
  self:AddTimer(1, 0.2, function()
    self._mapNode.window:SetActive(false)
    self.gameObject:SetActive(false)
    self._panel.mapLevel:Resume()
    if callback then
      callback()
    end
  end, true, true, true)
end

function PenguinCardConfirmCtrl:Awake()
  self._mapNode.window:SetActive(false)
end

function PenguinCardConfirmCtrl:OnEnable()
end

function PenguinCardConfirmCtrl:OnDisable()
end

function PenguinCardConfirmCtrl:OnBtnClick_Close()
  self:Close()
end

function PenguinCardConfirmCtrl:OnBtnClick_Confirm()
  self:Close(self.callbackConfirm)
end

function PenguinCardConfirmCtrl:OnBtnClick_Again()
  self._mapNode.againSelect:SetActive(not self._mapNode.againSelect.activeSelf)
  if self.callbackAgain then
    self.callbackAgain(self._mapNode.againSelect.activeSelf)
  end
end

return PenguinCardConfirmCtrl
