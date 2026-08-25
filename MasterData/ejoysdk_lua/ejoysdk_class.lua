local Class = {
  __ClassType__ = "<base class>"
}
Class.__index = Class

function Class:Inherit(class_type)
  local o = {}
  o.__index = o
  o.__ClassType__ = class_type or "<base class>"
  if self.__tostring then
    o.__tostring = self.__tostring
  end
  do return setmetatable, o end
  return setmetatable, o, self
end

function Class:New(...)
  local o = {}
  setmetatable(o, self)
  self._class = self
  if o._init then
    o:_init(...)
  end
  return o
end

function Class:Impl(o, ...)
  setmetatable(o, self)
  if o._init then
    o:_init(...)
  end
  return o
end

function Class:__tostring()
  local mt = getmetatable(self)
  local tbl_str = tostring(setmetatable(self, {}))
  setmetatable(self, mt)
  if self._class then
    return self._class.__ClassType__ .. "实例: " .. tbl_str
  else
    return self.__ClassType__ .. "类:" .. tbl_str
  end
end

return Class
