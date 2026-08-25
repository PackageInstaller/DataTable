local UIAnimationController = CS.Z1Client.UIAnimationController
local SetGenderPanel, Super = System.NewClass("SetGenderPanel", UIBasePanel)
SetGenderPanel.uiResCls = UI_Guide_ChangeGenderResource

function SetGenderPanel:ctor(callFunc, gender)
  Super.ctor(self)
  self.callFunc = callFunc
  self.gender = gender or CommonDefine.GenderID.Boy
end

function SetGenderPanel:OnBind(binder)
  self.binder = binder
  self.model = self.binder:createModel(SetGenderNameModel)
  self.model:SetGender(self.gender)
  self:UpdateShadow()
  self.AnimController = self.ui.uiNode:GetComponent(typeof(UIAnimationController))
  self.AnimController:PlayState("UI_Guide_ChangeGender_Open")
  self.binder:BindToVisible(self.ui.Image_Boy_Select, function()
    return self.model:GetGender() == CommonDefine.GenderID.Boy
  end)
  self.binder:BindToVisible(self.ui.Image_Girl_Select, function()
    return self.model:GetGender() == CommonDefine.GenderID.Girl
  end)
  self.binder:BindButtonClick(self.ui.Image_Boy, function()
    if self.model:GetGender() == CommonDefine.GenderID.Boy then
      return
    end
    self.model:SetGender(CommonDefine.GenderID.Boy)
    self:UpdateShadow()
  end)
  self.binder:BindButtonClick(self.ui.Image_Girl, function()
    if self.model:GetGender() == CommonDefine.GenderID.Girl then
      return
    end
    self.model:SetGender(CommonDefine.GenderID.Girl)
    self:UpdateShadow()
  end)
  self.binder:BindToImage(self.ui.Image_Lihui, function()
    do return self.model.GetPath end
    return self.model.GetPath, self.model
  end)
  binder:BindZ1Button(self.ui.Btn_Confirm, function()
    self:Confirm()
  end, function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "Common_Button_Confirm"
  end, nil, nil, nil)
  self.binder:BindTimer(0.01, 0, nil, System.fn(self, self.PlayInitAudio))
end

function SetGenderPanel:PlayInitAudio()
  AudioManager.Instance:PostSoundEvent("Play_A_MUS_Funeral_Chp0")
  AudioManager.Instance:PostSoundEvent("Play_A_SFX_Amb_Rain_Smalle")
end

function SetGenderPanel:UpdateShadow()
  self.ui.Image_BgBoy:SetActive(self.model:GetGender() == CommonDefine.GenderID.Boy)
  self.ui.Image_BgGril:SetActive(self.model:GetGender() == CommonDefine.GenderID.Girl)
end

function SetGenderPanel:Confirm()
  self.AnimController:PlayState("UI_Guide_ChangeGender_Close", System.fn(self, self.OnAnimCloseEnd))
end

function SetGenderPanel:OnAnimCloseEnd()
  self:Close()
  UIManager.Instance:Reopen(Urls.SetNamePanel, self.callFunc, self.model:GetGender())
end

function SetGenderPanel:OnAnimChangeEnd(gender)
  self.model:SetGender(gender)
end

return SetGenderPanel
