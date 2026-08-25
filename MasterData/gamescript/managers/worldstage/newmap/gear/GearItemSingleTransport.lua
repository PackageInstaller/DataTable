local GearItemSingleTransport, Super = System.NewClass("GearItemSingleTransport", GearItemBase)

function GearItemSingleTransport:OnTriggerChild(svrData)
  if svrData.data == nil then
    return
  end
  local nodeType = self:GetConfigData() and self:GetConfigData().NodeType
  if nodeType == DT.GetConstant("GridExport") then
    self:AfterTrigger()
    return
  end
  self:EnterTransport(svrData)
end

function GearItemSingleTransport:EnterTransport(svrData)
  local data = svrData.data
  if data.x and data.y then
    local moveMgr = self.manager:GetComponent(MapMoveManager)
    moveMgr:TransToPos(data.x, data.y)
    AudioManager.Instance:PostSoundEvent("EXPLORE_SECRETAISLE_PLAYERSEND")
    self:AfterTrigger()
  else
    self:OpenEventPanel(svrData)
  end
end

return GearItemSingleTransport
