local function dump_value_(v)
  if type(v) == "string" then
    v = "\"" .. v .. "\""
  end
  return tostring(v)
end

table.empty = setmetatable({}, {
  __newindex = function()
    error("table.empty is readonly")
  end
})
table.weakMetatable = {__mode = "kv"}

function table.tostring(value, nesting)
  if type(nesting) ~= "number" then
    nesting = 20
  end
  local lookupTable = {}
  local result = {}
  local desciption = "<" .. tostring(value) .. ">"
  
  local function dump_(value, desciption, indent, nest, keylen)
    local spc = ""
    if type(keylen) == "number" then
      spc = string.rep(" ", keylen - string.len(dump_value_(desciption)))
    end
    if type(value) ~= "table" then
      result[#result + 1] = string.format("%s%s%s = %s", indent, dump_value_(desciption), spc, dump_value_(value))
    elseif lookupTable[tostring(value)] then
      result[#result + 1] = string.format("%s%s%s = *REF*", indent, dump_value_(desciption), spc)
    else
      lookupTable[tostring(value)] = true
      if nest > nesting then
        result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, dump_value_(desciption))
      else
        result[#result + 1] = string.format("%s%s = {", indent, dump_value_(desciption))
        local indent2 = indent .. "    "
        local keys = {}
        local keylen = 0
        local values = {}
        for k, v in pairs(value) do
          keys[#keys + 1] = k
          local vk = dump_value_(k)
          local vkl = string.len(vk)
          if keylen < vkl then
            keylen = vkl
          end
          values[k] = v
        end
        table.sort(keys, function(a, b)
          if type(a) == "number" and type(b) == "number" then
            return a < b
          else
            return tostring(a) < tostring(b)
          end
        end)
        for i, k in ipairs(keys) do
          dump_(values[k], k, indent2, nest + 1, keylen)
        end
        result[#result + 1] = string.format("%s},", indent)
      end
    end
  end
  
  dump_(value, desciption, "", 1)
  local str = ""
  for i, line in ipairs(result) do
    str = str .. line .. "\n"
  end
  return str
end

function table.dumptree(obj, width)
  local dump_obj
  local end_flag = {}
  
  local function make_indent(layer, is_end)
    local subIndent = string.rep("  ", width)
    local indent = ""
    end_flag[layer] = is_end
    local subIndent = string.rep("  ", width)
    for index = 1, layer - 1 do
      if end_flag[index] then
        indent = indent .. " " .. subIndent
      else
        indent = indent .. "|" .. subIndent
      end
    end
    if is_end then
      return indent .. "└" .. string.rep("─", width) .. " "
    else
      return indent .. "├" .. string.rep("─", width) .. " "
    end
  end
  
  local function make_quote(str)
    local num
    str, num = string.gsub(str, "[%c\\\"]", {
      ["\t"] = "\\t",
      ["\r"] = "\\r",
      ["\n"] = "\\n",
      ["\""] = "\\\"",
      ["\\"] = "\\\\",
      ["\b"] = ""
    })
    local check = num ~= 0
    if check then
      str = ""
    end
    return "\"" .. str .. "\""
  end
  
  local function dump_key(key)
    if type(key) == "number" then
      return key .. "] "
    elseif type(key) == "string" then
      return tostring(key) .. ": "
    end
  end
  
  local function dump_val(val, layer)
    if type(val) == "table" then
      return dump_obj(val, layer)
    elseif type(val) == "string" then
      return make_quote(val)
    else
      return tostring(val)
    end
  end
  
  local function count_elements(obj)
    local count = 0
    for k, v in pairs(obj) do
      count = count + 1
    end
    return count
  end
  
  function dump_obj(obj, layer)
    if type(obj) ~= "table" then
      return count_elements(obj)
    end
    layer = layer + 1
    local tokens = {}
    local max_count = count_elements(obj)
    local cur_count = 1
    for k, v in pairs(obj) do
      local key_name = dump_key(k)
      if type(v) == "table" then
        key_name = key_name .. "\n"
      end
      table.insert(tokens, make_indent(layer, cur_count == max_count) .. key_name .. dump_val(v, layer))
      cur_count = cur_count + 1
    end
    if max_count == 0 then
      table.insert(tokens, make_indent(layer, true) .. "{ }")
    end
    return table.concat(tokens, "\n")
  end
  
  if type(obj) ~= "table" then
    return "the params you input is " .. type(obj) .. ", not a table, the value is --> " .. tostring(obj)
  end
  width = width or 2
  return "root-->" .. tostring(obj) .. "\n" .. dump_obj(obj, 0)
end

function table.totable(str)
  if str == nil or type(str) ~= "string" then
    return
  end
  return loadstring("return " .. str)()
end

function table.clear(tab)
  if tab == nil then
    return
  end
  for k, v in pairs(tab) do
    tab[k] = nil
  end
end

function table.isEmpty(tab)
  if tab == nil then
    return true
  end
  if type(tab) == "string" then
    return true
  end
  for k, v in pairs(tab) do
    if k ~= "_CType" and k ~= "_CObj" and k ~= "_Parent" then
      return false
    end
  end
  return true
end

function table.ipairsFind(tab, match)
  for _, v in ipairs(tab) do
    if match(v, _) then
      return v, _
    end
  end
end

function table.pairsFind(tab, match)
  for _, v in pairs(tab) do
    if match(v, _) then
      return v, _
    end
  end
end

function table.pairsFindAll(tab, match)
  local newTab = {}
  for _, v in pairs(tab) do
    if match(v, _) then
      table.insert(newTab, v)
    end
  end
  return newTab
end

function table.clone(t, cloneMetatable)
  if type(t) ~= "table" then
    return nil
  end
  local newTable = {}
  for k, v in pairs(t) do
    newTable[k] = v
  end
  local meta = getmetatable(t)
  if cloneMetatable then
    if meta and next(meta) then
      setmetatable(newTable, clone(meta))
    end
  elseif meta and next(meta) then
    setmetatable(newTable, meta)
  end
  return newTable
end

function table.deepClone(t)
  if type(t) ~= "table" then
    return nil
  end
  local newTable = {}
  for k, v in pairs(t) do
    if type(v) == "table" then
      newTable[k] = table.deepClone(v)
    else
      newTable[k] = v
    end
  end
  return newTable
end

function table.removeWith(tab, func, isIpairs)
  local _, i = table.find(tab, func, isIpairs)
  if i then
    return table.remove(tab, i)
  end
end

function table.toDic(tab, key)
  local dic = {}
  if tab then
    for _, v in pairs(tab) do
      dic[v[key]] = v
    end
  end
  return dic
end

function table.toArray(tab)
  local dic = {}
  if tab then
    for _, v in pairs(tab) do
      table.insert(dic, v)
    end
  end
  return dic
end

function table.resize(tab, size, fill)
  local start = #tab
  if size < start then
    start, size, fill = size, start, nil
  end
  for i = start + 1, size do
    tab[i] = fill
  end
  return tab
end

function table.merge(tabA, tabB)
  if tabB then
    for key, v in pairs(tabB) do
      tabA[key] = v
    end
  end
  return tabA
end

function table.find(tab, match, isIpairs)
  if isIpairs then
    return table.ipairsFind(tab, match)
  else
    return table.pairsFind(tab, match)
  end
end

function table.findAll(tab, match, isIpairs)
  if isIpairs then
    return table.ipairsFindAll(tab, match)
  else
    return table.pairsFindAll(tab, match)
  end
end

function table.removeBy(tab, o, isIpairs)
  local function _math(ele)
    return ele == o
  end
  
  local _, i = table.find(tab, _math, isIpairs)
  if i then
    return table.remove(tab, i)
  end
end

function table.fastRemove(tab, index)
  local len = #tab
  tab[index] = tab[len]
  tab[len] = nil
end

function table.count(hashtable)
  local count = 0
  for _, _ in pairs(hashtable) do
    count = count + 1
  end
  return count
end

function table.fill(tabA, tabB)
  if tabB then
    for _, v in ipairs(tabB) do
      table.insert(tabA, v)
    end
  end
  return tabA
end

local function ToStringEx(value)
  if type(value) == "table" then
    return table.tostring(value)
  elseif type(value) == "string" then
    return "'" .. value .. "'"
  else
    return tostring(value)
  end
end

function table.reverse(tab)
  for i = 1, #tab / 2 do
    local tmp = tab[i]
    tab[i] = tab[#tab - i + 1]
    tab[#tab - i + 1] = tmp
  end
end

function table.add(myTable, otherTable)
  local temp = {}
  for i, v in pairs(myTable) do
    temp[i] = v + otherTable[i]
  end
  return temp
end

function table.indexOf(array, value, begin)
  for i = begin or 1, table.count(array) do
    if array[i] == value then
      return i
    end
  end
  return false
end

function table.keyOf(hashtable, value)
  if hashtable == nil then
    return nil
  end
  for k, v in pairs(hashtable) do
    if v == value then
      return k
    end
  end
  return nil
end

function table.containsValue(hashtable, value)
  return table.keyOf(hashtable, value) ~= nil
end

function table.values(hashtable)
  local values = {}
  for _, v in pairs(hashtable) do
    table.insert(values, v)
  end
  return values
end

function table.keys(hashtable)
  local keys = {}
  for k, _ in pairs(hashtable) do
    table.insert(keys, k)
  end
  return keys
end

function table.same(t1, t2)
  if table.count(t1) ~= table.count(t2) then
    return false
  end
  for k, v in pairs(t1) do
    if type(t2[k]) ~= type(v) then
      return false
    end
    if type(v) == "table" then
      if not table.same(t2[k], v) then
        return false
      end
    elseif t2[k] ~= v then
      return false
    end
  end
  return true
end

function table.shuffle(arrayTable)
  if table.isEmpty(arrayTable) or #arrayTable <= 1 then
    return
  end
  for i = #arrayTable, 2, -1 do
    local j = math.random(i)
    arrayTable[i], arrayTable[j] = arrayTable[j], arrayTable[i]
  end
end
