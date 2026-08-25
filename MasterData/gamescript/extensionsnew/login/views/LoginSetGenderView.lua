local UIAnimationController = CS.Z1Client.UIAnimationController
local LoginSetGenderView, Super = System.NewClass("LoginSetGenderView", BaseView)
LoginSetGenderView.uiResCls = UI_Guide_ChangeGenderResource

function LoginSetGenderView:ctor(callFunc, gender)
  Super.ctor(self)
  self.callFunc = callFunc
  self.gender = gender or CommonDefine.GenderID.Boy
  self.model = LoginCharacterCreateModel.Instance
end

function LoginSetGenderView:OnBuildView()
  Super.OnBuildView(self)
  self.animController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self:SetButtonText(self.ui.Btn_Confirm, LT.Text("Common_Button_Confirm"))
end

function LoginSetGenderView:RegisterNotifications()
  Super.RegisterNotifications(self)
end

function LoginSetGenderView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Image_Boy, System.fn(self, self._OnClickBoy))
  self:AddButtonClickListener(self.ui.Image_Girl, System.fn(self, self._OnClickGirl))
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
end

function LoginSetGenderView:OnEnterView()
  Super.OnEnterView(self)
  self.model:SetGender(self.gender)
  self.animController:PlayState("UI_Guide_ChangeGender_Open")
  self:BindTimer(0.01, 0, nil, System.fn(self, self._PlayInitAudio))
  self:_RefreshAll()
end

function LoginSetGenderView:OnExitView()
  Super.OnExitView(self)
end

function LoginSetGenderView:_RefreshAll()
  self:_RefreshSelectState()
  self:_RefreshShadow()
  self:_RefreshLihui()
end

function LoginSetGenderView:_RefreshSelectState()
  self.ui.Image_Boy_Select:SetActive(self.model:GetGender() == CommonDefine.GenderID.Boy)
  self.ui.Image_Girl_Select:SetActive(self.model:GetGender() == CommonDefine.GenderID.Girl)
end

function LoginSetGenderView:_RefreshShadow()
  self.ui.Image_BgBoy:SetActive(self.model:GetGender() == CommonDefine.GenderID.Boy)
  self.ui.Image_BgGril:SetActive(self.model:GetGender() == CommonDefine.GenderID.Girl)
end

function LoginSetGenderView:_RefreshLihui()
  self:SetImage(self.ui.Image_Lihui, self.model:GetPath())
end

function LoginSetGenderView:_OnClickBoy()
  if self.model:GetGender() == CommonDefine.GenderID.Boy then
    return
  end
  self.model:SetGender(CommonDefine.GenderID.Boy)
  self:_RefreshAll()
end

function LoginSetGenderView:_OnClickGirl()
  if self.model:GetGender() == CommonDefine.GenderID.Girl then
    return
  end
  self.model:SetGender(CommonDefine.GenderID.Girl)
  self:_RefreshAll()
end

function LoginSetGenderView:_OnClickConfirm()
  self.animController:PlayState("UI_Guide_ChangeGender_Close", System.fn(self, self._OnAnimCloseEnd))
end

function LoginSetGenderView:_OnAnimCloseEnd()
  self:Close()
  UIManager.Instance:Reopen(Urls.SetNamePanel, self.callFunc, self.model:GetGender())
end

function LoginSetGenderView:_PlayInitAudio()
  AudioManager.Instance:PostSoundEvent("Play_A_MUS_Funeral_Chp0")
  AudioManager.Instance:PostSoundEvent("Play_A_SFX_Amb_Rain_Smalle")
end

return LoginSetGenderView
