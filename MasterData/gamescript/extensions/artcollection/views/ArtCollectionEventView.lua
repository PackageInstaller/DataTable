local ArtCollectionEventView, Super = NewClass("ArtCollectionEventView", ArtCollectionOrganizeBgView)

function ArtCollectionEventView:OnEnterView()
  Super.OnEnterView(self)
end

function ArtCollectionEventView:_GetRewardType()
  return ArtCollectionDefine.RewardType.Event
end

function ArtCollectionEventView:_RefreshTitle()
  local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(self:_GetFeature(), self:_GetKey())
  self:SetText(self.ui.Text_Label, LT.Text(featureCfg.FeatureName))
end

function ArtCollectionEventView:_GetFeature()
  return CommonDefine.FeatureId.CollectionEvent
end

function ArtCollectionEventView:_GetKey()
  do return end
  return PlayerDataUtils.GetFeatureMainTypeKey
end

function ArtCollectionEventView:_GetCollectCompRes()
  return UI_Collection_Panel_EventResource
end

function ArtCollectionEventView:_GetCollectCompCls()
  return CollectEventGroupCom
end

return ArtCollectionEventView
