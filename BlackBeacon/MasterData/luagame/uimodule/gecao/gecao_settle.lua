local Base = require("ui.uibase")
local M = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local TaskItem = require("uimodule.gecao.local_widgets.gecao_settle_task_item")
local TaskItemKey = "GECAO_SETTLE_TASK_ITEM_KEY"
local Stars = {
  "Star1",
  "Star2",
  "Star3"
}
local GECAO_SETTLEMENT_ITEM_KEY = "GECAO_SETTLEMENT_ITEM_KEY"
local Item_Helper = require("utils.item_helper")
local _sort = table.sort
local _insert = table.insert
local commonDef = require("cs_share.common_define")

local function _sort_func(a, b)
  local x = 0
  local y = 0
  if a.Priority then
    x = x + a.Priority * 10000
  end
  if b.Priority then
    y = y + b.Priority * 10000
  end
  x = x + a.qulity * 100000 - a.id - a.state * 1000000
  y = y + b.qulity * 100000 - b.id - b.state * 1000000
  if x ~= y then
    return x > y
  end
  return false
end

function M:ui_finish_load()
  self:set_button("BtnSure", function()
    self:settlement()
  end)
  local uobj = self.v_uiobjects
  self.v_ui_name = self:ui_get_name()
  self.v_task_sv = SaticSv:new(self, uobj.TargetObj, TaskItem, TaskItemKey .. self.v_ui_name)
  self:register_exist_auto_template(GECAO_SETTLEMENT_ITEM_KEY .. self.v_ui_name, self.v_uiobjects.RewardTem, self.v_uiobjects.RewardContent)
end

function M:ui_on_show(tower_progres, fight_info, award_list, is_in_fight)
  self.v_tower_progress = tower_progres
  self.v_fight_info = fight_info
  self.v_is_in_fight = is_in_fight
  self.v_fight_type = fight_info.type
  self.v_formation_type = commonDef.CHAL_TYPE2FORMN_TYPE[self.v_fight_type]
  UIMgr:try_hide_ui("gecao_battle")
  UIMgr:try_hide_ui("challenge_ring_floor_settle")
  self.v_chapter_id = fight_info.param
  self.v_chapter_cfg = ShareRes.get_gecao_cfg(fight_info.param)
  assert(self.v_chapter_cfg, "gecao chapter config is null!")
  self:refresh_task_list()
  local ucom = self.v_uicompents
  local cfg = self.v_chapter_cfg
  ucom.Hard_txt.text = cfg.LevelName
  local star_num = self:get_star_num()
  local uobj = self.v_uiobjects
  for i = 1, 3 do
    local star_obj = uobj[Stars[i]]
    local star_light_obj = star_obj.transform:GetChild(0)
    star_light_obj:SetActive(i <= star_num)
  end
  local pass_floor = self.v_tower_progress.pass_floor_id
  ucom.RingFinish_txt.text = pass_floor
  local chapter_point_cfg = ShareRes.get_chapter_point_cfg(cfg.EpisodeId)
  local tower_cfg = ShareRes.get_tower_cfg(chapter_point_cfg.FightId)
  local max_floor = tower_cfg.FloorMax
  ucom.RingMax_txt.text = max_floor
  self.v_show_item_list = {}
  self:update_award_show(award_list)
  self:update_show_drawing()
end

function M:get_star_num()
  local task_list = self.v_tower_progress and self.v_tower_progress.tower_task
  assert(task_list, "task_list is nil")
  if not task_list then
    return 0
  end
  local num = 0
  for key, value in pairs(task_list) do
    if value.status then
      num = num + 1
    end
  end
  return num
end

function M:ui_on_hide()
  self.v_task_sv:clear()
  self.v_show_item_list = nil
end

function M:cache_hide_ui()
  return false
end

function M:ui_on_destroy()
  self.v_task_sv = nil
end

local function _get_item_data(data, state)
  data.state = state
  local item_cfg = Item_Helper.get_item_cfg(data.id)
  data.qulity = item_cfg.Quality
  data.priority = item_cfg.Priority
end

local function _set_item_data(self, data)
  local item = self:get_auto_cache(GECAO_SETTLEMENT_ITEM_KEY .. self.v_ui_name)
  self:set_item_data(item, data)
  table.insert(self.v_show_item_list, item)
end

function M:update_award_show(award_list)
  local new_award_list = {}
  if type(self.v_is_in_fight) == "number" then
    local new_award_dict = {}
    for key, award_data in pairs(award_list) do
      local new_award_data = UtilTable.copy_table(award_data)
      _get_item_data(new_award_data, 0)
      if not new_award_dict[award_data.id] then
        new_award_dict[award_data.id] = new_award_data
      end
      new_award_dict[award_data.id].count = new_award_data.count + new_award_dict[award_data.id].count
    end
    for key, new_award_data in pairs(new_award_dict) do
      table.insert(new_award_list, new_award_data)
    end
  else
    for key, award_data in pairs(award_list) do
      local action = award_data.history_action
      if action then
        for index, value in ipairs(action) do
          local new_award_data = UtilTable.copy_table(award_data)
          _get_item_data(new_award_data, value.status)
          new_award_data.count = value.count
          table.insert(new_award_list, new_award_data)
        end
      else
        for index = 1, award_data.count do
          local new_award_data = UtilTable.copy_table(award_data)
          _get_item_data(new_award_data, 3)
          new_award_data.count = 1
          table.insert(new_award_list, new_award_data)
        end
      end
    end
  end
  _sort(new_award_list, _sort_func)
  self:remove_item_wrap_list()
  self:give_back_auto_cache(GECAO_SETTLEMENT_ITEM_KEY .. self.v_ui_name)
  for _, data in ipairs(new_award_list) do
    if type(self.v_is_in_fight) == "number" then
      _set_item_data(self, data)
    else
      local count = data.count or data.info.count
      for index = 1, count do
        _set_item_data(self, data)
      end
    end
  end
  self.v_uiobjects.TextRewardNone:SetActive(0 == #new_award_list)
end

function M:set_item_data(item, data)
  local com_item = Util.get_child_gameobj("ItemObjCom", item)
  
  local function click_cb()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = data.id,
      is_in_fight = true
    })
  end
  
  self:create_item_obj(nil, com_item.gameObject, nil, {
    item_id = data.id,
    click_cb = click_cb
  })
  local reward_state_obj = Util.get_child("RewardState_", item)
  reward_state_obj.gameObject:SetActive(true)
  local layout = Util.get_child("AmountLayout", item)
  local reward_num_txt = Util.get_text("AmountLayout/RewardNum_", item)
  layout:SetActive(false)
  local reward_state_text = Util.get_text("RewardState_/RewardStateText_", item)
  if data.state == commonDef.CHOOSE_ITEM_STATUS.USE then
    reward_state_text.text = Util.format_str("已翻牌")
  elseif data.state == commonDef.CHOOSE_ITEM_STATUS.IN_BAG then
    reward_state_text.text = Util.format_str("已存储")
  elseif 3 == data.state then
    reward_state_text.text = Util.format_str("已失效")
  else
    reward_state_obj.gameObject:SetActive(false)
    reward_num_txt.text = "+" .. data.count or 0
    layout:SetActive(true)
  end
end

function M:remove_item_wrap_list()
  for _, obj in pairs(self.v_show_item_list) do
    self:remove_wrap_ui(obj)
  end
  self.v_show_item_list = {}
end

function M:refresh_task_list()
  local task_list = self:get_tower_task_list()
  self.v_task_sv:update_list(task_list)
end

function M:settlement()
  if SceneMgr:check_main_scene() then
    self:ui_hide()
  end
  SceneMgr:on_enter_main_scene()
end

function M:update_show_drawing()
  local pos_data = {}
  local hero_list = SceneMgr:get_hero_list()
  if hero_list then
    for uuid, hero in pairs(hero_list) do
      local hero_id = hero:get_buddy_id()
      _insert(pos_data, {buddy_id = hero_id})
    end
  end
  if #pos_data <= 0 then
    local is_fixed, point_id, is_long_chapter_fixed, floor_id = ChapterMgr:check_cur_fight_fixed_team()
    local start_pos
    if not is_fixed then
      start_pos, pos_data = FormationMgr:get_formation_info_by_id(self.v_formation_type, nil, self.v_fight_type)
    elseif is_fixed and ChapterMgr:check_fixed_team_by_point_id(point_id, true) then
      pos_data = ChapterMgr:get_point_fixed_team_data(point_id)
    elseif is_fixed and ChapterMgr:check_use_fixed_char_pool(point_id) then
      pos_data = FixedBuddyPoolMgr:get_team_data(point_id)
    end
  end
  local new_data = {}
  for _, data in ipairs(pos_data) do
    if 0 ~= data.buddy_id then
      _insert(new_data, data.buddy_id)
    end
  end
  if #new_data <= 0 then
    Log.Error("编队信息空了")
    return
  end
  local random_index = math.random(1, #new_data)
  local buddy_id = new_data[random_index]
  local hero_icon = self.v_uicompents.HeroIcon_img
  local icon_path = UtilUI.get_hero_images(buddy_id, Config.HERO_ICON_LV.HD_FULL_IMG)
  ResMgr:load_set_icon(hero_icon, icon_path, nil, true)
end

function M:get_tower_task_list()
  return self.v_tower_progress and self.v_tower_progress.tower_task
end

return M
