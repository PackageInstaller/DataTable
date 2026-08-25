local UICompAbyssRankItem, Super = NewViewComponent("UICompAbyssRankItem")

function UICompAbyssRankItem:ctor(uiNode, view, data, onAvatarClick, onMoreClick, onReplayClick)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_AbyssRankResource(uiNode)
  self.data = data
  self.onAvatarClick = onAvatarClick
  self.onMoreClick = onMoreClick
  self.onReplayClick = onReplayClick
end

function UICompAbyssRankItem:RegisterNotifications()
end

function UICompAbyssRankItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_More, System.fn(self, self._OnMoreClick))
  self:AddButtonClickListener(self.ui.Btn_Replay, System.fn(self, self._OnClickReplay))
end

function UICompAbyssRankItem:OnEnterComponent()
  self:_Refresh()
end

function UICompAbyssRankItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function UICompAbyssRankItem:_Refresh()
  self.ui.Btn_Replay:SetActive(true)
  self:LoadAllLangFont(self.ui.Text_Name)
  local rankText = self.data.rewardRankIndex and self.data.rewardRankIndex > 0 and self.data.rewardRankIndex or LT.Text("AbyssChallengeRankNotOnTheList")
  self:SetText(self.ui.Text_Rank, rankText)
  local scoreText
  if self.data.isSelfRank and self.data.normalScore and AbyssExtModel.Instance:IsAbyssRevivalFeatureEnabled() then
    local revivalScore = self.data.revivalScore or 0
    scoreText = string.format("%s<color=#A3A6AB>(+%s)</color>", self.data.normalScore, revivalScore)
  else
    scoreText = self.data.score and self.data.score > 0 and self.data.score or "-"
  end
  self:SetText(self.ui.Text_Value, scoreText)
  self:SetText(self.ui.Text_Uid, self.data.uid)
  self:SetText(self.ui.Text_Name, SocialDataUtils.GetPlayerNameByUid(self.data.uid, LT.Text(self.data.name)))
  self:AddViewComponentOnce(self.ui.UI_Common_Head, CompHeadItem, {
    headIcon = ItemDataUtils.GetAvatarIcon(self.data.icon),
    frameIcon = ItemDataUtils.GetItemIcon(self.data.avatarFrame),
    clickCb = System.fn(self, self._OnAvatarClick)
  })
end

function UICompAbyssRankItem:_OnAvatarClick()
  if not (self.data and self.data.score) or self.data.score <= 0 then
    return
  end
  if self.onAvatarClick then
    self.onAvatarClick()
  end
end

function UICompAbyssRankItem:_OnMoreClick()
  if self.onMoreClick then
    self.onMoreClick()
  end
end

function UICompAbyssRankItem:_OnClickReplay()
  if self.onReplayClick then
    self.onReplayClick()
  end
end

return UICompAbyssRankItem
