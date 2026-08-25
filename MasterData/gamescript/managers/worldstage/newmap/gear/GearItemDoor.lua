local GearItemDoor, Super = System.NewClass("GearItemDoor", GearItemBase)

function GearItemDoor:OnTrigger(svrData)
  if svrData.data and svrData.data.eventId then
    self.isMoveAfterTrigger = true
    self:OpenEventPanel(svrData)
  else
    local x, y = self:GetGridPos()
    EventMgr.Instance.GearRoleMove:Dispatch(x, y, function()
      self:AfterTrigger()
    end)
  end
end

function GearItemDoor:OnRemove()
  if self.isMoveAfterTrigger then
    self.isMoveAfterTrigger = false
    local x, y = self:GetGridPos()
    EventMgr.Instance.GearRoleMove:Dispatch(x, y)
    AudioManager.Instance:PostSoundEvent("EXPLORE_DOOR_PLAYERSEND")
  end
  Super.OnRemove(self)
end

function GearItemDoor:OnLoad()
  Super.OnLoad(self)
  local data = self:GetData()
  if data and not data.block then
    self:Open()
  end
end

function GearItemDoor:Open()
  self:SetSprite(2)
end

return GearItemDoor
