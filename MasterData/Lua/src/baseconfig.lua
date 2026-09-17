local configLine = require("configLine")
local baseConfig = class("baseConfig")

function baseConfig:ctor(name)
  self.name = name
  self.lineGroup = {}
  self.keys = {}
  self.keyMap = {}
end

function baseConfig:getValue(id, key)
  if id == nil or TableIsNull(self.indexMap) or self.indexMap[key] == nil then
    return
  end
  local line = self:getLine(id)
  if line then
    return line[key]
  end
end

function baseConfig:getLine(id)
  if string.isEmpty(id) then
    return
  end
  if self.lineGroup == nil then
    self.lineGroup = {}
  end
  if self.lineGroup[id] then
    return self.lineGroup[id]
  end
  local valid = self:checkIdValid(id)
  if not valid then
    return
  end
  local offset = self:getLineOffset(id)
  if offset and offset ~= 0 then
    local line = configLine.new(offset)
    
    local function buildLine()
      return setmetatable({_LineObj = true}, {
        __index = function(t, k)
          local keyIndex = self.indexMap[k]
          if keyIndex then
            local cache = line:getData(keyIndex)
            if cache then
              return cache
            end
            local handler = self.keyToMethodsMap[k]
            if handler then
              local success, result = pcall(handler, self, line.offset)
              if success then
                local val = result
                line:setData(keyIndex, val)
                return val
              else
                errorf(string.format("[ConfigError]-[LuaTable] <color=yellow>[%s]</color> 的 <color=green>[%s]</color> 字段解析失败，请检查配置或是否支持该字段的解析!", self.name, k))
              end
            else
              errorf(string.format("[ConfigError]-[LuaTable] <color=yellow>[%s]</color> 的 <color=green>[%s]</color> 字段解析失败，没有对应的解析函数，检查配置生成!", self.name, k))
            end
          else
            return line[k]
          end
        end,
        __pairs = function(t, k)
          local nk, keyIndex
          return function()
            nk, keyIndex = next(self.indexMap, nk)
            if nk and keyIndex then
              local val = line:getData(keyIndex)
              if nil == val then
                local handler = self.keyToMethodsMap[nk]
                if handler then
                  local success, result = pcall(handler, self, line.offset)
                  if success then
                    val = result
                    line:setData(keyIndex, val)
                  else
                    errorf(string.format("[ConfigError]-[LuaTable] <color=yellow>[%s]</color> 的 <color=green>[%s]</color> 字段解析失败，请检查配置或是否支持该字段的解析!", self.name, k))
                  end
                end
              end
              return nk, val
            end
          end, t, nil
        end,
        __len = function(t)
          if self.indexMap then
            return table.count(self.indexMap)
          else
            return 0
          end
        end
      })
    end
    
    self.lineGroup[id] = buildLine()
    return self.lineGroup[id]
  else
    printf(string.format("[ConfigError]-[LuaTable] <color=yellow>[%s]</color> 的主键为 <color=green>[%s]</color> 的行访问失败! 先检查是否存在该行!", self.name, id))
  end
end

function baseConfig:checkIdValid(id)
  self:initAllKeys()
  if table.isEmpty(self.keyMap) then
    return false
  end
  return self.keyMap[id]
end

function baseConfig:clearCache()
  if TableIsNull(self.lineGroup) then
    return
  end
  for k, v in pairs(self.lineGroup) do
    v:clearData()
  end
end

function baseConfig:initAllKeys()
  if not table.isEmpty(self.keys) or not table.isEmpty(self.keyMap) then
    return
  end
  local enumerator = self:getKeys()
  if not L_CommonUtil.isValid(enumerator) then
    return
  end
  self.keys = {}
  self.keyMap = {}
  local index = 1
  while enumerator:MoveNext() do
    local key = enumerator.Current
    self.keys[index] = key
    self.keyMap[key] = true
    index = index + 1
  end
end

function baseConfig.__pairs(t)
  t:initAllKeys()
  if table.isEmpty(t.keys) then
    return
  end
  local index = 0
  return function()
    index = index + 1
    local key = t.keys[index]
    if key then
      return key, t.getLine(t, key)
    end
  end, t, nil
end

return baseConfig
