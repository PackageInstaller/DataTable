local M = Util.create_class()

function M:_init(attacker, magic_id, owner_missile, owner_skill, magic_level, part_id, ext_args, deyla_time, start_time, is_real, single_add_count)
  self.delay_time = deyla_time
  self.start_time = start_time
  self.attacker = attacker
  self.magic_id = magic_id
  self.owner_missile = owner_missile
  self.owner_skill = owner_skill
  self.magic_level = magic_level
  self.part_id = part_id
  self.ext_args = ext_args
  self.is_real = is_real
  self.single_add_count = single_add_count
end

function M:on_destroy()
  self.delay_time = nil
  self.start_time = nil
  self.attacker = nil
  self.magic_id = nil
  self.owner_missile = nil
  self.owner_skill = nil
  self.magic_level = nil
  self.part_id = nil
  self.ext_args = nil
  self.is_real = nil
  self.single_add_count = nil
end

return M
