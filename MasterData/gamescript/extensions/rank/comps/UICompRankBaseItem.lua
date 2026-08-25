local UICompRankBaseItem, Super = NewViewComponent("UICompRankBaseItem")

function UICompRankBaseItem:ctor(uiNode, view, rankMO)
  Super.ctor(self, uiNode, view)
  self._rankMO = rankMO
end

function UICompRankBaseItem:OnEnterComponent()
  self:LoadAllLangFont(self:_GetNameTextNode())
  self:_RefreshView()
end

function UICompRankBaseItem:_GetNameTextNode()
  Logger.Error("Please override UICompRankBaseItem:_GetNameTextNode")
end

function UICompRankBaseItem:_GetUidTextNode()
  Logger.Error("Please override UICompRankBaseItem:_GetUidTextNode")
end

function UICompRankBaseItem:_GetScoreTextNode()
  Logger.Error("Please override UICompRankBaseItem:_GetScoreTextNode")
end

function UICompRankBaseItem:_GetRankIdxTextNode()
  Logger.Error("Please override UICompRankBaseItem:_GetRankIdxTextNode")
end

function UICompRankBaseItem:_RefreshView()
  if not self._rankMO or type(self._rankMO.GetUid) ~= "function" then
    return
  end
  self:_RefreshUid()
  self:_RefreshName()
  self:_RefreshRankIdx()
  self:_RefreshScore()
  self:_RefreshHeadIcon()
end

function UICompRankBaseItem:_RefreshUid()
  if self:_GetUidTextNode() then
    self:SetText(self:_GetUidTextNode(), self._rankMO:GetUid())
  end
end

function UICompRankBaseItem:_RefreshName()
  if self:_GetNameTextNode() then
    self:SetText(self:_GetNameTextNode(), self._rankMO:GetName())
  end
end

function UICompRankBaseItem:_RefreshScore()
  if self:_GetScoreTextNode() then
    self:SetText(self:_GetScoreTextNode(), self._rankMO:GetScore())
  end
end

function UICompRankBaseItem:_RefreshRankIdx()
  local rankIdx = self._rankMO:GetRank()
  local showRank = 0 == rankIdx and LT.Text("Unranked") or rankIdx
  if self:_GetRankIdxTextNode() then
    self:SetText(self:_GetRankIdxTextNode(), showRank)
  end
end

function UICompRankBaseItem:_RefreshHeadIcon()
  self:AddViewComponentOnce(self.ui.UI_Common_Head, CompHeadItem, {
    headIcon = ItemDataUtils.GetAvatarIcon(self._rankMO:GetIcon()),
    frameIcon = ItemDataUtils.GetItemIcon(self._rankMO:GetAvatarFrame()),
    clickCb = function()
      SocialDataUtils.OpenPlayerInfoPanel(SocialDefine.PlayerInfoPage.Overview, self._rankMO:GetUid())
    end
  })
end

return UICompRankBaseItem
