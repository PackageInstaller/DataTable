local UIItemPool = class("UIItemPool")

function UIItemPool:ctor(uiClass, uiPrefab, prefabActive)
  self.uiClass = uiClass
  self.uiPrefab = uiPrefab
  self.listItem = {}
  self.poolItem = {}
  if prefabActive ~= nil then
    uiPrefab:SetActive(prefabActive)
  end
end

function UIItemPool:HideAll()
  while #self.listItem > 0 do
    local item = table.remove(self.listItem, #self.listItem)
    item:Hide()
    if self.__hideName ~= nil then
      item.gameObject.name = tostring(self.__hideName)
    end
    table.insert(self.poolItem, item)
  end
end

function UIItemPool:HideOne(item)
  item:Hide()
  table.removebyvalue(self.listItem, item, false)
  table.insert(self.poolItem, item)
end

function UIItemPool:GetOne(isShow)
  isShow = isShow == nil and true or isShow
  if #self.poolItem > 0 then
    local item = table.remove(self.poolItem, #self.poolItem)
    if isShow then
      item:Show()
    end
    item.transform:SetAsLastSibling()
    table.insert(self.listItem, item)
    return item
  else
    local item = self.uiClass.New()
    local go = self.uiPrefab:Instantiate()
    if isShow then
      go:SetActive(true)
    end
    item:Init(go)
    table.insert(self.listItem, item)
    return item
  end
end

function UIItemPool:DeleteAll()
  self:HideAll()
  for k, v in ipairs(self.poolItem) do
    v:Delete()
  end
  self.poolItem = {}
end

function UIItemPool:SetItemPoolHideName(name)
  self.__hideName = name
end

return UIItemPool
