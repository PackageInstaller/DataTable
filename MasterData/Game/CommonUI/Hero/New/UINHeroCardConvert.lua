local UINHeroCardConvert = class("UINHeroCardConvert", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINHeroCardConvert:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.uINBaseItem)
end

function UINHeroCardConvert:InitHeroCardConvert(itemId, itemNum)
  self.itemId = itemId
  self.ui.tex_Count.text = tostring(itemNum)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(itemId))
    return
  end
  self.baseItem:InitBaseItem(itemCfg, function()
  end)
  self.ui.text_Name.text = LanguageUtil.GetLocaleText(itemCfg.name)
  if self.ui.FxArr == nil then
    return
  end
  for _, go in ipairs(self.ui.FxArr) do
    go:SetActive(false)
  end
end

function UINHeroCardConvert:OnDelete()
  base.OnDelete(self)
end

return UINHeroCardConvert
