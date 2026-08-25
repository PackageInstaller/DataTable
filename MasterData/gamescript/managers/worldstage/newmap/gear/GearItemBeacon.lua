local GearItemBeacon, Super = System.NewClass("GearItemBeacon", GearItemBase)

function GearItemBeacon:OnTriggerChild(svrData)
  self:OpenEventPanel(svrData)
end

return GearItemBeacon
