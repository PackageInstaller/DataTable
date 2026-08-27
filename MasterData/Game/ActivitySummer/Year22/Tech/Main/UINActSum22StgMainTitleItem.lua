local base = UIBaseNode
local UINActSum22StgMainTitleItem = class("UINActSum22StgMainTitleItem", base)

function UINActSum22StgMainTitleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINActSum22StgMainTitleItem:InitActSum22StgMainTitleItem(branchCfg)
  self.ui.tex_CNName.text = LanguageUtil.GetLocaleText(branchCfg.branch_name)
  self.ui.tex_ENName.text = LanguageUtil.GetLocaleText(branchCfg.branch_name_en)
end

function UINActSum22StgMainTitleItem:SetActSum22StgMainTitleItemNum(curNum, maxNum)
  self.ui.tex_Num:SetIndex(0, tostring(curNum), tostring(maxNum))
end

function UINActSum22StgMainTitleItem:SetActSum22StgMainTitleItemWidth(width)
  if IsNull(self.ui.layoutElement) then
    return
  end
  self.ui.layoutElement.minWidth = width
end

function UINActSum22StgMainTitleItem:OnDelete()
  base.OnDelete(self)
end

return UINActSum22StgMainTitleItem
