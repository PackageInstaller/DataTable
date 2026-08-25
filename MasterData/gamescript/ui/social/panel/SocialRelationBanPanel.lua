local SocialRelationBanPanel, Super = System.NewClass("SocialRelationBanPanel", SocialRelationSubPanel1BasePanel)
SocialRelationBanPanel.uiResCls = UI_Social_Panel_Main_SubPanel_1Resource

function SocialRelationBanPanel:ctor(mainModel)
  Super.ctor(self, mainModel)
end

function SocialRelationBanPanel:Init(binder)
  self.binder = binder
  self.model = binder:createModel(SocialRelationBanModel, SocialDefine.RelationListType.Bans)
  self.socialListItemType = SocialDefine.SocialListItemType.Ban
end

function SocialRelationBanPanel:OnBind(binder)
  Super.OnBind(self, binder)
  binder:SetText(self.ui.Text_NoTask, LT.Text("TextEmptyBan"))
  binder:SetText(self.ui.Text_Time, "")
end

function SocialRelationBanPanel:_OnBindFilter()
  local binder, model = self.binder, self.model
  binder:SetActive(self.ui.Group_Inquire, false)
  binder:SetActive(self.ui.Btn_Trinket_Level, true)
  binder:SetActive(self.ui.Image_Line, true)
  binder:SetActive(self.ui.Btn_Trinket_Litre, true)
  binder:SetActive(self.ui.UI_Common_Filter_List, false)
  binder:SetActive(self.ui.Btn_Fliter_Type, false)
  binder:SetActive(self.ui.Btn_Sort_Group_Mask, false)
  binder:SetText(self.ui.Text_Trinket_SortType_1, LT.Text("SocialOnlineTimeLabel"))
  binder:BindToZ1Toggle(self.ui.Btn_Trinket_Litre, nil, function(isOn)
    binder:CircularScrollTo(self.ui.ScrollView_PlayerItem2, 1)
    if isOn then
      model:SetSortOrderType(CommonDefine.SortOrder.Descend)
    else
      model:SetSortOrderType(CommonDefine.SortOrder.Ascend)
    end
  end, function()
    return model.sortOrderType == CommonDefine.SortOrder.Descend
  end)
end

function SocialRelationBanPanel:_OnBindFollowNum()
  local binder, model = self.binder, self.model
  self.binder:SetActive(self.ui.Group_Tips, false)
  self.binder:SetActive(self.ui.Btn_Click_Fans, false)
  binder:BindToText(self.ui.Text_Concern, function()
    do return LT.Text end
    return LT.Text, "TextBanTitle"
  end)
  binder:BindToText(self.ui.Text_Num, function()
    do return LT.Text end
    return LT.Text, model.banNum
  end)
end

return SocialRelationBanPanel
