local M = Util.create_class()
local team_hero_list = {}
local time_sphere = get_god_npc()
local time_sphere_skill = 617069101
local time_sphere_missile = 61706910101
local huisu = 61706331
local huisu2 = 61706141
local weilai = 61706341
local black_hole_water_id = 61706910501
local black_hole_fire_id = 61706910502
local black_hole_thunder_id = 61706910503
local black_hole_light_id = 61706910504
local black_hole_dark_id = 61706910505

function M:_init(npc)
end

function M:on_magic_begin(npc, target, magic_id, is_self, magic_level)
  if target ~= self.npc then
    return
  end
  if (magic_id == huisu or magic_id == huisu2 or magic_id == weilai) and check_magic(self.npc, huisu) and check_magic(self.npc, weilai) then
    cast_magic(self.npc, self.npc, 61706041)
  end
end

function M:on_magic_end(npc, target, magic_id)
  if target ~= self.npc then
    return
  end
  if (magic_id == huisu or magic_id == huisu2 or magic_id == weilai) and (not check_magic(self.npc, huisu) or not check_magic(self.npc, weilai)) then
    abort_magic_by_id(self.npc, 61706041, 1)
  end
end

return M
