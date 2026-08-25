local GameObject = CS.UnityEngine.GameObject
local ArtCollectionCGView, Super = NewClass("ArtCollectionCGView", BaseView)
ArtCollectionCGView.uiResCls = UI_Collection_Panel_OrganizeResource

function ArtCollectionCGView:ctor()
  Super.ctor(self)
  self.feature = CommonDefine.FeatureId.CollectionPicture
end

function ArtCollectionCGView:OnBuildView()
  Super.OnBuildView(self)
end

function ArtCollectionCGView:_InitChildrenTapViews()
  self.childrenTapViews = {
    [CommonDefine.PictureSubFeature.MainCG] = {
      UIUrl = Urls.MainCGView,
      UINodeName = "MainCGView",
      parent = self.ui.Image_Mail.parent,
      viewInstance = nil,
      toggleUI = UI_Common_Item_Toggle_2Resource(self.ui.Toggle_1),
      rewardType = ArtCollectionDefine.RewardType.StoryLineCG
    },
    [CommonDefine.PictureSubFeature.SceneCG] = {
      UIUrl = Urls.SceneCGView,
      UINodeName = "SceneCGView",
      parent = self.ui.Image_Mail.parent,
      viewInstance = nil,
      toggleUI = UI_Common_Item_Toggle_2Resource(self.ui.Toggle_2),
      rewardType = ArtCollectionDefine.RewardType.ScenesCG
    },
    [CommonDefine.PictureSubFeature.PV] = {
      UIUrl = Urls.PVView,
      UINodeName = "PVView",
      parent = self.ui.Image_Mail.parent,
      viewInstance = nil,
      toggleUI = UI_Common_Item_Toggle_2Resource(self.ui.Toggle_3),
      rewardType = ArtCollectionDefine.RewardType.PromotionVideo
    },
    [CommonDefine.PictureSubFeature.Activity] = {
      UIUrl = Urls.CollectionActivityView,
      UINodeName = "ActivityView",
      parent = self.ui.Image_Mail.parent,
      viewInstance = nil,
      toggleUI = UI_Common_Item_Toggle_2Resource(self.ui.Toggle_4),
      rewardType = ArtCollectionDefine.RewardType.ActivityCG
    },
    [CommonDefine.PictureSubFeature.RadioDrama] = {
      UIUrl = Urls.RadioDramaView,
      UINodeName = "RadioDramaView",
      parent = self.ui.Image_Mail.parent,
      viewInstance = nil,
      toggleUI = UI_Common_Item_Toggle_2Resource(self.ui.Toggle_5),
      rewardType = ArtCollectionDefine.RewardType.RadioDrama
    }
  }
end

function ArtCollectionCGView:RegisterNotifications()
end

function ArtCollectionCGView:SwitchPage(curPage)
  if self.targetPage == curPage then
    return
  end
  self.targetPage = curPage
  self:UpdateTitle()
  self:UpdateCollectRate()
  local isActivityCG = curPage == CommonDefine.PictureSubFeature.Activity
  self.ui.Group_Coin:SetActive(isActivityCG)
  if isActivityCG then
    self:UpdateCurrency()
  end
  local cfg = self.childrenTapViews[curPage]
  self:SetZ1Toggle(cfg.toggleUI.uiNode, true)
  Super.SwitchChildTapView(self, curPage, curPage)
  ArtCollectionRewardModel.Instance:UpdateTaskData()
end

function ArtCollectionCGView:InitToggleState()
  for page, cfg in pairs(self.childrenTapViews) do
    local toggleUI = cfg.toggleUI
    local _, unlocked = PlayerDataUtils.IsFeatureUnlock(CommonDefine.FeatureId.CollectionPicture, page)
    unlocked = unlocked and (cfg.activityOpenedFunc and cfg.activityOpenedFunc or true) or true
    toggleUI.uiNode:SetActive(unlocked)
    if unlocked then
      self:AddRedPoint(toggleUI.RedDot, RedDotDefine.DynamicRedDotID.ArtCollectionCGTab, {
        rewardType = cfg.rewardType,
        feature = CommonDefine.FeatureId.CollectionPicture,
        page = page
      })
    end
    self:AddZ1ToggleValueChangedListener(toggleUI.uiNode, function(isOn)
      if isOn then
        self:SwitchPage(page)
        RedPointDataUtils.ReqRemoveData(CommonDefine.FeatureId.CollectionPicture, RedPointDataUtils.RedAttrType.IsNew, page)
      end
    end)
  end
end

function ArtCollectionCGView:OnEnterView()
  Super.OnEnterView(self)
  self.ui.TabCon:SetActive(true)
  self:InitCloseBtn()
  self:InitToggleState()
  self:SwitchPage(CommonDefine.PictureSubFeature.MainCG)
end

function ArtCollectionCGView:OnExitView()
  Super.OnExitView(self)
  GameObject.Destroy(self.obj)
  self.obj = nil
end

function ArtCollectionCGView:UpdateTitle()
  local featureCfg = PlayerDataUtils.GetFeatureConfigByTypeAndKey(self.feature, self.targetPage)
  self:SetText(self.ui.Text_Label, LT.Text(featureCfg.FeatureName))
  self.ui.Image_Mail:SetActive(true)
end

function ArtCollectionCGView:UpdateCollectRate()
  self:AddViewComponentOnce(self.ui.Image_Mail, CollectionRewardCom, self:_GetRewardType(), function()
    do return ArtCollectionController.Instance.CollectCnt, ArtCollectionController.Instance, self.feature end
    return ArtCollectionController.Instance.CollectCnt, ArtCollectionController.Instance, self.feature, self.targetPage
  end)
end

function ArtCollectionCGView:UpdateCurrency()
  self:AddViewComponentOnce(self.ui.Group_Coin, UICompCommonCurrencyGroupItem, DT.Constant.ActivityCGCurrencies.Data)
end

function ArtCollectionCGView:InitCloseBtn()
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

function ArtCollectionCGView:_GetRewardType()
  if self.childrenTapViews and self.childrenTapViews[self.targetPage] then
    return self.childrenTapViews[self.targetPage].rewardType
  end
end

return ArtCollectionCGView
