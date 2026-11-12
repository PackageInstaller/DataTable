local ExchangeCodeCtrl = class("ExchangeCodeCtrl", BaseCtrl)
ExchangeCodeCtrl._mapNodeConfig = {
  txtWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Account_ExchangeCode"
  },
  txtCodeDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "Settings_Account_CodeTips"
  },
  input = {
    sComponentName = "TMP_InputField"
  },
  btnClose = {sComponentName = "UIButton", callback = "ClosePanel"},
  btnClose1 = {sComponentName = "UIButton", callback = "ClosePanel"},
  btnConfirm2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Confirm"
  },
  txtBtnConfirm = {
    sComponentName = "TMP_Text",
    sLanguageId = "MessageBox_Confirm"
  },
  animator = {
    sNodeName = "---Exchange---",
    sComponentName = "Animator"
  }
}
ExchangeCodeCtrl._mapEventConfig = {}

function ExchangeCodeCtrl:Refresh()
  NovaAPI.SetTMPInputFieldText(self._mapNode.input, "")
end

function ExchangeCodeCtrl:PlayInAni()
  self.gameObject:SetActive(true)
  self._mapNode.animator:Play("t_window_04_t_in")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
end

function ExchangeCodeCtrl:PlayOutAni(callback)
  self._mapNode.animator:Play("t_window_04_t_out")
  self:AddTimer(1, 0.2, callback, true, true, true)
end

function ExchangeCodeCtrl:ClosePanel()
  local function cb()
    EventManager.Hit(EventId.ClosePanel, PanelId.ExchangeCodePanel)
  end
  
  self:PlayOutAni(cb)
end

function ExchangeCodeCtrl:FilterCharacters(text)
  local filtered = string.gsub(text, "[^%w]", "")
  filtered = string.upper(filtered)
  if filtered ~= text then
    NovaAPI.SetTMPInputFieldText(self._mapNode.input, filtered)
  end
end

function ExchangeCodeCtrl:Awake()
  self:Refresh()
  self:PlayInAni()
end

function ExchangeCodeCtrl:OnEnable()
  self._mapNode.input.onValueChanged:AddListener(function(text)
    self:FilterCharacters(text)
  end)
end

function ExchangeCodeCtrl:OnDisable()
  self._mapNode.input.onValueChanged:RemoveListener(function(text)
    self:FilterCharacters(text)
  end)
end

function ExchangeCodeCtrl:OnDestroy()
end

function ExchangeCodeCtrl:OnBtnClick_Confirm(btn)
  local function callback(changeInfo)
    UTILS.OpenReceiveByChangeInfo(changeInfo, function()
      self:ClosePanel()
    end)
  end
  
  local sCode = NovaAPI.GetTMPInputFieldText(self._mapNode.input)
  PlayerData.Base:SendPlayerRedeemCodeReq(sCode, callback)
end

return ExchangeCodeCtrl
