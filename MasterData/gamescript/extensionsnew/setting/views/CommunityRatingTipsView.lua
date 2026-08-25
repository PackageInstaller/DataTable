local ConfirmTipsType = CommonDefine.ConfirmTipsType
local CommunityRatingTipsView, Super = NewClass("CommunityRatingTipsView", BaseView)
CommunityRatingTipsView.uiResCls = UI_Community_Acclaim_TipsResource

function CommunityRatingTipsView:OnBuildView()
  local data = {
    sizeType = ConfirmTipsType.S,
    clickFunc = System.fn(self, self.Close)
  }
  self:AddViewComponent(self.ui.UI_Common_Popup_Tips_S, CompPublicPopupTips, data)
  self:SetText(self.ui.Text_Title, LT.Text("RatingTipsTitle"))
  self:SetText(self.ui.Text_Description, LT.Text("RatingTipsDesc"))
end

function CommunityRatingTipsView:RegisterEvents()
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Level2, function()
    SdkMgr.Rating()
  end)
end

return CommunityRatingTipsView
