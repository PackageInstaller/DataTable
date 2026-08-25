local GearItemMachine, Super = System.NewClass("GearItemMachine", GearItemBase)

function GearItemMachine:OnTriggerChild(svrData)
  self:EnterMachine(svrData)
end

function GearItemMachine:EnterMachine(svrData)
  if svrData.data == nil then
    self:AfterTrigger()
    return
  end
  local doorList = svrData.data.doorList
  if doorList then
    for _, uid in ipairs(doorList) do
      local gear = self.manager:GetGearByUid(uid)
      if gear then
        gear:Open()
      end
    end
  end
  self:OpenEventPanel(svrData)
end

return GearItemMachine
