local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local _tinsert = table.insert
local _tsort = table.sort
local _max = math.max

function M:init_sys()
  Base.init_sys(self)
  self.treasure_list = {}
  self.max_refresh_num = 0
  self.treasure_skill_list = {}
end

local function skill_cmp(a, b)
  local a_is_have = a.is_have == true
  local b_is_have = b.is_have == true
  if a_is_have ~= b_is_have then
    return a_is_have
  elseif a.is_use ~= b.is_use then
    return a.is_use
  else
    return a.final_lv < b.final_lv
  end
end

function M:cal_max_refresh_count()
  self.max_refresh_num = 0
  local list = SceneMgr:get_hero_list()
  assert(list, "can't get hero list")
  for _, hero in pairs(list) do
    local team_pos = hero:get_team_pos()
    local is_fixed, point_id, is_long_chapter_fixed, floor_id = ChapterMgr:check_cur_fight_fixed_team()
    local skill_cfg
    local is_robot = hero:is_robot()
    local buddy_id = hero.buddy_cfg.Id
    if is_long_chapter_fixed then
      local buddy_info = FixedBuddyMgr:get_buddy_info_by_floor_id(floor_id, team_pos)
      skill_cfg = buddy_info.lSkill
    elseif not is_fixed or not is_robot then
      skill_cfg = CharacterMgr:get_buddy_skill_by_id(buddy_id)
    else
      do
        local buddy_info = FixedBuddyMgr:get_buddy_info_by_point_id(point_id, team_pos, buddy_id)
        skill_cfg = buddy_info.lSkill
      end
    end
    for _, skill_data in pairs(skill_cfg) do
      local skill_lv_cfg = ShareRes.create("buddy.buddy_skill_level", skill_data.id)
      local lv = skill_data.lv
      local skill_info = skill_lv_cfg[lv]
      local privilegeType = skill_info.PrivilegeType
      local privilegeArg = skill_info.PrivilegeArg
      if 1 == privilegeType and nil ~= privilegeArg then
        self.max_refresh_num = _max(self.max_refresh_num, privilegeArg)
      end
    end
  end
end

function M:on_battle_treasure_info(data)
  self.treasure_list.refresh_cnt = data.refresh_cnt
  self.treasure_list.grid_list = data.grid_list
  MsgGame:mq_publish2(Const.MSG_ON_BATTLE_TREASURE_UPDATE)
end

function M:on_battle_treasure_item_info()
end

function M:_build_character_list()
  local own_buddy_list = CharacterMgr:get_buddy_list_show()
  local buddy_list = ShareRes.create("buddy.buddy")
  local skill_list_cfg = ShareRes.create("buddy.buddy_skill")
  local inbattle_hero = {}
  local own_buddy_skill = {}
  local inbattle_hero_list = SceneMgr:get_hero_list()
  assert(inbattle_hero_list, "can't get hero list")
  for idx, hero in pairs(inbattle_hero_list) do
    inbattle_hero[hero.buddy_cfg.Id] = idx
  end
  for _, buddy in pairs(own_buddy_list) do
    own_buddy_skill[buddy.id] = {}
    for _, skill_data in pairs(buddy.lSkill) do
      own_buddy_skill[buddy.id][skill_data.id] = skill_data.lv
    end
  end
  local is_fixed, point_id, is_long_chapter_fixed, floor_id = ChapterMgr:check_cur_fight_fixed_team()
  local team_pos = hero:get_team_pos()
  if not is_long_chapter_fixed then
    if is_fixed then
      for _, hero in pairs(inbattle_hero_list) do
        local buddy_id = hero.buddy_cfg.Id
        local buddy_info = FixedBuddyMgr:get_buddy_info_by_point_id(point_id, team_pos, buddy_id)
        if buddy_info then
          own_buddy_skill[buddy_info.id] = {}
          for _, skill_data in pairs(buddy_info.lSkill) do
            own_buddy_skill[buddy_info.id][skill_data.id] = skill_data.lv
          end
        end
      end
    end
  else
    local buddy_info = FixedBuddyMgr:get_buddy_info_by_floor_id(floor_id, team_pos)
    if buddy_info then
      own_buddy_skill[buddy_info.id] = {}
      for _, skill_data in pairs(buddy_info.lSkill) do
        own_buddy_skill[buddy_info.id][skill_data.id] = skill_data.lv
      end
    end
  end
  UtilTable.clear_list(self.treasure_skill_list)
  for _, buddy_cfg in pairs(buddy_list) do
    local buddy_id = buddy_cfg.Id
    local buddy_skill_cfg = skill_list_cfg[buddy_id]
    if buddy_skill_cfg then
      local skill_list = buddy_skill_cfg.Skill
      self:_build_single_character(buddy_cfg, buddy_id, skill_list, inbattle_hero, own_buddy_skill)
    end
  end
  _tsort(self.treasure_skill_list, skill_cmp)
end

function M:_build_single_character(buddy_cfg, buddy_id, skill_list, inbattle_hero, own_buddy_skill)
  for _, skill_id in pairs(skill_list) do
    local skill_lv_cfg = ShareRes.create("buddy.buddy_skill_level", skill_id)
    local skill_detail_cfg = ShareRes.create("buddy.buddy_skill_details", skill_id)
    local skill_name = skill_detail_cfg.Name
    local have_treasure_skill = false
    for _, skill_level_info in ipairs(skill_lv_cfg) do
      local privilegeType = skill_level_info.PrivilegeType
      local cfg_lv = skill_level_info.Lv
      local final_lv = 1
      local is_use = false
      local is_have = nil ~= own_buddy_skill[buddy_id]
      if nil ~= privilegeType then
        have_treasure_skill = true
        if own_buddy_skill[buddy_id] then
          local now_skill_lv = own_buddy_skill[buddy_id][skill_id]
          if cfg_lv > now_skill_lv then
            final_lv = cfg_lv
          else
            final_lv = now_skill_lv
            is_use = nil ~= inbattle_hero[buddy_id]
          end
        end
        local desc = skill_level_info.Desc
        local insert_data = {
          hero_name = buddy_cfg.Name,
          hero_icon = buddy_cfg.Icon[1],
          final_lv = final_lv,
          is_use = is_use,
          is_have = is_have,
          skill_name = skill_name,
          desc = desc
        }
        _tinsert(self.treasure_skill_list, insert_data)
        break
      end
    end
    if have_treasure_skill then
      break
    end
  end
end

function M:open_battle_treasure()
  Network:call("c2gs_battle_treasure_open", {}, function(ok)
    if ok then
      self:_build_character_list()
      local tower = TowerMgr:get_tower()
      if tower:is_challenge_ring_tower() then
        UIMgr:get_ui("ui_cr_treasure_box"):ui_show()
      else
        UIMgr:get_ui("uitreasure"):ui_show()
      end
    end
  end)
end

function M:refresh_battle_treasure()
  Network:call("c2gs_battle_treasure_refresh", {}, function(ok)
    if ok then
      Util.show_message_tip(2056)
    end
  end)
end

function M:choose_battle_treasure(index)
  Network:call("c2gs_battle_treasure_choose", {index = index}, function(ok)
    if ok then
      Util.show_message_tip(2051)
      local msg = MsgGame:mq_publish2(Const.MSG_ON_SELECTED_TREASURE_SUCCESS)
      msg.mm_obj = {
        self.treasure_list.grid_list[index]
      }
    end
  end)
end

function M:choose_battle_equip_treasure(index, is_need)
  FightBagMgr:request_operate_equip_item("c2gs_battle_treasure_choose", {index = index}, is_need, function(ok)
    Util.show_message_tip(2051)
    local msg = MsgGame:mq_publish2(Const.MSG_ON_SELECTED_TREASURE_SUCCESS)
    msg.mm_obj = {
      self.treasure_list.grid_list[index]
    }
  end)
end

function M:get_treasure_list()
  return self.treasure_list
end

function M:get_treasure_skill_list()
  return self.treasure_skill_list
end

function M:get_max_refresh_count()
  self:cal_max_refresh_count()
  return self.max_refresh_num
end

return M
