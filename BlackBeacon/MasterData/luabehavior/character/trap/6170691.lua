local M = Util.create_class()
local CommonRole = import("common.role")
local team_hero_list = {}
local MISSILE_EVT_TYPE = Const.MISSILE_EVT_TYPE
local rogueMgr = import("common.rogueManager")
local skill_area = {
  type = 1,
  res = "Fx_skill_maxrange",
  sizex = 10
}
local skill_indi_cfg = {
  type = 1,
  res = "Fx_skillarea_N1",
  sizex = 6
}
local skill_id = 617069101
local skill_cd = get_skill_cfg(skill_id).CdChargePerCost
local skill_missile_id = {
  [1] = 61706910101,
  [2] = 61706910201,
  [3] = 61706910301
}

function M:_init(npc)
  self.npc = get_god_npc()
  set_ui_object_visible("fight", "Btn_skill8", true)
  self.skill_missile_id = 61706910101
  self.bless_time_stop_skill = 617069104
  self.bless_time_stop_missile = 61706910401
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, skill_missile_id[1], self.on_timestop_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, skill_missile_id[1], self.on_timestop_release_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, skill_missile_id[2], self.on_timestop_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, skill_missile_id[2], self.on_timestop_release_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, skill_missile_id[3], self.on_timestop_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, skill_missile_id[3], self.on_timestop_release_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, npc, self.bless_time_stop_missile, self.on_bless_timestop_catch_npc, self)
  listen_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, npc, self.bless_time_stop_missile, self.on_bless_timestop_release_npc, self)
end

function M:on_remove()
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, skill_missile_id[1], self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, skill_missile_id[1], self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, skill_missile_id[2], self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, skill_missile_id[2], self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, skill_missile_id[3], self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, skill_missile_id[3], self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_CATCH_NPC, self.npc, self.bless_time_stop_missile, self)
  unlisten_missile_evt(MISSILE_EVT_TYPE.BOUND_RELEASE_NPC, self.npc, self.bless_time_stop_missile, self)
end

function M:on_timestop_catch_npc(owner, target_npc, missile_cfg, missile)
  if 1 ~= get_role_kind(target_npc) then
    cast_magic(self.npc, target_npc, 6170691001, 1)
  end
end

function M:on_timestop_release_npc(owner, target_npc, missile_cfg, missile)
  if 1 ~= get_role_kind(target_npc) then
    abort_magic_by_id(target_npc, 6170691001)
  end
end

function M:on_bless_timestop_catch_npc(owner, target_npc, missile_cfg, missile)
  if 1 ~= get_role_kind(target_npc) then
    cast_magic(self.npc, target_npc, 6170691001, 1)
  end
end

function M:on_bless_timestop_release_npc(owner, target_npc, missile_cfg, missile)
  if 1 ~= get_role_kind(target_npc) then
    abort_magic_by_id(target_npc, 6170691001)
  end
end

function M:on_input(input_id)
  if 60 == input_id then
    if 3 ~= get_god_skill_level() then
      if get_npc_cd_charge(self.npc, skill_id) >= skill_cd then
        update_skill_indicator(60, skill_area, skill_indi_cfg, 0.5)
        set_indicator_active(60, true, true)
      else
        cast_magic(self.npc, self.npc, 100158, 1)
      end
    else
      self:add_magic()
      cast_skill(self.npc, nil, skill_id, nil, nil)
    end
  end
end

function M:on_touch_up(output_id, iscancel)
  if 60 == output_id and not iscancel and get_npc_cd_charge(self.npc, skill_id) >= skill_cd and 3 ~= get_god_skill_level() then
    self.pos = {}
    self.pos.x, self.pos.y = get_indicator_pos(output_id)
    cast_skill_to_position(self.npc, skill_id, self.pos.x, self.pos.y)
    set_indicator_active(60, false)
    self:add_magic()
    CommonRole.indicator_slowdown_off(self)
  end
end

function M:get_level()
  local skill_data = {
    [1] = {
      id = 617069101,
      area = {
        type = 1,
        res = "Fx_skill_maxrange",
        sizex = 10
      },
      indi_cfg = {
        type = 1,
        res = "Fx_skillarea_N1",
        sizex = 6
      }
    },
    [2] = {
      id = 617069102,
      area = {
        type = 1,
        res = "Fx_skill_maxrange",
        sizex = 10
      },
      indi_cfg = {
        type = 1,
        res = "Fx_skillarea_N1",
        sizex = 12
      }
    },
    [3] = {
      id = 617069103,
      area = {
        type = 1,
        res = "Fx_skill_maxrange",
        sizex = 10
      },
      indi_cfg = {
        type = 1,
        res = "Fx_skillarea_N1",
        sizex = 6
      }
    }
  }
  local level = get_god_skill_level()
  if level >= 1 and level <= 3 then
    local data = skill_data[level]
    skill_id = data.id
    skill_area = data.area
    skill_indi_cfg = data.indi_cfg
    skill_cd = get_skill_cfg(skill_id).CdChargePerCost
    replace_hero_skill(8, skill_id)
    replace_tower_skill(level)
  end
end

function M:on_fate_book_battle_start()
  self:get_level()
end

function M:on_start()
  self:get_level()
end

function M:add_magic()
  local hero = get_come_on_hero()
  for i = 1, 10 do
    cast_magic(hero, hero, rogueMgr.weilai)
  end
  local role = hero:get_behavior()
  
  local function add_huisu()
    cast_magic(hero, hero, rogueMgr.huisu)
    cast_magic(hero, hero, rogueMgr.huisu_heal)
  end
  
  role:doAfter(add_huisu, 0.3)
end

return M
