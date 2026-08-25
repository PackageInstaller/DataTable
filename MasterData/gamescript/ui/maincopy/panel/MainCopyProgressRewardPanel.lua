local MainCopyProgressRewardPanel, Super = System.NewClass("MainCopyProgressRewardPanel", UIBasePanel)
MainCopyProgressRewardPanel.uiResCls = UI_Chaper_Popup_AwardResource

function MainCopyProgressRewardPanel:ctor(progressDrops, star, groupTid, getData, starRewardDatas)
  Super.ctor(self)
  self.progressDrops = progressDrops
  self.star = star
  self.groupTid = groupTid
  self.getData = getData or {}
  self.starRewardDatas = starRewardDatas
end

function MainCopyProgressRewardPanel:OnBind(binder)
  local model = binder:createModel(MainCopyProgressRewardPanelModel, self.progressDrops, self.star, self.groupTid, self.getData, self.starRewardDatas)
  self.model = model
  local CommonPopupFullTipsDataData = {textTitleCN = nil, textTitleEN = nil}
  binder:BindComponent(CommonPopupFullTips(self.ui.UI_Common_Popup_Tips_Full, CommonPopupFullTipsDataData))
  binder:BindToCircularListView(self.ui.ScrollView_Popup_Award, function()
    return model.showRewardItemGroup
  end, function(itemBinder, item, index)
    itemBinder:BindComponent(MainCopyProgressItem(item, model.showRewardItemGroup[index], model))
  end)
  binder:BindToButtonState(self.ui.Btn_OneKey, function()
    if model:IsHaveReward() then
      return CommonDefine.BtnType.High
    else
      return CommonDefine.BtnType.Unclickable
    end
  end)
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.Btn_OneKey, System.fn(self, self.OnClickOneKey))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Question, function()
    PlayerDataUtils.OpenIllustrate(nil, LT.Text("StarRatingRules"))
  end)
  PlayerDataUtils.OpenFirstTimeIllustrate(self.__name, nil, LT.Text("StarRatingRules"))
end

function MainCopyProgressRewardPanel:OnClickOneKey()
  ProtoManager.Instance:ReqServer("GameRequest", "GainAllStageGroupStarRw", function(_)
    self.model:MarkRewardGot()
  end, nil, self.groupTid)
end

return MainCopyProgressRewardPanel
