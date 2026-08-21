_class("UIActivityN8PersonProgressIconText", UICustomWidget)
UIActivityN8PersonProgressIconText = UIActivityN8PersonProgressIconText

function UIActivityN8PersonProgressIconText:OnShow(uiParams)
end

function UIActivityN8PersonProgressIconText:OnHide()
end

function UIActivityN8PersonProgressIconText:SetData(campaign, handleMaterial)
  local component = campaign:GetComponentByType(CampaignComType.E_CAMPAIGN_COM_PERSON_PROGESS, 1)
  local icon = self:GetUIComponent("Image", "_icon")
  local atlas = self:GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  local spriteId = component:GetItemPriceIcon()
  icon.sprite = atlas:GetSprite(spriteId)
  local txt = self:GetUIComponent("UILocalizationText", "_text")
  local num = component:GetCurrentProgress()
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, num)
  local fmtStr = string.format("<color=#5e5e5e>%s</color><color=#f2c641>%s</color>", preZero, tostring(num))
  txt:SetText(fmtStr)
end
