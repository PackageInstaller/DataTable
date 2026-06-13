local ctd = {}
local math = _ENV.math
local table = _ENV.table
local string = _ENV.string

function ctd.dump(root)
  local doc = {
    table_n = 0,
    table = {},
    strings = {},
    offset = 0
  }
  
  local function dump_table(t)
    local index = doc.table_n + 1
    doc.table_n = index
    doc.table[index] = false
    local array_n = 0
    local array = {}
    local kvs = {}
    local types = {}
    
    local function encode(v)
      local t = type(v)
      if "table" == t then
        local index = dump_table(v)
        return "\004", string.pack("<i4", index - 1)
      elseif "number" == t then
        if math.tointeger(v) and v <= 2147483647 and v >= -2147483648 then
          return "\001", string.pack("<i4", v)
        else
          return "\002", string.pack("<f", v)
        end
      elseif "boolean" == t then
        if v then
          return "\003", "\000\000\000\001"
        else
          return "\003", "\000\000\000\000"
        end
      elseif "string" == t then
        local offset = doc.strings[v]
        if not offset then
          offset = doc.offset
          doc.offset = offset + #v + 1
          doc.strings[v] = offset
          table.insert(doc.strings, v)
        end
        return "\005", string.pack("<I4", offset)
      else
        error("Unsupport value " .. tostring(v))
      end
    end
    
    for i, v in ipairs(t) do
      types[i], array[i] = encode(v)
      array_n = i
    end
    for k, v in pairs(t) do
      if type(k) == "string" then
        local _, kv = encode(k)
        local tv, ev = encode(v)
        table.insert(types, tv)
        table.insert(kvs, kv .. ev)
      else
        local ik = math.tointeger(k)
        assert(ik and ik > 0 and array_n >= ik)
      end
    end
    local typeset = table.concat(types)
    local align = string.rep("\000", 4 - #typeset & 3 & 3)
    local tmp = {
      string.pack("<i4i4", array_n, #kvs),
      typeset,
      align,
      table.concat(array),
      table.concat(kvs)
    }
    doc.table[index] = table.concat(tmp)
    return index
  end
  
  dump_table(root)
  local index = {}
  local offset = 0
  for i, v in ipairs(doc.table) do
    index[i] = string.pack("<I4", offset)
    offset = offset + #v
  end
  local tmp = {
    string.pack("<I4", 8 + 4 * doc.table_n + offset),
    string.pack("<I4", doc.table_n),
    table.concat(index),
    table.concat(doc.table),
    table.concat(doc.strings, "\000"),
    "\000"
  }
  return table.concat(tmp)
end

function ctd.undump(v)
  local stringtbl, n = string.unpack("<I4I4", v)
  local index = {
    string.unpack("<" .. string.rep("I4", n), v, 9)
  }
  local header = 8 + 4 * n + 1
  stringtbl = stringtbl + 1
  local tblidx = {}
  
  local function decode(n)
    local toffset = index[n + 1] + header
    local array, dict = string.unpack("<I4I4", v, toffset)
    local types = {
      string.unpack(string.rep("B", array + dict), v, toffset + 8)
    }
    local offset = (array + dict + 8 + 3 & -4) + toffset
    local result = {}
    
    local function value(t)
      local off = offset
      offset = offset + 4
      if 1 == t then
        return (string.unpack("<i4", v, off))
      elseif 2 == t then
        return (string.unpack("<f", v, off))
      elseif 3 == t then
        return 0 ~= string.unpack("<i4", v, off)
      elseif 4 == t then
        local tindex = string.unpack("<I4", v, off)
        return decode(tindex)
      elseif 5 == t then
        local sindex = string.unpack("<I4", v, off)
        return (string.unpack("z", v, stringtbl + sindex))
      else
        error(string.format("Invalid data at %d (%d)", off, t))
      end
    end
    
    for i = 1, array do
      table.insert(result, value(types[i]))
    end
    for i = 1, dict do
      local sindex = string.unpack("<I4", v, offset)
      offset = offset + 4
      local key = string.unpack("z", v, stringtbl + sindex)
      result[key] = value(types[array + i])
    end
    tblidx[result] = n
    return result
  end
  
  return decode(0), tblidx
end

local function diffmap(last, current)
  local lastv, lasti = ctd.undump(last)
  local curv, curi = ctd.undump(current)
  local map = {}
  
  local function comp(lastr, curr)
    local old = lasti[lastr]
    local new = curi[curr]
    map[new] = old
    for k, v in pairs(lastr) do
      if type(v) == "table" then
        local newv = curr[k]
        if type(newv) == "table" then
          comp(v, newv)
        end
      end
    end
  end
  
  comp(lastv, curv)
  return map
end

function ctd.diff(last, current)
  local map = diffmap(last, current)
  local stringtbl, n = string.unpack("<I4I4", current)
  local _, lastn = string.unpack("<I4I4", last)
  local existn = 0
  for k, v in pairs(map) do
    existn = existn + 1
  end
  local newn = lastn
  for i = 0, n - 1 do
    if not map[i] then
      map[i] = newn
      newn = newn + 1
    end
  end
  local index = {
    string.unpack("<" .. string.rep("I4", n), current, 9)
  }
  local header = 8 + 4 * n + 1
  
  local function remap(n)
    local toffset = index[n + 1] + header
    local array, dict = string.unpack("<I4I4", current, toffset)
    local types = {
      string.unpack(string.rep("B", array + dict), current, toffset + 8)
    }
    local hlen = array + dict + 8 + 3 & -4
    local hastable = false
    for _, v in ipairs(types) do
      if 4 == v then
        hastable = true
        break
      end
    end
    if not hastable then
      return string.sub(current, toffset, toffset + hlen + (array + dict * 2) * 4 - 1)
    end
    local offset = hlen + toffset
    local pat = "<" .. string.rep("I4", array + dict * 2)
    local values = {
      string.unpack(pat, current, offset)
    }
    for i = 1, array do
      if 4 == types[i] then
        values[i] = map[values[i]]
      end
    end
    for i = 1, dict do
      if 4 == types[i + array] then
        values[array + i * 2] = map[values[array + i * 2]]
      end
    end
    return string.sub(current, toffset, toffset + hlen - 1) .. string.pack(pat, table.unpack(values))
  end
  
  local oldindex = {
    string.unpack("<" .. string.rep("I4", n), current, 9)
  }
  local index = {}
  for i = 1, newn do
    index[i] = 4294967295
  end
  for i = 0, #map do
    index[map[i] + 1] = oldindex[i + 1]
  end
  local tmp = {
    string.pack("<I4I4", stringtbl + (newn - n) * 4, newn),
    string.pack("<" .. string.rep("I4", newn), table.unpack(index))
  }
  for i = 0, n - 1 do
    table.insert(tmp, remap(i))
  end
  table.insert(tmp, string.sub(current, stringtbl + 1))
  return table.concat(tmp)
end

return ctd
