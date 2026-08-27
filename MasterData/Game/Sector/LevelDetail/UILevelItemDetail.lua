local UILevelItemDetail = class("UILevelItemDetail", UIBaseNode)
local base = UIBaseNode

function UILevelItemDetail.Create(gameObject)
  local node = UILevelItemDetail.New()
  node:Init(gameObject)
  return node
end

function UILevelItemDetail:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UILevelItemDetail:InitItemDetail(itemCfg)
  self.ui.name.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.description.text = LanguageUtil.GetLocaleText(itemCfg.describe)
end

function UILevelItemDetail:OnDelete()
  base.OnDelete(self)
end

return UILevelItemDetail
