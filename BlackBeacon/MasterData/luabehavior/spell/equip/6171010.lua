local M = Util.create_class()
local linkMgr = import("character.base.base_linkManager")
local hero = get_come_on_hero()
local team_hero_list = {
  get_scene_hero_by_poskey(21),
  get_scene_hero_by_poskey(22),
  get_come_on_hero()
}

function M:_init(npc)
end

function M:on_start()
  self.level = get_ability_level(60018) or 1
  if not check_magic(self.npc, 6171001) then
    for k, v in pairs(team_hero_list) do
      cast_magic(self.npc, v, 6171001, 0)
    end
  end
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_room_change(npc)
  self.level = get_ability_level(60018) or 1
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
    self.is_ult = false
    local stage = linkMgr:getLinkStage()
    if 4 == stage then
      if self.level > 1 then
        cast_magic(self.npc, self.npc, 61710023, 0)
      elseif 1 == self.level then
        cast_magic(self.npc, self.npc, 61710022, 0)
      end
    end
  end
end

return M
