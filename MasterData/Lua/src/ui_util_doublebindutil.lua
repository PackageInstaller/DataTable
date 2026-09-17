local this = {}
local dbMetatable = {}

function dbMetatable:__index(k)
  local v = self._table[k]
  if v == nil then
    v = getmetatable(self)[k]
  end
  return v
end

function dbMetatable:__newindex(k, v)
  local old = self[k]
  if old ~= v then
    local tp = type(v)
    if tp == "function" then
      rawset(self, k, v)
    else
      if tp == "table" then
        this.wrapTab(v)
      end
      self._table[k] = v
      local list = self._handler[k]
      if list then
        for _, method in ipairs(list) do
          method(v, old)
        end
      end
    end
  end
end

local function _pairsHandle(t, k)
  local nk, nv = next(t._table, k)
  return nk, nv
end

local function _ipairsHandle(t, k)
  local nk, nv = next(t._table, k)
  return nk, nv
end

function dbMetatable:__pairs(k)
  return _pairsHandle, self, nil
end

function dbMetatable:__ipairs(k)
  return _ipairsHandle, self, nil
end

function dbMetatable:__len()
  return #self._table
end

function dbMetatable:invokeAll()
  for k, list in pairs(self._handler) do
    for _, v in ipairs(list) do
      v(self[k])
    end
  end
end

function dbMetatable:addHandlers(tab)
  for k, v in pairs(tab) do
    self:addHandler(k, v)
  end
end

function dbMetatable:addHandler(k, v)
  local list = self._handler[k]
  if list then
    table.insert(list, v)
  else
    self._handler[k] = {v}
  end
end

function dbMetatable:removeHandlers(tab)
  for k, v in pairs(tab) do
    self:removeHandler(k, v)
  end
end

function dbMetatable:removeHandler(k, v)
  local list = self._handler[k]
  if list then
    for index, ele in ipairs(list) do
      if ele == v then
        table.remove(list, index)
        break
      end
    end
  end
end

function dbMetatable:clearHandlers()
  self._handler = {}
end

function this.wrapTab(tab)
  local mb = getmetatable(tab)
  if mb then
    return
  end
  local _table = {}
  for k, v in pairs(tab) do
    local tp = type(v)
    if tp ~= "function" then
      if tp == "table" then
        this.wrapTab(tab)
      end
      _table[k] = v
      tab[k] = nil
    end
  end
  tab._table = _table
  tab._handler = {}
  setmetatable(tab, dbMetatable)
end

function this.createCls(name)
  local cls = table.merge({}, dbMetatable)
  cls.__name = name
  
  function cls.new()
    local ins = {
      _handler = {},
      _table = {}
    }
    setmetatable(ins, cls)
    if ins.ctor then
      ins:ctor()
    end
    return ins
  end
  
  return cls
end

function this.createTab()
  local ins = {
    _handler = {},
    _table = {}
  }
  setmetatable(ins, dbMetatable)
  return ins
end

return this
