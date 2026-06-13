local Base = require("gamelogic.base_system")
local CommonDefind = require("cs_share.common_define")
local FightDefind = require("cs_share.fight_define")
local Talent_Cfg = require("uimodule.battle_talent.battle_talent_cfg")
local CONFIG_NAME_ATTR_ID = FightDefind.CONFIG_NAME_ATTR_ID
local _tinsert = table.insert
local M = Util.create_child_mt(Base)
local _max = math.max
local GROUP_TYPE = Config.ATTR_GROUP_TYPE.BASE

function M:init_sys()
  Base.init_sys(self)
  self.v_tree_node_list = {}
  self.v_talent_tree = {}
  self.v_active_tree_id = {}
  self.v_attr_list = {}
  self.v_magic_list = {}
  self.v_skill_list = {}
  self.v_career_list = {}
  self.v_career2idx = {}
  self.v_select_idx = 1
  self:init_tree_point_list()
  self.active_point_num = 0
  self.total_point_num = 0
  self.v_is_get_data = false
end

local function use_line(pre_id, next_id)
  local Line = {
    Line1 = 1,
    Line2 = 2,
    Line3 = 3,
    Line4 = 4,
    Line5 = 5
  }
  local line_num = pre_id - next_id
  if -1 == line_num then
    return Line.Line3
  elseif 1 == line_num then
    return Line.Line2
  end
  return Line.Line1
end

local function get_career_id_by_tree_id(talent_tree_id)
  local talent_tree_cfg = ShareRes.create("fight_talent.fight_talent_tree", talent_tree_id)
  local career_id = talent_tree_cfg.Career
  return career_id
end

local function get_talent_tree_by_career(career_id)
  local talent_tree_cfg = ShareRes.create("fight_talent.fight_talent_tree")
  local talent_tree
  for _, tree_cfg in pairs(talent_tree_cfg) do
    local tree_career = tree_cfg.Career
    if tree_career == career_id then
      talent_tree = talent_tree_cfg[tree_cfg.TalentTreeId]
      break
    end
  end
  return talent_tree
end

function M:init_tree_point()
  for _, point in pairs(self.v_tree_node_list) do
    point.state = Talent_Cfg.TALENT_POINT_STATE.ACESS
    point.line = {}
  end
end

function M:init_tree_point_list()
  local talent_point = ShareRes.create("fight_talent.fight_talent_point")
  local node_tb = {}
  for point_id, point_data in pairs(talent_point) do
    if type(point_id) ~= "number" then
    else
      local talent_id = point_data.TalentId
      node_tb[talent_id] = {
        point_id = talent_id,
        point_cfg = point_data,
        point_height = 0,
        state = Talent_Cfg.TALENT_POINT_STATE.ACESS,
        line = {},
        sub_list = {}
      }
    end
  end
  local sub_list_cfg = talent_point.ByMainTalent
  for main_id, sub_data_list in pairs(sub_list_cfg) do
    local main_point = node_tb[main_id]
    for height, sub_cfg in pairs(sub_data_list) do
      local sub_id = sub_cfg.TalentId
      local sub_point = node_tb[sub_id]
      main_point.sub_list[height] = sub_point
    end
  end
  self.v_tree_node_list = node_tb
end

local function has_acess_point(front_ids, node_tb)
  local Has_acess_front_point = false
  for _, front_id in pairs(front_ids) do
    if node_tb[front_id].state ~= Talent_Cfg.TALENT_POINT_STATE.UNSELECT then
      Has_acess_front_point = true
      break
    end
  end
  return Has_acess_front_point
end

function M:set_point_line(points)
  local node_tb = self.v_tree_node_list
  for _, point_data in pairs(points) do
    local point_cfg = point_data.point_cfg
    local front_ids = point_cfg.FrontTalentIds
    if next(front_ids) ~= nil then
      for _, front_id in pairs(front_ids) do
        local front_point = node_tb[front_id]
        local front_branch = front_point.point_cfg.BranchId
        local next_branch = point_cfg.BranchId
        local line_num = use_line(front_branch, next_branch)
        local line = point_data.line
        local pre_state = front_point.state
        local now_state = point_data.state
        line[line_num] = false
        if now_state == Talent_Cfg.TALENT_POINT_STATE.ACTIVE and (pre_state == Talent_Cfg.TALENT_POINT_STATE.ACTIVE or pre_state == Talent_Cfg.TALENT_POINT_STATE.ACESS) then
          line[line_num] = true
        end
      end
    end
  end
end

function M:check_unselect(points)
  local talent_point_cfg = ShareRes.create("fight_talent.fight_talent_point")
  local Has_active_point = false
  local active_point
  local node_tb = self.v_tree_node_list
  local front_ids
  for _, point_data in pairs(points) do
    local point_id = point_data.point_id
    front_ids = talent_point_cfg[point_id].FrontTalentIds
    if next(front_ids) ~= nil and not has_acess_point(front_ids, node_tb) then
      node_tb[point_id].state = Talent_Cfg.TALENT_POINT_STATE.UNSELECT
    end
    if node_tb[point_id].state == Talent_Cfg.TALENT_POINT_STATE.ACTIVE then
      Has_active_point = true
      active_point = point_id
    end
  end
  if Has_active_point then
    for _, point_data in pairs(points) do
      local point_id = point_data.point_id
      if point_id ~= active_point then
        node_tb[point_id].state = Talent_Cfg.TALENT_POINT_STATE.UNSELECT
      end
    end
  end
end

function M:check_sub_unselect(points)
  for _, point in pairs(points) do
    local state = point.state
    local sub_list = point.sub_list
    if state == Talent_Cfg.TALENT_POINT_STATE.UNSELECT then
      for _, sub_point in ipairs(sub_list) do
        sub_point.state = Talent_Cfg.TALENT_POINT_STATE.UNSELECT
      end
    elseif state ~= Talent_Cfg.TALENT_POINT_STATE.UNSELECT then
      for _, sub_point in ipairs(sub_list) do
        if sub_point.state ~= Talent_Cfg.TALENT_POINT_STATE.ACTIVE then
          sub_point.state = Talent_Cfg.TALENT_POINT_STATE.ACESS
        end
      end
    end
  end
end

function M:init_career_tree(career_id)
  self.v_attr_list[career_id] = {}
  self.v_magic_list[career_id] = {}
  self.v_skill_list[career_id] = {}
  local career_tree_cfg = get_talent_tree_by_career(career_id)
  local talent_point_cfg = ShareRes.create("fight_talent.fight_talent_point")
  local career_tb = self.v_talent_tree
  career_tb[career_id] = {}
  local now_career_tree = career_tb[career_id]
  local node_tb = self.v_tree_node_list
  local display_tree_ids = career_tree_cfg.TalentIds
  local display_tree = {}
  local point2height = {}
  local active_talent_list = {}
  local talent_front_ids, front_id
  local height = 1
  local active_point_num = 0
  local max_height = 0
  local curr_index = 0
  local branch_id
  for _, point_id in ipairs(display_tree_ids) do
    local point_cfg = talent_point_cfg[point_id]
    local Type = point_cfg.Type
    local point = node_tb[point_id]
    if Type == Talent_Cfg.TALENT_POINT_TYPE.SUB then
      if point.state == Talent_Cfg.TALENT_POINT_STATE.ACTIVE then
        _tinsert(active_talent_list, point_id)
        self:on_tree_update_attr(career_id, point_id)
      end
    else
      talent_front_ids = point_cfg.FrontTalentIds
      branch_id = point_cfg.BranchId
      if next(talent_front_ids) == nil then
        height = 1
        point2height[point_id] = height
        display_tree[1] = {}
        display_tree[1][branch_id] = point_id
      else
        front_id = talent_front_ids[1]
        assert(point2height[front_id], "有天赋点不存在，请检查天赋点是否有缺漏，前一个天赋点为:" .. front_id .. "当前天赋点为" .. point_id)
        height = point2height[front_id] + 1
        point2height[point_id] = height
        max_height = _max(max_height, height)
        if nil == display_tree[height] then
          display_tree[height] = {}
        end
      end
      point.point_height = height
      display_tree[height][branch_id] = point
      if point.state == Talent_Cfg.TALENT_POINT_STATE.ACTIVE then
        _tinsert(active_talent_list, point_id)
        self:on_tree_update_attr(career_id, point_id)
        active_point_num = active_point_num + 1
        curr_index = height
      end
    end
  end
  for _, points in pairs(display_tree) do
    self:check_unselect(points)
    self:check_sub_unselect(points)
    self:set_point_line(points)
  end
  now_career_tree.active_point_num = active_point_num
  now_career_tree.max_height = max_height
  now_career_tree.curr_index = curr_index
  now_career_tree.display_tree = display_tree
  now_career_tree.active_talent_list = active_talent_list
  if self.v_active_tree_id[career_id] then
    now_career_tree.Not_Lock = true
  end
end

function M:init_tree()
  if not self.v_is_get_data then
    return
  end
  self.v_attr_list = {}
  self.v_magic_list = {}
  self.v_career_list = {}
  self.v_career2idx = {}
  self.v_talent_tree = {}
  self.v_skill_list = {}
  self.v_select_idx = 1
  local list = SceneMgr:get_hero_list()
  assert(list, "can't get hero list")
  if nil == list then
    return
  end
  local idx = 1
  for _, hero in pairs(list) do
    local career_id = hero.buddy_cfg.Job
    if self.v_career2idx[career_id] == nil then
      self.v_career2idx[career_id] = idx
      _tinsert(self.v_career_list, career_id)
      idx = idx + 1
    end
  end
  local active_point_num = 0
  local total_point_num = 0
  for _, career_id in pairs(self.v_career_list) do
    self:init_career_tree(career_id)
    active_point_num = active_point_num + self.v_talent_tree[career_id].active_point_num
    total_point_num = total_point_num + self.v_talent_tree[career_id].max_height
  end
  self.active_point_num = active_point_num
  self.total_point_num = total_point_num
  self:update_hero_attr()
  self:update_hero_magic()
  if not self.v_init then
    for _, career_id in pairs(self.v_career_list) do
      self:init_res_value(career_id)
    end
    self.v_init = true
  end
  self.v_is_get_data = false
end

function M:init_res_value(career_id)
  local talent_tree = self.v_talent_tree[career_id]
  local active_point_list = talent_tree.active_talent_list
  for _, point_id in pairs(active_point_list) do
    self:on_update_max_relate(point_id)
  end
end

function M:get_talent_tree_point_num(career_id)
  local tree = self.v_talent_tree[career_id]
  return tree.active_point_num, tree.max_height
end

function M:cal_career_talent_tree(data)
  self:init_tree_point()
  local have_career_list = {}
  for _, tree in pairs(data.talent_trees) do
    local career_id = tree.career
    have_career_list[career_id] = career_id
    for _, id in pairs(tree.talent_ids) do
      self.v_tree_node_list[id].state = Talent_Cfg.TALENT_POINT_STATE.ACTIVE
    end
  end
  for career_id, _ in pairs(have_career_list) do
    self:init_career_tree(career_id)
  end
  local active_point_num = 0
  local total_point_num = 0
  for _, talent_data in pairs(self.v_talent_tree) do
    active_point_num = active_point_num + talent_data.active_point_num
    total_point_num = total_point_num + talent_data.max_height
  end
  self.active_point_num = active_point_num
  self.total_point_num = total_point_num
end

function M:on_get_battle_talent_ids()
  Network:call("c2gs_settlement_growth_info", {}, function(ok, resp)
    if ok then
      self:cal_career_talent_tree(resp)
    end
  end)
end

function M:on_activate_battle_talent(talent_data)
  Network:call("c2gs_battle_talent_activate_talent", {
    talent_tree_id = talent_data.talent_tree_id,
    career = talent_data.career,
    talent_id = talent_data.talent_id
  })
end

function M:on_activate_talent_tree(talent_tree_id)
  Network:call("c2gs_activate_talent_tree", {talent_tree_id = talent_tree_id}, function(ok)
    if ok then
      local career_id = get_career_id_by_tree_id(talent_tree_id)
      self.v_active_tree_id[career_id] = true
      self.v_talent_tree[career_id].Not_Lock = true
      Util.show_message_tip(2052)
      MsgGame:mq_publish2(Const.MSG_ON_TALENT_UPDATE)
    end
  end)
end

function M:on_battle_talent_update(data)
  self.v_tree_node_list[data.talent_id].state = Talent_Cfg.TALENT_POINT_STATE.ACTIVE
  Util.show_message_tip(2053)
  self:init_career_tree(data.career)
  self.active_point_num = self.active_point_num + 1
  local attr_mgr = Global.hero.attr_mgr
  attr_mgr.attr_play_anim = true
  self:update_hero_attr()
  attr_mgr.attr_play_anim = false
  self:update_hero_magic()
  self:update_skill(data.talent_id)
  self:on_update_max_relate(data.talent_id)
  MsgGame:mq_publish2(Const.MSG_ON_TALENT_UPDATE)
end

function M:on_update_max_relate(talent_id)
  local talent_attr_cfg = ShareRes.create("fight_talent.fight_talent_attrs")
  local talent_point_cfg = ShareRes.create("fight_talent.fight_talent_point")
  local talent_point = talent_point_cfg[talent_id]
  assert(talent_point, "天赋点不存在，请检查配置是否有该天赋点" .. talent_id)
  local attr_id = talent_point.Attrs_Id
  if nil == talent_attr_cfg[attr_id] then
    return
  end
  local list = SceneMgr:get_hero_list()
  local talent_info = talent_attr_cfg[attr_id].max_hp
  if talent_info then
    local attr_hp = Config.CHAR_ATTR_TYPE.CHAR_HP
    for _, hero in pairs(list) do
      hero.attr_mgr:change_attr(GROUP_TYPE, attr_hp, talent_info)
    end
  end
end

function M:on_battle_talent_active_talent_ids(data)
  self:init_tree_point()
  self.v_active_tree_id = {}
  for _, tree in pairs(data.talent_trees) do
    self.v_active_tree_id[tree.career] = true
    for _, id in pairs(tree.talent_ids) do
      self.v_tree_node_list[id].state = Talent_Cfg.TALENT_POINT_STATE.ACTIVE
    end
  end
  self.v_is_get_data = true
  self:init_tree()
  MsgGame:mq_publish2(Const.MSG_ON_TALENT_UPDATE)
end

local function cal_attr(attrs, role_attr)
  for index, info in pairs(attrs) do
    if "Attrs_Id" ~= index then
      local id = CONFIG_NAME_ATTR_ID[index]
      if nil == role_attr[id] then
        role_attr[id] = {
          FIXED = info,
          RATIO = 0,
          OTHER_RATIO = {}
        }
      else
        local fixed = role_attr[id].FIXED
        role_attr[id].FIXED = fixed + info
      end
    end
  end
end

function M:on_tree_update_attr(career_id, talent_id)
  local talent_attr_cfg = ShareRes.create("fight_talent.fight_talent_attrs")
  local talent_point_cfg = ShareRes.create("fight_talent.fight_talent_point")
  local attr_tb = self.v_attr_list[career_id]
  local magic_tb = self.v_magic_list[career_id]
  local skill_tb = self.v_skill_list[career_id]
  local talent_point = talent_point_cfg[talent_id]
  local attr_id = talent_point.Attrs_Id
  local magic_id = talent_point.EffectId
  local skill_id = talent_point.Skill_Id
  if skill_id then
    skill_tb[talent_id] = skill_id
  end
  if nil ~= attr_id then
    local attrs = talent_attr_cfg[attr_id]
    cal_attr(attrs, attr_tb)
  elseif magic_id then
    magic_tb[talent_id] = magic_id
  end
end

function M:update_skill(talent_id)
  local talent_point_cfg = ShareRes.create("fight_talent.fight_talent_point")
  local talent_cfg = talent_point_cfg[talent_id]
  local skill_id = talent_cfg.Skill_Id
  if not skill_id then
    return
  end
  local list = SceneMgr:get_hero_list()
  if nil ~= list then
    for _, hero in pairs(list) do
      hero.skill_mgr:create_skill(skill_id)
    end
  end
end

function M:update_hero_magic()
  local total_magic_tb = {}
  for _, career_magic_tb in pairs(self.v_magic_list) do
    for talent_id, magic_id in pairs(career_magic_tb) do
      total_magic_tb[talent_id] = magic_id
    end
  end
  local list = SceneMgr:get_hero_list()
  if nil ~= list then
    for _, hero in pairs(list) do
      for talent_id, magic_id in pairs(total_magic_tb) do
        hero.magic_mgr:remove_magic_by_id(magic_id)
        hero.magic_mgr:add_magic(hero, magic_id, nil, nil, 1, nil, {talent_id = talent_id})
      end
    end
  end
end

function M:update_hero_attr()
  local total_attr_tb = {}
  for _, career_attr_tb in pairs(self.v_attr_list) do
    for attr_id, attr_info in pairs(career_attr_tb) do
      local data = total_attr_tb[attr_id]
      if not data then
        data = {
          OTHER_RATIO = {},
          RATIO = 0,
          FIXED = 0
        }
        total_attr_tb[attr_id] = data
      end
      data.FIXED = data.FIXED + attr_info.FIXED
    end
  end
  local list = SceneMgr:get_hero_list()
  if nil ~= list then
    for _, hero in pairs(list) do
      hero:update_module_attrs(CommonDefind.MODULE_ATTR_TYPE.TALENT, total_attr_tb, true)
    end
  end
end

function M:get_tree_point_list()
  return self.v_tree_node_list
end

function M:get_career_tree()
  return self.v_talent_tree
end

function M:get_total_talent_tree_point_num()
  local active_point = 0
  local total_point = 0
  for _, data in pairs(self.v_talent_tree) do
    active_point = active_point + data.active_point_num
    total_point = total_point + data.max_height
  end
  return active_point, total_point
end

function M:get_career_list()
  return self.v_career_list
end

function M:get_select_idx()
  return self.v_select_idx
end

function M:get_skill_list()
  local skill_tb = {}
  for _, career_skill in pairs(self.v_skill_list) do
    for _, skill_id in pairs(career_skill) do
      _tinsert(skill_tb, skill_id)
    end
  end
  return skill_tb
end

function M:get_active_tree_num()
  return UtilTable.hash_lenth(self.v_active_tree_id) + 1
end

function M:get_select_tree_data()
  local career_id = self.v_career_list[self.v_select_idx]
  local talent_tree_cfg = ShareRes.create("fight_talent.fight_talent_tree")
  local talent_tree_id
  for _, tree_cfg in pairs(talent_tree_cfg) do
    local tree_career = tree_cfg.Career
    if tree_career == career_id then
      talent_tree_id = tree_cfg.TalentTreeId
      break
    end
  end
  assert(talent_tree_id, "talent_tree is nil")
  return talent_tree_id, career_id
end

function M:is_talent_tree_unlock()
  local career_id = self.v_career_list[self.v_select_idx]
  local tree = self.v_talent_tree[career_id]
  assert(tree, "树并不存在")
  return tree.Not_Lock
end

function M:set_select_idx(idx)
  self.v_select_idx = idx
end

function M:exit_tower()
  self.v_init = false
end

return M
