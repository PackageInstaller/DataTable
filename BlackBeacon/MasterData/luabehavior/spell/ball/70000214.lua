local M = Util.create_class()

function M:_init()
end

function M:on_start()
  cast_magic(self.npc, self.npc, 7000021401)
end

function M:after_damage_target(target, magic_id, damage_sign, damage_type)
  if 5 == damage_sign then
    cast_magic(self.npc, target, 7000021402)
    cast_magic(self.npc, target, 7000021403)
  end
end

return M
