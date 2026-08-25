local UICompPvpDraftTeamItemAwaker, Super = NewViewComponent("UICompPvpDraftTeamItemAwaker", UICompPvpDraftTeamItemBase)

function UICompPvpDraftTeamItemAwaker:_GetCollectImage()
  local skinTid = PvpDraftModel.Instance:GetPlayerDataCollectSkin(self._playerData, self._collectionTid) or CommonDefine.DefaultSkinTid
  local rst = PvpCollectCfgUtils.GetCollectAwakerFormationImage(self._collectionTid, skinTid)
  return rst
end

function UICompPvpDraftTeamItemAwaker:_RefreshQualityBg()
  self:SetActive(self.ui.Image_Quality, true)
  self:SetImage(self.ui.Image_Quality, PVPCollectionDataUtils.GetCollectionNameFrameImage(self._collectionTid))
end

return UICompPvpDraftTeamItemAwaker
