local PropertiesTipsView, Super = NewClass("PropertiesTipsView", BaseView)
PropertiesTipsView.uiResCls = UI_Common_Tips_PropertiesResource

function PropertiesTipsView:ctor(data)
  Super.ctor(self)
  self.title = data.title
  self.showDatas = data.showDatas
  self.lockNode = data.lockNode
end

function PropertiesTipsView:RegisterNotifications()
  self:AddButtonClickListener(self.ui.Btn_Mask, function()
    self:Close()
  end)
end

function PropertiesTipsView:RegisterEvents()
end

function PropertiesTipsView:OnEnterView()
  Super.OnEnterView(self)
  self.ui.Goup_Title:SetActive(self.title ~= nil)
  self:SetText(self.ui.Text_Title, self.title or "")
  for _, showData in ipairs(self.showDatas) do
    local go = GameObject.Instantiate(self.ui.UI_Team_Panel_Main_item1, self.ui.CardKeyWordItem_New_Info.transform)
    go:SetActive(true)
    self:AddViewComponentOnce(go, CompPropertiesBaseItem, showData)
  end
  if self.lockNode then
    self.ui.BaseNode.transform.position = self.lockNode.transform.position
  end
end

return PropertiesTipsView
