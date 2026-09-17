local this = {}

function this:init()
  this.super.init(self)
  self.data = {
    photoDic = {},
    cache = {},
    templateDic = {},
    isGrid = false
  }
  self:injectCache()
end

function this:getPhotoData(name)
  if self.data.photoDic[name] ~= nil then
    self:createTexWithName(name)
  end
  return self.data.photoDic[name]
end

function this:getCache(id)
  return self.data.cache[id]
end

function this:getTemplateData(type, id, notCreate)
  if not type or not id then
    return
  end
  local key = string.format("%s_%s", type, id)
  local data = self.data.templateDic[key]
  if not data and not notCreate then
    data = self:createPhotoTemplateData(type, id)
  end
  return data
end

function this:removeTemplateData(type, id, ignore)
  local key = string.format("%s_%s", type, id)
  local data = self.data.templateDic[key]
  self.data.templateDic[key] = nil
  if data.type == L_Const.photoTemplateDataType.custom and not ignore then
    self:req_deleteTemplate(id)
  end
  return data ~= nil
end

function this:getCustomTempCount()
  local count = 0
  for _, data in pairs(self.data.templateDic) do
    if data.type == L_Const.photoTemplateDataType.custom then
      count = count + 1
    end
  end
  return count
end

function this:checkCustomTempIsMax()
  local count = self:getCustomTempCount()
  return count >= self.canAddTempMaxVal
end

function this:getAutoCustomTempId()
  local maxId = 0
  local haveCustomData = false
  for _, data in pairs(self.data.templateDic) do
    if data.type == L_Const.photoTemplateDataType.custom then
      maxId = math.max(maxId, data.id)
      haveCustomData = true
    end
  end
  return maxId + 1 + (haveCustomData and 0 or 1000)
end

function this:getCustomTempList()
  local list = {}
  local count = 0
  printf("getCustomTempList:%s", self.data.templateDic)
  for _, data in pairs(self.data.templateDic) do
    if data.type == L_Const.photoTemplateDataType.custom then
      count = count + 1
      table.insert(list, data)
    end
  end
  if 1 < count then
    table.sort(list, function(a, b)
      return a.id < b.id
    end)
  end
  return list
end

function this:clearTemplateData()
  table.clear(self.data.templateDic)
end

return this
