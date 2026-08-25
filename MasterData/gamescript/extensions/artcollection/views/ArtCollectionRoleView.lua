local ArtCollectionRoleView, Super = NewClass("ArtCollectionRoleView", ArtCollectionOrganizeBgView)

function ArtCollectionRoleView:OnEnterView()
  Super.OnEnterView(self)
  self:UpdateCollectRate()
end

function ArtCollectionRoleView:_GetRewardType()
  return ArtCollectionDefine.RewardType.Role
end

function ArtCollectionRoleView:_RefreshTitle()
  local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(self:_GetFeature(), self:_GetKey())
  self:SetText(self.ui.Text_Label, LT.Text(featureCfg.FeatureName))
  self.ui.Image_Mail:SetActive(true)
end

function ArtCollectionRoleView:_GetFeature()
  return CommonDefine.FeatureId.CollectionCharacter
end

function ArtCollectionRoleView:_GetKey()
  do return end
  return PlayerDataUtils.GetFeatureMainTypeKey
end

function ArtCollectionRoleView:_GetCollectCompRes()
  return UI_Collection_Item_RoleResource
end

function ArtCollectionRoleView:_GetCollectCompCls()
  return RoleGroupCom
end

return ArtCollectionRoleView
