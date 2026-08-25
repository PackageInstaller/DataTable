local GameObject = CS.UnityEngine.GameObject
local OrganizationListView, Super = NewClass("OrganizationListView", BaseView)
OrganizationListView.uiResCls = UI_Collection_Panel_OrganizeResource

function OrganizationListView:ctor()
  Super.ctor(self)
  self.feature = CommonDefine.FeatureId.CollectionStory
  self.key = CommonDefine.WorldStorySubFeature.Organization
end

function OrganizationListView:OnBuildView()
  Super.OnBuildView(self)
  self.ui.TabCon:SetActive(false)
  self:InitTitle()
  self:InitCollectRate()
  self:InitCloseBtn()
  local oriPrefab = self:LoadAsset(UI_Collection_Item_OrganizeResource.assetPath)
  self.obj = GameObject.Instantiate(oriPrefab, self.ui.CompCon.transform)
  self:AddViewComponentOnce(self.obj, OrganizaListCom)
end

function OrganizationListView:OnEnterView()
  Super.OnEnterView(self)
  self.ui.Group_Coin:SetActive(false)
end

function OrganizationListView:OnExitView()
  Super.OnExitView(self)
  GameObject.Destroy(self.obj)
  self.obj = nil
end

function OrganizationListView:InitTitle()
  local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(self.feature, self.key)
  self:SetText(self.ui.Text_Label, LT.Text(featureCfg.FeatureName))
end

function OrganizationListView:InitCollectRate()
  self:AddViewComponentOnce(self.ui.Image_Mail, CollectionRewardCom, self:_GetRewardType(), function()
    do return ArtCollectionController.Instance.CollectCnt, ArtCollectionController.Instance, self.feature end
    return ArtCollectionController.Instance.CollectCnt, ArtCollectionController.Instance, self.feature, self.key
  end)
end

function OrganizationListView:InitCloseBtn()
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

function OrganizationListView:_GetRewardType()
  return ArtCollectionDefine.RewardType.None
end

return OrganizationListView
