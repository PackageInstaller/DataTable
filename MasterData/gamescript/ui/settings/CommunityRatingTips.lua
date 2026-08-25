local CommunityRatingTips, Super = System.NewClass("CommunityRatingTips", UIBasePanel)
CommunityRatingTips.uiResCls = UI_Community_Acclaim_TipsResource

function CommunityRatingTips:ctor()
  Super.ctor(self)
end

function CommunityRatingTips:OnBind(binder)
  local commonPopupTipsData = {
    sizeType = CommonDefine.PopupTipsType.S,
    clickFunc = System.fn(self, self.Close)
  }
  binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_S, commonPopupTipsData))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:BindToText(self.ui.Text_Title, function()
    do return LT.Text end
    return LT.Text, "RatingTipsTitle"
  end)
  binder:BindToText(self.ui.Text_Description, function()
    do return LT.Text end
    return LT.Text, "RatingTipsDesc"
  end)
  binder:BindZ1Button(self.ui.UI_Common_Btn_Level2, function()
    SdkMgr.Rating()
  end)
end

return CommunityRatingTips
