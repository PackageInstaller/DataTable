local GearItemEvent, Super = System.NewClass("GearItemEvent", GearItemBase)

function GearItemEvent:OnTriggerChild(svrData)
  self:EnterEvent(svrData)
end

function GearItemEvent:EnterEvent(data)
  self:OpenEventPanel(data)
end

function GearItemEvent:AfterTrigger()
  Super.AfterTrigger(self)
end

return GearItemEvent
