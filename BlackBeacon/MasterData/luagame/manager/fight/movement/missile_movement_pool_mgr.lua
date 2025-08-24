local Util = require("utils.util")
local M = Util.create_class()
local _insert = table.insert

function M:_init()
  self.v_free_map = setmetatable({}, Config.VALUE_WEAK_METATABLE)
end

function M:_get_missile_class(type)
  local map = require("manager.fight.missile").get_missle_classs()
  return map[type]
end

function M:new_obj(movement_type, ...)
  local list = self.v_free_map[movement_type]
  if nil == list then
    list = {}
    self.v_free_map[movement_type] = list
  end
  local obj
  local free_count = #list
  if 0 == free_count then
    local class = self:_get_missile_class(movement_type)
    obj = class:new(...)
  else
    obj = list[free_count]
    obj:_init(...)
    list[free_count] = nil
  end
  return obj
end

function M:release(movement_type, obj)
  local list = self.v_free_map[movement_type]
  if nil == list then
    return
  end
  _insert(self.v_free_map[movement_type], obj)
end

function M:release_all()
  UtilTable.clear_map(self.v_free_map)
end

return M
