local INTRO_MAX_SHOW_CHARA = 48
local UICompSocialRankItem, Super = NewViewComponent("UICompSocialRankItem")
local SocialRelationType = SocialDefine.SocialRelationType

function UICompSocialRankItem:ctor(uiNode, view, data, curRankAwakerTid, onAvatarClick)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Social_Item_RankResource(uiNode)
  self.avatarUiRes = UI_Social_Item_AvatarResource(self.ui.UI_Social_Item_Avatar)
  self.model = SocialExtModel.Instance
  self.data = data
  self.onAvatarClick = onAvatarClick
  self.curRankAwakerTid = curRankAwakerTid
  self.awakerFacade = self.data.awakerBagFacade and self.data.awakerBagFacade[self.curRankAwakerTid]
end

function UICompSocialRankItem:RegisterNotifications()
end

function UICompSocialRankItem:RegisterEvents()
  self:BindEvent(EventMgr.Instance.SocialSetNote, System.fn(self, self._RefreshWhenNoteChanged))
end

function UICompSocialRankItem:OnEnterComponent()
  self:LoadAllLangFont(self.ui.Text_Name)
  self:_Refresh()
end

function UICompSocialRankItem:OnExitComponent()
  Super.OnExitComponent(self)
end

function UICompSocialRankItem:_Refresh()
  self:_RefreshPlayerInfo()
  self:_RefreshScore()
  self:_RefreshRelationBtn()
  self:_RefreshLikeBtn()
end

function UICompSocialRankItem:_RefreshPlayerInfo()
  self:SetText(self.ui.Text_Uid, self:_GetUid())
  self:SetText(self.ui.Text_Name, self:_GetName())
  self:SetText(self.ui.Text_Sign, self:_GetSign())
  self:AddViewComponentOnce(self.avatarUiRes.UI_Common_Head, CompHeadItem, {
    headIcon = ItemDataUtils.GetAvatarIcon(self.data.icon),
    frameIcon = ItemDataUtils.GetItemIcon(self.data.avatarFrame),
    clickCb = System.fn(self, self._OnClickAvatar)
  })
end

function UICompSocialRankItem:_RefreshWhenNoteChanged(newNote)
  if self:_GetUid() ~= PlayerDataUtils.GetPlayerUid() then
    return
  end
  self:SetText(self.ui.Text_Sign, newNote or "")
end

function UICompSocialRankItem:_RefreshScore()
  self:SetText(self.ui.Text_Rank, self:_GetRankIndex())
  self:SetText(self.ui.Text_LikeCount, self:_GetRankText())
  self:SetText(self.ui.Text_CurValue, self:_GetAwakerLikeLevel())
  self:SetText(self.ui.Text_TotalValue, self:_GetAwakerLikeScore())
end

function UICompSocialRankItem:_RefreshRelationBtn()
end

function UICompSocialRankItem:_RefreshLikeBtn()
  self.ui.UI_Vx_Glow:SetActive(false)
end

function UICompSocialRankItem:_GetName()
  do return SocialDataUtils.GetPlayerNameByUid, (self:_GetUid()) end
  return SocialDataUtils.GetPlayerNameByUid, self:_GetUid(), self.data.name
end

function UICompSocialRankItem:_GetUid()
  return self.data.uid
end

function UICompSocialRankItem:_GetSign()
  if string.isempty(self.data.note) then
    do return LT.Text end
    return LT.Text, "SocialSystemIntroductionNone", nil
  end
  return StrUtils.TruncateChineseString(self.data.note, INTRO_MAX_SHOW_CHARA) or LT.Text("SocialSystemIntroductionNone")
end

function UICompSocialRankItem:_GetRankText()
  local scoreText = self.model:GetScoreShowText(self.data, self.data.type)
  return scoreText
end

function UICompSocialRankItem:_GetAwakerLikeScore()
  do return self._GetRankText end
  return self._GetRankText, self
end

function UICompSocialRankItem:_GetAwakerLikeLevel()
  local likeLevel = self.awakerFacade and self.awakerFacade.likeLevel or 0
  return likeLevel
end

function UICompSocialRankItem:_GetRankIndex()
  do return RankDataUtils.GetRankText end
  return RankDataUtils.GetRankText, self.data
end

function UICompSocialRankItem:_OnClickAvatar()
  if self.onAvatarClick then
    self.onAvatarClick()
  end
end

function UICompSocialRankItem:_OnClickAttention()
  local curRelation = self.data.relation
  if curRelation == SocialRelationType.Cor or curRelation == SocialRelationType.Atten then
    SocialController.Instance:ReqCancelAttentionPlayer(self.data.uid, System.fn(self, self._OnChangeRelation))
  else
    SocialController.Instance:ReqAttentionPlayer(self.data.uid, System.fn(self, self._OnChangeRelation))
  end
end

function UICompSocialRankItem:_OnClickLike()
  if self.data.todayGood then
    return
  end
  SocialController.Instance:ReqLikePlayer(self.data.uid, System.fn(self, self._OnLikePlayerSucc))
end

function UICompSocialRankItem:_OnChangeRelation(newRelation)
  self.data.relation = newRelation
  self:_RefreshRelationBtn()
  local needUpdateScore = false
  local shouldUpdateScoreTypes = {
    RankDefine.RankType.FollowerNum
  }
  for _, rankType in ipairs(shouldUpdateScoreTypes) do
    if string.contains(self.data.type, rankType) then
      needUpdateScore = true
      break
    end
  end
  if needUpdateScore then
    local addScore = 1
    if newRelation == SocialRelationType.UnAtten or newRelation == SocialRelationType.MyFans then
      addScore = -1
    end
    self.data.score = self.data.score + addScore
    self:_RefreshScore()
  end
end

function UICompSocialRankItem:_OnLikePlayerSucc()
  self.data.todayGood = true
  self:_RefreshLikeBtn()
  local needUpdateScore = false
  local shouldUpdateScoreTypes = {
    RankDefine.RankType.BeGoodNum,
    RankDefine.RankType.GoodNum
  }
  for _, rankType in ipairs(shouldUpdateScoreTypes) do
    if string.contains(self.data.type, rankType) then
      needUpdateScore = true
      break
    end
  end
  if needUpdateScore then
    self.data.score = self.data.score + 1
    self:_RefreshScore()
  end
  SocialDataUtils.AddLikeRecord(self:_GetUid(), 1)
  self.ui.UI_Vx_Glow:SetActive(false)
  self.ui.UI_Vx_Glow:SetActive(true)
end

return UICompSocialRankItem
