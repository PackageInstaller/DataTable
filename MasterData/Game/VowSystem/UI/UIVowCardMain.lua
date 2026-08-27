local UIVowCardMain = class("UIVowCardMain", UIBaseWindow)
local UINVowTitle = require("Game.VowSystem.UI.Title.UINVowTitle")
local base = UIBaseWindow
local CS_Camera = CS.UnityEngine.Camera
local vowCardMainUiState = {
  Default = 1,
  Sign = 2,
  Waiting = 3,
  Confirm = 4,
  Check = 5
}
local SetVowCardUiFunc = {
  [vowCardMainUiState.Default] = function(self)
    self.ui.obj_Signature:SetActive(false)
    self.ui.obj_Confirmation:SetActive(false)
    self.ui.obj_Formal:SetActive(false)
    self.ui.obj_Review:SetActive(false)
    self.titleGo:Hide()
    self.ui.btn_Skip.gameObject:SetActive(false)
  end,
  [vowCardMainUiState.Sign] = function(self)
    self.ui.obj_Signature:SetActive(true)
    self.ui.obj_Confirmation:SetActive(false)
    self.ui.obj_Formal:SetActive(false)
    self.ui.obj_Review:SetActive(false)
    self.titleGo:Hide()
    self.ui.btn_Skip.gameObject:SetActive(true)
    self.ui.tex_Skip:SetIndex(0)
  end,
  [vowCardMainUiState.Waiting] = function(self)
    self.ui.obj_Signature:SetActive(false)
    self.ui.obj_Confirmation:SetActive(true)
    self.ui.obj_Formal:SetActive(false)
    self.ui.obj_Review:SetActive(false)
    self.titleGo:Hide()
    self.ui.btn_Skip.gameObject:SetActive(false)
  end,
  [vowCardMainUiState.Confirm] = function(self)
    self.ui.obj_Signature:SetActive(false)
    self.ui.obj_Confirmation:SetActive(false)
    self.ui.obj_Formal:SetActive(true)
    self.ui.obj_Review:SetActive(false)
    self.titleGo:Hide()
    self.ui.btn_Skip.gameObject:SetActive(true)
    self.ui.tex_Skip:SetIndex(1)
  end,
  [vowCardMainUiState.Check] = function(self)
    self.ui.obj_Signature:SetActive(false)
    self.ui.obj_Confirmation:SetActive(false)
    self.ui.obj_Formal:SetActive(false)
    self.ui.obj_Review:SetActive(true)
    self.titleGo:Show()
    local cfg = self:GetNowUIVowCfg()
    if cfg then
      self.titleGo:InitVowTitle(cfg)
    end
    self.ui.btn_Skip.gameObject:SetActive(true)
    self.ui.tex_Skip:SetIndex(1)
  end
}

function UIVowCardMain:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):PushTopStatusDataToBackStack()
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnVowDrawConfirmClick)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.OnVowDrawCancleClick)
  UIUtil.AddButtonListener(self.ui.btn_Skip, self, self.OnVowDrawSkipClick)
  UIUtil.AddButtonListener(self.ui.btn_ShowAvg, self, self.OnVowDrawShowAvg)
  self.titleGo = UINVowTitle.New()
  self.titleGo:Init(self.ui.obj_TitleGroup)
  self:__SetVowCardMainState(vowCardMainUiState.Default)
  self.__mainCamGo = UIManager:GetMainCamera().gameObject
  self.__prefCamGoActive = self.__mainCamGo.activeSelf
  self.__mainCamGo:SetActive(false)
end

function UIVowCardMain:InitVowCardMainWithSign(heroId, confimDrawFunc, cancleDrawFunc)
  self._heroId = heroId
  self._confimDrawFunc = confimDrawFunc
  self._cancleDrawFunc = cancleDrawFunc
  self:__SetVowCardMainState(vowCardMainUiState.Sign)
end

function UIVowCardMain:InitVowCardMainWithCheck(heroId)
  self._heroId = heroId
  self:__SetVowCardMainState(vowCardMainUiState.Check)
end

function UIVowCardMain:__SetVowCardMainState(newstate)
  if self._prefState == newstate then
    return
  end
  self._prefState = newstate
  if SetVowCardUiFunc[newstate] ~= nil then
    SetVowCardUiFunc[newstate](self)
  end
end

function UIVowCardMain:GetNowUIVowCfg()
  local heroData = PlayerDataCenter.heroDic[self._heroId]
  if heroData == nil then
    return
  end
  return heroData:GetVowCfg()
end

function UIVowCardMain:OnVowDrawOver()
  self:__SetVowCardMainState(vowCardMainUiState.Waiting)
end

function UIVowCardMain:OnVowDrawConfirmClick()
  if self._confimDrawFunc ~= nil then
    self._confimDrawFunc()
  end
  self:__SetVowCardMainState(vowCardMainUiState.Confirm)
end

function UIVowCardMain:OnVowDrawCancleClick()
  self:__SetVowCardMainState(vowCardMainUiState.Sign)
  if self._cancleDrawFunc ~= nil then
    self._cancleDrawFunc()
  end
end

function UIVowCardMain:OnVowDrawSkipClick()
  if self._prefState == vowCardMainUiState.Confirm or self._prefState == vowCardMainUiState.Check then
    UIUtil.OnClickBackByUiTab(self)
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.VowShowSkip, function(window)
    window:InitVowShowSkip(function()
      local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
      vowSystemCtrl:SkipToCheckCardState()
    end)
  end)
end

function UIVowCardMain:OnVowChangeStateToConfirm()
  self:__SetVowCardMainState(vowCardMainUiState.Confirm)
end

function UIVowCardMain:OnVowDrawShowAvg()
  self.isShowAvg = true
  UIUtil.OnClickBackByUiTab(self)
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem, true)
  vowSystemCtrl:ShowVowShow(self._heroId)
end

function UIVowCardMain:__BackAction()
  self:OnCloseWin()
  self:Delete()
  local vowSystemCtrl = ControllerManager:GetController(ControllerTypeId.VowSystem)
  if vowSystemCtrl then
    vowSystemCtrl:LeaveVow(self.isShowAvg)
  end
  self.isShowAvg = false
end

function UIVowCardMain:OnDelete()
  self.__mainCamGo:SetActive(self.__prefCamGoActive)
  base.OnDelete(self)
end

return UIVowCardMain
