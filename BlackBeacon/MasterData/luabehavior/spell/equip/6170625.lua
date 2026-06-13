local M = Util.create_class()
local ultTime = false
local CD = 3
local current_time = 0
local element_magic = {
  [2] = 61706251,
  [3] = 61706252,
  [4] = 61706253,
  [5] = 61706254,
  [6] = 61706255
}

function M:_init(npc)
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:deemUlt() then
    ultTime = true
  end
end

function M:on_self_skill_hit(skill_id, hit_target, hit_type, missile_cfg, missile)
  if not ultTime then
    return
  end
  local kind = get_role_kind(hit_target)
  if 2 ~= kind and 3 ~= kind and 4 ~= kind then
    return
  end
  local level = get_ability_level(20016) or 1
  for i = 2, 6 do
    if check_element_ab_state(hit_target, i) and get_magic_num(hit_target, element_magic[i]) < 10 then
      if level > 1 then
        change_abnormal_flag_count(hit_target, i, 2)
      else
        change_abnormal_flag_count(hit_target, i, 1)
      end
    end
  end
  ultTime = false
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if ultTime then
    ultTime = false
  end
end

return M
