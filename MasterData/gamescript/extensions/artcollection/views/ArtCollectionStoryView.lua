local ArtCollectionStoryView, Super = NewClass("ArtCollectionStoryView", BaseView)
ArtCollectionStoryView.uiResCls = UI_Collection_Panel_WorldResource

function ArtCollectionStoryView:ctor()
  Super.ctor(self)
end

function ArtCollectionStoryView:OnBuildView()
  Super.OnBuildView(self)
end

function ArtCollectionStoryView:OnEnterView()
  Super.OnEnterView(self)
  self:UpdateCollectRate()
  self:InitCloseBtn()
  self:UpdateShow()
end

function ArtCollectionStoryView:UpdateShow()
  self:InitEntryBtns()
  ArtCollectionRewardModel.Instance:UpdateTaskData()
end

function ArtCollectionStoryView:_GetFeature()
  return CommonDefine.FeatureId.CollectionStory
end

function ArtCollectionStoryView:_GetKey()
  do return end
  return PlayerDataUtils.GetFeatureMainTypeKey
end

function ArtCollectionStoryView:UpdateCollectRate()
  self:AddViewComponentOnce(self.ui.Image_Mail, CollectionRewardCom, self:_GetRewardType(), function()
    local featureType = self:_GetFeature()
    local subFeature = CommonDefine.WorldStorySubFeature
    do return ArtCollectionController.Instance.GetCollectPageUnlockCount, ArtCollectionController.Instance, featureType end
    return ArtCollectionController.Instance.GetCollectPageUnlockCount, ArtCollectionController.Instance, featureType, subFeature
  end)
end

function ArtCollectionStoryView:_GetRewardType()
  return ArtCollectionDefine.RewardType.WorldView
end

function ArtCollectionStoryView:InitCloseBtn()
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

function ArtCollectionStoryView:InitEntryBtns()
  local Page = CommonDefine.WorldStorySubFeature
  local map = {
    [Page.History] = {
      uiBtn = self.ui.Btn_Chronicle,
      uiUrl = Urls.ArtCollectionHistoryMainView,
      featureId = CommonDefine.WorldStorySubFeature.History,
      lockUi = self.ui.Group_Lock_Chronicle,
      redUi = self.ui.Com_RedDot_Chronicle,
      progressUi = "History"
    },
    [Page.Organization] = {
      uiBtn = self.ui.Btn_Organize,
      uiUrl = Urls.OrganizationListView,
      featureId = CommonDefine.WorldStorySubFeature.Organization,
      lockUi = self.ui.Group_Lock_Organize,
      redUi = self.ui.Com_RedDot_Organize,
      progressUi = "Organization"
    },
    [Page.Concept] = {
      uiBtn = self.ui.Btn_Comprehensive,
      uiUrl = Urls.CommonConceptView,
      params = self:GetConceptViewParams(),
      featureId = CommonDefine.WorldStorySubFeature.Concept,
      lockUi = self.ui.Group_Lock_Concept,
      redUi = self.ui.Com_RedDot_Comprehensive,
      progressUi = "Concept"
    }
  }
  for page, btnCfg in pairs(map) do
    self:InitBtn(btnCfg)
    self:RefreshProgress(btnCfg)
    self:InitRedComp(btnCfg)
  end
end

function ArtCollectionStoryView:GetConceptViewParams()
  local data = {}
  data.feature = self:_GetFeature()
  data.key = CommonDefine.WorldStorySubFeature.Concept
  data.list = ArtCollectionController.Instance:GetDataSortListByFeature(data.feature, data.key)
  return data
end

function ArtCollectionStoryView:RefreshProgress(btnCfg)
  local feature = self:_GetFeature()
  local key = btnCfg.featureId
  local finishCnt, totalCnt = ArtCollectionController.Instance:CollectCnt(feature, key)
  self:SetText(self.ui["Text_Cur_" .. btnCfg.progressUi], finishCnt)
  self:SetText(self.ui["Text_Total_" .. btnCfg.progressUi], "/" .. totalCnt)
end

function ArtCollectionStoryView:InitBtn(btnCfg)
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(self:_GetFeature(), btnCfg.featureId)
  self:AddButtonClickListener(btnCfg.uiBtn, function()
    if not unlock then
      PlayerDataUtils.AlertLockedTips(self:_GetFeature(), btnCfg.featureId)
      return
    end
    RedPointDataUtils.ReqRemoveData(self:_GetFeature(), RedPointDataUtils.RedAttrType.IsNew, btnCfg.featureId)
    UIManager.Instance:Reopen(btnCfg.uiUrl, btnCfg.params)
  end)
  btnCfg.lockUi:SetActive(not unlock)
  self.ui["Group_Progress_" .. btnCfg.progressUi]:SetActive(unlock)
end

function ArtCollectionStoryView:InitRedComp(btnCfg)
  self:AddViewComponentOnce(btnCfg.redUi, UICompRedDot, CommonDefine.RedDotType.TextNew, nil, function()
    local _, unlock = PlayerDataUtils.IsFeatureUnlock(self:_GetFeature(), btnCfg.featureId)
    if not unlock then
      return false
    end
    do return RedPointDataUtils.IsShowCollectionFeature, (self:_GetFeature()) end
    return RedPointDataUtils.IsShowCollectionFeature, self:_GetFeature(), btnCfg.featureId
  end)
end

return ArtCollectionStoryView
