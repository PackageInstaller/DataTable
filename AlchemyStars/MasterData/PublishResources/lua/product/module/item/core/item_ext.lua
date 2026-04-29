_class("ItemExt", Object)
ItemExt = ItemExt

function ItemExt:Constructor()
end

_class("ItemExtFactory", Object)
ItemExtFactory = ItemExtFactory

function ItemExtFactory:Constructor()
  self._regster = {}
end

function ItemExtFactory:Register(item_sub_type, item_ext_type)
  self._regster[item_sub_type] = item_ext_type
end

function ItemExtFactory:Alloc(item_sub_type)
  local Ext = self._regster[item_sub_type]
  if Ext == nil then
    return nil
  end
  return Ext:New()
end
