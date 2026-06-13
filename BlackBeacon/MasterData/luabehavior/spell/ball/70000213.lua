local M = Util.create_class()

function M:_init()
end

function M:on_start()
end

function M:on_skill_begin(npc, skill_id, skill_type)
end

function M:on_element_aborn_start(npc, element, skill_id, attacker)
  if 5 == element and attacker == self.npc then
    if get_tough_record_state(npc) then
      abort_magic_by_id(npc, 7000021301)
      cast_magic(attacker, npc, 7000021302, 1)
    else
      abort_magic_by_id(npc, 7000021302)
      cast_magic(attacker, npc, 7000021301, 1)
    end
  end
end

function M:on_element_aborn_end(npc, element, attacker)
  if 5 == element and attacker == self.npc then
    abort_magic_by_id(npc, 7000021302)
    abort_magic_by_id(npc, 7000021301)
  end
end

return M
