local ArtCollectionWeaponDetailView, Super = NewClass("ArtCollectionWeaponDetailView", ArtCollectionOrganizeBgView)

function ArtCollectionWeaponDetailView:ctor(weaponCollectTid)
  Super.ctor(self)
  self.weaponCollectTid = weaponCollectTid
end

function ArtCollectionWeaponDetailView:_GetFeature()
  return CommonDefine.FeatureId.CollectionWeapon
end

function ArtCollectionWeaponDetailView:_GetKey()
  do return end
  return PlayerDataUtils.GetFeatureMainTypeKey
end

function ArtCollectionWeaponDetailView:_GetCollectCompRes()
  return UI_Collection_Panel_EquipDetailResource
end

function ArtCollectionWeaponDetailView:_GetCollectCompCls()
  return CollectWeaponDetailCom
end

function ArtCollectionWeaponDetailView:_AddCollectViewComp(collectCompObj)
  self:AddViewComponentOnce(collectCompObj, self:_GetCollectCompCls(), self.weaponCollectTid)
end

return ArtCollectionWeaponDetailView
