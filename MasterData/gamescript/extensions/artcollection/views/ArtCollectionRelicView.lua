local ArtCollectionRelicView, Super = NewClass("ArtCollectionRelicView", ArtCollectionOrganizeBgView)

function ArtCollectionRelicView:OnEnterView()
  Super.OnEnterView(self)
  self:UpdateCollectRate()
end

function ArtCollectionRelicView:_GetRewardType()
  return ArtCollectionDefine.RewardType.Creation
end

function ArtCollectionRelicView:_RefreshTitle()
  local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(self:_GetFeature(), self:_GetKey())
  self:SetText(self.ui.Text_Label, LT.Text(featureCfg.FeatureName))
  self.ui.Image_Mail:SetActive(true)
end

function ArtCollectionRelicView:_GetFeature()
  return CommonDefine.FeatureId.CollectionRelic
end

function ArtCollectionRelicView:_GetKey()
  do return end
  return PlayerDataUtils.GetFeatureMainTypeKey
end

function ArtCollectionRelicView:_GetCollectCompRes()
  return UI_Collection_Panel_RelicResource
end

function ArtCollectionRelicView:_GetCollectCompCls()
  return CollectRelicGroupCom
end

return ArtCollectionRelicView
