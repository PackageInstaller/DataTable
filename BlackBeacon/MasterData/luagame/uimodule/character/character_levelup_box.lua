local Base = require("ui.uibase")
local AssetBarView = require("ui.asset_bar.asset_bar")
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local TRIGGER_SOUND_TYPE = CHARACTER_CONFIG.TRIGGER_SOUND_TYPE
local ui = Util.create_child_mt(Base)
local Timer = Global.timer
local _tinsert = table.insert
local BIND_TYPE = Config.BIND_TYPE
local ATTR_ITEM_KEY = "ATTR_ITEM_KEY"
local LEVELUP_ITEM_KEY = "LEVELUP_ITEM_KEY"
local BREAK_ITEM_KEY = "BREAK_ITEM_KEY"
local MODEL = {
  v_ani_ui_char_level_up = {
    "Ani_UIChar_LevelUp",
    BIND_TYPE.OBJECT
  },
  v_asset_bar = {
    "AssetBar",
    BIND_TYPE.OBJECT
  },
  v_attr_list = {
    "AttrList",
    BIND_TYPE.OBJECT
  },
  v_attr_tem = {
    "AttrTem",
    BIND_TYPE.IMAGE
  },
  v_bg_btn = {
    "BgBtn",
    BIND_TYPE.BUTTON
  },
  v_break = {
    "Break",
    BIND_TYPE.OBJECT
  },
  v_btn_auto_select = {
    "BtnAutoSelect",
    BIND_TYPE.BUTTON
  },
  v_btn_break = {
    "BtnBreak",
    BIND_TYPE.BUTTON
  },
  v_btn_close = {
    "BtnClose",
    BIND_TYPE.BUTTON
  },
  v_btn_level_up = {
    "BtnLevelUp",
    BIND_TYPE.BUTTON
  },
  v_btn_reset = {
    "BtnReset",
    BIND_TYPE.BUTTON
  },
  v_content = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_curr_icon = {
    "CurrIcon",
    BIND_TYPE.IMAGE
  },
  v_curr_num = {
    "CurrNum",
    BIND_TYPE.TEXT
  },
  v_exp_add = {
    "ExpAdd",
    BIND_TYPE.TEXT
  },
  v_exp_add_obj = {
    "ExpAdd",
    BIND_TYPE.OBJECT
  },
  v_exp_max = {
    "ExpMax",
    BIND_TYPE.TEXT
  },
  v_exp_next_bar_fill = {
    "ExpNextBarFill",
    BIND_TYPE.IMAGE
  },
  v_exp_now_bar_fill = {
    "ExpNowBarFill",
    BIND_TYPE.IMAGE
  },
  v_exp_now = {
    "ExpNow",
    BIND_TYPE.TEXT
  },
  v_item_break = {
    "ItemBreak",
    BIND_TYPE.OBJECT
  },
  v_item_lv_up = {
    "ItemLvUp",
    BIND_TYPE.BUTTON
  },
  v_level_up = {
    "LevelUp",
    BIND_TYPE.OBJECT
  },
  v_lv_next_num = {
    "LvNextNum",
    BIND_TYPE.TEXT
  },
  v_lv_now_num = {
    "LvNowNum",
    BIND_TYPE.TEXT
  },
  v_title1 = {
    "Title1",
    BIND_TYPE.OBJECT
  },
  v_title2 = {
    "Title2",
    BIND_TYPE.OBJECT
  }
}
local CHARACTER_CONFIG = require("uimodule.character.character_config")

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BgBtn", function()
    self:ui_hide()
  end)
  self:set_button("BtnLevelUp", function()
    self:_on_click_levelup()
  end)
  self:set_button("BtnBreak", function()
    self:_on_click_tupo()
  end)
  self:set_button("BtnAutoSelect", function()
    self:_on_click_quick_levelup()
  end)
  self:set_button("BtnReset", function()
    self:clear_use_item_preview()
  end)
  self:init_model(MODEL)
  self:register_exist_auto_template(ATTR_ITEM_KEY, self.v_uiobjects.AttrTem, self.v_attr_list)
  self:register_exist_auto_template(LEVELUP_ITEM_KEY, self.v_uiobjects.ItemLvUp, self.v_content)
  self:register_exist_auto_template(BREAK_ITEM_KEY, self.v_uiobjects.ItemBreak, self.v_content)
  self.v_asset_bar = AssetBarView:new(self, self.v_asset_bar)
  self.v_level_up_ani_obj = Util.get_child_gameobj("Level/VX_tupo", self.v_level_up)
  self.v_next_max_star_count = self.v_uiobjects.StarNext.transform.childCount
  self.v_success_pd = Util.get_playabledirector(nil, self.v_uiobjects.Ani_UIChar_LevelUp)
end

function ui:ui_on_show(buddy_id)
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self._on_item_update, self)
  self.v_asset_bar:reset_by_id_list({
    Config.COIN_ITEMID
  })
  self.v_asset_bar:set_jump_callback(function()
    self:ui_hide()
  end)
  self.v_asset_bar:on_create()
  self.v_title1:SetActive(true)
  self.v_title2:SetActive(false)
  self.v_level_up_ani_obj:SetActive(false)
  self.v_success_pd.time = 0
  self.v_success_pd:Evaluate()
  self.v_buddy_id = buddy_id
  self:refresh(false)
end

function ui:ui_on_hide()
  self:clear_timer()
  self.v_use_levelup_items = nil
  self.v_item_uis = nil
  self.v_buddy_break_cost = nil
  self.v_break_item = nil
  self.v_asset_bar:on_hide()
  if GuideMgr then
    GuideMgr:check_sys_guide()
  end
end

function ui:ui_on_destroy()
  self:clear_timer()
  self.v_asset_bar:on_destory()
end

function ui:refresh(internal_fresh)
  self.v_if_play_eff = false
  self.v_cost_coin = 0
  self.v_diff_level = 0
  if self:check_buddy_can_lvup() then
    self:ui_hide()
    return
  end
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local need_break = CharacterMgr:is_need_break(buddy_info.id)
  self.v_level_up:SetActive(not need_break)
  self.v_break:SetActive(need_break)
  self.v_uiobjects.BtnReset:SetActive(not need_break)
  if not internal_fresh then
    self.v_level_up_ani_obj:SetActive(false)
  end
  if need_break then
    self:give_back_auto_cache(LEVELUP_ITEM_KEY)
    self:refresh_tupo()
  else
    self:give_back_auto_cache(BREAK_ITEM_KEY)
    self:refresh_levelup(internal_fresh)
  end
end

function ui:check_buddy_can_lvup()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local max_level = ShareRes.get_buddy_max_level(buddy_info.break_lv)
  local need_break = CharacterMgr:is_need_break(buddy_info.id)
  if max_level <= buddy_info.lv and not need_break then
    return true
  end
  return false
end

function ui:refresh_tupo()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local buddy_next_break_cfg = ShareRes.create("buddy.buddy_break", buddy_info.id)[buddy_info.break_lv + 1]
  if not buddy_next_break_cfg then
    return
  end
  local buddy_break_cfg = ShareRes.create("buddy.buddy_break", buddy_info.id)[buddy_info.break_lv]
  local cur_attr = CharacterMgr.cal_buddy_attr(buddy_info.id, buddy_info.break_lv, buddy_info.lv, buddy_info.advance)
  local next_attr = CharacterMgr.cal_buddy_attr(buddy_info.id, buddy_info.break_lv + 1, buddy_info.lv, buddy_info.advance)
  local is_buddy_breack_auto_unlock_talent = ShareRes.is_buddy_breack_auto_unlock_talent(buddy_info.id, buddy_info.break_lv + 1)
  self:refresh_attrs(cur_attr, next_attr)
  self:add_break_extra_item(is_buddy_breack_auto_unlock_talent, buddy_info.break_lv + 1)
  local item_num = BagMgr:get_item_num(Config.COIN_ITEMID)
  local cost_num = buddy_break_cfg.Coin
  local cost_txt
  if item_num < cost_num then
    cost_txt = Util.set_str_color("<color=#E22525>", cost_num)
  else
    cost_txt = Util.set_str_color("<color=#292929>", cost_num)
  end
  self.v_curr_num.text = cost_txt
  self.v_buddy_break_cost = {}
  self.v_break_item = {}
  self:give_back_auto_cache(BREAK_ITEM_KEY)
  for idx, item_id in ipairs(buddy_break_cfg.Item) do
    local item_ui = self:get_auto_cache(BREAK_ITEM_KEY)
    local item_count = BagMgr:get_item_num(item_id)
    local need_num = buddy_break_cfg.ItemCount[idx]
    local v_cost = {id = item_id, count = need_num}
    _tinsert(self.v_buddy_break_cost, v_cost)
    self:refresh_item_num_ui(item_count, need_num, item_ui)
    self:set_button_listener(Util.get_button("ItemBtn_", item_ui), function()
      local now_count = BagMgr:get_item_num(item_id)
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = item_id,
        jump_cb = function()
          self:ui_hide()
        end,
        curr_count = now_count,
        need_count = need_num
      })
    end)
    local icon_path, quality_path = UtilUI.get_item_images(item_id)
    local item_icon = Util.get_image("ItemIcon_", item_ui)
    ResMgr:load_set_icon(item_icon, icon_path)
    local quality_img = Util.get_image("ItemQuality_", item_ui)
    ResMgr:load_set_icon(quality_img, quality_path)
    self.v_break_item[item_id] = item_ui
  end
  local next_break_lv = buddy_info.break_lv
  local now_break_lv = next_break_lv - 1
  local max_break_lv = ShareRes.get_role_max_break_lv(buddy_info.id)
  for i = 1, self.v_next_max_star_count do
    self.v_uiobjects["StarNext" .. i]:SetActive(i <= max_break_lv)
    self.v_uiobjects["StarNow" .. i]:SetActive(i <= max_break_lv)
    self.v_uiobjects["StarNowLightUp" .. i]:SetActive(i <= now_break_lv)
    self.v_uiobjects["StarNextLightUp" .. i]:SetActive(i <= next_break_lv)
    self.v_uiobjects["StarNextPreview" .. i]:SetActive(i == next_break_lv)
  end
  self.v_cost_coin = buddy_break_cfg.Coin
  self.v_uicompents.BtnBreak_btn.enabled = true
  self.v_uicompents.BtnBreakText_txt.text = "突 破"
  if buddy_break_cfg.Condition and buddy_break_cfg.Condition > 0 then
    if Condition:check_condition(buddy_break_cfg.Condition) then
      self:refresh_tupo_btn()
    else
      Util.apply_grey_ex(self.v_uiobjects.BtnBreak, true)
      self.v_uicompents.BtnBreak_btn.enabled = false
      self.v_uicompents.BtnBreakText_txt.text = ShareRes.get_condition_desc(buddy_break_cfg.Condition)
    end
  else
    self:refresh_tupo_btn()
  end
end

function ui:refresh_tupo_btn()
  if not self.v_buddy_break_cost then
    return
  end
  if self:is_can_tupo() then
    Util.apply_grey_ex(self.v_uiobjects.BtnBreak, false)
  else
    Util.apply_grey_ex(self.v_uiobjects.BtnBreak, true)
  end
end

function ui:is_can_tupo()
  local is_can = true
  for k, cost in pairs(self.v_buddy_break_cost) do
    local item_num = BagMgr:get_item_num(cost.id)
    if item_num <= 0 then
      is_can = false
    elseif item_num < cost.count then
      is_can = false
    end
    if not is_can then
      return is_can
    end
  end
  if self.v_cost_coin and self.v_cost_coin > 0 then
    local coin_num = CharacterMgr:get_coin() or 0
    if coin_num < self.v_cost_coin then
      return false
    end
  end
  return is_can
end

function ui:refresh_levelup(internal_fresh)
  self.v_use_levelup_items = {}
  self:_refresh_levelup_preview()
  local levelup_items = ShareRes.create("buddy.buddy_exp")
  local add_exp_item_data = {}
  for k, v in pairs(levelup_items) do
    local item_cfg = ShareRes.create("item.item", v.Id)
    local data = {
      Exp = item_cfg.Arg[1],
      Id = v.Id
    }
    table.insert(add_exp_item_data, data)
  end
  table.sort(add_exp_item_data, function(a, b)
    return a.Exp > b.Exp
  end)
  self.v_add_exp_val = 0
  if not internal_fresh then
    self:give_back_auto_cache(LEVELUP_ITEM_KEY)
    self.v_item_uis = {}
    self.is_have_up_consum = false
    for _, item_info in ipairs(add_exp_item_data) do
      local item_id = item_info.Id
      local item_num = BagMgr:get_item_num(item_id)
      if not self.is_have_up_consum and item_num > 0 then
        self.is_have_up_consum = true
      end
      local item_ui = self:get_auto_cache(LEVELUP_ITEM_KEY)
      item_ui.gameObject.name = "ItemLvUp" .. item_id
      local select_obj = Util.get_child_gameobj("SelectObj_", item_ui)
      local select_num = Util.get_text("SelectObj_/SelectNumBg/SelectNum", item_ui)
      local dec_btn = Util.get_button("SelectObj_/BtnDel_", item_ui)
      local item_btn = Util.get_button(nil, item_ui)
      local particls = Util.get_child_gameobj("FX_UI_Items_Particls", item_ui)
      particls:SetActive(false)
      select_obj:SetActive(false)
      select_num.text = "0"
      self:set_button_listener(item_btn, function()
        local item_num = BagMgr:get_item_num(item_id)
        if item_num <= 0 then
          UIMgr:get_ui("itemTip"):ui_show({
            item_id = item_id,
            jump_cb = function()
              self:ui_hide()
            end
          })
          return
        end
        local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
        local need_max_exp = CharacterMgr.get_buddy_lvmax_need_exp(buddy_info)
        if not (self.v_add_exp_val and need_max_exp) or need_max_exp <= self.v_add_exp_val then
          return
        end
        local use_items = self.v_use_levelup_items[item_id]
        if not use_items then
          use_items = {id = item_id, count = 1}
          self.v_use_levelup_items[item_id] = use_items
        else
          use_items.count = use_items.count + 1
        end
        use_items.count = math.min(use_items.count, item_num)
        select_obj:SetActive(true)
        select_num.text = use_items.count
        self:_refresh_levelup_preview()
      end)
      self:set_button_listener(dec_btn, function()
        local use_items = self.v_use_levelup_items[item_id] or {}
        local use_items_count = use_items.count or 0
        local count = use_items_count - 1
        count = count > 0 and count or 0
        use_items.count = count
        select_num.text = count
        self:_refresh_levelup_preview()
        if count <= 0 then
          self.v_use_levelup_items[item_id] = nil
          select_obj:SetActive(false)
          return
        end
      end)
      local cur_num = 0 == item_num and "<color=#e0212c>0</color>" or item_num
      Util.get_text("ItemAmount_/Bg/ItemNum_", item_ui).text = cur_num
      Util.get_child_gameobj("Mask_", item_ui):SetActive(0 == item_num)
      self.v_item_uis[item_id] = item_ui
      local icon_path, quality_path = UtilUI.get_item_images(item_id)
      local icon = Util.get_image("ItemIcon_", item_ui)
      ResMgr:load_set_icon(icon, icon_path)
      local quality_img = Util.get_image("ItemQuality_", item_ui)
      ResMgr:load_set_icon(quality_img, quality_path)
    end
  end
  self:refresh_level_up_btn()
end

function ui:clear_use_item_preview()
  self.v_add_exp_val = 0
  self.v_use_levelup_items = nil
  self:give_back_auto_cache(LEVELUP_ITEM_KEY)
  self:refresh_levelup(false)
  self:_refresh_levelup_preview()
end

function ui:refresh_attrs(now_attrs, after_attrs)
  self:give_back_auto_cache(ATTR_ITEM_KEY)
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  if not buddy_info then
    return
  end
  local buddy_id = buddy_info.id
  local show_buddy_attr_cfg = ShareRes.get_show_buddy_attr_cfg(buddy_id)
  assert("show_buddy_attr_cfg", "ATTR CFG NULL = " .. buddy_id)
  local attr_list = show_buddy_attr_cfg.BaseAttr
  for index, attr_id in ipairs(attr_list) do
    if not Config.SKIP_SHOW_ATTR_ID[attr_id] then
      local attr_ui = self:get_auto_cache(ATTR_ITEM_KEY)
      self:update_attr_item(attr_ui, attr_id, now_attrs, after_attrs)
    end
  end
end

function ui:add_break_extra_item(is_buddy_breack_auto_unlock_talent, new_break_lv)
  if is_buddy_breack_auto_unlock_talent then
    self:update_attr_item_talent()
  end
  if new_break_lv then
    self:update_attr_item_puzzle(new_break_lv)
  end
  if 3 == new_break_lv and ShareRes.get_buddy_cfg(self.v_buddy_id).Icon[7] then
    self:update_attr_item_spine()
  end
end

local highlight_color_key = "<color=#EC7F00>"
local normal_color_key = "<color=#292929>"

function ui:update_attr_item(attr_ui, attr_id, now_attrs, after_attrs)
  Util.get_child_gameobj("AttrNumNext_", attr_ui):SetActive(true)
  local attr_cfg = ShareRes.get_buddy_attr_cfg(attr_id)
  assert(attr_cfg, "ATTR_CFG NULL = " .. attr_id)
  local is_ration = ShareRes.get_is_ration_attr(attr_id)
  local now_attr = now_attrs[attr_cfg.Name]
  local after_attr = after_attrs[attr_cfg.Name]
  local rat_after_attr = Util.format_number(after_attr, is_ration)
  if not now_attr then
    attr_ui:SetActive(false)
    return
  end
  local attr_name_txt = Util.get_text("AttrName_", attr_ui)
  local attr_num_now_txt = Util.get_text("AttrNumNext_/Arrow_/AttrNumNow_", attr_ui)
  local attr_num_after_txt = Util.get_text("AttrNumNext_", attr_ui)
  local attr_name = ShareRes.get_buddy_attr_name(attr_id)
  local attr_up_mark = Util.get_child_gameobj("Up_", attr_ui)
  attr_name_txt.text = Util.set_str_color(normal_color_key, attr_name)
  attr_num_now_txt.text = Util.format_number(now_attr, is_ration)
  if now_attr < after_attr then
    attr_num_after_txt.text = Util.set_str_color(highlight_color_key, rat_after_attr)
  else
    attr_num_after_txt.text = Util.set_str_color(normal_color_key, rat_after_attr)
  end
  attr_up_mark:SetActive(now_attr < after_attr)
end

function ui:update_attr_item_talent()
  local attr_ui = self:get_auto_cache(ATTR_ITEM_KEY)
  Util.get_child_gameobj("Up_", attr_ui):SetActive(true)
  Util.get_child_gameobj("AttrNumNext_", attr_ui):SetActive(false)
  Util.get_text("AttrName_", attr_ui).text = Util.set_str_color(highlight_color_key, Util.format_str("天赋解锁"))
end

function ui:update_attr_item_puzzle(new_break_lv)
  local is_first_unlock, is_new_unlock, old_node_num, new_node_num = PuzzleMgr:get_puzzle_change_when_buddy_break(self.v_buddy_id, new_break_lv)
  if not is_first_unlock and not is_new_unlock then
    return
  end
  local attr_ui = self:get_auto_cache(ATTR_ITEM_KEY)
  Util.get_child_gameobj("Up_", attr_ui):SetActive(true)
  Util.get_child_gameobj("AttrNumNext_", attr_ui):SetActive(is_new_unlock)
  Util.get_text("AttrName_", attr_ui).text = Util.set_str_color(highlight_color_key, Util.format_str(is_first_unlock and "古痕解锁" or "古痕槽位"))
  if is_new_unlock then
    Util.get_text("AttrNumNext_/Arrow_/AttrNumNow_", attr_ui).text = Util.set_str_color(normal_color_key, old_node_num)
    Util.get_text("AttrNumNext_", attr_ui).text = Util.set_str_color(highlight_color_key, new_node_num)
  end
end

function ui:update_attr_item_spine()
  local attr_ui = self:get_auto_cache(ATTR_ITEM_KEY)
  Util.get_child_gameobj("Up_", attr_ui):SetActive(true)
  Util.get_child_gameobj("AttrNumNext_", attr_ui):SetActive(false)
  Util.get_text("AttrName_", attr_ui).text = Util.set_str_color(highlight_color_key, Util.format_str("突破映像解锁"))
end

function ui:_refresh_levelup_preview(quick_add_exp)
  local lv_normal_col = "<color=#f5ede2>"
  local lv_diff_col = "<color=#efc66e>"
  local coin_normal_col = "<color=#292929>"
  local add_exp = 0
  if not quick_add_exp then
    for _, item in pairs(self.v_use_levelup_items) do
      local item_cfg = ShareRes.create("item.item", item.id)
      add_exp = add_exp + item_cfg.Arg[1] * item.count
    end
  else
    add_exp = quick_add_exp
  end
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local max_level = ShareRes.get_buddy_max_level(buddy_info.break_lv)
  self.v_lv_now_num.text = Util.set_str_color(lv_normal_col, buddy_info.lv)
  local expnow, next_exp = CharacterMgr:get_character_exp_info(self.v_buddy_id)
  self.v_exp_now.text = expnow
  self.v_exp_max.text = next_exp
  self.v_exp_now_bar_fill.fillAmount = expnow / next_exp
  if add_exp <= 0 then
    self.v_cost_coin = 0
    self.v_diff_level = 0
    self.v_curr_num.text = Util.set_str_color(coin_normal_col, 0)
    self.v_lv_next_num.text = Util.set_str_color(lv_normal_col, buddy_info.lv)
    self.v_add_exp_val = 0
    self.v_exp_add_obj:SetActive(false)
    self.v_exp_next_bar_fill.fillAmount = 0
    local cur_attr = CharacterMgr.cal_buddy_attr(buddy_info.id, buddy_info.break_lv, buddy_info.lv, buddy_info.advance)
    self:refresh_attrs(cur_attr, cur_attr)
    return
  end
  local target_level, coin_cost = CharacterMgr:get_add_exp_info(buddy_info.id, add_exp)
  local cur_attr = CharacterMgr.cal_buddy_attr(buddy_info.id, buddy_info.break_lv, buddy_info.lv, buddy_info.advance)
  local after_attrs = CharacterMgr.cal_buddy_attr(buddy_info.id, buddy_info.break_lv, target_level, buddy_info.advance)
  self:refresh_attrs(cur_attr, after_attrs)
  self.v_add_exp_val = add_exp
  self.v_exp_add.text = add_exp
  self.v_exp_add_obj:SetActive(true)
  self.v_exp_next_bar_fill.fillAmount = (add_exp + buddy_info.exp) / next_exp
  local item_num = BagMgr:get_item_num(Config.COIN_ITEMID)
  local cost_color = coin_cost > item_num and "<color=#E22525>" or coin_normal_col
  local next_lv_color = target_level > buddy_info.lv and lv_diff_col or lv_normal_col
  self.v_cost_coin = coin_cost
  self.v_diff_level = target_level - buddy_info.lv
  self.v_curr_num.text = Util.set_str_color(cost_color, coin_cost)
  self.v_lv_next_num.text = Util.set_str_color(next_lv_color, target_level)
end

function ui:_on_click_levelup()
  self:check_track()
  if self.v_if_play_eff then
    return
  end
  if next(self.v_use_levelup_items) == nil then
    Util.show_message_tip(2142)
    return
  end
  if self.v_cost_coin and self.v_cost_coin > 0 then
    local coin_num = CharacterMgr:get_coin() or 0
    if coin_num < self.v_cost_coin then
      self:show_coin_not_enough_tip()
      return
    end
  end
  local items = {}
  for _, item in pairs(self.v_use_levelup_items) do
    _tinsert(items, item)
    if item.count > 0 then
      local particls = Util.get_child_gameobj("FX_UI_Items_Particls", self.v_item_uis[item.id])
      particls:SetActive(false)
      particls:SetActive(true)
    end
  end
  CharacterMgr:upgrade_buddy(self.v_buddy_id, items, function(lv_up)
    if self:visible() then
      local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
      local need_break = CharacterMgr:is_need_break(self.v_buddy_id)
      if lv_up then
        self.v_success_pd.time = 0
        self.v_success_pd:Play()
        Global.sound_mgr:play_character_lv_up_sound()
        if not need_break then
          self:check_can_levelup()
        end
      else
        Util.show_message_tip(2144)
      end
      self:delay_refresh(lv_up, need_break)
    end
  end)
end

function ui:check_track()
  local guide_tips = UIMgr:try_get_visible_ui("ui_guide")
  if not guide_tips then
    return
  end
  if self.v_buddy_id == 1001001 then
    SDKManager:track_adjust_event("33_levelup_zero")
  end
end

function ui:clear_timer()
  if self.v_timer_idx then
    Timer:remove_timer(self.v_timer_idx)
    self.v_timer_idx = nil
  end
end

function ui:delay_refresh(lv_up, need_break)
  if lv_up then
    self.v_if_play_eff = true
    self:clear_timer()
    local delay_time = need_break and 0.7 or 0.4
    self.v_timer_idx = Timer:add_timer("character_levelup_box:delay_refresh", delay_time, function()
      self:_use_item_clear()
      self:refresh(true)
    end)
  else
    self:_use_item_clear()
    self:refresh(true)
  end
end

function ui:check_can_levelup()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local buddy_break_cfg = ShareRes.create("buddy.buddy_break", buddy_info.id)[buddy_info.break_lv + 1]
  if buddy_break_cfg then
    return
  end
  local max_level = ShareRes.get_buddy_max_level(buddy_info.break_lv)
  if max_level <= buddy_info.lv then
    self:ui_hide()
  end
end

function ui:refresh_level_up_btn()
  if self.is_have_up_consum then
    Util.apply_grey_ex(self.v_uiobjects.BtnLevelUp, false)
    Util.apply_grey_ex(self.v_uiobjects.BtnAutoSelect, false)
  else
    Util.apply_grey_ex(self.v_uiobjects.BtnLevelUp, true)
    Util.apply_grey_ex(self.v_uiobjects.BtnAutoSelect, true)
  end
end

function ui:_on_click_tupo()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local buddy_break_cfg = ShareRes.create("buddy.buddy_break", buddy_info.id)[buddy_info.break_lv]
  if not buddy_break_cfg then
    return
  end
  if buddy_break_cfg.Condition and buddy_break_cfg.Condition > 0 then
    local condition = Condition:check_condition(buddy_break_cfg.Condition)
    if not condition then
      Util.show_message_tip(2145)
      return
    end
  end
  local tip = false
  for k, cost in pairs(self.v_buddy_break_cost) do
    local item_num = BagMgr:get_item_num(cost.id)
    if item_num <= 0 then
      tip = true
    elseif item_num < cost.count then
      tip = true
    end
    if tip then
      Util.show_message_tip(2146)
      return
    end
  end
  if self.v_cost_coin and self.v_cost_coin > 0 then
    local coin_num = CharacterMgr:get_coin() or 0
    if coin_num < self.v_cost_coin then
      self:show_coin_not_enough_tip()
      return
    end
  end
  CharacterMgr:buddy_break(self.v_buddy_id, function(resp)
    if 3 == resp.newlv then
      local spine_id = UtilUI.get_hero_display_big_spine(self.v_buddy_id)
      if spine_id then
        UIMgr:get_ui("char_spine_display"):ui_show(self.v_buddy_id, nil, resp.award_list or {})
        self:refresh()
        return
      end
    end
    CharacterMgr:trigger_buddy_sound(TRIGGER_SOUND_TYPE.BREAK, self.v_buddy_id)
    UIMgr:get_ui("buddy_break_detil"):ui_show(self.v_buddy_id, resp.award_list)
    self:refresh()
  end)
end

function ui:_on_click_quick_levelup()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local cost_data, coin_not_enough = CharacterMgr.get_buddy_lvMax_need_cost_data(buddy_info)
  if #cost_data <= 0 then
    if coin_not_enough then
      self:show_coin_not_enough_tip()
    else
      Util.show_message_tip(2147)
    end
    return
  end
  self:_use_item_clear()
  local quick_add_exp = 0
  self.v_use_levelup_items = {}
  for i, v_data in ipairs(cost_data) do
    if v_data.count > 0 then
      local id = v_data.id
      local item_cfg = ShareRes.create("item.item", id)
      quick_add_exp = quick_add_exp + item_cfg.Arg[1] * v_data.count
      self.v_use_levelup_items[id] = v_data
      local item_ui = self.v_item_uis[id]
      if item_ui then
        local select_obj = Util.get_child_gameobj("SelectObj_", item_ui)
        local select_num = Util.get_text("SelectObj_/SelectNumBg/SelectNum", item_ui)
        select_obj:SetActive(true)
        select_num.text = v_data.count
      end
    end
  end
  local target_level, coin_cost = CharacterMgr:get_add_exp_info(buddy_info.id, quick_add_exp)
  local item_num = BagMgr:get_item_num(Config.COIN_ITEMID)
  if coin_cost > item_num then
    self:show_coin_not_enough_tip()
    self:_use_item_clear()
    self:clear_use_item_preview()
    return
  end
  self:_refresh_levelup_preview(quick_add_exp)
end

function ui:_use_item_clear()
  local levelup_items = ShareRes.create("buddy.buddy_exp")
  for _, item_info in pairs(levelup_items) do
    local item_ui = self.v_item_uis[item_info.Id]
    if item_ui then
      local select_obj = Util.get_child_gameobj("SelectObj_", item_ui)
      select_obj:SetActive(false)
    end
  end
end

function ui:_on_item_update()
  self.v_item_uis = self.v_item_uis or {}
  local levelup_items = ShareRes.create("buddy.buddy_exp")
  self.is_have_up_consum = false
  for _, item_info in pairs(levelup_items) do
    local item_ui = self.v_item_uis[item_info.Id]
    local item_num = BagMgr:get_item_num(item_info.Id)
    if item_ui then
      local cur_num = 0 == item_num and "<color=#e0212c>0</color>" or item_num
      Util.get_child_gameobj("Mask_", item_ui):SetActive(0 == item_num)
      Util.get_text("ItemAmount_/Bg/ItemNum_", item_ui).text = cur_num
      if item_num > 0 then
        self.is_have_up_consum = true
      end
    end
  end
  self:refresh_level_up_btn()
  if not self.v_buddy_id then
    return
  end
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local buddy_break_cfg = ShareRes.create("buddy.buddy_break", buddy_info.id)[buddy_info.break_lv]
  if not buddy_break_cfg then
    return
  end
  self.v_break_item = self.v_break_item or {}
  for idx, item_id in ipairs(buddy_break_cfg.Item) do
    local item_ui = self.v_break_item[item_id]
    if item_ui then
      local need_num = buddy_break_cfg.ItemCount[idx]
      local item_count = BagMgr:get_item_num(item_id)
      self:refresh_item_num_ui(item_count, need_num, item_ui)
    end
  end
  self:refresh_tupo_btn()
end

function ui:refresh_item_num_ui(now_num, need_num, item_ui)
  local item_count_txt
  if now_num < need_num then
    item_count_txt = Util.set_str_color("<color=#E22525>", now_num)
  else
    item_count_txt = now_num
  end
  Util.get_text("ItemAmountBg/ItemNow_", item_ui).text = item_count_txt
  Util.get_text("ItemAmountBg/ItemNeed_", item_ui).text = need_num
end

function ui:get_cache_data()
  return self.v_backui, self.v_buddy_idx
end

function ui:cache_ui()
  return true
end

function ui:show_coin_not_enough_tip()
  local coin_cfg = ShareRes.get_item_cfg(Config.COIN_ITEMID)
  Util.show_message_tip(2314, coin_cfg.Name)
end

return ui
