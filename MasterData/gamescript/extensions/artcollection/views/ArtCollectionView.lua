local ArtCollectionView, Super = NewClass("ArtCollectionView", BaseView)
ArtCollectionView.uiResCls = UI_Collection_Panel_MainResource

function ArtCollectionView:ctor()
  Super.ctor(self)
end

function ArtCollectionView:OnBuildView()
  Super.OnBuildView(self)
end

function ArtCollectionView:OnEnterView()
  Super.OnEnterView(self)
  self:InitCloseBtn()
  self:UpdateShow()
  self:_RefreshCollectRate()
end

function ArtCollectionView:_RefreshCollectRate()
  self:AddViewComponentOnce(self.ui.Group_Collection, CollectionRewardCom, nil, function()
    do return ArtCollectionController.Instance.GetAllCollectCnt end
    return ArtCollectionController.Instance.GetAllCollectCnt, ArtCollectionController.Instance
  end)
end

function ArtCollectionView:UpdateShow()
  self:InitEntryBtns()
end

function ArtCollectionView:RegisterEvents()
end

function ArtCollectionView:RegisterNotifications()
end

function ArtCollectionView:Close()
  Super.Close(self)
  if not UIManager.Instance:GetWindow(Urls.MainPanel) then
    UIManager.Instance:Reopen(Urls.MainPanel)
  end
end

function ArtCollectionView:InitCloseBtn()
  self.closeBtn = self:AddViewComponent(self.ui.UI_Common_Btn_Back3, UICompBtnCloseItem, System.fn(self, self.Close))
end

function ArtCollectionView:InitEntryBtns()
  local Page = CommonDefine.ArtCollectionPage
  local map = {
    [Page.Roles] = {
      uiBtn = self.ui.UI_Collection_Btn_Position_1,
      uiUrl = Urls.ArtCollectionRoleView,
      featureId = CommonDefine.FeatureId.CollectionCharacter,
      rewardType = ArtCollectionDefine.RewardType.Role
    },
    [Page.World] = {
      uiBtn = self.ui.UI_Collection_Btn_Position_2,
      uiUrl = Urls.ArtCollectionStoryView,
      featureId = CommonDefine.FeatureId.CollectionStory,
      rewardType = ArtCollectionDefine.RewardType.WorldView
    },
    [Page.CG] = {
      uiBtn = self.ui.UI_Collection_Btn_Position_3,
      uiUrl = Urls.ArtCollectionCGView,
      featureId = CommonDefine.FeatureId.CollectionPicture,
      rewardType = ArtCollectionDefine.CGType
    },
    [Page.Music] = {
      uiBtn = self.ui.UI_Collection_Btn_Position_4,
      uiUrl = Urls.ArtCollectionOSTView,
      featureId = CommonDefine.FeatureId.CollectionOST,
      rewardType = ArtCollectionDefine.RewardType.Music
    },
    [Page.Weapon] = {
      uiBtn = self.ui.UI_Collection_Btn_Position_5,
      uiUrl = Urls.ArtCollectionWeaponView,
      featureId = CommonDefine.FeatureId.CollectionWeapon,
      rewardType = ArtCollectionDefine.RewardType.Weapon
    },
    [Page.Trinket] = {
      uiBtn = self.ui.UI_Collection_Btn_Position_6,
      uiUrl = Urls.ArtCollectionTrinketView,
      featureId = CommonDefine.FeatureId.CollectionTrinket,
      rewardType = ArtCollectionDefine.RewardType.Trinket
    },
    [Page.Relic] = {
      uiBtn = self.ui.UI_Collection_Btn_Position_7,
      uiUrl = Urls.ArtCollectionRelicView,
      featureId = CommonDefine.FeatureId.CollectionRelic,
      rewardType = ArtCollectionDefine.RewardType.Creation
    },
    [Page.Event] = {
      uiBtn = self.ui.UI_Collection_Btn_Position_8,
      uiUrl = Urls.ArtCollectionEventView,
      featureId = CommonDefine.FeatureId.CollectionEvent,
      rewardType = ArtCollectionDefine.RewardType.Event
    }
  }
  for page, btnCfg in pairs(map) do
    self:AddViewComponentOnce(btnCfg.uiBtn, ArtCollectionEntryBtn, btnCfg)
  end
end

return ArtCollectionView
