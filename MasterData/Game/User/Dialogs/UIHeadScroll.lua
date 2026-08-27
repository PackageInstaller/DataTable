local UIHeadScroll = class("UIHeadScroll", UIBaseNode)
local base = UIBaseNode

function UIHeadScroll:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIHeadScroll:ReFreshData(dataListLen)
  if 0 < dataListLen then
    self.gameObject:SetActive(true)
    self.ui.img_Empty.gameObject:SetActive(false)
    self.ui.scro_List.totalCount = dataListLen
    self.ui.scro_List:RefillCells(0)
    self.ui.scrollbar.gameObject:SetActive(true)
  else
    self.ui.scrollbar.gameObject:SetActive(false)
    self.gameObject:SetActive(false)
    self.ui.img_Empty.gameObject:SetActive(true)
  end
end

function UIHeadScroll:OnDelete()
  base.OnDelete(self)
end

return UIHeadScroll
