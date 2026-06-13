local M = Util.create_class()
local team_hero_list = {}
local shield_hp1 = 0
local shield_hp2 = 0
local shield_hp3 = 0
local ability = 10002
local level = 1
local is_add = true

function M:_init(npc)
  team_hero_list = {
    get_come_on_hero(),
    get_scene_hero_by_poskey(21),
    get_scene_hero_by_poskey(22)
  }
end

function M:on_start()
end

function M:on_frame()
  if self.npc == get_come_on_hero() then
    shield_hp1 = get_npc_shield(self.npc)
    if shield_hp1 > 0 then
      if not check_magic(self.npc, 61700021) then
        cast_magic(self.npc, self.npc, 61700021, level)
      end
    elseif check_magic(self.npc, 61700021) then
      abort_magic_by_id(self.npc, 61700021)
    end
  end
end

return M
