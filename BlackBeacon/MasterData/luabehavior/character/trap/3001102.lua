local crystalMan = import("character.trap.3001103")
local crystalManList = crystalMan:getAllInst()
local monster = Util.create_class()
local skill_id = 300110201
local nearest_target, current_nav_target

function monster:_init(npc)
  self.npc = get_god_npc()
  self.is_button_pressed = false
  self.has_show_effect = false
  self.delayed_time = 0
  self.skill_cd = get_skill_cfg(skill_id).CdChargePerCost
  set_ui_object_visible("fight", "Btn_skill8", true)
end

function monster:on_input(input_id)
  if 60 ~= input_id then
    return
  end
  if get_npc_cd_charge(self.npc, skill_id) < self.skill_cd then
    cast_magic(self.npc, self.npc, 100158, 1)
    return
  else
    cast_skill(self.npc, self.npc, skill_id)
    current_nav_target = self:check_nearest_alive_target()
    if nil ~= current_nav_target then
      create_navigator_effect(get_monster_npc_name(current_nav_target), true, true)
    end
  end
end

function monster:on_frame()
  if nil ~= current_nav_target and check_npc_die(current_nav_target) then
    create_navigator_effect(get_monster_npc_name(current_nav_target), false, false)
  end
end

function monster:check_nearest_alive_target()
  if nil ~= crystalManList then
    local nearest_distance = math.huge
    for key, value in pairs(crystalManList) do
      if not check_npc_die(value) then
        local calc_distance = get_npc_distance(self.npc, 1, value, false)
        if nearest_distance > calc_distance then
          nearest_distance = calc_distance
          nearest_target = value
        end
      end
    end
  else
  end
  return nearest_target
end

return monster
