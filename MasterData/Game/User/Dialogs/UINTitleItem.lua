local UINTitleItem = class("UINTitleItem", UIBaseNode)
local base = UIBaseNode

function UINTitleItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UINTitleItem:InitTitleItem(cfg, index)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(cfg.name)
  self.index = index
  local newTitleItemDic = PlayerDataCenter.gameSettingData:GetNewTitleItemDic()
  if newTitleItemDic[cfg.id] then
    self.ui.img_New:SetActive(true)
  else
    self.ui.img_New:SetActive(false)
  end
end

function UINTitleItem:OnDelete()
  base.OnDelete(self)
end

return UINTitleItem
