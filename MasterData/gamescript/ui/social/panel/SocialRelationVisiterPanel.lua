local SocialRelationVisiterPanel, Super = System.NewClass("SocialRelationVisiterPanel", SocialRelationSubPanel1BasePanel)
SocialRelationVisiterPanel.uiResCls = UI_Social_Panel_Main_SubPanel_1Resource

function SocialRelationVisiterPanel:ctor(mainModel)
  Super.ctor(self, mainModel)
end

function SocialRelationVisiterPanel:Init(binder)
  self.binder = binder
  self.model = binder:createModel(SocialRelationVisiterModel, SocialDefine.RelationListType.Visiter)
  self.socialListItemType = SocialDefine.SocialListItemType.ShowVisited
end

function SocialRelationVisiterPanel:_OnBindFollowNum()
  local binder, model = self.binder, self.model
  self.ui.Group_Tips:SetActive(false)
  self.ui.Btn_Click_Fans:SetActive(false)
  binder:BindToText(self.ui.Text_Concern, function()
    do return LT.Text end
    return LT.Text, "SocialSystemVisitor"
  end)
  binder:BindToText(self.ui.Text_Num, function()
    do return LT.Text end
    return LT.Text, model.followNum
  end)
  binder:SetText(self.ui.Text_NoTask, LT.Text("SocialSystemVisitorEmptyStatusTitle"))
  binder:SetText(self.ui.Text_Time, LT.Text("SocialSystemVisitorEmptyStatusDesc"))
end

return SocialRelationVisiterPanel
