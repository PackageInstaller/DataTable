local GearItemWall = System.NewClass("GearItemWall", GearItemBase)

function GearItemWall:OnTriggerChild()
  self:AfterTrigger()
end

return GearItemWall
