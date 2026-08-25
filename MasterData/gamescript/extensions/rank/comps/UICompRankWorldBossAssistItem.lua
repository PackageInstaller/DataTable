local UICompRankWorldBossAssistItem, Super = NewViewComponent("UICompRankWorldBossAssistItem", UICompRankBaseItem)

function UICompRankWorldBossAssistItem:ctor(uiNode, view, rankMO)
  Super.ctor(self, uiNode, view, rankMO)
  self.ui = UI_Events_Item_AssistRankResource(uiNode)
end

function UICompRankWorldBossAssistItem:_GetNameTextNode()
  return self.ui.Text_Name
end

function UICompRankWorldBossAssistItem:_GetUidTextNode()
  return self.ui.Text_Uid
end

function UICompRankWorldBossAssistItem:_GetScoreTextNode()
  return self.ui.Text_AssistCount
end

function UICompRankWorldBossAssistItem:_GetRankIdxTextNode()
  return self.ui.Text_Ranking
end

function UICompRankWorldBossAssistItem:_RefreshView()
  Super._RefreshView(self)
  if not self._rankMO or type(self._rankMO.GetUid) ~= "function" then
    if self.ui and self.ui.AssistAwaker then
      self:SetActive(self.ui.AssistAwaker, false)
    end
    return
  end
  self:_RefreshAssistAwaker()
end

function UICompRankWorldBossAssistItem:_RefreshAssistAwaker()
  local awakerTid = self._rankMO:GetAssistAwakerTid()
  local awakerLevel = self._rankMO:GetAssistAwakerLevel()
  if not awakerTid or not awakerLevel then
    self:SetActive(self.ui.AssistAwaker, false)
    return
  end
  self:SetActive(self.ui.AssistAwaker, true)
  local viewData = {
    awakerId = awakerTid,
    itemCount = LT.Textf("Team_AwakerLevel", awakerLevel),
    clickFunc = function()
      SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, self._rankMO:GetUid())
    end
  }
  self:AddViewComponentOnce(self.ui.AssistAwaker, CompPublicIconItemType2, viewData)
end

return UICompRankWorldBossAssistItem
