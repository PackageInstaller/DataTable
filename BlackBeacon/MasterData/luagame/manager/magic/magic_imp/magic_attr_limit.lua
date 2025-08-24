local Base = require("manager.magic.magic_imp.magic_base")
local _max = math.max
local _min = math.min
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

function M:change_attr_limit(magic_type_list)
  local magic_cfg = self.cfg
  local attr_type = magic_cfg[1]
  local attr_mngr = self.owner.attr_mgr
  local attr_min, attr_max
  for index, magic in pairs(magic_type_list) do
    local cfg = magic.cfg
    local attr_id = cfg[1]
    local attr_min_cfg = cfg[2]
    local attr_max_cfg = cfg[3]
    local refer_attr_id = cfg[4]
    if refer_attr_id then
      local coeff = assert(attr_mngr:get_attr(refer_attr_id), refer_attr_id)
      attr_min_cfg = attr_min_cfg and attr_min_cfg / 10000 * coeff
      attr_max_cfg = attr_max_cfg and attr_max_cfg / 10000 * coeff
    end
    if attr_id and attr_type == attr_id then
      if not attr_min then
        attr_min = attr_min_cfg
      else
        attr_min = attr_min_cfg and _max(attr_min_cfg, attr_min) or attr_min
      end
      if not attr_max then
        attr_max = attr_max_cfg
      else
        attr_max = attr_max_cfg and _min(attr_max_cfg, attr_max) or attr_max
      end
    end
  end
  if attr_min and attr_max and attr_min > attr_max then
    error(string.format("添加锁定属性区间magic时下限高于上限, id: %d, 目标npc: %d.%d, 下限: %f, 上限: %f", self.magic_id, self:get_npc_id(), self.owner.uuid, attr_min, attr_max))
  end
  attr_mngr:set_magic_attr_limit(attr_type, attr_min, attr_max, self.magic_id)
end

function M:on_effect(magic_type_list)
  self:change_attr_limit(magic_type_list)
end

function M:on_remove(magic_type_list)
  self:change_attr_limit(magic_type_list)
end

return M
