local SummonIntroUpPage, Super = System.NewComponent("SummonIntroUpPage")

function SummonIntroUpPage:ctor(uiNode, model)
  Super.ctor(self)
  self.ui = UI_Summon_Popup_Detail_TipResource(uiNode)
  self.model = model
end

function SummonIntroUpPage:OnBind(binder)
  binder:SetText(self.ui.Text_Up_Title, LT.Text("Summon_LongDesc_Text1"))
  binder:BindToCircularListView(self.ui.ScrollView_Up_Awaker_SSR, function()
    do return self.model.GetUpPageInfoList end
    return self.model.GetUpPageInfoList, self.model
  end, function(itemBinder, uiNode, index)
    local infoList = self.model:GetUpPageInfoList()
    itemBinder:BindComponent(SummonIntroUpPageItem(uiNode, infoList[index]))
  end)
end

return SummonIntroUpPage
