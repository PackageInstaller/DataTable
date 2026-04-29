_class("UIN25VampireTalentRelicItem", UICustomWidget)
UIN25VampireTalentRelicItem = UIN25VampireTalentRelicItem

function UIN25VampireTalentRelicItem:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN25Data()
end

function UIN25VampireTalentRelicItem:OnShow(uiParams)
  self.Icon = self:GetUIComponent("RawImageLoader", "Icon")
end

function UIN25VampireTalentRelicItem:OnHide()
  self.Icon:DestoryLastImage()
end

function UIN25VampireTalentRelicItem:Flush(relic, callback)
  self.callback = callback
  local icon, name, desc = relic:IconNameDesc()
  self.Icon:LoadImage(icon)
end

function UIN25VampireTalentRelicItem:IconOnClick(go)
  if self.callback then
    self.callback()
  end
end
