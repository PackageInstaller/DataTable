local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CURSE_RING_CONTRIBUTION_POINT = 28
local CURSE_RING_CURRENCY_BATTLE = 541000
local CURSE_RING_CURRENCY_MAIN = 29
local CURSE_SETTLEMENT_ITEM_KEY = "CURSE_SETTLEMENT_ITEM_KEY"
local CURSE_BLESS_ITEM_KEY = "CURSE_BLESS_ITEM_KEY"
local Item_Helper = require("utils.item_helper")
local CommonDef = require("cs_share.common_define")
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

function ui:ui_finish_load()
  self:set_button("BtnSure", function()
    self:settlement()
  end)
  self:set_button("BtnReborn", function()
    self:click_reborn_btn()
  end)
  self.v_ui_name = self:ui_get_name()
  self.v_reward_content_local_pos = self.v_uiobjects.RewardContent.transform.localPosition
  self:register_exist_auto_template(CURSE_SETTLEMENT_ITEM_KEY .. self.v_ui_name, self.v_uiobjects.RewardTem, self.v_uiobjects.RewardContent)
  self:register_exist_auto_template(CURSE_BLESS_ITEM_KEY .. self.v_ui_name, self.v_uiobjects.BlessingTem, self.v_uiobjects.BlessingContent)
  self.v_show_item_list = {}
  self.v_show_bless_list = {}
end

function ui:ui_on_show(is_fight, is_end_ring, tower_info, fight_info, card_list, temp_episode_id)
  UIMgr:try_hide_ui("challenge_ring_floor_settle")
  self.v_uiobjects.RewardContent.transform.localPosition = self.v_reward_content_local_pos
  self:refresh(is_fight, is_end_ring, tower_info, fight_info, card_list, temp_episode_id)
end

function ui:refresh(is_fight, is_end_ring, tower_info, fight_info, card_list, temp_episode_id)
  self.v_tower_info = tower_info or TowerMgr:get_tower_progress()
  fight_info = fight_info or TowerMgr:get_fight_info()
  self.card_list = card_list or UtilTable.copy_table(self.v_tower_info.award_list)
  if not fight_info and self.v_tower_info then
    fight_info = {
      type = self.v_tower_info.challenge_type,
      point_id = self.v_tower_info.episode_id,
      param = self.v_tower_info.param
    }
  end
  self.v_fight_info = fight_info
  self.v_fight_info.point_id = 0 == self.v_fight_info.point_id and temp_episode_id or self.v_fight_info.point_id
  self.v_fight_type = fight_info.type
  self.v_formation_type = CommonDef.CHAL_TYPE2FORMN_TYPE[self.v_fight_type]
  self.v_is_in_fight = is_fight
  local is_show_rebron = type(is_fight) == "number"
  local settle_btn_text = Util.get_text("Text", self.v_uiobjects.BtnSure)
  settle_btn_text.text = is_show_rebron and "直接结算" or "确定"
  self.v_uiobjects.BtnReborn:SetActive(is_show_rebron)
  self:update_pnl_info(is_end_ring)
end

function ui:update_pnl_info(is_end_ring)
  local ring_cfg = ShareRes.create("activity.rings_of_curse_ring_by_tower", self.v_tower_info.tower_id)
  local finish_num = self.v_tower_info.floor_id - 1
  if is_end_ring then
    finish_num = self.v_tower_info.floor_id
  end
  self.v_uicompents.RingFinish_txt.text = finish_num
  self.v_uicompents.RingMax_txt.text = #ring_cfg
  self.v_uicompents.RoundNum_txt.text = ChallengeRingPlusMgr:get_round_cnt()
  self.v_uicompents.TimeNum_txt.text = math.floor(ChallengeRingPlusMgr:get_fight_time()) .. "s"
  self.v_uicompents.ContriNow_txt.text = ChallengeRingPlusMgr:get_weekly_contribute_point() or 0
  self.v_uicompents.ContriMax_txt.text = ChallengeRingPlusMgr:get_weekly_contribute_point_limit()
  self.v_battle_exchange_item = ChallengeRingPlusMgr:get_battle_exchange_item()
  local point_id = self.v_fight_info.point_id
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  self.v_uicompents.Hard_txt.text = point_cfg.PointName
  local award_list = self.card_list
  self:update_award_show(award_list)
  self:update_bless_show()
  self:update_show_drawing()
end

local function _get_item_data(data, state)
  data.state = state
  local item_cfg = Item_Helper.get_item_cfg(data.id)
  data.qulity = item_cfg.Quality
  data.priority = item_cfg.Priority
end

local function _set_item_data(self, data)
  local item = self:get_auto_cache(CURSE_SETTLEMENT_ITEM_KEY .. self.v_ui_name)
  self:set_item_data(item, data)
  table.insert(self.v_show_item_list, item)
end

function ui:update_award_show(award_list)
  self.v_uicompents.BlessingCoinNum_txt.text = "+" .. 0
  if self.v_is_in_fight then
    local bless_coin = FightBagMgr:get_item_num_by_id(CURSE_RING_CURRENCY_BATTLE)
    if bless_coin > 0 then
      self.v_uicompents.BlessingCoinNum_txt.text = "+" .. bless_coin
    end
  elseif self.v_battle_exchange_item then
    for key, data in pairs(self.v_battle_exchange_item) do
      if data.id == CURSE_RING_CURRENCY_MAIN then
        self.v_uicompents.BlessingCoinNum_txt.text = "+" .. data.count
      end
    end
  end
  self.v_uicompents.ContriPointNum_txt.text = "+" .. 0
  local tower_award_list = self.v_tower_info.award_list
  if tower_award_list[CURSE_RING_CONTRIBUTION_POINT] then
    self.v_uicompents.ContriPointNum_txt.text = "+" .. tower_award_list[CURSE_RING_CONTRIBUTION_POINT].count
  end
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
      end
    end
  end
  table.sort(new_award_list, _sort_func)
  self:remove_item_wrap_list()
  self:give_back_auto_cache(CURSE_SETTLEMENT_ITEM_KEY .. self.v_ui_name)
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

function ui:set_item_data(item, data)
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

function ui:remove_item_wrap_list()
  for _, obj in pairs(self.v_show_item_list) do
    self:remove_wrap_ui(obj)
  end
  self.v_show_item_list = {}
end

function ui:remove_bless_wrap_list()
  for _, obj in pairs(self.v_show_bless_list) do
    self:remove_wrap_ui(obj)
  end
  self.v_show_bless_list = {}
end

function ui:update_bless_show()
  local bless_list = ChallengeRingPlusMgr:get_bless_pos_list()
  self:remove_bless_wrap_list()
  self:give_back_auto_cache(CURSE_BLESS_ITEM_KEY .. self.v_ui_name)
  for _, bless_data in ipairs(bless_list) do
    local item = self:get_auto_cache(CURSE_BLESS_ITEM_KEY .. self.v_ui_name)
    self:set_bless_data(item, bless_data)
    table.insert(self.v_show_bless_list, item)
  end
end

function ui:set_bless_data(item, bless_data)
  local is_show_icon = bless_data.bless_id ~= nil and not bless_data.is_lock
  local is_lock = bless_data.is_lock
  local bless_icon = Util.get_image("BlessingIcon", item)
  local bless_lock = Util.get_image("Lock", item)
  bless_icon.gameObject:SetActive(is_show_icon)
  bless_lock.gameObject:SetActive(is_lock)
  if not is_show_icon then
    return
  end
  local icon_path = ShareRes.get_curse_ring_bless_icon(bless_data.bless_id)
  ResMgr:load_set_icon(bless_icon, icon_path)
end

function ui:ui_on_hide()
  self:remove_bless_wrap_list()
  self:remove_item_wrap_list()
  self.flip_card_award_list = nil
end

function ui:settlement()
  local is_in_fight = type(self.v_is_in_fight) == "number"
  if is_in_fight then
    TowerMgr:entry_choose_reward(true, ChallengeRingPlusMgr:is_end_ring(), false)
  else
    ChallengeRingPlusMgr:exit_tower()
    if SceneMgr:check_main_scene() then
      self:ui_hide()
      SceneMgr:set_game_pause(false)
    end
    Global.scene_mgr:on_enter_main_scene()
    UIMgr:revert_cache_ui()
  end
end

function ui:click_reborn_btn()
  local _, reborn_cost_num, reborn_cost_id = TowerMgr:get_reborn_cost()
  
  local function callback1()
    self:requese_reborn()
  end
  
  local item_cfg = ShareRes.create("item.item", reborn_cost_id)
  local item_tip = reborn_cost_num .. item_cfg.Name
  local stip = Util.format_str("是否使用{1}，进行复活", item_tip)
  UIMgr:get_ui("uinotice_tips"):ui_show(callback1, nil, stip)
end

function ui:requese_reborn()
  local _, reborn_cost_num, reborn_cost_id = TowerMgr:get_reborn_cost()
  local cur_num = BagMgr:get_item_num(reborn_cost_id)
  if reborn_cost_num > cur_num then
    Util.show_message_tip(2115)
    return
  end
  ChapterMgr:request_reborn_all()
  self:ui_hide()
  SceneMgr:set_game_pause(false)
end

function ui:update_show_drawing()
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
  local hero_shadow_icon = self.v_uicompents.HeroShadow_img
  local icon_path = UtilUI.get_hero_images(buddy_id, Config.HERO_ICON_LV.HD_FULL_IMG)
  ResMgr:load_set_icon(hero_icon, icon_path, nil, true)
end

function ui:ui_on_destroy()
end

return ui
