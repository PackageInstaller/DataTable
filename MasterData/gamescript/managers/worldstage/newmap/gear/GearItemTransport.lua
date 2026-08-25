local GearItemTransport, Super = System.NewClass("GearItemTransport", GearItemBase)

function GearItemTransport:OnTriggerChild(svrData)
  if svrData.data == nil then
    return
  end
  Super.OnTrigger(self)
  self:EnterTransport(svrData)
end

function GearItemTransport:EnterTransport(svrData)
  local data = svrData.data
  if data.x and data.y then
    local moveMgr = self.manager:GetComponent(MapMoveManager)
    moveMgr:TransToPos(data.x, data.y)
    AudioManager.Instance:PostSoundEvent("EXPLORE_PASSAGE_PLAYERSEND")
    self:AfterTrigger()
  else
    self:OpenEventPanel(svrData)
  end
end

return GearItemTransport
