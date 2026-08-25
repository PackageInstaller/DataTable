local ArtCollectionTrinketDetailView, Super = NewClass("ArtCollectionTrinketDetailView", ArtCollectionOrganizeBgView)

function ArtCollectionTrinketDetailView:ctor(trinketCollectTid)
  Super.ctor(self)
  self.trinketCollectTid = trinketCollectTid
end

function ArtCollectionTrinketDetailView:_GetFeature()
  return CommonDefine.FeatureId.CollectionTrinket
end

function ArtCollectionTrinketDetailView:_GetKey()
  do return end
  return PlayerDataUtils.GetFeatureMainTypeKey
end

function ArtCollectionTrinketDetailView:_GetCollectCompRes()
  return UI_Collection_Panel_EquipDetailResource
end

function ArtCollectionTrinketDetailView:_GetCollectCompCls()
  return CollectTrinketDetailCom
end

function ArtCollectionTrinketDetailView:_AddCollectViewComp(collectCompObj)
  self:AddViewComponentOnce(collectCompObj, self:_GetCollectCompCls(), self.trinketCollectTid)
end

return ArtCollectionTrinketDetailView
