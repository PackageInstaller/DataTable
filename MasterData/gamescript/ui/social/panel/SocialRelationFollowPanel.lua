local SocialRelationFollowPanel, Super = System.NewClass("SocialRelationFollowPanel", SocialRelationSubPanel1BasePanel)
SocialRelationFollowPanel.uiResCls = UI_Social_Panel_Main_SubPanel_1Resource

function SocialRelationFollowPanel:ctor(mainModel)
  Super.ctor(self, mainModel)
end

function SocialRelationFollowPanel:Init(binder)
  self.binder = binder
  self.model = binder:createModel(SocialRelationFollowModel, SocialDefine.RelationListType.Attention)
  self.socialListItemType = SocialDefine.SocialListItemType.ShowAssist
end

SocialRelationFollowPanel.UnfollowBtnState = {
  default = "default",
  exit = "exit",
  finish = "finish"
}

function SocialRelationFollowPanel:_OnBindFilter()
  local binder, model = self.binder, self.model
  self.ui.Group_Inquire:SetActive(true)
  self.ui.Btn_Trinket_Level:SetActive(true)
  self.ui.Image_Line:SetActive(true)
  self.ui.Btn_Trinket_Litre:SetActive(true)
  self.ui.UI_Common_Filter_List:SetActive(false)
  self.ui.Btn_Fliter_Type:SetActive(false)
  self.ui.Btn_Sort_Group_Mask:SetActive(false)
  binder:CircularScrollTo(self.ui.ScrollView_PlayerItem2, 1)
  binder:BindToVisible(self.ui.Btn_Unfollow, function()
    return model.followNum > 0
  end)
  self.unFollowBtnState = SocialRelationFollowPanel.UnfollowBtnState.default
  binder:SetText(self.ui.Text_Unfollow, self:_GetUnfollowBtnState())
  self.binder:BindZ1Button(self.ui.Btn_Unfollow, function()
    self:_OnClickUnfollowBtn()
  end)
  binder:BindToRaw(function(_, newValue)
    if SocialData.isUnfollowing then
      if 0 == newValue then
        self:SetUnfollowBtnState(SocialRelationFollowPanel.UnfollowBtnState.exit)
      else
        self:SetUnfollowBtnState(SocialRelationFollowPanel.UnfollowBtnState.finish)
      end
    end
  end, function()
    do return end
    return SocialDataUtils.GetUnfollowListLen, nil
  end)
  local commonFilterListData = {
    sortTypeList = model.relationSortTypeList,
    selectedFunc = function(sortOrderType)
      return model.sortOrderType.feq == SocialDefine.SocialFollowSortParam[sortOrderType].sortType.feq
    end,
    callback = function(sortOrderType)
      if not sortOrderType then
        return
      end
      binder:SetActive(self.ui.UI_Common_Filter_List, false)
      model:SetShowRelationFilter(false)
      binder:SetZ1Toggle(self.ui.Btn_Trinket_Level, false, true)
      binder:CircularScrollTo(self.ui.ScrollView_PlayerItem2, 1)
      SocialDataUtils.MarkSocialListDirty(model.relationListType)
      model:SetSortOrderType(sortOrderType)
    end
  }
  binder:BindComponent(CommonFilterList(self.ui.UI_Common_Filter_List, commonFilterListData))
  binder:BindToAnimator(self.ui.UI_Common_Filter_List, function(_, animator, show)
    AnimatorUtils.SetStateEndInBehavior(animator, "Close", function()
      binder:SetActive(self.ui.UI_Common_Filter_List, false)
    end)
    local name = show and "Open" or "Close"
    if "Open" == name then
      return
    end
    local state = string.format("Base Layer.%s", name)
    AnimatorUtils.PlayState(animator, state)
  end, nil, function()
    return model.isShowRelationFilter
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Trinket_Level, nil, function(isOn)
    model:SetShowRelationFilter(isOn)
    binder:SetActive(self.ui.UI_Common_Filter_List, isOn)
  end)
  binder:BindToText(self.ui.Text_Trinket_SortType_1, function()
    local index = SocialDefine.SocialFollowSortType[model.sortOrderType.feq]
    local relationSortTypeData = model.relationSortTypeList[index]
    return relationSortTypeData and relationSortTypeData.name
  end)
  binder:BindToVisible(self.ui.Btn_Sort_Group_Mask, function()
    return model.isShowRelationFilter
  end)
  binder:BindButtonClick(self.ui.Btn_Sort_Group_Mask, function()
    binder:SetActive(self.ui.UI_Common_Filter_List, false)
    model:SetShowRelationFilter(false)
    binder:SetZ1Toggle(self.ui.Btn_Trinket_Level, false, true)
  end)
  binder:BindToZ1Toggle(self.ui.Btn_Trinket_Litre, nil, function()
    local isOn = self.ui.Btn_Trinket_Litre:GetComponent(typeof(CS.Z1Client.Z1Toggle)).isOn
    binder:CircularScrollTo(self.ui.ScrollView_PlayerItem2, 1)
    model:SetOppositeSortOrderType(isOn)
  end, function()
    return model.sortOrderType.order == CommonDefine.SortOrder.Descend
  end)
end

function SocialRelationFollowPanel:_GetUnfollowBtnState()
  if self.unFollowBtnState == SocialRelationFollowPanel.UnfollowBtnState.default then
    do return LT.Text("SocializeBatchCancel").color, (LT.Text("SocializeBatchCancel")) end
    return LT.Text("SocializeBatchCancel").color, LT.Text("SocializeBatchCancel"), "#C5C4BE"
  elseif self.unFollowBtnState == SocialRelationFollowPanel.UnfollowBtnState.exit then
    do return LT.Text("SocializeExitCancel").color, (LT.Text("SocializeExitCancel")) end
    return LT.Text("SocializeExitCancel").color, LT.Text("SocializeExitCancel"), "#C5C4BE"
  elseif self.unFollowBtnState == SocialRelationFollowPanel.UnfollowBtnState.finish then
    do return LT.Text("SocializeFinishCancel").color, (LT.Text("SocializeFinishCancel")) end
    return LT.Text("SocializeFinishCancel").color, LT.Text("SocializeFinishCancel"), "#FF6262"
  end
end

function SocialRelationFollowPanel:SetUnfollowBtnState(state)
  self.unFollowBtnState = state
  self.binder:SetText(self.ui.Text_Unfollow, self:_GetUnfollowBtnState())
end

function SocialRelationFollowPanel:_OnClickUnfollowBtn()
  if self.unFollowBtnState == SocialRelationFollowPanel.UnfollowBtnState.default then
    SocialDataUtils.SetUnfollow(true)
    self:SetUnfollowBtnState(SocialRelationFollowPanel.UnfollowBtnState.exit)
  elseif self.unFollowBtnState == SocialRelationFollowPanel.UnfollowBtnState.exit then
    SocialDataUtils.SetUnfollow(false, function()
      if not self.ui then
        return
      end
      self:SetUnfollowBtnState(SocialRelationFollowPanel.UnfollowBtnState.default)
    end)
  elseif self.unFollowBtnState == SocialRelationFollowPanel.UnfollowBtnState.finish then
    SocialDataUtils.ExecuteUnfollow(function()
      if not self.ui then
        return
      end
      self:SetUnfollowBtnState(SocialRelationFollowPanel.UnfollowBtnState.default)
    end)
  end
end

function SocialRelationFollowPanel:_OnBindFollowNum()
  local binder, model = self.binder, self.model
  self.ui.Group_Tips:SetActive(false)
  self.ui.Btn_Click_Fans:SetActive(false)
  binder:BindToText(self.ui.Text_Concern, function()
    do return LT.Text end
    return LT.Text, "SocialSystemFollow"
  end)
  binder:BindToText(self.ui.Text_Num, function()
    do return LT.Text end
    return LT.Text, model.followNum
  end)
  binder:SetText(self.ui.Text_NoTask, LT.Text("SocialSystemFollowEmptyStatusTitle"))
  binder:SetText(self.ui.Text_Time, LT.Text("SocialSystemFollowEmptyStatusDesc"))
end

return SocialRelationFollowPanel
