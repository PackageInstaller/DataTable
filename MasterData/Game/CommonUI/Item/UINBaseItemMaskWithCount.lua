local UINBaseItemMaskWithCount = class("UINBaseItemWithCount", UIBaseNode)
local base = UIBaseNode

function UINBaseItemMaskWithCount:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINBaseItemMaskWithCount:InitItemMaskWithCount(nowNum, totalNum)
  self:SetFntMask(nowNum, totalNum)
end

function UINBaseItemMaskWithCount:SetFntMask(nowNum, totalNum)
  if nowNum == 0 then
    self.ui.obj_mask:SetActive(false)
    self.ui.obj_had:SetActive(false)
  elseif nowNum < totalNum then
    self.ui.obj_mask:SetActive(false)
    self.ui.obj_had:SetActive(true)
    self.ui.tex_Had:SetIndex(1, "\n", tostring(nowNum), tostring(totalNum))
  else
    self.ui.obj_mask:SetActive(true)
    self.ui.obj_had:SetActive(true)
    self.ui.tex_Had:SetIndex(0)
  end
end

function UINBaseItemMaskWithCount:OnDelete()
  base.OnDelete(self)
end

return UINBaseItemMaskWithCount
