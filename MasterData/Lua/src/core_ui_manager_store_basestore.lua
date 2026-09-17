local base = {}
local tag = "baseStore"

function base.importPartialClass(cls, partCls)
  table.merge(cls, partCls)
  partCls.super = cls.super
end

function base:_wrapState(mapedStates, state)
  local mt = {}
  if state == nil then
    return setmetatable({}, mt)
  end
  mt._handlers = {}
  mt._values = {}
  mt._tables = {}
  mt._tableHandlers = {}
  mt._arrays = {}
  mt._arrayHandlers = {}
  mt.self = self
  
  local function _setValue(t, key, v)
    local m = mapedStates[key]
    if m then
      for i = 1, #m do
        local mk = m[i]
        if mk then
          mk(t, v)
        end
      end
    end
  end
  
  local function _setArray(key, value)
    local arr = {}
    for i, v in ipairs(value) do
      table.insert(arr, v)
    end
    
    function arr.insert(value)
      table.insert(mt._arrays[key], value)
      local m = mapedStates[key .. "_insert"]
      if m then
        for i = 1, #m do
          local mk = m[i]
          if mk then
            mk(mt._arrays[key], value)
          end
        end
      end
    end
    
    function arr.change(index, changeValue)
      if type(changeValue) == "table" then
        for i, v in pairs(changeValue) do
          mt._arrays[key][index][i] = v
        end
      else
        mt._arrays[key][index] = changeValue
      end
      local m = mapedStates[key .. "_change"]
      if m then
        for i = 1, #m do
          local mk = m[i]
          if mk then
            mk(mt._arrays[key], index, changeValue)
          end
        end
      end
    end
    
    function arr.remove(v)
      if v > #arr then
        errorf("remove dont has this index in array: " .. v)
        return
      end
      local vx = mt._arrays[key][v]
      table.remove(mt._arrays[key], v)
      local m = mapedStates[key .. "_remove"]
      if m then
        for i = 1, #m do
          local mk = m[i]
          if mk then
            mk(mt._arrays[key], v, vx)
          end
        end
      end
    end
    
    function arr.clear()
      for i = 1, #mt._arrays[key] do
        table.remove(mt._arrays[key], 1)
      end
      local m = mapedStates[key .. "_clear"]
      if m then
        for i = 1, #m do
          local mk = m[i]
          if mk then
            mk(mt._arrays[key])
          end
        end
      end
    end
    
    function arr.sort(sortKey, order)
      local array = mt._arrays[key]
      for i = 1, #array do
        for j = 1, #array - i do
          if order == "DESC" and array[j][sortKey] < array[j + 1][sortKey] or order == "ASC" and array[j][sortKey] > array[j + 1][sortKey] then
            local tmp = array[j + 1]
            array[j + 1] = array[j]
            array[j] = tmp
          end
        end
      end
      local m = mapedStates[key .. "_sort"]
      if m then
        for i = 1, #m do
          local mk = m[i]
          if mk then
            mk(mt._arrays[key], sortKey, order)
          end
        end
      end
    end
    
    mt._arrays[key] = arr
  end
  
  for key, value in pairs(state) do
    if type(value) == "table" then
      local type = "table"
      if value.type then
        type = value.type
      end
      if 0 < #value then
        type = "array"
      end
      if type == "table" then
        mapedStates[key] = mapedStates[key] or {}
        mt._tables[key] = mt.self:_wrapState(mapedStates[key], value)
        mt._tableHandlers[key] = function(v)
          local old = mt._tables[key]
          mapedStates[key] = mapedStates[key] or {}
          mt._tables[key] = mt.self:_wrapState(mapedStates[key], v)
          _setValue(old, key, v)
        end
      elseif type == "array" then
        _setArray(key, value)
        mt._arrayHandlers[key] = function(v)
          local old = mt._arrays[key]
          _setArray(key, v)
          _setValue(old, key, v)
        end
      end
    else
      mt._values[key] = value
      mt._handlers[key] = function(v)
        local old = mt._values[key]
        mt._values[key] = v
        _setValue(old, key, v)
      end
    end
  end
  
  function mt.__index(t, k)
    local result = mt._values[k]
    if result ~= nil then
      return result
    end
    result = mt._tables[k]
    if result ~= nil then
      return result
    end
    result = mt._arrays[k]
    if result ~= nil then
      return result
    else
      errorf("dont has this key :" .. k)
    end
  end
  
  function mt.__newindex(t, k, v)
    if type(v) == "table" then
      if mt._tableHandlers[k] then
        mt._tableHandlers[k](v)
      elseif mt._arrayHandlers[k] then
        mt._arrayHandlers[k](v)
      else
        errorf("dont has this key in table:" .. k)
      end
    else
      local h = mt._handlers[k]
      if h then
        return h(v)
      else
        mt._values[k] = v
        mt._handlers[k] = function(v)
          local old = mt._values[k]
          mt._values[k] = v
          _setValue(old, k, v)
        end
        _setValue(nil, k, v)
      end
    end
  end
  
  local s = {}
  s.mt = mt
  return setmetatable(s, mt)
end

function base:ctor()
  self._eventCenter = require("core.event").new()
  self:init()
end

function base:init()
  if self.state then
    self.mapedStates = {}
    self.callback = {}
    if self.souStateFunc then
      self.state = self.souStateFunc()
    else
      self.souStateFunc = self.state
      self.state = self.state()
    end
    self.state = self:_wrapState(self.mapedStates, self.state)
  end
end

function base:clear()
  self:init()
end

function base:_toMapState(mapedStates, maps)
  if not mapedStates then
    return
  end
  if type(maps) == "table" then
    for k, v in pairs(maps) do
      mapedStates[k] = mapedStates[k] or {}
      self:_toMapState(mapedStates[k], v)
    end
  elseif type(maps) == "function" then
    table.insert(mapedStates, 1, maps)
  else
    errorf("mapStates error map target must table or function: ")
  end
end

function base:_toUnmapState(mapedStates, maps)
  if not mapedStates or not maps then
    return
  end
  if type(maps) == "table" then
    for i, v in pairs(maps) do
      mapedStates[i] = mapedStates[i] or {}
      self:_toUnmapState(mapedStates[i], v)
    end
  elseif type(maps) == "function" then
    for i = 1, #mapedStates do
      if mapedStates[i] == maps then
        table.remove(mapedStates, i)
        break
      end
    end
  else
    errorf("mapStates error map target must table or function: ")
  end
end

function base:mapDatas(maps)
  self:_toMapState(self.mapedStates, maps)
end

function base:unmapDatas(maps)
  self:_toUnmapState(self.mapedStates, maps)
end

function base:call(eventName, ...)
  self._eventCenter:send(eventName, ...)
end

function base:listenCallFunc(eventName, method, ...)
  self._eventCenter:register(eventName, method, ...)
end

function base:listenCallMaps(map, ...)
  for eventName, method in pairs(map) do
    self:listenCallFunc(eventName, method, ...)
  end
end

function base:unListenCallFunc(eventName, method, ...)
  self._eventCenter:unRegister(eventName, method, ...)
end

function base:unListenAll(register)
  self._eventCenter:unRegisterAll(register)
end

function base:unListenCallMaps(map)
  for eventName, method in pairs(map) do
    self:unListenCallFunc(eventName, method)
  end
end

return base
