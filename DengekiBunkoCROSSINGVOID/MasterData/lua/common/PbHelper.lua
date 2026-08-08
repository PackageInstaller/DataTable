local GC = require("Internal/gc")
local dochunk = require("Internal/do_chunk")
local pb = require("pb")
local __cache = {}
local __data_root
__data_root = "Xlsx/"

local function load_server(table_name)
  local raw = {}
  local indexed = {}
  local resTable = GetResTable(table_name)
  for i = 1, #resTable.res do
    raw[i] = pb.decode(resTable.type, resTable.res[i])
    local keys = {}
    for j = 1, #resTable.keys do
      keys[j] = raw[i][resTable.keys[j]]
    end
    
    local function set_value(container, keys, index, value)
      local key = keys[index]
      if #keys == index then
        container[key] = value
      else
        if container[key] == nil then
          container[key] = {}
        end
        set_value(container[key], keys, index + 1, value)
      end
    end
    
    set_value(indexed, keys, 1, i)
  end
  return {raw, indexed}
end

local function load(table_name)
  local data = __cache[table_name]
  if data == nil then
    data = dochunk(__data_root .. table_name)
    __cache[table_name] = data
  end
  return table.unpack(data)
end

local function resolve_index(indexed, keys)
  if 0 < #keys then
    local iter = indexed
    for i = 1, #keys do
      if iter ~= nil then
        iter = iter[keys[i]]
      else
        break
      end
    end
    return iter
  end
end

local function create_enum(enum_name)
  local enum_table = {}
  local full_enum_name = "." .. enum_name
  local prefixes = {
    enum_name .. "_",
    enum_name
  }
  enum_table = setmetatable({}, {
    __index = function(this, key)
      local value = pb.enum(full_enum_name, key)
      if value == nil then
        for i = 1, #prefixes do
          local prefix = prefixes[i]
          value = pb.enum(full_enum_name, prefix .. key)
          if value ~= nil then
            break
          end
        end
      end
      rawset(this, key, value)
      return value
    end,
    __pairs = function(this)
      local fields = rawget(this, "__enum_fields")
      if fields == nil then
        fields = {}
        for key, value, _ in pb.fields(full_enum_name) do
          fields[key] = value
        end
        rawset(this, "__enum_fields", fields)
      end
      return next, fields, nil
    end
  })
  enum_table.__keys = setmetatable({}, {
    __index = function(this, value)
      local key = pb.enum(full_enum_name, value)
      if key ~= nil then
        for i = 1, #prefixes do
          local prefix = prefixes[i]
          if key:starts(prefix) then
            key = key:sub(prefix:len() + 1)
            break
          end
        end
      end
      rawset(this, value, key)
      return key
    end
  })
  return enum_table
end

local PBH = {}

function PBH.get(table_name, ...)
  local raw, indexed = load(table_name)
  local index = resolve_index(indexed, {
    ...
  })
  if index ~= nil then
    return raw[index]
  end
end

function PBH.index(table_name, index)
  local raw, indexed = load(table_name)
  return raw[index]
end

function PBH.all(table_name)
  local raw, indexed = load(table_name)
  return _ENV["!"](raw)
end

function PBH.unload_all()
  __cache = {}
end

PBH.enum = setmetatable({}, {
  __index = function(this, enum_name)
    local enum_table = create_enum(enum_name)
    rawset(this, enum_name, enum_table)
    return enum_table
  end
})
GC:subscribe(PBH.unload_all)
return PBH
