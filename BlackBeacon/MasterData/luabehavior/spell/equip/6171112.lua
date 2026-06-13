local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")
local fanji_times = 0

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
  self.level = get_ability_level(10010) or 1
end

function M:on_room_change(npc)
  self.level = get_ability_level(10010) or 1
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:deemUlt() then
    self.is_ult = true
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if self.is_ult then
    if get_npc_shield(self.npc) > 0 then
      cast_missile3(self.npc, self.npc, nil, nil, 61711910408, self.level)
      cast_magic(self.npc, self.npc, 61711122)
    end
    self.is_ult = false
  end
end

function M:_init(npc)
end

return M
