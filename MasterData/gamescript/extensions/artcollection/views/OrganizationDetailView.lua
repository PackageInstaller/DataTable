local GameObject = CS.UnityEngine.GameObject
local OrganizationDetailView, Super = NewClass("OrganizationDetailView", BaseView)
OrganizationDetailView.uiResCls = UI_Collection_Panel_OrganizeResource

function OrganizationDetailView:ctor(collectId)
  Super.ctor(self)
  self.collectId = collectId
  self.feature = CommonDefine.FeatureId.CollectionStory
  self.key = CommonDefine.WorldStorySubFeature.Organization
end

function OrganizationDetailView:OnBuildView()
  Super.OnBuildView(self)
  self.ui.TabCon:SetActive(false)
  self:InitTitle()
  self:InitCloseBtn()
  local oriPrefab = self:LoadAsset(UI_Collection_Item_Organize_DetailsResource.assetPath)
  self.obj = GameObject.Instantiate(oriPrefab, self.ui.CompCon.transform)
  self:AddViewComponentOnce(self.obj, OrganizationDetailCom, self.collectId)
end

function OrganizationDetailView:OnEnterView()
  Super.OnEnterView(self)
  self.ui.Group_Coin:SetActive(false)
end

function OrganizationDetailView:OnExitView()
  Super.OnExitView(self)
  GameObject.Destroy(self.obj)
  self.obj = nil
end

function OrganizationDetailView:InitTitle()
  local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(self.feature, self.key)
  self:SetText(self.ui.Text_Label, LT.Text(featureCfg.FeatureName))
  self.ui.Image_Mail:SetActive(false)
end

function OrganizationDetailView:InitCloseBtn()
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

function OrganizationDetailView:_GetRewardType()
  return ArtCollectionDefine.RewardType.None
end

return OrganizationDetailView
