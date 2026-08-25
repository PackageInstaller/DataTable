local UICompPvpDraftAdjustItemAwaker, Super = NewViewComponent("UICompPvpDraftAdjustItemAwaker", UICompPvpDraftAdjustItemBase)

function UICompPvpDraftAdjustItemAwaker:_GetCollectImage()
  do return PvpCollectCfgUtils.GetCollectAwakerCollectImage end
  return PvpCollectCfgUtils.GetCollectAwakerCollectImage, self._collectionTid
end

function UICompPvpDraftAdjustItemAwaker:_GetAwakerTid()
  do return PvpCollectCfgUtils.GetCollectAwakerTid end
  return PvpCollectCfgUtils.GetCollectAwakerTid, self._collectionTid
end

function UICompPvpDraftAdjustItemAwaker:_RefreshQualityBg()
  self:SetActive(self.ui.Image_Quality, true)
  self:SetImage(self.ui.Image_Quality, PVPCollectionDataUtils.GetCollectionNameFrameImage(self._collectionTid))
end

function UICompPvpDraftAdjustItemAwaker:_RefreshVisible()
  self:SetActive(self.ui.Group_Mask, false)
end

return UICompPvpDraftAdjustItemAwaker
