local PvpRecordAwakerItem, Super = System.NewComponent("PvpRecordAwakerItem")

function PvpRecordAwakerItem:ctor(go, collectOrAwakerTid, curSkin)
  Super.ctor(self)
  self.ui = UI_Social_PvpRecordAwakerResource(go)
  if PvpCollectCfgUtils.GetCollectAwakerTid(collectOrAwakerTid) then
    self.collectTid = collectOrAwakerTid
    self.awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(collectOrAwakerTid)
  else
    self.collectTid = nil
    self.awakerTid = collectOrAwakerTid
  end
  self.curSkin = curSkin
end

function PvpRecordAwakerItem:OnBind(binder)
  self.binder = binder
  if not self.awakerTid then
    return
  end
  self.binder:BindToImage(self.ui.Image_Icon, System.fn(self, self.GetImage))
  if self.collectTid then
    self.binder:SetActive(self.ui.Image_Quality, true)
    self.binder:BindToImage(self.ui.Image_Quality, System.fn(self, self.GetQualityImage))
  else
    self.binder:SetActive(self.ui.Image_Quality, false)
  end
end

function PvpRecordAwakerItem:OnUnbind()
end

function PvpRecordAwakerItem:GetImage()
  do return AwakerDataUtils.GetLittleIcon, self.awakerTid, nil end
  return AwakerDataUtils.GetLittleIcon, self.awakerTid, nil, self.curSkin
end

function PvpRecordAwakerItem:GetQualityImage()
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(self.awakerTid)
  if not awakerConfig then
    return
  end
  local positionConfig = PVPPositionCfgUtils.GetCfg(awakerConfig.PVPPosition)
  return positionConfig and positionConfig.CollectPositionColour
end

return PvpRecordAwakerItem
