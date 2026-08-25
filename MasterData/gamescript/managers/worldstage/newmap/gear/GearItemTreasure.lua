local GearItemTreasure, Super = System.NewClass("GearItemTreasure", GearItemBase)

function GearItemTreasure:OnTriggerChild(svrData)
  local data = svrData and svrData.data
  Logger.Info("GearItemTreasure.OnTrigger", table.tostring(svrData))
  if data and data.option and data.eventId then
    self:EnterTreasure(data)
    return
  end
  self.manager:RemoveGearByUid(svrData.uid)
  self:EnterTreasure(data)
end

function GearItemTreasure:EnterTreasure(data)
  local tid = self:GetTid()
  if data.option and data.eventId then
    self:OpenEventPanel({data = data})
    return
  end
  if data.items and #data.items > 0 then
    UIManager.Instance:Show(Urls.WorldStageGetAwardTip, data, function()
      self:AfterTrigger()
      local mapGuideMgr = self.manager and self.manager:GetComponent(MapGuideManager)
      if mapGuideMgr then
        mapGuideMgr:TriggerEvent(CommonDefine.GuideEvent.GearDone, tid)
      end
    end)
  else
    self:AfterTrigger()
    local mapGuideMgr = self.manager and self.manager:GetComponent(MapGuideManager)
    if mapGuideMgr then
      mapGuideMgr:TriggerEvent(CommonDefine.GuideEvent.GearDone, tid)
    end
  end
end

return GearItemTreasure
