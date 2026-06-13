local M = Util.create_class()
local hero = get_come_on_hero()
local god = get_god_npc()

function M:_init(npc)
  self.god_skill = false
end

function M:on_start()
  self.level = get_ability_level(60024) or 1
  listen_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self.on_skact_begin, self)
end

function M:on_room_change(npc)
  self.level = get_ability_level(60024) or 1
end

function M:on_remove()
  unlisten_custom_event_mq(Const.SKACT_EVT_TYPE.ON_BEGIN, self.npc, self)
end

function M:on_skill_begin(npc, skill_id, skill_type)
  if 1 == self.level then
    return
  end
  if 6 == skill_type then
    self.god_skill = true
  end
end

function M:on_skact_begin(npc, act)
  if act.role.npc ~= self.npc then
    return
  end
  if 1 == self.level and not act:deemUlt() then
    return
  end
  if self.level > 1 and not act:deemUlt() and not self.god_skill then
    return
  end
  self.god_skill = false
  hero = get_come_on_hero()
  god = get_god_npc()
  local godID = get_npc_id(god)
  if 6171091 == godID then
    if 0 == get_god_skill_level() or 1 == get_god_skill_level() then
      cast_magic(hero, god, 61710041, 0)
    elseif 2 == get_god_skill_level() then
      cast_magic(hero, god, 61710042, 0)
    elseif 3 == get_god_skill_level() then
      cast_magic(hero, god, 61710043, 0)
    end
  elseif 6170691 == godID then
    if 0 == get_god_skill_level() or 1 == get_god_skill_level() then
      cast_magic(hero, god, 61710044, 0)
    elseif 2 == get_god_skill_level() then
      cast_magic(hero, god, 61710045, 0)
    elseif 3 == get_god_skill_level() then
      cast_magic(hero, god, 61710046, 0)
    end
  elseif 6170791 == godID then
    if 0 == get_god_skill_level() or 1 == get_god_skill_level() then
      cast_magic(hero, god, 61710047, 0)
    elseif 2 == get_god_skill_level() then
      cast_magic(hero, god, 61710048, 0)
    elseif 3 == get_god_skill_level() then
      cast_magic(hero, god, 61710049, 0)
    end
  elseif 6170991 == godID then
    if 0 == get_god_skill_level() or 1 == get_god_skill_level() then
      cast_magic(hero, god, 617100491, 0)
    elseif 2 == get_god_skill_level() then
      cast_magic(hero, god, 617100492, 0)
    elseif 3 == get_god_skill_level() then
      cast_magic(hero, god, 617100493, 0)
    end
  elseif 6170891 == godID then
    if 0 == get_god_skill_level() or 1 == get_god_skill_level() then
      cast_magic(hero, god, 617100494, 0)
    elseif 2 == get_god_skill_level() then
      cast_magic(hero, god, 617100495, 0)
    elseif 3 == get_god_skill_level() then
      cast_magic(hero, god, 617100496, 0)
    end
  elseif 6171191 == godID then
    if 0 == get_god_skill_level() or 1 == get_god_skill_level() then
      cast_magic(hero, god, 617100497, 0)
    elseif 2 == get_god_skill_level() then
      cast_magic(hero, god, 617100498, 0)
    elseif 3 == get_god_skill_level() then
      cast_magic(hero, god, 617100499, 0)
    end
  end
end

return M
