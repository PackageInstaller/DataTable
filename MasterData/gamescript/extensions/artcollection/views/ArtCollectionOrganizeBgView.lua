local GameObject = CS.UnityEngine.GameObject
local ArtCollectionOrganizeBgView, Super = NewClass("ArtCollectionOrganizeBgView", BaseView)
ArtCollectionOrganizeBgView.uiResCls = UI_Collection_Panel_OrganizeResource

function ArtCollectionOrganizeBgView:_GetFeature()
  Logger.Error("Please override ArtCollectionOrganizeBgView:_GetFeature")
end

function ArtCollectionOrganizeBgView:_GetKey()
  Logger.Error("Please override ArtCollectionOrganizeBgView:_GetKey")
end

function ArtCollectionOrganizeBgView:_GetCollectCompRes()
  Logger.Error("Please override ArtCollectionOrganizeBgView:_GetCollectCompRes")
end

function ArtCollectionOrganizeBgView:_GetCollectCompCls()
  Logger.Error("Please override ArtCollectionOrganizeBgView:_GetCollectCompCls")
end

function ArtCollectionOrganizeBgView:ctor()
  Super.ctor(self)
end

function ArtCollectionOrganizeBgView:OnBuildView()
  self:_CreateCollectComp()
end

function ArtCollectionOrganizeBgView:OnEnterView()
  self:_RefreshView()
end

function ArtCollectionOrganizeBgView:OnExitView()
  Super.OnExitView(self)
  self:_DestroyCollectCompObj()
end

function ArtCollectionOrganizeBgView:_RefreshView()
  self:_RefreshToggle()
  self:_RefreshTitle()
  self:_RefreshCloseBtn()
  self:UpdateCollectRate()
  self.ui.Group_Coin:SetActive(false)
  ArtCollectionRewardModel.Instance:UpdateTaskData()
end

function ArtCollectionOrganizeBgView:_RefreshToggle()
  self.ui.TabCon:SetActive(false)
end

function ArtCollectionOrganizeBgView:_RefreshTitle()
  local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(self:_GetFeature(), self:_GetKey())
  self:SetText(self.ui.Text_Label, LT.Text(featureCfg.FeatureName))
  self.ui.Image_Mail:SetActive(false)
end

function ArtCollectionOrganizeBgView:_RefreshCloseBtn()
  self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

function ArtCollectionOrganizeBgView:UpdateCollectRate()
  if not self.ui.Image_Mail then
    return
  end
  self:AddViewComponentOnce(self.ui.Image_Mail, CollectionRewardCom, self:_GetRewardType(), function()
    do return ArtCollectionController.Instance.CollectCnt, ArtCollectionController.Instance, self:_GetFeature(), self:_GetKey() end
    return ArtCollectionController.Instance.CollectCnt, ArtCollectionController.Instance, self:_GetFeature(), self:_GetKey()
  end)
end

function ArtCollectionOrganizeBgView:_GetRewardType()
  return ArtCollectionDefine.RewardType.None
end

function ArtCollectionOrganizeBgView:_CreateCollectComp()
  local res = self:_GetCollectCompRes()
  if not res then
    return
  end
  local oriPrefab = self:LoadAsset(res.assetPath)
  self._collectCompObj = GameObject.Instantiate(oriPrefab, self.ui.CompCon.transform)
  self:_AddCollectViewComp(self._collectCompObj)
end

function ArtCollectionOrganizeBgView:_AddCollectViewComp(collectCompObj)
  self:AddViewComponentOnce(collectCompObj, self:_GetCollectCompCls(), self:_GetFeature(), self:_GetKey())
end

function ArtCollectionOrganizeBgView:_DestroyCollectCompObj()
  if self._collectCompObj then
    GameObject.Destroy(self._collectCompObj)
    self._collectCompObj = nil
  end
end

return ArtCollectionOrganizeBgView
