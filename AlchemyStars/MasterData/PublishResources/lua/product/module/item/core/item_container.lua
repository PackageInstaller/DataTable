_class("ItemContainer", Object)
ItemContainer = ItemContainer

function ItemContainer:Constructor()
  self.m_items = {}
  self.m_itemsRefByTplID = {}
end

function ItemContainer:Init()
end

function ItemContainer:AddItem(item)
  if not item then
    Log.fatal("not item")
    return false
  end
  if self:FindItem(item:GetID()) then
    Log.fatal("item exists ", item:GetID())
    return false
  end
  self.m_items[item:GetID()] = item
  local tplid = item:GetTemplateID()
  if not self.m_itemsRefByTplID[tplid] then
    self.m_itemsRefByTplID[tplid] = {item}
  else
    table.insert(self.m_itemsRefByTplID[tplid], item)
  end
  return true
end

function ItemContainer:DelItem(pst_id)
  if not self:FindItem(pst_id) then
    return false
  end
  local item = self.m_items[pst_id]
  table.removev(self.m_itemsRefByTplID[item:GetTemplateID()], item)
  self.m_items[pst_id] = nil
  return true
end

function ItemContainer:FindItem(pst_id)
  return self.m_items[pst_id]
end

function ItemContainer:FindItems(template_id, item_list)
  local list = self.m_itemsRefByTplID[template_id]
  if not list then
    return
  end
  for i = 1, #list do
    item_list[list[i]:GetID()] = list[i]
  end
end

function ItemContainer:GetItemCount(template_id)
  local list = self.m_itemsRefByTplID[template_id]
  if not list then
    return 0
  end
  local sum = 0
  for i = 1, #list do
    sum = sum + list[i]:GetCount()
  end
  return sum
end

function ItemContainer:GetAllItemInfo(item_list, filter)
  for k, v in pairs(self.m_items) do
    if not filter or filter(v) then
      table.insert(item_list, v)
    end
  end
end
