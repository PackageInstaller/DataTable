local SocialRelationNewFansPanel, Super = System.NewClass("SocialRelationNewFansPanel", UIBasePanel)
SocialRelationNewFansPanel.uiResCls = UI_Social_Popup_WatchListResource

function SocialRelationNewFansPanel:ctor(maxNum)
  Super.ctor(self)
  self.maxNum = maxNum
end

function SocialRelationNewFansPanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(SocialRelationNewFansModel, SocialDefine.RelationListType.Fans, self.maxNum)
  self.isFansFollowAllDone = false
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:SetText(self.ui.Text_Title, LT.Text("SocialSystemAddNewFans"))
  binder:SetActive(self.ui.Text_Tip, true)
  binder:SetText(self.ui.Text_Tip, LT.Textf("SocialSystemNewFansTip", self.maxNum))
  binder:BindToVisible(self.ui.Btn_FollowAll, System.fn(self, self._ShouldShowFollowAllButton))
  binder:BindZ1Button(self.ui.Btn_FollowAll, System.fn(self, self._OnClickFollowAll))
  binder:BindEvent(EventMgr.Instance.SocialAttention, System.fn(self, self._OnSocialAttention))
  self:_OnBindNewFansPlayerGroup()
end

function SocialRelationNewFansPanel:_ShouldShowFollowAllButton()
  if self.isFansFollowAllDone then
    return false
  end
  local showGroup = self.model.showGroup
  return nil ~= showGroup and #showGroup > 0 and SocialDataUtils.HasFollowableInList(showGroup)
end

function SocialRelationNewFansPanel:_OnSocialAttention(targetUid, newRelation)
  local showGroup = self.model.showGroup
  if showGroup and targetUid and newRelation then
    for _, facade in ipairs(showGroup) do
      if facade.uid == targetUid then
        facade.relation = newRelation
        break
      end
    end
  end
  self:_RefreshFollowAllButtonVisible()
end

function SocialRelationNewFansPanel:_RefreshFollowAllButtonVisible()
  if not self.binder then
    return
  end
  local showGroup = self.model.showGroup
  if showGroup and SocialDataUtils.HasFollowableInList(showGroup) then
    self.isFansFollowAllDone = false
  end
  self.binder:SetActive(self.ui.Btn_FollowAll, self:_ShouldShowFollowAllButton())
end

function SocialRelationNewFansPanel:_OnClickFollowAll()
  local binder = self.binder
  
  local function onFollowAllDone()
    self.isFansFollowAllDone = true
    binder:SetActive(self.ui.Btn_FollowAll, false)
    Alert.ShowStr(LT.Text("Socialize_AllStrangersFollowed"))
  end
  
  local showGroup = self.model.showGroup
  if not showGroup or #showGroup <= 0 then
    Alert.ShowStr(LT.Text("DailyChallengeEmptyTips"))
    return
  end
  if not SocialDataUtils.HasFollowableInList(showGroup) then
    return
  end
  if #showGroup < self.model.followNum and #showGroup < self.model.maxListNum then
    local curListNum = #showGroup
    local queryEnd = self.maxNum
    SocialDataUtils.ReqOnSocialQueryList(self.model.relationListType, curListNum + 1, queryEnd, 1, function()
      SocialDataUtils.ExecuteFollowAll(self.model.showGroup, true, onFollowAllDone)
    end)
  else
    SocialDataUtils.ExecuteFollowAll(showGroup, true, onFollowAllDone)
  end
end

function SocialRelationNewFansPanel:_OnBindNewFansPlayerGroup()
  local binder, model = self.binder, self.model
  binder:BindToCircularListView(self.ui.ScrollView, function()
    return model.showGroup
  end, function(_, item, index)
    local itemData = {
      facade = model.showGroup[index],
      socialListItemType = SocialDefine.SocialListItemType.ShowNewFans,
      attentionCb = function(newRelation)
        local facadeData = SocialDataUtils.GetRelationByindex(model.relationListType, index)
        if facadeData then
          facadeData.relation = newRelation
        end
        self:_RefreshFollowAllButtonVisible()
      end
    }
    binder:SetIcon(MaterialIconType.SocialRelationListItem, item.gameObject, itemData)
  end)
  binder:BindToRaw(function(_, nVal, oVal)
    if not oVal or not nVal then
      return
    end
    if #model.showGroup >= model.followNum then
      return
    end
    if #model.showGroup >= self.maxNum then
      return
    end
    if nVal <= 0 and oVal > 0 then
      local curListNum = #model.showGroup
      local queryEnd = math.min(model.maxListNum, curListNum + model.perQueryNum)
      SocialDataUtils.ReqOnSocialQueryList(model.relationListType, curListNum + 1, queryEnd, 1)
    end
  end, function()
    return model.scrollBarVal
  end)
  binder:BindToScrollbarValueChange(self.ui.Scrollbar_Vertical, function(val)
    model:SetScrollBarVal(val)
  end)
  binder:BindToVisible(self.ui.Group_Null_Black, function()
    return #model.showGroup <= 0
  end)
  binder:SetText(self.ui.Text_NoTask, LT.Text("DailyChallengeEmptyTips"))
  binder:SetText(self.ui.Text_Time, LT.Text("SocialSystemLikeEmptyStatusDesc"))
end

function SocialRelationNewFansPanel:Close()
  Super.Close(self)
  SocialRedUtils.RemoveSocialRed(RedTypeDefine.SocialSubType.NewFans)
  local myPlayerData = SocialDataUtils.GetMyPlayer()
  SocialDataUtils.ReqOnClearNewFanNum(function()
    myPlayerData.newFansNum = 0
  end)
end

return SocialRelationNewFansPanel
