local ArtCollectionEntryBtn, Super = NewViewComponent("ArtCollectionEntryBtn")
local FeatureMainTypeKey = PlayerDataUtils.GetFeatureMainTypeKey()

function ArtCollectionEntryBtn:ctor(uiNode, view, btnCfg)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Collection_Btn_PositionResource(uiNode)
  self.btnCfg = btnCfg
end

function ArtCollectionEntryBtn:OnEnterComponent()
  Super.OnEnterComponent(self)
  self:InitBtn(self.btnCfg)
  self:InitRedComp(self.btnCfg)
  self:RegisterNotify(NotifyId.CollectionRewardGet, self.RefreshRed, self)
  self:RegisterNotify(NotifyId.CollectionItemUnlocked, self.OnCollectionItemUnlocked, self)
end

function ArtCollectionEntryBtn:GetBtnStates(btnCfg)
  local _, unlock = PlayerDataUtils.IsFeatureUnlock(btnCfg.featureId, FeatureMainTypeKey)
  if not unlock then
    return CommonDefine.BtnType.Unclickable, CommonDefine.ColorType.Dark
  else
    return CommonDefine.BtnType.Normal, CommonDefine.ColorType.Light
  end
end

function ArtCollectionEntryBtn:InitBtn(btnCfg)
  self:AddButtonClickListener(btnCfg.uiBtn, function()
    local _, unlock = PlayerDataUtils.IsFeatureUnlock(btnCfg.featureId, FeatureMainTypeKey)
    if not unlock then
      PlayerDataUtils.AlertLockedTips(btnCfg.featureId, FeatureMainTypeKey)
      return
    end
    RedPointDataUtils.ReqRemoveData(btnCfg.featureId, RedPointDataUtils.RedAttrType.IsNew, FeatureMainTypeKey)
    if btnCfg.uiUrl then
      UIManager.Instance:Reopen(btnCfg.uiUrl)
    else
      PlayerDataUtils.AlertLockedTips(btnCfg.featureId, PlayerDataUtils.GetFeatureMainTypeKey())
    end
  end)
  local btnState, _ = self:GetBtnStates(btnCfg)
  self:SetButtonState(self.ui.uiNode, btnState)
  self:RefreshProgress()
end

function ArtCollectionEntryBtn:OnCollectionItemUnlocked(cfgId)
  self:RefreshProgress()
end

function ArtCollectionEntryBtn:RefreshProgress()
  local finishCnt, totalCnt = self:GetCollectUnlockCount(self.btnCfg.featureId, FeatureMainTypeKey)
  self:SetText(self.ui.Text_Cur, finishCnt)
  self:SetText(self.ui.Text_Total, "/" .. totalCnt)
end

function ArtCollectionEntryBtn:GetCollectUnlockCount(featureType, key)
  local finishCnt, totalCnt = 0, 0
  if featureType == CommonDefine.FeatureId.CollectionStory then
    local subFeature = CommonDefine.WorldStorySubFeature
    finishCnt, totalCnt = ArtCollectionController.Instance:GetCollectPageUnlockCount(featureType, subFeature)
  elseif featureType == CommonDefine.FeatureId.CollectionPicture then
    local subFeature = CommonDefine.PictureSubFeature
    finishCnt, totalCnt = ArtCollectionController.Instance:GetCollectPageUnlockCount(featureType, subFeature)
  else
    finishCnt, totalCnt = ArtCollectionController.Instance:CollectCnt(featureType, key)
  end
  return finishCnt, totalCnt
end

function ArtCollectionEntryBtn:InitRedComp(btnCfg)
  if not self.redUi then
    self.redUi = self:FindChildRecursively(self.ui.uiNode, "Com_RedDot")
  end
  local redTypeDot = RedPointDataUtils.NewCollectionReward(btnCfg.rewardType)
  self:AddViewComponentOnce(self.redUi, UICompRedDot, CommonDefine.RedDotType.Dot, nil, function()
    return redTypeDot
  end)
  return redTypeDot
end

function ArtCollectionEntryBtn:RefreshRed()
  self:InitRedComp(self.btnCfg)
end

return ArtCollectionEntryBtn
