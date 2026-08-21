_class("UIN25VampireTalentText", UICustomWidget)
UIN25VampireTalentText = UIN25VampireTalentText

function UIN25VampireTalentText:Constructor()
  self.mCampaign = self:GetModule(CampaignModule)
  self.data = self.mCampaign:GetN25Data()
end

function UIN25VampireTalentText:OnShow(uiParams)
  self.imgTen = self:GetUIComponent("Image", "imgTen")
  self.imgOne = self:GetUIComponent("Image", "imgOne")
  self.atlas = self:GetAsset("UIN25Vampire.spriteatlas", LoadType.SpriteAtlas)
end

function UIN25VampireTalentText:OnHide()
end

function UIN25VampireTalentText:Flush(num, prefix)
  local str = tostring(num)
  local one = string.sub(str, -1)
  local ten = string.sub(str, -2, -2)
  self.imgOne.sprite = self.atlas:GetSprite(prefix .. one)
  if string.isnullorempty(ten) then
    self.imgTen.gameObject:SetActive(false)
  else
    self.imgTen.gameObject:SetActive(true)
    self.imgTen.sprite = self.atlas:GetSprite(prefix .. ten)
  end
end
