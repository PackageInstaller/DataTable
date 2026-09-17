local this = class("cellFiltrateItem", G_UIModuleBase)

function this.bind()
  return {
    title = "",
    professionItemList = {
      moduleName = "modulePages/filtrate/cellFiltrateInfoItem"
    }
  }
end

function this:refresh()
  self.bind.professionItemList:clear()
  local tempData = {}
  for i, v in ipairs(self.bind.data) do
    local node, index = table.ipairsFind(self.bind.param or {}, function(value)
      return value == v.value
    end)
    table.insert(tempData, {
      name1 = v.txt_name,
      name2 = v.txt_name,
      id = v.value,
      pitchOn = index ~= nil
    })
  end
  self.bind.professionItemList:insert_array(tempData)
end

function this:filtrateCondition()
  self.professionData = {}
  for k = 1, #self.bind.professionItemList do
    if self.bind.professionItemList:getValue(k, "pitchOn") then
      table.insert(self.professionData, self.bind.professionItemList:getValue(k, "id"))
    end
  end
  return self.professionData
end

function this:filtrateReset()
  for k = 1, #self.bind.professionItemList do
    if self.bind.professionItemList:getValue(k, "pitchOn") then
      self.bind.professionItemList:change(k, {pitchOn = false})
    end
  end
end

return this
