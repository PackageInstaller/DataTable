_class("UIN25VampireTalentItemTips", UIController)
UIN25VampireTalentItemTips = UIN25VampireTalentItemTips

function UIN25VampireTalentItemTips:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN25Data()
end

function UIN25VampireTalentItemTips:OnShow(uiParams)
  self.atc = self:GetGameObject():GetComponent(typeof(ATransitionComponent))
  self.atc.enabled = true
  self.atc:PlayEnterAnimation(true)
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self.txtDesc = self:GetUIComponent("UILocalizationText", "txtDesc")
  self.relic = uiParams[1]
  self:Flush()
end

function UIN25VampireTalentItemTips:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIN25VampireTalentItemTips:Flush()
  local icon, name, desc = self.relic:IconNameDesc()
  self.imgIcon:LoadImage(icon)
  self.txtName:SetText(name)
  self.txtDesc:SetText(desc)
end

function UIN25VampireTalentItemTips:BgOnClick(go)
  self:CloseDialog()
end

function UIN25VampireTalentItemTips:PlayAnimClose()
  self:StartTask(function(TT)
    local key = "UIN25VampireTalentItemTipsPlayAnimClose"
    self:Lock(key)
    self.atc:PlayLeaveAnimation(true)
    YIELD(TT, 140)
    self:CloseDialog()
    self:UnLock(key)
  end, self)
end
