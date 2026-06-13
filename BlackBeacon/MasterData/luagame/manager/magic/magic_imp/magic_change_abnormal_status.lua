local FightDefine = require("cs_share.fight_define")
local char_abnormal_map = FightDefine.CHAR_ABNORMAL_MAP
local ABNORMAL_STATUS = FightDefine.ABNORMAL_STATUS

local function check_need_skip_operation(new_state, cur_states, action_open_state)
  if new_state == cur_states then
    return true
  elseif cur_states == ABNORMAL_STATUS.CLOSE and new_state == ABNORMAL_STATUS.IMMUNITY then
    return true
  elseif action_open_state and cur_states == ABNORMAL_STATUS.CLOSE then
    return true
  end
  return false
end

local Base = require("manager.magic.magic_imp.magic_base")
local M = Util.create_child_mt(Base)

function M:_init(owner, magic_info)
  Base._init(self, owner, magic_info)
end

local EFFECT_TYPE = {
  CHANGE_STATUS = 1,
  CHANGE_VALUE = 2,
  CLEAR_ABNORMAL_STATUS = 3
}
local EFFECT_FUNC_NAME = {
  [EFFECT_TYPE.CHANGE_STATUS] = "change_status",
  [EFFECT_TYPE.CHANGE_VALUE] = "change_value",
  [EFFECT_TYPE.CLEAR_ABNORMAL_STATUS] = "clear_abnormal_status"
}
local CLEAR_TYPE = {CLEAR_VALUE_COUNT = 1, CLEAR_EFFECT = 2}

function M:change_status(element_id, param3)
  self:_change_status(element_id, param3)
end

function M:_change_status(element_id, status)
  local action_open_state = self.cfg[4] ~= nil and self.cfg[4] > 0
  local attr_id = FightDefine.ELEMENT_TO_AB_ATTR[element_id]
  if not attr_id or not char_abnormal_map[attr_id] then
    return
  end
  local nStatus = self.owner.attr_mgr:get_abnormal_status(attr_id)
  if check_need_skip_operation(status, nStatus, action_open_state) then
    return
  end
  self.owner.attr_mgr:change_abnormal_status(attr_id, status)
end

function M:change_value(param2, param3)
  local element_abnormal_mgr = self.owner.element_abnormal_mgr
  if not element_abnormal_mgr then
    return
  end
  local value = param3
  local value_type = self.cfg[4]
  local change_type = self.cfg[5]
  self:_change_value(param2, value, value_type, change_type)
end

function M:_change_value(element_id, value, value_type, change_type)
  local attacker = self.magic_info.attacker
  if self.owner:is_npc() and attacker and (attacker:is_hero() or attacker:is_summons()) then
    self.owner.element_abnormal_mgr:cache_abnor_magic(attacker, self.magic_info.owner_skill_id, element_id)
  else
    Log.Error("修改元素异常属性状态  参数1为2时，caster只能是角色、角色召唤物，target只能是怪物， Caster ID: ", self.magic_info.attacker.id, "target ID: ", self.owner.id, debug.traceback())
    return
  end
  self.owner.element_abnormal_mgr:set_element_value(attacker, element_id, value, value_type, change_type)
end

function M:clear_abnormal_status(param2, param3)
  local element_abnormal_mgr = self.owner.element_abnormal_mgr
  if not element_abnormal_mgr then
    return
  end
  self:_clear_abnormal_status(param2, param3)
end

function M:_clear_abnormal_status(element_id, clear_type)
  local element_abnormal_mgr = self.owner.element_abnormal_mgr
  if not element_abnormal_mgr then
    return
  end
  if clear_type == CLEAR_TYPE.CLEAR_VALUE_COUNT then
    self.owner.element_abnormal_mgr:reset_abnromal_value(element_id, true)
    self.owner.magic_mgr:remove_abnormal_flag_magic(element_id)
  elseif clear_type == CLEAR_TYPE.CLEAR_EFFECT then
    self.owner.element_abnormal_mgr:reset_abnormal_state(element_id)
    self.owner.element_abnormal_mgr:clear_element_delay_effect(element_id)
  end
end

function M:on_effect_after()
  if not self.owner:is_npc() then
    return
  end
  local func_name = EFFECT_FUNC_NAME[self.cfg[1]] or EFFECT_FUNC_NAME[EFFECT_TYPE.CHANGE_STATUS]
  if not self[func_name] then
    return
  end
  if type(self.cfg[2]) == "table" then
    local param3 = self.cfg[3]
    local param3_is_table = type(param3) == "table"
    for index, param2 in pairs(self.cfg[2]) do
      self[func_name](self, param2, param3_is_table and param3[index] or param3)
    end
  else
    local param2 = tonumber(self.cfg[2])
    local param3 = tonumber(self.cfg[3])
    self[func_name](self, param2, param3)
  end
end

function M:on_remove()
end

return M
