local M = Util.create_class()
local tool = import("common.tool")

function M:_init(npc)
  set_hud_config_world("1001021_bar", {
    Prefab = "Fx_UI_H_1001021_Slider_Fill_1"
  }, 2, 74, 75)
  set_hud_config_world("1001021_bar1", {
    Prefab = "Fx_UI_H_1001021_Slider_Fill_2"
  }, 2, 74, 75)
  self.time = 0
  self.time_up = false
  self.BUFF_on = true
  active_hud_world(npc, "1001021_bar", "effectpoint_head", true)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if get_npc_attr(self.npc, 74) <= 0 then
    active_hud_world(self.npc, "1001021_bar", "effectpoint_head", true)
    active_hud_world(self.npc, "1001021_bar1", "effectpoint_head", false)
    self.time_up = false
  end
  if get_npc_attr(self.npc, 74) >= 100 then
    active_hud_world(self.npc, "1001021_bar", "effectpoint_head", false)
    active_hud_world(self.npc, "1001021_bar1", "effectpoint_head", true)
    self.time = get_npc_time(self.npc)
    self.time_up = true
  end
end

function M:sleep_time()
  if self.time_up == true then
    if get_npc_time(self.npc) >= self.time then
      self.time = self.time + 1
      cast_magic(self.npc, self.npc, 1021068, 1)
    end
    if true == self.BUFF_on then
      self.Azi:start_onFire()
      cast_magic(self.azi, self.npc, 1021111, 0)
      if self.azi:get_behavior().traceLv >= 4 then
        cast_magic(self.azi, self.npc, 1021063, 0)
        cast_magic(self.azi, self.npc, 10210631, 0)
      end
      if self.azi:get_behavior().destinyLv >= 5 then
        local JT_val = get_npc_attr(self.azi, 23)
        local magicLv = math.ceil(JT_val / 100) + 1
        if magicLv > 6 then
          magicLv = 6
        end
        cast_magic(self.azi, self.npc, 10210251, magicLv)
      end
      if self.azi:get_behavior().spWeapon.lv >= 1 then
        cast_magic(self.azi, self.npc, 1021112, self.azi:get_behavior().spWeapon.lv)
        cast_magic(self.azi, self.azi, 10211121, self.azi:get_behavior().spWeapon.lv)
        tool:castMagicToTeam(10211122, self.azi:get_behavior().spWeapon.lv, self.azi)
      end
      self.BUFF_on = false
    end
    if get_npc_attr(self.npc, 74) <= 0 then
      active_hud_world(self.npc, "1001021_bar", "effectpoint_head", false)
      active_hud_world(self.npc, "1001021_bar1", "effectpoint_head", false)
      self.time_up = false
      abort_magic_by_id(self.npc, 1021111)
      abort_magic_by_id(self.npc, 1021112)
      abort_magic_by_id(self.npc, 1021063)
      abort_magic_by_id(self.npc, 10210631)
      abort_magic_by_id(self.npc, 1021047)
    end
  end
end

function M:on_remove()
  self.Azi:remove_onFire(self.azi)
end

function M:on_frame()
  self:sleep_time()
end

return M
