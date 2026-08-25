local next = _ENV.next
local hardreload = {}
local upvalue_map = {}

local function same_proto(f1, f2)
  local uv = {}
  local i = 1
  while true do
    local name = debug.getupvalue(f1, i)
    if nil == name then
      break
    end
    if "_ENV" ~= name then
      uv[name] = true
    end
    i = i + 1
  end
  i = 1
  while true do
    local name = debug.getupvalue(f2, i)
    if nil == name then
      return true
    end
    if "_ENV" ~= name and nil == uv[name] and nil == upvalue_map[name] then
      return false
    end
    uv[name] = nil
    i = i + 1
  end
end

function hardreload.collect_up(m)
  local clone = clonefunc.clone
  local proto = clonefunc.proto
  
  local function collect(a)
    local p1, n1 = proto(a)
    local i = 1
    while true do
      local name = debug.getupvalue(a, i)
      if nil == name then
        break
      end
      if "_ENV" ~= name then
        upvalue_map[name] = {a, i}
      end
      i = i + 1
    end
    for j = 1, n1 do
      collect(clone(a, j))
    end
  end
  
  collect(m)
end

function hardreload.diff(m1, m2)
  local clone = clonefunc.clone
  local proto = clonefunc.proto
  local diff = {}
  local err
  
  local function funcinfo(f)
    local info = debug.getinfo(f, "S")
    do return string.format, "%s(%d-%d)", info.short_src, info.linedefined end
    return string.format, "%s(%d-%d)", info.short_src, info.linedefined, info.lastlinedefined
  end
  
  local function diff_(a, b)
    local p1, n1 = proto(a)
    local p2, n2 = proto(b)
    if nil == p1 or nil == p2 or n1 ~= n2 then
      err = err or {}
      table.insert(err, funcinfo(a) .. "/" .. funcinfo(b))
      return
    end
    if not same_proto(a, b) then
      err = err or {}
      table.insert(err, funcinfo(a) .. "/" .. funcinfo(b))
    end
    diff[p1] = b
    for i = 1, n1 do
      diff_(clone(a, i), clone(b, i))
    end
  end
  
  diff_(m1, m2)
  return diff, err
end

local function findloader(name)
  local msg = {}
  for _, loader in ipairs(package.searchers) do
    local f, extra = loader(name)
    local t = type(f)
    if "function" == t then
      return f, extra
    elseif "string" == t then
      table.insert(msg, f)
    end
  end
  error(string.format("module '%s' not found:%s", name, table.concat(msg)))
end

local loaders = {}
local origin = {}
local old_functions = setmetatable({}, {__mode = "k"})

function hardreload.require(name)
  assert(type(name) == "string")
  local _LOADED = debug.getregistry()._LOADED
  if _LOADED[name] then
    return _LOADED[name]
  end
  local loader, arg = findloader(name)
  local ret = loader(name, arg) or true
  loaders[name] = loader
  origin[name] = loader
  _LOADED[name] = ret
  return ret
end

local function update_funcs(proto_map)
  local root = debug.getregistry()
  local co = coroutine.running()
  local exclude = {
    [old_functions] = true,
    [origin] = true,
    [loaders] = true,
    [co] = true,
    [proto_map] = true
  }
  local getmetatable = debug.getmetatable
  local getinfo = debug.getinfo
  local getlocal = debug.getlocal
  local setlocal = debug.setlocal
  local getupvalue = debug.getupvalue
  local setupvalue = debug.setupvalue
  local getuservalue = debug.getuservalue
  local setuservalue = debug.setuservalue
  local upvaluejoin = debug.upvaluejoin
  local type = _ENV.type
  local next = next
  local rawset = _ENV.rawset
  local proto = clonefunc.proto
  local clone = clonefunc.clone
  local print = hardreload.print
  local error_log = hardreload.error_log
  local update_funcs_
  
  local function copy_function(f, nf)
    f = old_functions[f] or f
    local i = 1
    local oldf
    while true do
      local name = getupvalue(nf, i)
      if nil == name then
        break
      end
      local j = 1
      while true do
        local name2 = getupvalue(f, j)
        if nil == name2 then
          if not upvalue_map[name] then
            if error_log then
              error_log("ERROR upvalue", name, nf)
            end
            break
          end
          upvaluejoin(nf, i, table.unpack(upvalue_map[name]))
          break
        end
        upvalue_map[name2] = {f, j}
        if name == name2 then
          if print then
            print("HEHE upvalue", name, nf)
          end
          upvaluejoin(nf, i, f, j)
          break
        end
        j = j + 1
      end
      i = i + 1
    end
    old_functions[nf] = old_functions[nf] or oldf
    i = 1
    while true do
      local name, value = getupvalue(nf, i)
      if nil ~= name then
        if "_ENV" == name then
          if nil == value then
            setupvalue(nf, i, _ENV)
          end
          break
        end
      end
      i = i + 1
    end
  end
  
  local map = setmetatable({}, {
    __index = function(self, f)
      local nf = proto_map[proto(f)]
      if nil == nf then
        return nil
      end
      if false == nf then
        self[f] = f
        update_funcs_(f)
        return f
      end
      nf = clone(nf)
      copy_function(f, nf)
      self[f] = nf
      update_funcs_(nf)
      return nf
    end
  })
  exclude[exclude] = true
  exclude[map] = true
  
  local function update_funcs_frame(co, level)
    local info = getinfo(co, level + 1, "f")
    if nil == info then
      return
    end
    local f = info.func
    info = nil
    update_funcs_(f)
    local i = 1
    while true do
      local name, v = getlocal(co, level + 1, i)
      if nil == name then
        if i > 0 then
          i = -1
        else
          break
        end
      end
      local nv = map[v]
      if nv then
        if nv == v then
          if print then
            print("RESERVE local", name, v)
          end
        else
          if print then
            print("REPLACE local", name, v)
          end
          setlocal(co, level + 1, i, nv)
        end
      else
        update_funcs_(v)
      end
      if i > 0 then
        i = i + 1
      else
        i = i - 1
      end
    end
    do return update_funcs_frame, co end
    return update_funcs_frame, co, level + 1, update_funcs_, v, level + 1, i, nv
  end
  
  function update_funcs_(root)
    if exclude[root] then
      return
    end
    local t = type(root)
    if "table" == t then
      exclude[root] = true
      local mt = getmetatable(root)
      if mt then
        update_funcs_(mt)
      end
      local tmp
      for k, v in next, root, nil, nil do
        local nv = map[v]
        if nv then
          if nv == v then
            if print then
              print("RESERVE value", v)
            end
          else
            if print then
              print("REPLACE value", v)
            end
            rawset(root, k, nv)
            update_funcs_(nv)
          end
        else
          update_funcs_(v)
        end
        local nk = map[k]
        if nk then
          if nk == k then
            if print then
              print("RESERVE key", k)
            end
          else
            if nil == tmp then
              tmp = {}
            end
            tmp[k] = nk
          end
        else
          update_funcs_(k)
        end
      end
      if tmp then
        for k, v in next, tmp, nil, nil do
          root[k], root[v] = nil, root[k]
          if print then
            print("REPLACE key", k)
          end
        end
        tmp = nil
      end
    elseif "userdata" == t then
      exclude[root] = true
      local mt = getmetatable(root)
      if mt then
        update_funcs_(mt)
      end
      local uv = getuservalue(root)
      if uv then
        local tmp = map[uv]
        if tmp then
          if tmp == uv then
            if print then
              print("RESERVE uservalue", uv)
            end
          else
            if print then
              print("REPLACE uservalue", uv)
            end
            setuservalue(root, tmp)
          end
        else
          update_funcs_(uv)
        end
      end
    elseif "thread" == t then
      exclude[root] = true
      update_funcs_frame(root, 2)
    elseif "function" == t then
      exclude[root] = true
      local i = 1
      while true do
        local name, v = getupvalue(root, i)
        if nil == name then
          break
        end
        if v then
          local nv = map[v]
          if nv then
            if nv == v then
              if print then
                print("RESERVE upvalue", name, v)
              end
            else
              if print then
                print("REPLACE upvalue", name, v)
              end
              setupvalue(root, i, nv)
              update_funcs_(nv)
            end
          else
            update_funcs_(v)
          end
        end
        i = i + 1
      end
    end
  end
  
  for _, v in pairs({
    nil,
    0,
    true,
    "",
    co,
    update_funcs,
    debug.upvalueid(update_funcs, 1)
  }) do
    local mt = getmetatable(v)
    if mt then
      update_funcs_(mt)
    end
  end
  update_funcs_frame(co, 2)
  update_funcs_(root)
end

function hardreload.print(...)
end

function hardreload.reload(name, updatename)
  assert(type(name) == "string")
  updatename = updatename or name
  local _LOADED = debug.getregistry()._LOADED
  if nil == _LOADED[name] then
    do return hardreload.require end
    return hardreload.require, name, nil, nil, nil, nil, nil, nil, nil
  end
  if nil == loaders[name] then
    return false, "Can't find last version : " .. name
  end
  local loader = findloader(updatename)
  upvalue_map = {}
  hardreload.collect_up(loaders[name])
  local diff, err = hardreload.diff(loaders[name], loader)
  if err then
    if loaders[name] == origin[name] then
      return false, table.concat(err, "\n")
    end
    local _, err = hardreload.diff(origin[name], loader)
    if err then
      return false, table.concat(err, "\n")
    end
  end
  upvalue_map = {}
  update_funcs(diff)
  update_funcs(diff)
  loaders[name] = loader
  return true, _LOADED[name]
end

function hardreload.is_valid()
  return clonefunc and type(clonefunc) == "table" and clonefunc.clone and clonefunc.proto
end

return hardreload
