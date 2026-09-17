local this = class("petPixelTagTpl")

function this:init(config)
  self.data = {}
  self.sortList = {}
  for _, tpl in pairs(config) do
    if not self.sortList[tpl.tagPos] then
      self.sortList[tpl.tagPos] = {}
    end
    self.data[tpl.id] = tpl
    table.insert(self.sortList[tpl.tagPos], tpl.id)
  end
  for _, tagList in pairs(self.sortList) do
    table.sort(tagList, function(a, b)
      return self.data[a].tagPriority > self.data[b].tagPriority
    end)
  end
end

function this:getTagInfo()
  return self.data
end

function this:getTagTpl(tagId)
  return self.data[tagId]
end

function this:getTagSortList(pos)
  return self.sortList[pos]
end

return this
