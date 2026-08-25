local SocialOtherPlayerInfoPanel, Super = System.NewClass("SocialOtherPlayerInfoPanel", SocialPlayerInfoPanel)
SocialOtherPlayerInfoPanel.uiResCls = UI_Social_Panel_DataResource

function SocialOtherPlayerInfoPanel:ctor(initData)
  Super.ctor(self, initData)
end

function SocialOtherPlayerInfoPanel:OnBind(binder)
  Super.OnBind(self, binder)
  binder:SetActive(self.ui.Btn_PVP, true)
end

function SocialOtherPlayerInfoPanel:_IsHideReview(page)
  if page ~= SocialDefine.PlayerInfoPage.BattleReplayView then
    return false
  end
  local facade = self.model.playerInfoData and self.model.playerInfoData.facade
  local isHideReview = facade and 1 == facade["copyReview.hideReview"]
  return isHideReview
end

return SocialOtherPlayerInfoPanel
