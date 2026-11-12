local cacheTable = {}

local function GetCache(name)
  if name == nil then
    traceback("获取缓存数据时, name 参数不能为空！！！")
    return
  end
  if cacheTable[name] == nil then
    cacheTable[name] = {}
  end
  return cacheTable[name]
end

local function SetCache(name, tb)
  if name == nil then
    traceback("写入缓存数据时, name 参数不能为空！！！")
    return
  end
  cacheTable[name] = tb
end

local function GetCacheData(name, key)
  if key == nil then
    traceback("获取缓存数据时, key 参数不能为空！！！")
    return
  end
  local tb = GetCache(name)
  if tb == nil then
    return
  end
  return tb[key]
end

local function SetCacheData(name, key, data)
  if name == nil then
    traceback("写入缓存数据时, name 参数不能为空！！！")
    return
  end
  if key == nil then
    traceback("写入缓存数据时, key 参数不能为空！！！")
    return
  end
  local tb = GetCache(name)
  tb[key] = data
end

local function SetCacheField(name, key, field, data)
  if name == nil then
    traceback("写入缓存数据时, name 参数不能为空！！！")
    return
  end
  if key == nil then
    traceback("写入缓存数据时, key 参数不能为空！！！")
    return
  end
  if field == nil then
    traceback("写入缓存数据时, field 参数不能为空！！！")
    return
  end
  local tb = GetCache(name)
  if tb == nil then
    return
  end
  if tb[key] == nil then
    tb[key] = {}
  end
  tb[key][field] = data
end

local function InsertCacheData(name, key, data)
  if name == nil then
    traceback("写入缓存数据时, name 参数不能为空！！！")
    return
  end
  if key == nil then
    traceback("写入缓存数据时, key 参数不能为空！！！")
    return
  end
  local tb = GetCache(name)
  if tb == nil then
    return
  end
  if tb[key] == nil then
    tb[key] = {}
  end
  table.insert(tb[key], data)
end

_G.CacheTable = {
  Get = GetCache,
  Set = SetCache,
  GetData = GetCacheData,
  SetData = SetCacheData,
  SetField = SetCacheField,
  InsertData = InsertCacheData
}
