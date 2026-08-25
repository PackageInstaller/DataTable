local Vector2 = CS.UnityEngine.Vector2
local AvgDialogHistoryText, Super = System.NewComponent("AvgDialogHistoryText")

function AvgDialogHistoryText:ctor(uiNode, histData, histList, spacing)
  Super.ctor(self)
  self.ui = UI_Story_Item_History_TextResource(uiNode)
  self.histData = histData
  self.histList = Vue.ref(histList)
  self.spacing = spacing
end

function AvgDialogHistoryText:OnBind(binder)
  self.binder = binder
  binder:LoadAllLangFont(self.ui.Text_Desc)
  binder:LoadAllLangFont(self.ui.Text_Name)
  if self.histData.actor then
    binder:SetText(self.ui.Text_Name, StrUtils.ReplaceAvgContent(self.histData.actor))
  else
    binder:SetText(self.ui.Text_Name, "")
  end
  local chosenIndex = self.histData.chosenIndex
  binder:SetActive(self.ui.Text_Option, nil ~= chosenIndex)
  binder:SetActive(self.ui.Text_Name, not self.histData.isOption)
  local isCurrent = self.histData == self.histList.value[#self.histList.value]
  local isOption = nil ~= chosenIndex
  local content = LT.Text(self.histData.content)
  content = self:GetColoredContent(content, isCurrent, isOption)
  binder:SetText(self.ui.Text_Desc, StrUtils.ReplaceAvgContent(content or ""))
  binder:SetActive(self.ui.Text_Option, StrUtils.ReplaceAvgContent(content or ""))
  binder:BindToVisible(self.ui.Image_Arrow, function()
    return self.histData == self.histList.value[#self.histList.value]
  end)
  binder:SetActive(self.ui.Group_Choice_1, nil ~= chosenIndex)
  binder:SetActive(self.ui.Group_Choice_2, false)
  binder:SetActive(self.ui.Group_Choice_3, false)
  local textComp = self.binder:GetTextComp(self.ui.Text_Desc)
  self.preSizeDelta = self.preSizeDelta or self.ui.uiNode.transform.sizeDelta
  local height = math.max(60, textComp.preferredHeight + (self.spacing or 0))
  local newSizeDelta = Vector2(self.preSizeDelta.x, height)
  self.ui.uiNode.transform.sizeDelta = newSizeDelta
end

function AvgDialogHistoryText:GetColoredContent(content, isCurrent, isOption)
  local color
  if isCurrent then
    color = "#f5df94"
    do return string.format, "<color=%s>%s</color>", color end
    return string.format, "<color=%s>%s</color>", color, content
  end
  if isOption then
    color = "#75ecff"
    do return string.format, "<color=%s>%s</color>", color end
    return string.format, "<color=%s>%s</color>", color, content
  end
  return content
end

return AvgDialogHistoryText
