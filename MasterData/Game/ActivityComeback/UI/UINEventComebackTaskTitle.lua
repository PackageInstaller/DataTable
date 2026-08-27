local UINEventComebackTaskTitle = class("UINEventComebackTaskTitle", UIBaseNode)
local base = UIBaseNode

function UINEventComebackTaskTitle:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINEventComebackTaskTitle:InitCombackTaskTitle(txtIndex)
  self._totalCount = totalCount
  self.ui.tex_Title:SetIndex(txtIndex)
  self.ui.tex_Progress.gameObject:SetActive(false)
end

function UINEventComebackTaskTitle:RefreshCombackTaskProgress(count, totalCount)
  self.ui.tex_Progress.gameObject:SetActive(true)
  self.ui.tex_Progress:SetIndex(0, tostring(count), tostring(totalCount))
end

return UINEventComebackTaskTitle
