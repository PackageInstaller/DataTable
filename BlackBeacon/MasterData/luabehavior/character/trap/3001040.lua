local Base = import("character.base.base_monster")
local M = Util.create_class()
local CommonMonster = import("common.monster")

function M:_init(npc)
  self.cam_offset = false
  self.cam_offset_timer = 0
  self.macoff = false
  self.water_pos = get_npc_offset_position(npc, nil, 90, 3)
  self.water_timer = get_time() + 9999999
  self.water_missile = nil
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
end

function M:skill_main_logic()
  if self.macoff then
    return
  end
  if not self.macoff and get_sync_var("mac1off") then
    cast_magic(self.npc, self.npc, 3001040002, 0)
    self.macoff = true
  end
  local nowtime = get_time()
  if get_sync_var("CamOffsetOn1") and not self.cam_offset then
    cast_magic(self.npc, self.npc, 3001040001, 0)
    change_follow_target(1, self.npc, {
      8,
      4.5,
      {
        x = 0,
        y = -0.2,
        z = 2
      },
      1.3,
      0.55
    })
    self.cam_offset = true
    self.cam_offsettimer = nowtime + 3
    self.water_timer = nowtime + 5
  elseif self.cam_offset and nowtime > self.cam_offsettimer then
    self.cam_offset = false
    set_sync_var("CamOffsetOn1", false)
    change_follow_target(0)
  end
  if get_sync_var("TimelineOn") then
    cast_magic(self.npc, self.npc, 3001040001, 0)
    set_sync_var("TimelineOn", false)
    self.water_timer = nowtime + 5
  end
  if get_sync_var("WaterOn") and nowtime > self.water_timer then
    cast_missile(self.npc, nil, self.water_pos.x, self.water_pos.z, 30010400101, 0)
    self.water_timer = nowtime + 15
  end
end

function M:wander_time(skill)
  self.wander_timer_skill_makeup = skill[6] + skill[7]
  self.wander_timer = get_time() + self.wander_timer_skill_makeup
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if owner == self.npc and 30010400101 == missile_cfg then
    set_sync_var("W1", missile)
  end
end

function M:on_frame()
  CommonMonster.search_target(self, 30, 8)
  self:skill_main_logic()
  set_npc_hp_visible(self.npc, false)
end

function M:on_skill_end(npc, skill_id)
  if npc ~= self.npc then
    return
  end
end

function M:on_npc_hp_zero(npc)
  if npc == self.npc then
  end
end

return M
