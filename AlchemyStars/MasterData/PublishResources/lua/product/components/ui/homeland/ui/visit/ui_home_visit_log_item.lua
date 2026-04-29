_class("UIHomeVisitLogItem", UICustomWidget)
UIHomeVisitLogItem = UIHomeVisitLogItem

function UIHomeVisitLogItem:OnShow(uiParams)
  self:InitWidget()
end

function UIHomeVisitLogItem:InitWidget()
  self.content = self:GetUIComponent("UILocalizationText", "content")
  self.time = self:GetUIComponent("UILocalizationText", "time")
end

function UIHomeVisitLogItem:SetData(data)
  self.content:SetText(data:Content())
  local tb = os.date("*t", data:Time())
  self.time:SetText(tb.year .. "." .. tb.month .. "." .. tb.day)
end
