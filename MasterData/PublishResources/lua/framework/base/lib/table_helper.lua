local toint = math.tointeger
local type = _ENV.type
local next = _ENV.next

function table.append(a, b, filter_list)
  filter_list = filter_list and filter_list or {}
  for k, v in next, b, nil do
    local filter = false
    for _, _v in pairs(filter_list) do
      if k == _v then
        filter = true
      end
    end
    if false == filter and nil == a[k] then
      a[k] = v
    end
  end
end

function table.appendArray(a, b)
  if not a or not b then
    return
  end
  for i, v in ipairs(b) do
    table.insert(a, v)
  end
end

function table.select(tt, k)
  local ret = {}
  for _, t in pairs(tt) do
    table.insert(ret, t[k])
  end
  return ret
end

function table.ACS(a, b)
  return a < b
end

function table.asc(k)
  return function(a, b)
    return a[k] < b[k]
  end
end

function table.DESC(a, b)
  return b < a
end

function table.desc(k)
  return function(a, b)
    return a[k] > b[k]
  end
end

function table.orderby(...)
  local tb = {
    ...
  }
  return function(a, b)
    for i = 1, #tb, 2 do
      local k = tb[i]
      local by = tb[i + 1]
      assert(a[k] ~= nil, "table.orderby nil " .. k)
      assert(b[k] ~= nil, "table.orderby nil " .. k)
      if a[k] == b[k] then
      elseif by == "desc" then
        return a[k] > b[k]
      else
        return a[k] < b[k]
      end
    end
    return false
  end
end

local visited

function table.singlefind(tb, func, path)
  for k, v in next, tb, nil do
    if type(v) == "table" and not visited[v] then
      visited[v] = true
      if func(v) then
        table.insert(path, k)
        return true
      else
        table.insert(path, k)
        if table.singlefind(v, func, path) then
          return path
        end
        path[#path] = nil
      end
    end
  end
  return false
end

function table.template(tb)
  local s, loop = table.tostring(tb)
  if loop then
    assert("template loop table")
    return loadstring("return string.totable[===[" .. s .. "]===]")
  else
    return loadstring("return " .. s)
  end
end

local tpns = {}

function table.templaten(n)
  if n <= 0 then
    return {}
  end
  if tpns[n] then
    return tpns[n]()
  end
  local tb = {}
  for ii = 1, n do
    tb[ii] = 0
  end
  local tpn = table.template(tb)
  tpns[n] = tpn
  return tpn()
end

function table.filter(tb, func)
  local newtb = {}
  for k, v in next, tb, nil do
    if func(v) then
      newtb[k] = v
    end
  end
  return newtb
end

function table.cover(dest, src)
  local samek
  for k, v in next, src, nil do
    if dest[k] ~= v then
      dest[k] = v
      if dest[k] == nil then
        samek = false
      elseif samek == nil then
        samek = true
      end
    end
  end
  return dest, samek
end

function table.find(tb, func)
  visited = {}
  return table.singlefind(tb, func, {})
end

function table.add(tb, col, newcol)
  local v = 0
  for ii = 1, #tb do
    v = v + tb[ii][col]
    tb[ii][newcol] = v
  end
  return tb
end

function table.ikey(tb, v)
  for ii = 1, #tb do
    if tb[ii] == v then
      return ii
    end
  end
end

if not table.clear then
  function table.clear(t)
    if not t then
      return t
    end
    for k, v in next, t, nil do
      t[k] = nil
    end
    return t
  end
else
  local clear0 = table.clear
  
  function table.clear(t)
    if not t then
      return
    end
    return clear0(t)
  end
end

function table.pushv(dest, src)
  for k, v in next, src, nil do
    table.insert(dest, v)
  end
  return dest
end

function table.removev(tb, value)
  for k, v in next, tb, nil do
    if v == value then
      table.remove(tb, k)
      return
    end
  end
end

function table.recursive(dest, src)
  for k, v in next, src, nil do
    if type(v) == "table" and type(dest[k]) == "table" then
      table.recursive(dest[k], v)
    else
      dest[k] = v
    end
  end
  return dest
end

function table.del(tb, dels)
  for k, v in next, dels, nil do
    if type(v) == "table" then
      table.del(tb[k], v)
    else
      tb[k] = nil
    end
  end
end

function table.readonly(x, name, deep)
  if deep then
    for k, v in next, x, nil do
      if type(v) == "table" then
        x[k] = table.readonly(v, name .. "." .. k, true)
      end
    end
  end
  local m = {}
  
  function m.__newindex()
    error(name and "readonly " .. name or "readonly")
  end
  
  return setmetatable(x, m), m
end

function table.keys(t, keys)
  local keys = keys or {}
  for k, _ in next, t, nil do
    keys[#keys + 1] = k
  end
  return keys
end

function table.ikeys(t)
  local s = {}
  for i = 1, #t do
    s[i] = i
  end
  return s
end

function table.values(t)
  local values = {}
  for _, v in next, t, nil do
    table.insert(values, v)
  end
  return values
end

function table.compare(t1, t2)
  t1 = t1 or GameHelper.EMPTY_TABLE
  t2 = t2 or GameHelper.EMPTY_TABLE
  local com, r1, r2 = {}, table.append({}, t1), table.append({}, t2)
  for k, v in next, t1, nil do
    if t2[k] == v then
      com[k] = v
      r1[k] = nil
      r2[k] = nil
    end
  end
  return com, r1, r2
end

function table.reverse(t, func)
  local r = {}
  for k, v in next, t, nil do
    r[v] = func and func(k) or k
  end
  return r
end

function table.collect(t)
  local arr = {}
  for ii = 1, table.maxn(t) do
    if t[ii] then
      table.insert(arr, t[ii])
    end
  end
  return arr
end

function table.minn(t)
  for ii = 1, #t do
    if t[ii] then
      return ii
    end
  end
end

function table.minv(tb, key)
  local minv = math.huge
  for _, v in next, tb, nil do
    local rv = key and v[key] or v
    minv = math.min(minv, rv)
  end
  return minv
end

function table.min(t)
  local firstk
  for k = 1, #t do
    if t[k] then
      firstk = k
      break
    end
  end
  local minnum = t[firstk]
  local pos = firstk
  if not minnum then
    return
  end
  for k = 1, #t do
    local v = t[k]
    if minnum > v then
      minnum = v
      pos = k
    end
  end
  return minnum, pos
end

function table.max(t)
  local firstk
  for k, _ in next, t, nil do
    if t[k] then
      firstk = k
    end
  end
  local maxnum = t[firstk]
  local pos = firstk
  assert(maxnum, "blank table")
  for k, v in next, t, nil do
    if v > maxnum then
      maxnum = v
      pos = k
    end
  end
  return maxnum, pos
end

function table.count(t)
  local sum = 0
  for k, v in next, t, nil do
    if v ~= nil then
      sum = sum + 1
    end
  end
  return sum
end

function table.addValue(base, app)
  for k, v in pairs(app) do
    if type(v) == "number" then
      base[k] = (base[k] or 0) + v
    else
      base[k] = table.addValue(base[k] or {}, v)
    end
  end
  return base
end

local function unserialize(flattb, tb, visited)
  if not visited[tb] then
    visited[tb] = true
    for key, v in next, tb.__ref__, nil do
      tb[key] = flattb[v]
      unserialize(flattb, flattb[v], visited)
    end
    tb.__ref__ = nil
  end
end

function string.totable(s)
  local flattb = loadstring("return " .. s)()
  if 1 < #flattb then
    local tbs = {}
    for _, ftb in next, flattb, nil do
      local tb = ftb.tb0
      if tb then
        unserialize(ftb, tb, {})
      else
        tb = ftb
      end
      table.insert(tbs, tb)
    end
    return tbs
  else
    local tb = flattb.tb0
    if tb then
      unserialize(flattb, tb, {})
    else
      tb = flattb
    end
    return {tb}
  end
end

function table.flat(t, flattb, visited)
  local tbname = "tb" .. flattb.lv
  if not visited[t] then
    flattb[tbname] = {
      __ref__ = {}
    }
    visited[t] = tbname
    for k, v in next, t, nil do
      if type(v) ~= "table" then
        flattb[tbname][k] = v
      elseif not visited[v] then
        flattb.lv = flattb.lv + 1
        local newtbname = "tb" .. flattb.lv
        flattb[tbname][k] = newtbname
        flattb[tbname].__ref__[k] = newtbname
        table.flat(v, flattb, visited)
      else
        flattb.loop = true
        flattb[tbname][k] = visited[v]
        flattb[tbname].__ref__[k] = visited[v]
      end
    end
  end
end

local function serialize(o, s)
  if type(o) == "number" then
    s = s .. o
  elseif type(o) == "string" then
    s = s .. "'" .. o .. "'"
  elseif type(o) == "boolean" then
    s = s .. (o and "true" or "false")
  elseif type(o) == "table" then
    s = s .. "{"
    for k, v in next, o, nil do
      if type(k) == "number" then
        s = s .. "[" .. k .. "]="
        s = serialize(v, s)
        s = s .. ","
      elseif type(k) == "string" then
        s = s .. "['" .. k .. "']="
        s = serialize(v, s)
        s = s .. ","
      elseif type(k) == "boolean" then
        s = s .. "[" .. (k and "true" or "false") .. "]="
        s = serialize(v, s)
        s = s .. ","
      end
    end
    s = s .. "}"
  elseif type(o) == "function" then
  elseif type(o) == "userdata" then
  else
    error("cannot serialize a " .. type(o))
  end
  return s
end

function table.tonumber(t)
  local t2 = {}
  for k, v in next, t, nil do
    t2[k] = tonumber(v)
  end
  return t2
end

function table.tostring(t)
  local flattb, visited = {lv = 0}, {}
  table.flat(t, flattb, visited)
  flattb.lv = nil
  if not flattb.loop then
    return serialize(t, ""), false
  else
    flattb.loop = nil
    return serialize(flattb, ""), true
  end
end

function table.minn(t)
  for ii = 1, #t do
    if not t[ii] then
      return ii
    end
  end
  return #t + 1
end

function table.tostr(t, tabnum, float)
  local tabnum = tabnum or 1
  local tabs = ""
  for i = 1, tabnum do
    tabs = tabs .. "\t"
  end
  local tt = type(t)
  assert(tt == "table", "bad argument #1(table expected, got " .. tt .. ")")
  local ts = {}
  local t0 = table.keys(t)
  table.sort(t0, function(a, b)
    if type(a) == "number" and type(b) == "number" then
      return a < b
    elseif type(a) == "number" and type(b) ~= "number" then
      return true
    elseif type(b) == "number" and type(a) ~= "number" then
      return false
    else
      return tostring(a) < tostring(b)
    end
  end)
  for i = 1, #t0 do
    local k = t0[i]
    local v = t[k]
    local tv = type(v)
    local tk = type(k)
    if tk == "number" then
      k = "[" .. k .. "]"
    end
    if tk == "string" then
      k = "[\"" .. k .. "\"]"
    end
    k = tabs .. tostring(k)
    if tv == "table" then
      ts[#ts + 1] = k .. "=" .. table.tostr(v, tabnum + 1, float)
    elseif tv == "string" then
      ts[#ts + 1] = k .. "=[[" .. v .. "]]"
    elseif tv == "number" then
      if v ~= toint(v) and float then
        assert(0 <= float and toint(float) == float, "")
        ts[#ts + 1] = k .. string.format("=%." .. float .. "f", v)
      else
        ts[#ts + 1] = k .. "=" .. tostring(v)
      end
    else
      ts[#ts + 1] = k .. "=" .. tostring(v)
    end
  end
  return "{\n" .. table.concat(ts, ",\n") .. "\n" .. tabs .. "}"
end

function table.cloneconf(st)
  if not st then
    return st
  end
  local dt = {}
  if st._className == "Vector2" then
    dt = Vector2(0, 0)
  end
  if type(st) ~= "table" then
    error("source is not table in table.clone")
  else
    local isConf, name = IsConf(st)
    if isConf then
      return CloneConf(name)
    end
    for k, v in next, st, nil do
      if type(v) ~= "table" then
        dt[k] = v
      else
        dt[k] = table.cloneconf(v)
      end
    end
  end
  return dt
end

if not table.clone then
  function table.clone(st)
    local dt = {}
    
    if type(st) ~= "table" then
      error("source is not table in table.clone")
    else
      for k, v in next, st, nil do
        if type(v) == "table" then
          dt[k] = table.clone(v)
        else
          dt[k] = v
        end
      end
    end
    return dt
  end
end

function table.replace(t, r)
  for k, v in next, t, nil do
    if type(v) == "string" then
      local a = {}
      for s in string.gmatch(v, "var%d+") do
        table.insert(a, s)
      end
      if #a == 1 and a[1] == v then
        local index = string.find(v, "%d")
        local value = r["var" .. string.sub(v, index)]
        if not value then
          Log.fatal(r.id, "no define", "var" .. string.sub(v, index))
        end
        t[k] = value
      end
    elseif type(v) == "table" then
      t[k] = table.replace(v, r)
    end
  end
  return t
end

function table.delEmpty(tbl)
  if not next(tbl) then
    return nil
  end
  for k, v in next, tbl, nil do
    if type(v) == "table" then
      tbl[k] = table.delEmpty(v)
    end
  end
  return tbl
end

local function hequal(tb1, tb2)
  if #table.keys(tb1) ~= #table.keys(tb2) then
    return false
  end
  for k1, v1 in next, tb1, nil do
    if not table.equal(v1, tb2[k1]) then
      return false
    end
  end
  return true
end

function table.equal(tb1, tb2)
  local kd1, kd2 = type(tb1), type(tb2)
  if kd1 ~= kd2 then
    return false
  end
  if kd1 == "table" then
    return hequal(tb1, tb2)
  end
  return tb1 == tb2 or tb1 ~= tb1 and tb2 ~= tb2
end

function table.pre(tb1, tb2)
  if not tb2 then
    return tb1 == nil
  end
  for ii = 1, #tb1 do
    if not table.equal(tb1[ii], tb2[ii]) then
      return false
    end
  end
  return true
end

function table.childequalex(v1, tb2)
  local has = false
  for k2, v2 in next, tb2, nil do
    if table.equal(v1, v2) then
      has = true
      break
    end
  end
  return has
end

function table.childequal(tb1, tb2)
  local kd1, kd2 = type(tb1), type(tb2)
  if kd1 ~= kd2 then
    return false
  end
  if kd1 == "table" then
    for k1, v1 in next, tb1, nil do
      if not table.childequalex(v1, tb2) then
        return false
      end
    end
    for k2, v2 in next, tb2, nil do
      if not table.childequalex(v2, tb1) then
        return false
      end
    end
    return true
  end
  return tb1 == tb2
end

function table.recursive(dest, src)
  local type = type
  for k, v in next, src, nil do
    if type(v) == "table" and type(dest[k]) == "table" then
      table.recursive(dest[k], v)
    else
      dest[k] = v
    end
  end
  return dest
end

function table.sub(tb, from, to)
  from = from or 1
  to = to or #tb
  local ntb = {}
  for ii = from, to do
    table.insert(ntb, tb[ii])
  end
  return ntb
end

local weakk = {__mode = "k"}

function table.weakk()
  return setmetatable({}, weakk)
end

local weakv = {__mode = "v"}

function table.weakv()
  return setmetatable({}, weakv)
end

function table.intable(tb, val, key)
  for _, v in pairs(tb) do
    if val == (key and v[key] or v) then
      return true
    end
  end
  return false
end

function table.noarray(s)
  local ss = {}
  for k, v in next, s, nil do
    if type(k) ~= "number" then
      ss[k] = v
    end
  end
  return ss
end

function table.findpos(tb, val, key)
  for ii = 1, #tb do
    if val < tb[ii][key] then
      return ii - 1
    end
  end
end

function table.appendattrs(tb, newtb)
  if not newtb then
    return
  end
  local temp = table.clone(newtb)
  for key, value in pairs(temp) do
    local iksy = table.iskey(tb, key)
    if iksy then
      tb[key] = tb[key] + value
    else
      tb[key] = value
    end
  end
end

function table.appendattr(tb, key, value)
  if table.iskey(tb, key) then
    tb[key] = tb[key] + value
  else
    tb[key] = value
  end
end

function table.appendnum(tb1, tb2)
  for k, v in pairs(tb2 or {}) do
    local key
    for m, n in pairs(tb1 or {}) do
      if v[1] == n[1] then
        n[2] = n[2] + v[2]
        key = n[1]
      end
    end
    if not key then
      table.insert(tb1, {
        v[1],
        v[2]
      })
    end
  end
  return tb1
end

function table.iskey(tb, key)
  if tb == nil then
    return false
  end
  for k, v in pairs(tb) do
    if k == key then
      return true
    end
  end
end

function table.randomn(t, n)
  if n > #t then
    assert(false, "cant sel n from t")
  end
  if #t == n then
    return t
  end
  local s = {}
  while n > #s do
    local i = math.random(1, #t)
    if not table.ikey(s, t[i]) then
      s[#s + 1] = t[i]
    end
  end
  return s
end

function table.icontains(t, value)
  if t == nil then
    return false
  end
  if value == nil then
    Log.error("table.icontains is checking nil in a table")
    return false
  end
  for ii = 1, #t do
    if t[ii] == value then
      return true
    end
  end
  return false
end

function table.maxn(t)
  local mn = 0
  for k, v in pairs(t) do
    if k > mn then
      mn = k
    end
  end
  return mn
end

function table.foreach(t, visitor)
  for k, v in pairs(t) do
    visitor(v)
  end
end

function table.shallowcopy(dest)
  local destType = type(dest)
  local src
  if destType == "table" then
    src = {}
    for k, v in pairs(dest) do
      src[k] = v
    end
  else
    src = dest
  end
  return src
end

function table.shuffle(t)
  for i = 1, #t do
    local n = math.random(1, #t)
    t[i], t[n] = t[n], t[i]
  end
  return t
end

function table.unique(t)
  local s = {}
  for _, v in ipairs(t) do
    if not table.icontains(s, v) then
      s[#s + 1] = v
    end
  end
  return s
end

function table.union(t1, t2)
  local t = {}
  for _, v in ipairs(t1) do
    if table.icontains(t2, v) then
      t[#t + 1] = v
    end
  end
  return t
end

function table.toArray(t)
  local r = {}
  for k, v in pairs(t) do
    r[#r + 1] = v
  end
  return r
end

function table.isSame(t1, t2)
  for k, v in pairs(t1) do
    if not t2[k] or t2[k] ~= v then
      return false
    end
  end
  for k, v in pairs(t2) do
    if not t1[k] or t1[k] ~= v then
      return false
    end
  end
  return true
end

function table.Vector2Include(t, v)
  if not v._className or v._className ~= "Vector2" then
    return false
  end
  for i, s in ipairs(t) do
    if s.x == v.x and s.y == v.y then
      return true
    end
  end
  return false
end

function table.Vector2Append(t, v, filter_list)
  filter_list = filter_list or {}
  for _, pos in pairs(v) do
    if not table.Vector2Include(filter_list, pos) then
      table.insert(t, pos)
    end
  end
end

function table.Unfold(t)
  local r = {}
  for i, v in ipairs(t) do
    if type(v) ~= "table" then
      r[#r + 1] = v
    else
      table.appendArray(r, table.Unfold(v))
    end
  end
  return r
end

function table.getTableDiffIndex(arr1, arr2)
  local idx = 0
  local diff = false
  local new = false
  if type(arr1) ~= "table" or type(arr2) ~= "table" then
    return false
  end
  local len1 = #arr1
  local len2 = #arr2
  local len = math.max(len1, len2)
  for i = 1, len do
    local val1 = arr1[i]
    local val2 = arr2[i]
    if val1 ~= val2 then
      idx = i
      diff = true
      if val1 == nil or val2 == nil then
        new = true
      end
      break
    end
  end
  return diff, idx, new
end
