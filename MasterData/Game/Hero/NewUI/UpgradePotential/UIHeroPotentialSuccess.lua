local UIHeroPotentialSuccess = class("UIHeroPotentialSuccess", UIBaseWindow)
local base = UIBaseWindow

function UIHeroPotentialSuccess:OnInit()
  UIUtil.Push2BackStack(self, self.OnBtnCloseClick)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
end

function UIHeroPotentialSuccess:OnInitHeroLimitUpSuccess(curLimit, nextLimit, heroId)
  AudioManager:PlayAudioById(1074)
  local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
  local voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.levelup, nil, heroId)
  cvCtr:PlayCv(heroId, voiceId)
  self.ui.uiAdapter:AdaptBgUI()
  self.ui.tex_CurLimit.text = tostring(curLimit or 0)
  if nextLimit ~= nil then
    self.ui.tex_NextLimit:SetIndex(0, tostring(nextLimit))
  else
    self.ui.tex_NextLimit:SetIndex(1)
  end
end

function UIHeroPotentialSuccess:SetBtnCloseAction(action)
  self.onBtnCloseAction = action
end

function UIHeroPotentialSuccess:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIHeroPotentialSuccess:OnBtnCloseClick()
  if self.onBtnCloseAction ~= nil then
    local bindFunc = self.onBtnCloseAction
    self.onBtnCloseActio = nil
    bindFunc()
  end
  self:Delete()
end

function UIHeroPotentialSuccess:OnDelete()
  base.OnDelete(self)
end

return UIHeroPotentialSuccess
