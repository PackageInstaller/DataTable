local UICompPvpDraftPoolAwaker, _ = NewViewComponent("UICompPvpDraftPoolAwaker", UICompPvpDraftPoolBase)

function UICompPvpDraftPoolAwaker:_GetCollectImage()
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(self._collectionTid)
  do return AwakerCfgUtils.GetCfgField, "PVPCardIcon" end
  return AwakerCfgUtils.GetCfgField, "PVPCardIcon", awakerTid
end

function UICompPvpDraftPoolAwaker:_GetAwakerTid()
  do return PvpCollectCfgUtils.GetCollectAwakerTid end
  return PvpCollectCfgUtils.GetCollectAwakerTid, self._collectionTid
end

function UICompPvpDraftPoolAwaker:_GetCollectName()
  local collectItem = PvpCollectCfgUtils.GetCfgField("Item", self._collectionTid)
  if not collectItem then
    return
  end
  local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(collectItem)
  if not awakerTid then
    return
  end
  do return AwakerDataUtils.GetAwakerName end
  return AwakerDataUtils.GetAwakerName, awakerTid
end

function UICompPvpDraftPoolAwaker:_RefreshQualityBg()
  self:SetActive(self.ui.Image_Quality, true)
  self:SetImage(self.ui.Image_Quality, PVPCollectionDataUtils.GetCollectionNameFrameImage(self._collectionTid))
end

function UICompPvpDraftPoolAwaker:_IsCanNotSelect()
  do return PvpDraftModel.Instance.IsAwakerCanNotSelect, PvpDraftModel.Instance end
  return PvpDraftModel.Instance.IsAwakerCanNotSelect, PvpDraftModel.Instance, self._collectionTid
end

return UICompPvpDraftPoolAwaker
