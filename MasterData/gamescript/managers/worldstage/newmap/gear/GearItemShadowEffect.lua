local GearItemShadowEffect, Super = System.NewClass("GearItemShadowEffect", GearItemBase)

function GearItemShadowEffect:OnTriggerChild()
  local comp = self.manager:GetComponent(MapArtEffectManager)
  comp:ChangeAtmosphere()
  self:AfterTrigger()
end

return GearItemShadowEffect
