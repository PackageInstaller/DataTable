local clonefunc = require("clonefunc")
local hardreload = {}

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
    if "_ENV" ~= name and nil == uv[name] then
      return false
    end
    uv[name] = nil
    i = i + 1
  end
end

function hardreload.diff(m1, m2)
  local clone = clonefunc.clone
  local proto = clonefunc.proto
  local diff = {}
  
  local function funcinfo(f)
    local info = debug.getinfo(f, "S")
    return string.format("%s(%d-%d)", info.short_src, info.linedefined, info.lastlinedefined)
  end
  
  local function diff_(a, b)
    local p1, n1 = proto(a)
    local p2, n2 = proto(b)
    if nil == p1 or nil == p2 or n1 ~= n2 or not same_proto(a, b) then
      return funcinfo(a) .. "/" .. funcinfo(b)
    end
    diff[p1] = b
    for i = 1, n1 do
      local err = diff_(clone(a, i), clone(b, i))
      if err then
        return err
      end
    end
  end
  
  local err = diff_(m1, m2)
  if err then
    return false, err
  else
    return diff
  end
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

function hardreload.require(name)
  assert(type(name) == "string")
  local _LOADED = debug.getregistry()._LOADED
  if _LOADED[name] then
    return _LOADED[name]
  end
  local loader, arg = findloader(name)
  local ret = loader(name, arg) or true
  loaders[name] = loader
  _LOADED[name] = ret
  return ret
end

local function update_funcs(proto_map)
  local root = debug.getregistry()
  local co = coroutine.running()
  local exclude = {
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
  local next = _ENV.next
  local rawset = _ENV.rawset
  local proto = clonefunc.proto
  local clone = clonefunc.clone
  local print = hardreload.print
  local update_funcs_
  
  local function copy_function(f, nf)
    local i = 1
    while true do
      local name = getupvalue(f, i)
      if nil == name then
        break
      end
      local j = 1
      while true do
        local name2 = getupvalue(nf, j)
        if nil == name2 then
          assert("_ENV" == name)
          break
        end
        if name == name2 then
          upvaluejoin(nf, j, f, i)
          break
        end
        j = j + 1
      end
      i = i + 1
    end
    local name, value = getupvalue(nf, 1)
    if "_ENV" == name and nil == value then
      setupvalue(nf, 1, _ENV)
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
    return update_funcs_frame(co, level + 1)
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
          if uv then
            if nv == v then
              if print then
                print("RESERVE upvalue", name, v)
              end
            else
              if print then
                print("REPLACE upvalue", name, v)
              end
              setupvalue(root, i, uv)
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

function hardreload.reload(name, updatename)
  assert(type(name) == "string")
  updatename = updatename or name
  local _LOADED = debug.getregistry()._LOADED
  if nil == _LOADED[name] then
    return hardreload.require(name)
  end
  if nil == loaders[name] then
    return false, "Can't find last version : " .. name
  end
  local loader = findloader(updatename)
  local diff, err = hardreload.diff(loaders[name], loader)
  if not diff then
    return false, err
  end
  update_funcs(diff)
  loaders[name] = loader
  return _LOADED[name]
end

return hardreload
