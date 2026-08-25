local SocialRelationFansPanel, Super = System.NewClass("SocialRelationFansPanel", SocialRelationSubPanel1BasePanel)
SocialRelationFansPanel.uiResCls = UI_Social_Panel_Main_SubPanel_1Resource

function SocialRelationFansPanel:ctor(mainModel)
  Super.ctor(self, mainModel)
end

function SocialRelationFansPanel:Init(binder)
  self.binder = binder
  self.model = binder:createModel(SocialRelationFansModel, SocialDefine.RelationListType.Fans)
  self.socialListItemType = SocialDefine.SocialListItemType.ShowAssist
end

function SocialRelationFansPanel:_OnBindFilter()
  self.ui.Group_Inquire:SetActive(true)
  self.ui.Btn_Fliter_Type:SetActive(true)
  self.ui.UI_Common_Filter_List:SetActive(false)
  self.ui.Image_Line:SetActive(false)
  self.ui.Btn_Trinket_Level:SetActive(false)
  self.ui.Btn_Trinket_Litre:SetActive(false)
  local binder, model = self.binder, self.model
  local commonFilterListData = {
    sortTypeList = model.relationSortTypeList,
    selectedFunc = function(relationSortType)
      return model.relationSortType == relationSortType
    end,
    callback = function(relationSortType)
      if not relationSortType then
        return
      end
      local relationSortTypeData = model.relationSortTypeList[relationSortType]
      model:SetRelationSortType(relationSortType)
      model:SetRelationType(relationSortTypeData.relation)
      binder:SetActive(self.ui.UI_Common_Filter_List, false)
      model:SetShowRelationFilter(false)
      binder:SetZ1Toggle(self.ui.Btn_Fliter_Type, false)
      binder:CircularScrollTo(self.ui.ScrollView_PlayerItem2, 1)
      model:SetSortOrderType(relationSortTypeData.relation)
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
  binder:BindToZ1Toggle(self.ui.Btn_Fliter_Type, nil, function(isOn)
    model:SetShowRelationFilter(isOn)
    binder:SetActive(self.ui.UI_Common_Filter_List, isOn)
  end, function()
  end)
  binder:BindToText(self.ui.Text_Fliter_Type, function()
    local index = model.relationSortType
    local relationSortTypeData = model.relationSortTypeList[index]
    return relationSortTypeData and relationSortTypeData.name
  end)
  binder:BindToVisible(self.ui.Btn_Sort_Group_Mask, function()
    return model.isShowRelationFilter
  end)
  binder:BindButtonClick(self.ui.Btn_Sort_Group_Mask, function()
    binder:SetActive(self.ui.UI_Common_Filter_List, false)
    model:SetShowRelationFilter(false)
    binder:SetZ1Toggle(self.ui.Btn_Fliter_Type, false)
  end)
end

function SocialRelationFansPanel:_OnBindFollowNum()
  local binder, _ = self.binder, self.model
  binder:BindToText(self.ui.Text_NewNum, function()
    local myPlayerData = SocialDataUtils.GetMyPlayer()
    do return LT.Text end
    return LT.Text, myPlayerData.newFansNum
  end)
  binder:BindToText(self.ui.Text_Num, function()
    local myPlayerData = SocialDataUtils.GetMyPlayer()
    do return LT.Text end
    return LT.Text, myPlayerData.followerNum
  end)
  binder:BindToVisible(self.ui.Group_Num, function()
    local myPlayerData = SocialDataUtils.GetMyPlayer()
    return 0 ~= myPlayerData.newFansNum
  end)
  binder:SetText(self.ui.Text_Concern, LT.Text("SocialSystemFans"))
  binder:SetActive(self.ui.Group_Tips, true)
  binder:SetActive(self.ui.Btn_Click_Fans, true)
  binder:BindButtonClick(self.ui.Btn_Click_Fans, function()
    SocialDataUtils.OpenSocialRelationNewFansPanel()
    SocialRedUtils.RemoveSocialRed(RedTypeDefine.SocialSubType.NewFans)
    self.ui.Group_Num:SetActive(false)
  end)
  binder:SetText(self.ui.Text_NoTask, LT.Text("SocialSystemFansEmptyStatusTitle"))
  binder:SetText(self.ui.Text_Time, LT.Text("SocialSystemFansEmptyStatusDesc"))
end

function SocialRelationFansPanel:_OnBindEmptyState()
  local binder, model = self.binder, self.model
  binder:BindToVisible(self.ui.Group_Null_Black, function()
    return #model.showGroup <= 0
  end)
end

function SocialRelationFansPanel:_OnAttentionCallback(newRelation, index)
  Super._OnAttentionCallback(self, newRelation, index)
  local myPlayerData = SocialDataUtils.GetMyPlayer()
  if not myPlayerData then
    return
  end
  if myPlayerData.newFansNum <= 0 then
    SocialRedUtils.RemoveSocialRed(RedTypeDefine.SocialSubType.NewFans)
  end
  local hasMyFans = false
  for _, facade in ipairs(self.model.showGroup) do
    if facade.relation == SocialDefine.SocialRelationType.MyFans then
      hasMyFans = true
      break
    end
  end
  if not hasMyFans then
    SocialRedUtils.RemoveSocialRed(RedTypeDefine.SocialSubType.NewFans)
  end
end

function SocialRelationFansPanel:Close()
  Super.Close(self)
end

return SocialRelationFansPanel
