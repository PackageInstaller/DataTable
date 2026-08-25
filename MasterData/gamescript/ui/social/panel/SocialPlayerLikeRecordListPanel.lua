local SocialPlayerLikeRecordListPanel, Super = System.NewClass("SocialPlayerLikeRecordListPanel", UIBasePanel)
SocialPlayerLikeRecordListPanel.uiResCls = UI_Social_Popup_WatchListResource

function SocialPlayerLikeRecordListPanel:ctor()
  Super.ctor(self)
end

function SocialPlayerLikeRecordListPanel:OnBind(binder)
  self.binder = binder
  self.model = binder:createModel(SocialPlayerLikeRecordModel)
  self:_BindPopupComp(binder)
  self:_BindScrollView(binder)
  self:_OnBindEmptyState()
end

function SocialPlayerLikeRecordListPanel:_BindScrollView(binder)
  binder:BindToCircularListView(self.ui.ScrollView, System.fn(self, self._GetLikeRecordList), System.fn(self, self._OnUpdateRecordItem))
  binder:BindToScrollbarValueChange(self.ui.Scrollbar_Vertical, function(val)
    self.model:SetScrollBarVal(val)
  end)
  binder:BindToRaw(function(_, nVal, oVal)
    if not oVal or not nVal then
      return
    end
    if 0 == #self.model.showingGroup then
      return
    end
    if #self.model.showingGroup >= self.model.likeRecordNum then
      return
    end
    if #self.model.showingGroup >= self.model.maxListNum then
      return
    end
    if nVal <= 0 and oVal > 0 then
      local curListNum = #self.model.showingGroup
      local queryEnd = math.min(self.model.maxListNum, curListNum + self.model.perQueryNum)
      SocialDataUtils.ReqOnSocialQueryList(SocialDefine.RelationListType.Good, curListNum + 1, queryEnd, 1)
    end
  end, function()
    return self.model.scrollBarVal
  end)
end

function SocialPlayerLikeRecordListPanel:_BindPopupComp(binder)
  local commonPopupConfirmTipsData = {
    sizeType = CommonDefine.PopupTipsType.L,
    clickFunc = System.fn(self, self.Close),
    textTitleCN = LT.Text("SocialSystemLikeHistory")
  }
  binder:BindComponent(CommonPopupTips(self.ui.UI_Common_Popup_Tips_L, commonPopupConfirmTipsData))
end

function SocialPlayerLikeRecordListPanel:_GetLikeRecordList()
  return self.model.showingGroup
end

function SocialPlayerLikeRecordListPanel:_OnUpdateRecordItem(binder, obj, index)
  local facade = self.model.showingGroup[index]
  
  local function _CheckLikeState()
    local record = self.model.totdayLikeRecord[facade.uid]
    return record and record > 0
  end
  
  local function _OnReqLike(ts)
    self.model:AddTodayLikeRecord(facade.uid, ts or TimeUtils.GetServerTime())
  end
  
  local itemData = {
    facade = facade,
    socialListItemType = SocialDefine.SocialListItemType.ShowLikeRecord,
    checkLikeStateFunc = _CheckLikeState,
    likeCb = _OnReqLike
  }
  binder:SetIcon(MaterialIconType.SocialRelationListItem, obj, itemData)
end

function SocialPlayerLikeRecordListPanel:_OnBindEmptyState()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Group_Null_Black, function()
    return 0 == #model.showingGroup
  end)
  binder:SetText(self.ui.Text_NoTask, LT.Text("DailyChallengeEmptyTips"))
  binder:SetText(self.ui.Text_Time, LT.Text("SocialSystemLikeEmptyStatusDesc"))
end

function SocialPlayerLikeRecordListPanel:Close()
  Super.Close(self)
end

return SocialPlayerLikeRecordListPanel
