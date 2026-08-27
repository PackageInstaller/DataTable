local base = UIBaseNode
local UINActCommonMonsterCardDropGroupItem = class("UINActCommonMonsterCardDropGroupItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")

function UINActCommonMonsterCardDropGroupItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.dropItemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.UINBaseItemWithReceived, false)
end

function UINActCommonMonsterCardDropGroupItem:InitUINActCommonMonsterCardDropGroupItem(typeId, diffTypeList)
  self.ui.Tex_Title:SetIndex(typeId - 1)
  self.dropItemPool:HideAll()
  for _, data in ipairs(diffTypeList) do
    local item = self.dropItemPool:GetOne()
    item:InitItemWithCount(data.itemCfg, nil, nil, false)
    item.ui.obj_uncollected:SetActive(not data.isGetted)
  end
end

function UINActCommonMonsterCardDropGroupItem:OnDelete()
  base.OnDelete(self)
end

return UINActCommonMonsterCardDropGroupItem
