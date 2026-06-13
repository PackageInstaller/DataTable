local Base = import("character.base.base_monster")
local M = Util.create_child_mt(Base)
local CommonMonster = import("common.monster")
local monsterTool = import("common.monster_tool")
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE

function M:_init(npc)
  Base._init(self)
  self.Skill01 = {
    2010050901,
    8,
    0,
    1.5,
    3,
    get_skill_cfg(2010050101).CastTime,
    get_skill_cfg(2010050101).AfterTime
  }
  self.selfcastmissileID = 0
  self.target = nil
  self.FirstTimeEnter = true
  self.InwaterTimer = 0
  self.InwaterInterval = 3
  self.inwater = false
end

function M:skill_main_logic()
  local Currenttime = get_npc_time(self.npc)
  if check_magic(self.npc, 2010050112) == false then
    self:cast_skill(self.Skill01)
    cast_magic(self.npc, self.npc, 2010050112, 1)
    cast_magic(self.npc, self.npc, 30010050101, 1)
    cast_magic(self.npc, self.npc, 300100501012, 1)
    cast_magic(self.npc, self.npc, 300100501013, 1)
    set_npc_hp_visible(self.npc, false)
  end
end

function M:on_hero_showup_or_back(npc, is_showup, by_ult_change)
  local Player = get_come_on_hero()
  if npc == Player then
    if check_magic(Player, 2010050114) == true then
      abort_magic_by_id(Player, 2010050114, 1)
    end
    if true == check_magic(Player, 2010050115) then
      abort_magic_by_id(Player, 2010050115, 1)
      cast_magic(Player, Player, 2010050116, 1)
    end
  end
end

function M:on_missile_end_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= self.npc then
    return
  end
  if missile == self.selfcastmissileID then
    abort_skill(self.npc, true)
    abort_magic_by_id(self.npc, 2010050112, 1)
  end
end

function M:on_born_behavior()
  cast_magic(self.npc, self.npc, 2010050113, 1)
  cast_magic(self.npc, self.npc, Const.LOCK_MASK, 1)
  cast_magic(self.npc, self.npc, 2010050117, 1)
  set_npc_hp_visible(self.npc, false)
  enable_shadow(self.npc, false)
end

function M:on_skill_hit(npc, skill_id, hit_target, hit_type, missile_cfg, missile)
  if npc ~= self.npc then
    return
  end
  if hit_target == search_npc(self.npc, 7, 5, nil, false, false, nil, 1) then
    if check_magic(search_npc(self.npc, 7, 5, nil, false, false, nil, 1), 2010050111) == false then
      cast_magic(self.npc, search_npc(self.npc, 111, 5, nil, false, false, nil, 1), 2010050111, 1)
      hit_target.magiccaster = self.npc
    end
    if false == check_magic(search_npc(self.npc, 7, 5, nil, false, false, nil, 1), 2010050114) then
      cast_magic(self.npc, search_npc(self.npc, 111, 5, nil, false, false, nil, 1), 2010050114, 1)
      hit_target.magiccaster = self.npc
    end
    if false == check_magic(search_npc(self.npc, 7, 5, nil, false, false, nil, 1), 2010050115) then
      cast_magic(self.npc, search_npc(self.npc, 111, 5, nil, false, false, nil, 1), 2010050115, 1)
      hit_target.magiccaster = self.npc
    end
    if self.FirstTimeEnter == true then
      self.FirstTimeEnter = false
      self.InwaterTimer = get_npc_time(self.npc)
      self.inwater = true
    end
  end
end

function M:check_Player_timer_in_water()
  local Player = get_come_on_hero()
  if nil == Player then
    return
  end
  if self.inwater == true and get_npc_time(self.npc) >= self.InwaterTimer + self.InwaterInterval and check_magic(Player, 2010050118) == false then
    cast_magic(self.npc, Player, 2010050118, 1)
  end
  if false == check_npc_distance(self.npc, Player, 2, false) and Player.magiccaster == self.npc and true == check_magic(Player, 2010050114) then
    abort_magic_by_id(Player, 2010050114, 1)
    abort_magic_by_id(Player, 2010050115, 1)
    abort_magic_by_id(Player, 2010050118, 1)
    abort_magic_by_id(Player, 2010050111, 1)
    self.FirstTimeEnter = true
    self.inwater = false
    cast_magic(self.npc, Player, 2010050116, 1)
  end
end

function M:on_magic_end(npc, target, magic_id)
  if search_npc(self.npc, 7, 5, nil, false, false, nil, 1) == nil then
    return
  end
  if 2010050115 == magic_id then
    cast_magic(self.npc, search_npc(self.npc, 7, 5, nil, false, false, nil, 1), 2010050116, 1)
  end
end

function M:cast_skill(skill_instant)
  cast_skill(self.npc, nil, skill_instant[1])
end

function M:on_missile_begin_pos(owner, pos_x, pos_z, missile_cfg, missile)
  if owner ~= self.npc then
    return
  end
  if missile_cfg.Id == 201005010101 then
    monsterTool.blueWaters = monsterTool.blueWaters or {}
    missile.movetoNum = 0
    missile.drinkNum = 0
    missile.drinkDis = 2
    missile.drinkNum_Max = 1
    monsterTool.blueWaters[missile] = missile
    waterpos = {
      missile,
      pos_x,
      pos_z
    }
    self.selfcastmissileID = missile
  end
end

function M:on_frame()
  self:check_Player_timer_in_water()
  self:skill_main_logic()
  CommonMonster.monster_on_frame(self)
  CommonMonster.platform_move(self)
end

return M
