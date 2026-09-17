local configLine = class("configLine")

function configLine:getData(index)
  if TableIsNull(self.dataCache) then
    return
  end
  return self.dataCache[index]
end

function configLine:setData(index, value)
  if index ~= nil and value ~= nil then
    self.dataCache[index] = value
  end
end

function configLine:ctor(offset)
  self.offset = offset
  self.dataCache = {}
end

function configLine:clearData()
  self.dataCache = {}
end

return configLine
