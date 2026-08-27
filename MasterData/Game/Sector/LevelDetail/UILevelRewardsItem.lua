local UILevelRewardsItem = class("UILevelRewardsItem", UIBaseNode)
local base = UIBaseNode

function UILevelRewardsItem.Create(gameObject)
  local node = UILevelRewardsItem.New()
  node:Init(gameObject)
  return node
end

function UILevelRewardsItem:OnInit()
  self.OnClickEvent = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  if not IsNull(self.ui.rootBtn) then
    UIUtil.AddButtonListener(self.ui.rootBtn, self, self.__OnClickRootBtn)
  end
end

function UILevelRewardsItem:InitRewardsItem(itemCfg, count)
  self.itemCfg = itemCfg
  if count ~= nil then
    self.ui.count.text = tostring(count)
  else
    self.ui.count.text = ""
  end
  if not IsNull(self.ui.name) then
    self.ui.name.text = LanguageUtil.GetLocaleText(itemCfg.name)
  end
  self.ui.icon.sprite = CRH:GetSpriteByItemConfig(itemCfg)
  self.transform:SetAsLastSibling()
  self:Show()
end

function UILevelRewardsItem:__OnClickRootBtn()
  if self.OnClickEvent ~= nil then
    self.OnClickEvent(self)
  end
end

function UILevelRewardsItem:OnDelete()
  base.OnDelete(self)
end

return UILevelRewardsItem
