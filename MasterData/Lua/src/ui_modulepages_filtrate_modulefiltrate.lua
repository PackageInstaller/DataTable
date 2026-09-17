local page = class("moduleFiltrate", G_UIModuleBase)

function page.bind()
  return {
    filtrateItemList = {
      moduleName = "modulePages/filtrate/cellFiltrateItem"
    }
  }
end

function page.methods()
  return {
    closeOnClick = function(self)
      self.closeModule()
    end,
    affirmOnClick = function(self)
      self:filtrateCondition()
      self.filterFunc(self.param)
      self.closeModule()
    end,
    resetOnClick = function(self)
      for i = 1, #self.bind.filtrateItemList do
        self.bind.filtrateItemList:getItemCls(i):filtrateReset()
      end
      self.filterFunc(self.param)
    end
  }
end

function page:initModule(option)
  self.closeModule = option.closeCurModule
  self.filterFunc = option.filterFunc
  self.filterListData = option.filterListData
  self.param = {}
  self:refreshList()
  self:refreshListParam(option.param)
end

function page:refreshList()
  self.bind.filtrateItemList:clear()
  local tempData = {}
  for k, v in pairs(self.filterListData) do
    table.insert(tempData, {
      title = v.txt_title,
      type = v.type,
      data = v.list,
      multiple = v.multiple
    })
  end
  self.bind.filtrateItemList:insert_array(tempData)
end

function page:filtrateCondition()
  self.param = {}
  for i = 1, #self.bind.filtrateItemList do
    local data = self.bind.filtrateItemList:getItemCls(i):filtrateCondition()
    if not table.isEmpty(data) then
      self.param[self.bind.filtrateItemList:getValue(i, "type")] = data
    end
  end
end

function page:refreshListParam(data)
  data = data or {}
  for i = 1, #self.bind.filtrateItemList do
    local param = data[self.bind.filtrateItemList:getValue(i, "type")]
    self.bind.filtrateItemList:change(i, {param = param})
  end
end

return page
