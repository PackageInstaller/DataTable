local ArtCollectionWeaponView, Super = NewClass("ArtCollectionWeaponView", ArtCollectionOrganizeBgView)

function ArtCollectionWeaponView:OnEnterView()
  Super.OnEnterView(self)
  self:UpdateCollectRate()
end

function ArtCollectionWeaponView:_GetRewardType()
  return ArtCollectionDefine.RewardType.Weapon
end

function ArtCollectionWeaponView:_RefreshTitle()
  local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(self:_GetFeature(), self:_GetKey())
  self:SetText(self.ui.Text_Label, LT.Text(featureCfg.FeatureName))
  self.ui.Image_Mail:SetActive(true)
end

function ArtCollectionWeaponView:_GetFeature()
  return CommonDefine.FeatureId.CollectionWeapon
end

function ArtCollectionWeaponView:_GetKey()
  do return end
  return PlayerDataUtils.GetFeatureMainTypeKey
end

function ArtCollectionWeaponView:_GetCollectCompRes()
  return UI_Collection_Panel_EquipResource
end

function ArtCollectionWeaponView:_GetCollectCompCls()
  return CollectWeaponGroupCom
end

return ArtCollectionWeaponView
