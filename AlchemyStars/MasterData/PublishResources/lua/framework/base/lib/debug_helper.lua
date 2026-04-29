function debug.getlocals(t)
  assert(type(t) == "thread", "argument #1 thread expected")
  
  local as = {}
  local i = 1
  while true do
    local name, value = debug.getlocal(t, 1, i)
    if not name then
      break
    end
    as[name] = value
    i = i + 1
  end
  return as
end

local getmetatable = _ENV.getmetatable
local n = 0
local stack = {}

function debug.findobj(start, comp, root)
  local passed = {}
  passed[tostring] = true
  passed[debug] = true
  passed[table] = true
  
  local function getupvalues(f)
    local ups = {}
    local i = 1
    while true do
      local a, b = debug.getupvalue(f, i)
      if not a then
        break
      end
      i = i + 1
      ups[a] = b
    end
    return ups
  end
  
  local function cp(t)
    local res = {}
    for k, v in pairs(t) do
      res[k] = v
    end
    return res
  end
  
  local checktype = {}
  checktype.userdata = true
  checktype.table = true
  checktype["function"] = true
  checktype.thread = true
  local res = {}
  stack = {}
  
  local function restrain(obj, name)
    if comp(obj) then
      stack[#stack + 1] = name
      res[#res + 1] = cp(stack)
      stack[#stack] = nil
      return
    end
    if passed[obj] then
      return
    end
    if not obj then
      for i, v in ipairs(res) do
        print(v)
      end
      assert(false)
    end
    passed[obj] = true
    if type(obj) == "function" then
      local mt = getupvalues(obj)
      local info = debug.getinfo(obj)
      stack[#stack + 1] = ("%s(function %s|%s)"):format(name, info.short_src, info.linedefined)
      restrain(mt, "upvalues")
      stack[#stack] = nil
    elseif type(obj) == "userdata" then
      local mt = getmetatable(obj)
      if mt then
        stack[#stack + 1] = ("%s(userdata)"):format(name)
        restrain(mt, "metatables")
        stack[#stack] = nil
      end
    elseif type(obj) == "thread" then
      local as = debug.getlocals(obj)
      stack[#stack + 1] = ("%s(thread)"):format(name)
      restrain(as, "locals")
      stack[#stack] = nil
    elseif type(obj) == "table" then
      local mt = getmetatable(obj)
      local countk = true
      local countv = true
      if mt then
        stack[#stack + 1] = ("%s(table).MT=%s"):format(name, mt)
        restrain(mt, "metatable")
        stack[#stack] = nil
        local mode = rawget(mt, "__mode")
        if mode then
          if mode:find("k") then
            countk = false
          end
          if mode:find("v") then
            countv = false
          end
        end
      end
      for k, v in next, obj, nil do
        if countk and checktype[type(k)] then
          stack[#stack + 1] = ("%s(table)"):format(name)
          restrain(k, ("key|k=%s(%s) v=%s(%s)"):format(tostring(k), type(k), tostring(v), type(v)))
          stack[#stack] = nil
        end
        if countv and checktype[type(v)] then
          stack[#stack + 1] = ("%s(table)"):format(name)
          restrain(v, ("val|k=%s(%s) v=%s(%s)"):format(tostring(k), type(k), tostring(v), type(v)))
          stack[#stack] = nil
        end
      end
    end
  end
  
  restrain(start, root or "root")
  return res
end

function debug.findall(comp)
  local res = debug.findobj(_G, comp, "root")
  local rs = debug.findobj(debug.GetRegistry(), comp, "registry")
  for ii = 1, #rs do
    res[#res + 1] = rs[ii]
  end
  return res
end

function debug.logCall(b)
  if b then
    debug.sethook(function(event, line)
      Log.debug("hook ", Log.traceback())
    end, "c")
  else
    debug.sethook()
  end
end

function debug.dumpreg()
  App.ClearMemory()
  local str = ""
  collectgarbage("collect")
  local tb = debug.getregistry()
  local strs = {}
  for k2, v2 in next, tb, nil do
    local v2str = tostring(v2)
    strs[#strs + 1] = tostring(k2)
    strs[#strs + 1] = tostring("=")
    strs[#strs + 1] = v2str
    strs[#strs + 1] = tostring("\n")
  end
  Log.error(table.concat(strs))
  str = str .. tostring(table.concat(strs)) .. "\n"
  strs = {}
  for k2, v2 in next, tb, nil do
    local v2str = tostring(v2)
    if tostring(v2):find("null") or tostring(v2):find("<invalid c# object>") then
      local o = debug.findobj(_G, function(tb)
        return tostring(tb) == v2str and tb == v2
      end)
      local str1 = string.format("_G[%s][%s][%s]", tostring(k2), v2str, table.tostr(o))
      Log.error(str1)
      str = str .. str1 .. "\n"
      local o = debug.findobj(debug.getregistry(), function(tb)
        return tostring(tb) == v2str and tb == v2
      end)
      local str2 = string.format("Reg[%s][%s][%s]", tostring(k2), v2str, table.tostr(o))
      Log.error("Reg[%s][%s][%s]", tostring(k2), v2str, table.tostr(o))
      return str .. str2
    end
    strs[#strs + 1] = tostring(k2)
    strs[#strs + 1] = tostring("=")
    strs[#strs + 1] = v2str
    strs[#strs + 1] = tostring("\n")
  end
  local str3 = table.concat(strs)
  Log.error(str3)
  return str .. str3
end

function debug.regfunc()
  local regidtry = debug.getregistry()
  local funcs = {}
  for k, v in next, regidtry, nil do
    if type(v) == "function" then
      local info = debug.getinfo(v)
      local funckey = string.format("%s%s", info.source, info.linedefined)
      funcs[funckey] = (funcs[funckey] or 0) + 1
    end
  end
  return funcs
end

local function cnttb(tb)
  local cnt = 0
  for k, v in next, tb, nil do
    cnt = cnt + 1
  end
  return cnt
end

function debug.getupvalues(f)
  local ups = {}
  local i = 1
  while true do
    local a, b = debug.getupvalue(f, i)
    if not a then
      break
    end
    i = i + 1
    ups[a] = b
  end
  return ups
end

local function exceedtb(env, tb, head)
  if type(tb) ~= "table" then
    return
  end
  local visited = env.visited
  if visited[tb] then
    return
  end
  visited[tb] = true
  env.visitedn = env.visitedn + 1
  local paths = env.paths
  local n = cnttb(tb)
  if 100 < n then
    paths[head] = n
    env.pathtbs[head] = tb
  end
  for k, v in next, tb, nil do
    if type(k) == "table" then
      exceedtb(env, k, head .. "/val|" .. tostring(v))
      local meta = getmetatable(k)
      if meta then
        exceedtb(env, meta, string.format("%s/val=%s|%s(table).meta", head, tostring(v), tostring(k)))
      end
    elseif type(k) == "function" then
      if not visited[k] then
        visited[k] = true
        env.visitedn = env.visitedn + 1
        local ups = debug.getupvalues(k)
        local info = debug.getinfo(k)
        exceedtb(env, ups, string.format("%s/val=%s(function %s@%s)", head, tostring(v), info.linedefined, info.short_src))
      end
    elseif type(k) == "userdata" then
      local meta = getmetatable(k)
      if meta then
        exceedtb(env, meta, string.format("%s/val=%s|%s(userdata).meta", head, tostring(v), tostring(k)))
      end
    end
    if type(v) == "table" then
      exceedtb(env, v, string.format("%s/%s(table)", head, k))
      local meta = getmetatable(v)
      if meta then
        exceedtb(env, meta, string.format("%s/%s(table).meta", head, v))
      end
    elseif type(v) == "function" then
      if not visited[v] then
        visited[v] = true
        env.visitedn = env.visitedn + 1
        local ups = debug.getupvalues(v)
        local info = debug.getinfo(v)
        exceedtb(env, ups, string.format("%s/%s(function %s@%s)", head, tostring(k), info.linedefined, info.short_src))
      end
    elseif type(v) == "userdata" then
      local meta = getmetatable(v)
      if meta then
        exceedtb(env, meta, string.format("%s/%s(userdata).meta", head, k))
      end
    end
  end
  local meta = getmetatable(tb)
  if meta then
    exceedtb(env, meta, head .. "/metatable")
  end
end

function debug.findexceedtb()
  collectgarbage("collect")
  local env = {
    paths = {},
    pathtbs = {},
    visited = {},
    visitedn = 0
  }
  Log.error("findexceedtb")
  exceedtb(env, _G, "_G")
  Log.error("findexceedtb._G")
  exceedtb(env, debug.getregistry(), "registry")
  return env.paths, env.pathtbs
end
