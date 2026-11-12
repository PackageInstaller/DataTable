local UIObjs = class("UIObjs")

local function _instanceIndex(t, name)
  local v = rawget(UIObjs, name)
  if v ~= nil then
    return v
  end
  if name == "_keys" then
    local _keys = string.split(t._CSUIObjs.Keys, ",")
    rawset(t, "_keys", _keys)
    return _keys
  end
  local maps = t._objMaps
  local cached = maps[name]
  if cached ~= nil then
    return cached
  end
  local obj = t._CSUIObjs:Get(name)
  if obj == nil then
    return nil
  end
  maps[name] = obj
  local type_name = obj:GetType().Name
  t._objTypeMaps[name] = type_name
  return obj, type_name
end

function UIObjs:ctor(CSUIObjs, ctrl)
  self._CSUIObjs = CSUIObjs
  self._objMaps = {}
  self._objTypeMaps = {}
  self._ctrl = ctrl
  setmetatable(self, {__index = _instanceIndex})
end

function UIObjs:Get(name)
  local obj = self[name]
  if obj == nil then
    return nil, nil
  end
  return obj, self._objTypeMaps[name]
end

return UIObjs
