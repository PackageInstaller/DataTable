function table:isempty()
  return next(self) == nil
end

function table:next(index)
  local mt = getmetatable(self)
  if mt and mt.__next then
    do return mt.__next, next, self end
    return mt.__next, next, self, index
  end
  do return next, self end
  return next, self, index, index
end

function table:keys()
  local keys = {}
  for k, _ in pairs(self) do
    table.insert(keys, k)
  end
  return keys
end

function table:values()
  local values = {}
  for _, v in pairs(self) do
    table.insert(values, v)
  end
  return values
end

function table:indexof(value)
  for i, v in ipairs(self) do
    if v == value then
      return i
    end
  end
end

function table:length()
  local count = 0
  for _, _ in pairs(self) do
    count = count + 1
  end
  return count
end

function table:pop(key)
  local v
  if nil == key then
    local index
    index, v = next(self)
    table.remove(self, index)
    return v
  end
  v = self[key]
  self[key] = nil
  return v
end

function table:append(lst)
  for _, v in pairs(lst) do
    table.insert(self, v)
  end
end

function table:merge(lst)
  for k, v in pairs(lst) do
    local exist = self[k]
    if exist then
      if type(exist) == "table" and type(v) == "table" then
        table.merge(exist, v)
      end
    else
      self[k] = v
    end
  end
  return self
end

function table:mergeTable(lst)
  for k, v in pairs(lst) do
    if type(v) ~= type(self[k]) then
      self[k] = v
    elseif type(v) == "table" then
      self[k] = table.mergeTable(self[k], v)
    else
      self[k] = v
    end
  end
  return self
end

function table:reverse()
  local l = 1
  local r = #self
  while l < r do
    self[l], self[r] = self[r], self[l]
    l = l + 1
    r = r - 1
  end
end

function table:mergeArray(array)
  for _, value in ipairs(array) do
    table.insert(self, value)
  end
end

function table:hasCross(array)
  local ret = false
  if type(array) == "table" then
    for _, value in pairs(array) do
      if table.contains(self, value) then
        ret = true
        break
      end
    end
  else
    ret = table.contains(self, array)
  end
  return ret
end

function table:find(value, key)
  local ret = {}
  for k, v in pairs(self) do
    if type(v) == "table" then
      if key and v[key] == value then
        table.insert(ret, v)
      end
    elseif v == value then
      table.insert(ret, v)
    end
  end
  return ret
end

function table:contains(value, key)
  for k, v in pairs(self) do
    if type(v) == "table" and key then
      if v[key] == value then
        return true
      end
    elseif v == value then
      return true
    end
  end
  return false
end

function table:findvalue(value, key)
  for k, v in pairs(self) do
    if type(v) == "table" and key then
      if v[key] == value then
        return k
      end
    elseif v == value then
      return k
    end
  end
  return nil
end

function table:findvaluef(fn)
  for k, v in pairs(self) do
    if fn(v) then
      return k
    end
  end
  return nil
end

function table:delete(value, key)
  local cmpFunc
  if type(value) == "function" then
    cmpFunc = value
  end
  local dels = {}
  for k, v in pairs(self) do
    local remove = false
    if cmpFunc then
      remove = cmpFunc(v)
    else
      remove = key and v[key] == value or v == value
    end
    if remove then
      table.insert(dels, k)
    end
  end
  for _, v in pairs(dels) do
    self[v] = nil
  end
  return #dels
end

function table:adelete(value, key, noCmpFunc)
  if nil == value then
    return
  end
  local ret = 0
  local cmpFunc
  if not noCmpFunc and type(value) == "function" then
    cmpFunc = value
  end
  local i = 1
  while i <= #self do
    local remove = false
    if cmpFunc then
      remove = cmpFunc(self[i])
    else
      remove = key and self[i][key] == value or self[i] == value
    end
    if remove then
      table.remove(self, i)
      ret = ret + 1
    else
      i = i + 1
    end
  end
  return ret
end

function table:update(tbl)
  for k, v in pairs(tbl) do
    self[k] = v
  end
end

function table:sum()
  local sum = 0
  for _, v in pairs(self) do
    sum = sum + v
  end
  return sum
end

function table:getwc(key, default)
  local value = self[key]
  if nil == self[key] then
    value = default or {}
    self[key] = value
  end
  return value
end

function table:deepclone()
  local function copy_table(t)
    if type(t) ~= "table" then
      return t
    end
    local res = {}
    for k, v in pairs(t) do
      if type(v) == "table" then
        res[k] = copy_table(v)
      else
        res[k] = v
      end
    end
    return res
  end
  
  do return copy_table end
  return copy_table, self
end

function table:condclone()
  if getmetatable(self) then
    do return table.deepclone end
    return table.deepclone, self
  end
  return self
end

function table:deepclone()
  local function copy_table(t)
    if type(t) ~= "table" then
      return t
    end
    local res = {}
    for k, v in pairs(t) do
      if type(v) == "table" then
        res[k] = copy_table(v)
      else
        res[k] = v
      end
    end
    return res
  end
  
  do return copy_table end
  return copy_table, self
end

function table.arrayCopy(from, sourceIndex, to, targetIndex, len)
  local sourceLen = #from
  if len > sourceLen then
    error("not enough length")
  end
  for i = sourceIndex, len do
    to[targetIndex] = table.deepclone(from[i])
    local mt = getmetatable(from[i])
    setmetatable(to[targetIndex], mt)
    targetIndex = targetIndex + 1
  end
end

function table:clone()
  local ret = {}
  for k, v in pairs(self) do
    ret[k] = v
  end
  return ret
end

function table:cloneDT()
  local ret = {}
  for k, v in pairs(self) do
    ret[k] = v
  end
  local mt = getmetatable(self)
  if mt then
    setmetatable(ret, mt)
  end
  return ret
end

function table.clear(t)
  if type(t) == "table" then
    for k, v in pairs(t) do
      t[k] = nil
    end
  end
end

function table.mergeWithoutGc(dest, src)
  for k, v in pairs(src) do
    dest[k] = v
  end
end

function table:random()
  return self[math.random(1, #self)]
end

function table:randomEx()
  local ret = {}
  for k, _ in pairs(self) do
    table.insert(ret, k)
  end
  local key = ret[math.random(1, #ret)]
  ret = nil
  return self[key], key
end

function table:tostring(printLayer, crlf, dSpace, isUnLimit)
  if CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.WindowsEditor then
    return ""
  end
  local curItemNum = 0
  local maxItemNum = 300
  local isExceedMax = false
  crlf = crlf or "\n"
  local max_print_layer = tonumber(printLayer) or 3
  local outStrList = {}
  local objDic = {}
  local dSpaceStr = dSpace or "    "
  
  local function serialize(obj, spaceStr, layer)
    spaceStr = spaceStr or ""
    if isExceedMax then
      return
    end
    curItemNum = curItemNum + 1
    if not isUnLimit and curItemNum >= maxItemNum then
      isExceedMax = true
      Logger.Warn("【错误】table.tostring序列化过大的table对象，需要注释或去除相关代码。强制仅显示部分内容。最大字段项数：", maxItemNum, " Lua调用堆栈：", debug.traceback())
      return
    end
    if type(obj) == "string" then
      table.insert(outStrList, "\"" .. tostring(obj) .. "\"")
    elseif type(obj) == "table" then
      if layer >= max_print_layer then
        table.insert(outStrList, "...")
        return
      end
      if objDic[obj] then
        table.insert(outStrList, "Repetition of the table:" .. (obj.__name or tostring(obj)))
      else
        objDic[obj] = true
        table.insert(outStrList, tostring(obj) .. "{" .. crlf)
        for k, v in pairs(obj) do
          if type(k) == "number" then
            table.insert(outStrList, spaceStr .. dSpaceStr .. "[" .. k .. "] = ")
          else
            table.insert(outStrList, spaceStr .. dSpaceStr .. "[" .. "\"" .. tostring(k) .. "\"" .. "] = ")
          end
          serialize(v, spaceStr .. dSpaceStr, layer + 1)
          if isExceedMax then
            return
          end
          table.insert(outStrList, "," .. crlf)
        end
        table.insert(outStrList, spaceStr .. "}")
      end
    else
      table.insert(outStrList, tostring(obj))
    end
  end
  
  serialize(self, nil, 0)
  do return table.concat end
  return table.concat, outStrList, nil, 0
end

function table:tostringByProto(crlf, dSpace)
  if CS.UnityEngine.Application.platform ~= CS.UnityEngine.RuntimePlatform.WindowsEditor or CS.Z1Client.LuaBehaviour.disable_proto_log then
    return ""
  end
  if GmClientUtils.isForbidProtoLog then
    return ""
  end
  crlf = crlf or "\n"
  local outStrList = {}
  local objDic = {}
  local dSpaceStr = dSpace or "    "
  
  local function serialize(o, spaceStr)
    spaceStr = spaceStr or ""
    if type(o) == "string" then
      table.insert(outStrList, "\"" .. tostring(o) .. "\"")
    elseif type(o) == "table" then
      if objDic[o] then
        table.insert(outStrList, "Repetition of the table:" .. (o.__name or tostring(o)))
      else
        objDic[o] = true
        table.insert(outStrList, tostring(o) .. "{" .. crlf)
        for k, v in pairs(o) do
          if type(k) == "number" then
            table.insert(outStrList, spaceStr .. dSpaceStr .. "[" .. k .. "] = ")
          else
            table.insert(outStrList, spaceStr .. dSpaceStr .. "[" .. "\"" .. tostring(k) .. "\"" .. "] = ")
          end
          serialize(v, spaceStr .. dSpaceStr)
          table.insert(outStrList, "," .. crlf)
        end
        table.insert(outStrList, spaceStr .. "}")
      end
    else
      table.insert(outStrList, tostring(o))
    end
  end
  
  serialize(self)
  do return table.concat end
  return table.concat, outStrList
end

function table:listtostring(crlf, dSpace)
  crlf = crlf or ""
  local outStrList = {}
  local dSpaceStr = dSpace or "    "
  if type(self) ~= "table" then
    do return table.tostring, self, crlf end
    return table.tostring, self, crlf, dSpace, nil, nil, nil, nil, nil, nil, nil, nil
  end
  for i, v in ipairs(self) do
    table.insert(outStrList, table.tostring(v, crlf, dSpace))
  end
  do return table.concat end
  return table.concat, outStrList, ipairs(self)
end

function table:OrmInsert(pos, value)
  local mt = getmetatable(self)
  if mt and mt.__insert then
    do return mt.__insert, self, pos end
    return mt.__insert, self, pos, value
  end
  if nil == value then
    do return table.insert, self end
    return table.insert, self, pos, value
  else
    do return table.insert, self, pos end
    return table.insert, self, pos, value
  end
end

function table:OrmRemove(pos)
  local mt = getmetatable(self)
  if mt and mt.__remove then
    do return mt.__remove, self end
    return mt.__remove, self, pos
  end
  do return table.remove, self end
  return table.remove, self, pos
end

function table:OrmRemoveByValue(value)
  local pos
  for i, v in pairs(self) do
    if v == value then
      pos = i
      break
    end
  end
  assert(pos, "OrmRemoveByValue cant find value " .. value)
  table.OrmRemove(self, pos)
end

function table:isarray()
  if type(self) ~= "table" then
    return false
  end
  local n = #self
  for i, v in pairs(self) do
    if type(i) ~= "number" then
      return false
    end
    if i > n then
      return false
    end
  end
  return true
end

function table:aconcat(lst)
  if lst then
    for i = 1, #lst do
      table.insert(self, lst[i])
    end
  end
end

function table.sameValues(a, b)
  if a == b then
    return true
  end
  if nil == a or nil == b then
    return false
  end
  if #a ~= #b then
    return false
  end
  for i, v in ipairs(a) do
    if v ~= b[i] then
      return false
    end
  end
  return true
end

function table.iteraDouble(tb)
  local i = -1
  return function()
    i = i + 2
    return tb[i], tb[i + 1], (i + 1) * 0.5
  end
end

function table.print(tb)
  Logger.Debug(table.tostring(tb))
end

function table.fullUnpack(args)
  local maxKey = 0
  for key, _ in pairs(args) do
    if key > maxKey then
      maxKey = key
    end
  end
  do return table.unpack, args, 1 end
  return table.unpack, args, 1, maxKey, nil, nil, nil
end

function table:removeByValue(value)
  for i, v in pairs(self) do
    if v == value then
      table.remove(self, i)
      break
    end
  end
end

function table:reverseKV()
  local reverse = {}
  for k, v in pairs(self) do
    reverse[v] = k
  end
  return reverse
end
