CHECK_MEMBERS1 = {}
CHECK_MEMBERS2 = {}
for i = 0, 1000 do
  CHECK_MEMBERS1[tostring(i)] = i
end
for i = 0, 100 do
  CHECK_MEMBERS2[tostring(i)] = i / 10
end
local config = {}
local CsvManager = class("CsvManager")

function CsvManager:ctor()
  self._sharedata = {}
  self:startCheckThread()
end

function CsvManager:load(fileName)
  if not self._sharedata[fileName] then
    self:_load(fileName)
  end
  return self._sharedata[fileName]
end

function CsvManager:_load(fileName)
  local csvData = require(fileName)
  if not csvData then
    printError("csvdata not found " .. fileName)
    return
  end
  if not config[fileName] then
    self._sharedata[fileName] = csvData
    return
  end
  local content = self:getTable()
  if self:doubleKey(csvData) then
    for key1, t1 in pairs(csvData) do
      local _t1 = self:getTable()
      for key2, t2 in pairs(t1) do
        local _t2 = self:getTable()
        for k, v in pairs(t2 or {}) do
          _t2[k] = v
        end
        _t1[key2] = _t2
      end
      content[key1] = _t1
    end
  else
    for key1, t1 in pairs(csvData) do
      local _t = self:getTable()
      for k, v in pairs(t1 or {}) do
        _t[k] = v
      end
      content[key1] = _t
    end
  end
  self._sharedata[fileName] = content
end

function CsvManager:doubleKey(csvData)
  for key1, t1 in pairs(csvData) do
    for key2, t2 in pairs(t1 or {}) do
      return type(t2) == "table"
    end
    return false
  end
  return false
end

function CsvManager:getTable()
  local content = {}
  setmetatable(content, {
    __index = function(t, key)
      if rawget(t, key) then
        return rawget(t, key)
      end
      local v = rawget(t, key .. "__ed")
      if v then
        return MemDecrypt(v)
      else
        return rawget(t, key)
      end
    end,
    __newindex = function(t, key, value)
      if type(value) == "number" then
        rawset(t, key .. "__ed", MemEncrypt(value))
      else
        rawset(t, key, value)
      end
    end
  })
  return content
end

function CsvManager:startCheckThread()
  self.checkHandler = scheduler.scheduleGlobal(function()
    pcall(function()
      local ret = self:checkMembers()
      if ret then
        sharedDirector:endToLua()
      end
    end)
  end, 100)
end

function CsvManager:checkMembers()
  for key, value in pairs(CHECK_MEMBERS1) do
    if key ~= tostring(value) then
      return true
    end
  end
  for key, value in pairs(CHECK_MEMBERS2) do
    if key ~= tostring(value * 10) then
      return true
    end
  end
end

return CsvManager
