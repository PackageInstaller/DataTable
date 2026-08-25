local ArtCollectionTrinketView, Super = NewClass("ArtCollectionTrinketView", ArtCollectionOrganizeBgView)

function ArtCollectionTrinketView:OnEnterView()
  Super.OnEnterView(self)
  self:UpdateCollectRate()
end

function ArtCollectionTrinketView:_GetRewardType()
  return ArtCollectionDefine.RewardType.Trinket
end

function ArtCollectionTrinketView:_RefreshTitle()
  local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(self:_GetFeature(), self:_GetKey())
  self:SetText(self.ui.Text_Label, LT.Text(featureCfg.FeatureName))
  self.ui.Image_Mail:SetActive(true)
end

function ArtCollectionTrinketView:_GetFeature()
  return CommonDefine.FeatureId.CollectionTrinket
end

function ArtCollectionTrinketView:_GetKey()
  do return end
  return PlayerDataUtils.GetFeatureMainTypeKey
end

function ArtCollectionTrinketView:_GetCollectCompRes()
  return UI_Collection_Panel_EquipResource
end

function ArtCollectionTrinketView:_GetCollectCompCls()
  return CollectTrinketGroupCom
end

return ArtCollectionTrinketView
