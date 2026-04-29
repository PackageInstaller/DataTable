_class("UIN34DelegatePersonTips", UIController)
UIN34DelegatePersonTips = UIN34DelegatePersonTips

function UIN34DelegatePersonTips:OnShow(uiParams)
  self._currentDelegatePerson = uiParams[1]
  self._closeCb = uiParams[2]
  self._pastBtn = self:GetGameObject("PastBtn")
  self._closeBtn = self:GetGameObject("CloseBtn")
  self:ShowDesc()
  self:StartTask(self.PlayAnimation, self)
end

function UIN34DelegatePersonTips:ShowDesc()
  local personid = self._currentDelegatePerson:GetPersonId()
  local cfgs = Cfg.cfg_component_survey({PetID = personid})
  if cfgs and next(cfgs) then
    local cfg = cfgs[1]
    local FinalReport = cfg.FinalReport
    self._desc = self:GetUIComponent("UILocalizationText", "Des")
    self._desc:SetText(StringTable.Get(FinalReport))
  else
    Log.error("###[UIN34DelegatePersonTips] cfg_component_survey is nil ! id : ", personid)
  end
end

function UIN34DelegatePersonTips:PlayAnimation(TT)
  self:Lock("UIN34DelegatePersonTips_PlayAnimation")
  self._pastBtn:SetActive(false)
  self._closeBtn:SetActive(false)
  self._pastBtn:SetActive(true)
  self._closeBtn:SetActive(true)
  self:UnLock("UIN34DelegatePersonTips_PlayAnimation")
end

function UIN34DelegatePersonTips:PastBtnOnClick()
  if self._closeCb then
    self._closeCb()
  end
  self:CloseDialog()
end

function UIN34DelegatePersonTips:CloseBtnOnClick()
  self:CloseDialog()
end
