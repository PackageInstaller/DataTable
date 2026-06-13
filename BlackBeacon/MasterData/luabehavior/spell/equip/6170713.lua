local M = Util.create_class()
local tool = import("common.tool")
local rogueMgr = import("common.rogueManager")

function M:_init(npc)
end

function M:on_toughness_change(npc, camp, change_level)
  if self.npc ~= get_come_on_hero() then
    return
  end
  for i = 1, 2 do
    cast_magic(self.npc, self.npc, rogueMgr.kuangnu)
  end
  cast_magic(self.npc, self.npc, 61707131)
  local level = get_ability_level(40011) or 1
  if level > 1 then
    for i = 1, 1 do
      cast_magic(self.npc, self.npc, rogueMgr.baojun)
    end
  end
end

function M:on_start()
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if act:deemAtk() and check_magic(self.npc, 61707131) then
    cast_magic(self.npc, self.npc, 61707134)
    self.is_pugong = true
  end
end

function M:on_self_skill_end(skill_id, is_time_out, is_break, behavior_abort)
  if self.is_pugong == true then
    abort_magic_by_id(self.npc, 61707134)
    self.is_pugong = false
  end
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

return M
