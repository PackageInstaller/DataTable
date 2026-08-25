local GameObject = CS.UnityEngine.GameObject
local CommonConceptView, Super = NewClass("CommonConceptView", BaseView)
CommonConceptView.uiResCls = UI_Collection_Panel_OrganizeResource

function CommonConceptView:ctor(params)
  Super.ctor(self)
  self.feature = params.feature
  self.key = params.key
  self.list = params.list
  self.groupId = params.groupId or 0
  self.cfg = DT.CollectionHall[self.groupId] or {}
end

function CommonConceptView:OnBuildView()
  Super.OnBuildView(self)
  self.ui.TabCon:SetActive(false)
  self:InitTitle()
  self:InitCollectRate()
  self:InitCloseBtn()
  local oriPrefab = self:LoadAsset(UI_Collection_Item_ComprehensiveResource.assetPath)
  self.obj = GameObject.Instantiate(oriPrefab, self.ui.CompCon.transform)
  self:AddViewComponentOnce(self.obj, CommonConceptCom, self.list)
end

function CommonConceptView:OnEnterView()
  Super.OnEnterView(self)
  self.ui.Group_Coin:SetActive(false)
end

function CommonConceptView:OnExitView()
  Super.OnExitView(self)
  GameObject.Destroy(self.obj)
  self.obj = nil
end

function CommonConceptView:InitTitle()
  local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(self.feature, self.key)
  self:SetText(self.ui.Text_Label, LT.Text(featureCfg.FeatureName))
end

function CommonConceptView:InitCollectRate()
  self:AddViewComponentOnce(self.ui.Image_Mail, CollectionRewardCom, self:_GetRewardType(), function()
    do return ArtCollectionController.Instance.CollectUnlockCntByTids, ArtCollectionController.Instance end
    return ArtCollectionController.Instance.CollectUnlockCntByTids, ArtCollectionController.Instance, self.list
  end)
end

function CommonConceptView:_GetRewardType()
  return ArtCollectionDefine.RewardType.None
end

function CommonConceptView:InitCloseBtn()
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

return CommonConceptView
