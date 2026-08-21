_class("UISwitchPetPro", UIController)
UISwitchPetPro = UISwitchPetPro

function UISwitchPetPro:OnShow(uiParams)
  self.petId = uiParams[1]
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.txtDesc:SetText(StringTable.Get("str_tale_pet_txt_switch_pet_tips"))
  self:_AttachEvents()
end

function UISwitchPetPro:OnHide()
  self:_DetachEvents()
end

function UISwitchPetPro:_AttachEvents()
  self:AttachEvent(GameEventType.TalePetInfoDataChange, self._SelectTalePetCall)
end

function UISwitchPetPro:_DetachEvents()
  self:DetachEvent(GameEventType.TalePetInfoDataChange)
end

function UISwitchPetPro:_SelectTalePetCall()
end

function UISwitchPetPro:btnConfirmOnClick()
  self:Lock("UISwitchPetPro:SwitchPetCall")
  GameGlobal.TaskManager():StartTask(self.SwitchPetCall, self)
end

function UISwitchPetPro:SwitchPetCall(TT)
  local talePetModule = GameGlobal.GetModule(TalePetModule)
  local res = self.talePetModule:ReqTaleChoose(TT, self.petId)
  if res:GetSucc() then
    ToastManager.ShowToast(StringTable.Get("str_tale_pet_txt_start_convene_pet"))
    self:ShowDialog("UITalePetMissionController", self.petId)
    self:CloseDialog()
  else
    ToastManager.ShowToast(res.m_result)
  end
  self:UnLock("UISwitchPetPro:SwitchPetCall")
end

function UISwitchPetPro:btnCancelOnClick()
  self:CloseDialog()
end
