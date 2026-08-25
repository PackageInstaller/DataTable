local GearItemCamp, Super = System.NewClass("GearItemCamp", GearItemBase)

function GearItemCamp:OnTriggerChild(svrData)
  self:EnterCamp(svrData)
end

function GearItemCamp:EnterCamp(data)
  self:OpenEventPanel(data)
end

return GearItemCamp
