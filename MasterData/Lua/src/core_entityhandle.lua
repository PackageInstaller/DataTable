local EntityHandle = CS.Lens.Gameplay.Modules.BigWorld.EntityHandle
local memberMap = {}
local BindingFlags = CS.System.Reflection.BindingFlags
local MemberTypes = CS.System.Reflection.MemberTypes
local members = typeof(EntityHandle):GetMembers(BindingFlags.Public | BindingFlags.Instance | BindingFlags.Static)
for i = 0, members.Length - 1 do
  local m = members[i]
  local name = m.Name
  if m.MemberType == MemberTypes.Constructor then
  elseif m.MemberType == MemberTypes.Method then
    if not m.IsSpecialName then
      memberMap[name] = true
    end
  else
    memberMap[name] = true
  end
end
local rawMeta = xlua.getmetatable(EntityHandle)
local getter = rawMeta.__index
local setter = rawMeta.__newindex

function rawMeta.IsNull(o)
  if getter(o, "entity") then
    return false
  else
    return true
  end
end

function rawMeta.__index(o, k)
  if memberMap[k] then
    return getter(o, k)
  elseif rawMeta[k] ~= nil then
    return rawMeta[k]
  end
  local entity = getter(o, "entity")
  if entity == nil then
    errorf("index " .. k .. " on a nil entityHandle")
    return nil
  end
  local v = entity[k]
  if type(v) == "function" then
    errorf(k .. " is a function of the entity")
    return function(h, ...)
      return v(h.entity, ...)
    end
  end
  return v
end

function rawMeta.__newindex(o, k, v)
  if memberMap[k] then
    setter(o, k, v)
    return
  end
  local entity = getter(o, "entity")
  if entity == nil then
    error("newindex " .. k .. " on a nil entityHandle")
  end
  entity[k] = v
end

function rawMeta.__tostring(o)
  local entity = getter(o, "entity")
  return string.format("entityHandle(%s)", tostring(entity))
end

xlua.setmetatable(EntityHandle, rawMeta)
