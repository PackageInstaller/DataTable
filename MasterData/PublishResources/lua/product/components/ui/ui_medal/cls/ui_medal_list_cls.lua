_class("UIMedalListData", Object)
UIMedalListData = UIMedalListData

function UIMedalListData:Constructor()
  self.filterIds = {}
  self.fileterIdMap = {}
  self.client_medal_info = nil
  self.items = {}
  self.newItemsId = {}
  self.visit = nil
  self.allMedalCount = 0
  self.receiveMedalCount = 0
end

function UIMedalListData:Init(client_medal_info, visit)
  self.client_medal_info = client_medal_info
  self.visit = visit
  local tabs = Cfg.cfg_item_medal_tab({})
  table.sort(tabs, function(a, b)
    return a.Order < b.Order
  end)
  self.filterIds = {}
  table.insert(self.filterIds, 0)
  for _, v in pairs(tabs) do
    table.insert(self.filterIds, v.ID)
    self.fileterIdMap[v.ID] = true
  end
  for _, v in pairs(self.client_medal_info) do
    local tmpId = v.medal_id
    local medalItem = self.items[tmpId]
    medalItem = medalItem or UIMedalItemData:New()
    medalItem:Init(v)
    self.items[tmpId] = medalItem
    if not visit and medalItem:IsNew() then
      self.newItemsId[tmpId] = medalItem:GetPstId()
    end
  end
end

function UIMedalListData:GetFilterIds()
  return self.filterIds
end

function UIMedalListData:GetFilterInfoById(filter)
  local r = {}
  r.ID = filter
  local tab = Cfg.cfg_item_medal_tab[filter]
  if tab then
    r.Name = tab.Name
    r.Icon = tab.Icon
  else
    r.Name = "str_medal_all"
    r.Icon = "N22_xzzl_icon01"
  end
  return r
end

function UIMedalListData:GetItemsByFilter(filter)
  if filter == 0 then
    self.allMedalCount = 0
    self.receiveMedalCount = 0
  end
  local list = {}
  for k, v in pairs(self.items) do
    local tmpl = v:GetTempl()
    if tmpl and (filter == 0 or filter == tmpl.Tab) then
      if not v:IsReceive() then
        if tmpl.IsShow then
          table.insert(list, v)
          if filter == 0 then
            self.allMedalCount = self.allMedalCount + 1
          end
        end
      else
        table.insert(list, v)
        if filter == 0 then
          self.allMedalCount = self.allMedalCount + 1
          self.receiveMedalCount = self.receiveMedalCount + 1
        end
      end
    end
  end
  self:_Sort(list)
  return list
end

function UIMedalListData:_Sort(list)
  table.sort(list, function(a, b)
    local aNew = a:IsNew()
    local bNew = b:IsNew()
    if aNew ~= bNew then
      return aNew
    end
    local aReceived = a:IsReceive()
    local bReceived = b:IsReceive()
    if aReceived ~= bReceived then
      return aReceived
    end
    local cfgItemA = a:GetTemplateItem()
    local cfgItemB = b:GetTemplateItem()
    local orderA = cfgItemA.BagSortIndex
    local orderB = cfgItemB.BagSortIndex
    if orderA ~= orderB then
      return orderA > orderB
    end
    local colorA = cfgItemA.Color
    local colorB = cfgItemB.Color
    if colorA ~= colorB then
      return colorA > colorB
    end
    return cfgItemA.ID < cfgItemB.ID
  end)
end

function UIMedalListData:IsNew()
  if self.visit then
    return false
  end
  for k, v in pairs(self.newItemsId) do
    if v then
      return true
    end
  end
  return false
end

function UIMedalListData:IsFilterNew(filter)
  if self.visit or filter == 0 then
    return false
  end
  for k, v in pairs(self.newItemsId) do
    if v then
      local item = self.items[k]
      if item:GetTempl().Tab == filter then
        return true
      end
    end
  end
  return false
end

function UIMedalListData:SetUnNew(id)
  if self.newItemsId[id] then
    self.newItemsId[id] = nil
  end
end

function UIMedalListData:GetAllNewPstId()
  local r = {}
  for k, v in pairs(self.newItemsId) do
    if v then
      table.insert(r, v)
    end
  end
  return r
end
