local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local OBJ_VISIBLE_TYPE = Config.FIGHT_OBJ_VISIBLE_TYPE
local _tinsert = table.insert
local QTE_SHOW_SKILL_IDX = 7
local skill_type = {normal = 1, mastery = 2}
local normal_skill_id = {
  [3] = "First",
  [4] = "Second",
  [5] = "Third"
}
local DEBUG = false

function M:init_sys()
  Base.init_sys(self)
  self.v_skill_list = {}
  self.v_select_skill_list = {}
  self.v_skill_max_num = 0
  self.v_magic_list = {}
  self.v_hero_skill_btn = {}
  self.v_hero_skill_list = {}
  self.v_hero_btn_skill_map = nil
  self.v_operate_char_skill_map = nil
  self.v_hero_born_end = false
  self:on_get_battle_skill_list()
end

function M:on_battle_skill_select_list(data)
  self.v_select_skill_list = data.select_list
  if next(self.v_select_skill_list) then
    Util.show_message_tip(2050)
    self:open_select_skill_book_view()
  end
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_SKILL_SELECTED_DATA)
end

function M:on_battle_skill(data)
  local select_list = data.select_list or {}
  local skill_list = data.skill_list or {}
  self.v_select_skill_list = select_list
  self.v_skill_list = skill_list
  self:update_hero_skill()
  self:check_btn()
  self:cal_skill_max_num()
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_FIGHT_SKILL_LIST)
end

function M:check_btn()
  self.v_hero_skill_btn = {}
  local total_skill_cfg = ShareRes.create("battle.battle_skill")
  for _, skill_id in pairs(self.v_skill_list) do
    local skill_cfg = total_skill_cfg[skill_id]
    local BuddyId = skill_cfg.BuddyId
    local SkillType = skill_cfg.SkillType
    local EffectId = skill_cfg.EffectId
    if SkillType == skill_type.normal then
      if self.v_hero_skill_btn[BuddyId] == nil then
        self.v_hero_skill_btn[BuddyId] = {}
      end
      self.v_hero_skill_btn[BuddyId][EffectId] = EffectId
    end
  end
end

function M:update_hero_skill()
  self:update_hero_skill_list()
  self:update_hero_magic()
end

function M:update_hero_skill_list()
  local total_skill_cfg = ShareRes.create("battle.battle_skill")
  local list = SceneMgr:get_hero_list()
  self.v_hero_skill_list = {}
  for _, hero in pairs(list) do
    local BuddyId = hero.buddy_cfg.Id
    self.v_hero_skill_list[BuddyId] = {}
  end
  for _, skill_id in pairs(self.v_skill_list) do
    local skill_cfg = total_skill_cfg[skill_id]
    Util.assert(skill_cfg, "【技能专精表】缺少技能配置：", skill_id)
    local BuddyId = skill_cfg.BuddyId
    if self.v_hero_skill_list[BuddyId] then
      _tinsert(self.v_hero_skill_list[BuddyId], skill_id)
    end
  end
end

function M:update_hero_magic()
  local total_skill_cfg = ShareRes.create("battle.battle_skill")
  local list = SceneMgr:get_hero_list()
  local skill_list = {}
  for _, hero in pairs(list) do
    local BuddyId = hero.buddy_cfg.Id
    skill_list[BuddyId] = {}
  end
  for _, skill_id in pairs(self.v_skill_list) do
    local skill_cfg = total_skill_cfg[skill_id]
    Util.assert(skill_cfg, "【技能专精表】缺少技能配置：", skill_id)
    local BuddyId = skill_cfg.BuddyId
    local EffectId = skill_cfg.EffectId
    local SkillType = skill_cfg.SkillType
    if SkillType == skill_type.mastery then
      skill_list[BuddyId][EffectId] = skill_list[BuddyId][EffectId] or {}
      _tinsert(skill_list[BuddyId][EffectId], skill_id)
    end
  end
  for _, hero in pairs(list) do
    local hero_id = hero.buddy_cfg.Id
    local effect_data = skill_list[hero_id]
    if effect_data then
      for effect_id, data in pairs(effect_data) do
        hero.magic_mgr:remove_magic_by_id(effect_id)
        local count = #data
        for i = 1, count do
          local skill_id = data[i]
          hero.magic_mgr:add_magic(hero, effect_id, nil, nil, 1, nil, {skill_major_id = skill_id})
        end
      end
    end
  end
end

function M:is_need_open_select_ui()
  return (self:is_have_select_list() or self:is_have_skill_book()) and not self:is_reach_max_limit()
end

function M:use_skill_book()
  if self:is_have_select_list() then
    self:open_select_skill_book_view()
    return true
  end
  local uuid = self:is_have_skill_book()
  if uuid and not self:is_reach_max_limit() then
    local send_data = {
      item_list = {
        {uuid = uuid, count = 1},
        hero_uuid = nil
      }
    }
    self.v_has_used = true
    Network:call("c2gs_use_battle_items", send_data)
    return true
  end
  return false
end

function M:is_have_skill_book()
  local skill_book_id = ShareRes.get_single_key_define("BattleSkillBookId")
  local bag = FightBagMgr:get_bag(8)
  local uuid
  for _, data in pairs(bag) do
    if data.Id == skill_book_id then
      uuid = data.uuid
      break
    end
  end
  return uuid
end

function M:is_have_select_list()
  return next(self.v_select_skill_list) ~= nil
end

function M:cal_skill_max_num()
  local skill_weight_total_list = ShareRes.create("battle.battle_skill_weight")
  local list = SceneMgr:get_hero_list()
  local skill_num = 0
  local group_map = {}
  for _, hero in pairs(list) do
    local hero_id = hero.buddy_cfg.Id
    group_map[hero_id] = {}
    local weight_map = skill_weight_total_list[hero_id]
    if weight_map then
      for _, data in pairs(weight_map) do
        local group_id = data.GroupId
        if 0 == group_id then
          skill_num = skill_num + 1
        else
          group_map[hero_id][group_id] = true
        end
      end
    end
  end
  for _, group in pairs(group_map) do
    local group_num = UtilTable.hash_lenth(group)
    skill_num = skill_num + group_num
  end
  self.v_skill_max_num = skill_num
end

function M:select_battle_skill(idx)
  self.v_select_skill_list = {}
  self.v_is_used = false
  Network:call("c2gs_battle_skill_select_skill", {index = idx}, function(ok, resp)
    if ok then
      _tinsert(self.v_skill_list, resp.new_skill_id)
      self:update_hero_skill()
      self:check_btn()
      Util.show_message_tip(2051)
      local skill_cfg = ShareRes.create("battle.battle_skill", resp.new_skill_id)
      if skill_cfg then
        BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_GET_BATTLE_SKILL, Global.hero, skill_cfg.EffectId)
      end
    end
    MsgGame:mq_publish2(Const.MSG_ON_UPDATE_FIGHT_SKILL_LIST)
  end)
end

function M:on_get_battle_skill_list()
  if Util.is_client_only() then
    self:client_add_normal_skill()
  end
  Network:call("c2gs_settlement_growth_info", {}, function(ok, resp)
    if ok then
      self.v_skill_list = resp.battle_skill_list
    end
  end)
end

function M:get_select_skill_ids()
  return self.v_select_skill_list
end

function M:get_skill_list()
  return self.v_skill_list
end

function M:get_hero_skill_btn()
  return self.v_hero_skill_btn
end

function M:is_have_skill(skill_id)
  return self.v_skill_list[skill_id]
end

function M:get_skill_num(hero_id)
  local skill_num = 0
  local total_skill_cfg = ShareRes.create("battle.battle_skill")
  for _, skill_id in pairs(self.v_skill_list) do
    local skill_cfg = total_skill_cfg[skill_id]
    local BuddyId = skill_cfg.BuddyId
    local SkillType = skill_cfg.SkillType
    if SkillType == skill_type.mastery and hero_id == BuddyId then
      skill_num = skill_num + 1
    end
  end
  return skill_num
end

function M:is_reach_max_limit()
  local own_skill_num = #self.v_skill_list
  return own_skill_num >= self.v_skill_max_num
end

function M:add_skill(skill_id)
  _tinsert(self.v_skill_list, skill_id)
  self:update_hero_skill()
  self:check_btn()
  local skill_cfg = ShareRes.create("battle.battle_skill", skill_id)
  if skill_cfg then
    BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_GET_BATTLE_SKILL, Global.hero, skill_cfg.EffectId)
  end
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_FIGHT_SKILL_LIST)
end

function M:del_skill(skill_id)
  UtilTable.list_delete_by_value(self.v_skill_list, skill_id)
  self:update_hero_skill()
  self:check_btn()
  MsgGame:mq_publish2(Const.MSG_ON_UPDATE_FIGHT_SKILL_LIST)
end

function M:client_add_normal_skill()
  local total_skill = ShareRes.create("battle.battle_skill")
  for _, data in pairs(total_skill) do
    local is_normal_skill = normal_skill_id[data.EffectId]
    if is_normal_skill then
      _tinsert(self.v_skill_list, data.SkillId)
    end
  end
end

function M:open_select_skill_book_view()
  UIMgr:get_ui("uifight_skill_select"):ui_show()
end

function M:check_have_skill_list()
  if next(self.v_select_skill_list) ~= nil then
    self.v_is_used = true
    self:open_select_skill_book_view()
  end
end

function M:get_hero_btn_skill_map()
  if not self.v_hero_btn_skill_map then
    self:init_hero_btn_skill()
  end
  return self.v_hero_btn_skill_map, self.v_hero_qte_id_map
end

function M:get_hero_btn_skill_map_list(uuid)
  if not self.v_hero_btn_skill_map then
    self:init_hero_btn_skill()
  end
  if not self.v_hero_btn_skill_map[uuid] then
    local hero = SceneMgr:get_hero_by_uuid(uuid)
    if not hero then
      Log.Error("hero is nil", uuid, debug.traceback())
    elseif hero:is_destroy() then
      Log.Error("hero is destroy id ", hero.id, "uuid", uuid, debug.traceback())
    else
      self:init_single_hero_btn_skill(uuid, hero)
    end
  end
  return self.v_hero_btn_skill_map[uuid]
end

function M:get_skill_expend_count_map()
  if not self.v_skill_expend_count_map then
    self:init_hero_btn_skill()
  end
  return self.v_skill_expend_count_map
end

function M:init_hero_btn_skill()
  self.v_hero_btn_skill_map = {}
  self.v_hero_qte_id_map = {}
  self.v_skill_expend_count_map = {}
  local hero_list = SceneMgr:get_hero_list()
  if not hero_list then
    Log.Error("角色列表为空", debug.traceback())
    return
  end
  for uuid, hero in pairs(hero_list) do
    self:init_single_hero_btn_skill(uuid, hero)
  end
end

function M:init_single_hero_btn_skill(uuid, hero)
  local skill_id_list = hero:get_default_skill_list()
  local skill_mgr = hero.skill_mgr
  local skill_list = {}
  self.v_hero_btn_skill_map[uuid] = skill_list
  if not skill_id_list then
    Log.Error("hero 未找到 skill_id_list, name, id", hero:get_hero_name())
  end
  for k, skill_id in pairs(skill_id_list) do
    if k == QTE_SHOW_SKILL_IDX then
      self.v_hero_qte_id_map[uuid] = skill_id
    end
    if not Config.ABANDON_BTN_IDX[k] then
      local skill = skill_mgr:get_skill(skill_id)
      if skill then
        local info = skill:get_energy_info()
        if not info then
          skill:init_energy()
        end
        skill_list[k] = info
        self:init_expend_count(hero, skill_id)
      else
        Log.Error("fight not find skill " .. skill_id)
      end
    end
  end
end

function M:init_expend_count(hero, skill_id)
  self.v_skill_expend_count_map[hero.uuid] = self.v_skill_expend_count_map[hero.uuid] or {}
  local dict = self.v_skill_expend_count_map[hero.uuid]
  local cfg = ShareRes.create("skill.skill", skill_id)
  if cfg then
    if cfg.BattleResCost > 0 and 1 == cfg.BattleResCostType then
      local value = Config.EACH_POINT_EXPEND_VALUE
      if 0 == value then
        dict[skill_id] = 0
      else
        dict[skill_id] = math.ceil(math.max(0, cfg.BattleResCost) / value)
      end
    else
      dict[skill_id] = 0
    end
  else
    Log.Error("技能:", skill_id, "无法获取配置信息", debug.traceback())
  end
end

function M:reload_all()
  self.v_hero_btn_skill_map = nil
  self.v_operate_char_skill_map = nil
end

function M:exit_tower()
  self.v_hero_btn_skill_map = nil
  self.v_operate_char_skill_map = nil
  self.v_hero_born_end = false
  self.v_has_used = false
  self.v_hero_skill_list = {}
  BattleTreasureBoxMgr:exit_tower()
end

function M:get_has_used_book()
  return self.v_has_used
end

function M:get_hero_skill_list(hero_id)
  return self.v_hero_skill_list[hero_id]
end

function M:get_robot_hero_skills(uuid)
  if not self.v_operate_char_skill_map then
    self:_init_operate_char_skill()
  end
  return self.v_operate_char_skill_map[uuid]
end

function M:_init_operate_char_skill()
  self.v_operate_char_skill_map = {}
  for uuid, hero in pairs(SceneMgr:get_robot_hero_list()) do
    local skill_id_list = hero:get_default_skill_list()
    hero.skill_mgr:init_energy()
    local skill_list = {}
    self.v_operate_char_skill_map[uuid] = skill_list
    if not skill_id_list then
      Log.Error("hero 未找到 skill_id_list, name, id", hero:get_hero_name())
    end
    for k, skill_id in ipairs(skill_id_list) do
      local skill = hero.skill_mgr:get_skill(skill_id)
      if skill then
        local info = skill:get_energy_info()
        if k == QTE_SHOW_SKILL_IDX then
          info.qte_type = k
        end
        table.insert(skill_list, info)
      else
        Log.Error("fight not find skill " .. skill_id)
      end
    end
  end
end

return M
