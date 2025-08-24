local Base = require("ui.uiobject")
local Vec2 = require("base.vec2")
local Item_Helper = require("utils.item_helper")
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
local BIND_TYPE = Config.BIND_TYPE
local STAR_START_IDX = 1
local STAR_END_IDX = 4
local CHAR_HELPER = require("uimodule.character.char_helper")
local UPGRADE_ITEM_KEY = "WEAPON_UPGRADE_ITEM"
local BREAK_ITEM_KEY = "WEAPON_BREAK_ITEM_KEY"
local MODEL = {
  v_after_info = {
    "AfterInfo",
    BIND_TYPE.OBJECT
  },
  v_levelup = {
    "Levelup",
    BIND_TYPE.OBJECT
  },
  v_hp_after = {
    "HpAfter",
    BIND_TYPE.TEXT
  },
  v_mp_after = {
    "MpAfter",
    BIND_TYPE.TEXT
  },
  v_attack_after = {
    "AttackAfter",
    BIND_TYPE.TEXT
  },
  v_spec_attack_after = {
    "SpecAttackAfter",
    BIND_TYPE.TEXT
  },
  v_level_add = {
    "LvAdd",
    BIND_TYPE.TEXT
  },
  v_exp_add = {
    "ExpAdd",
    BIND_TYPE.TEXT
  },
  v_item_template = {
    "ItemTemplate",
    BIND_TYPE.OBJECT
  },
  v_item_list_content = {
    "ItemListContent",
    BIND_TYPE.OBJECT
  },
  v_levelup_cost_gold = {
    "LevelupCost",
    BIND_TYPE.TEXT
  },
  v_star_preview1 = {
    "StarPreview1",
    BIND_TYPE.OBJECT
  },
  v_star_preview2 = {
    "StarPreview2",
    BIND_TYPE.OBJECT
  },
  v_star_preview3 = {
    "StarPreview3",
    BIND_TYPE.OBJECT
  },
  v_star_preview4 = {
    "StarPreview4",
    BIND_TYPE.OBJECT
  },
  v_star_break1 = {
    "StarBreak1",
    BIND_TYPE.OBJECT
  },
  v_star_break2 = {
    "StarBreak2",
    BIND_TYPE.OBJECT
  },
  v_star_break3 = {
    "StarBreak3",
    BIND_TYPE.OBJECT
  },
  v_star_break4 = {
    "StarBreak4",
    BIND_TYPE.OBJECT
  },
  v_bottom_levelup = {
    "BottomLevelup",
    BIND_TYPE.OBJECT
  },
  v_bottom_tupo = {
    "BottomTupo",
    BIND_TYPE.OBJECT
  },
  V_lock = {
    "Lock",
    BIND_TYPE.OBJECT
  },
  v_tupo = {
    "Tupo",
    BIND_TYPE.OBJECT
  },
  v_tupo_lvnow = {
    "TpLvNow",
    BIND_TYPE.TEXT
  },
  v_tupo_lvafter = {
    "TpLvAfter",
    BIND_TYPE.TEXT
  },
  v_tupo_hp = {
    "TupoHp",
    BIND_TYPE.TEXT
  },
  v_tupo_hp_after = {
    "TupoHpAfter",
    BIND_TYPE.TEXT
  },
  v_tupo_mp = {
    "TupoMp",
    BIND_TYPE.TEXT
  },
  v_tupo_mp_after = {
    "TupoMpAfter",
    BIND_TYPE.TEXT
  },
  v_tupo_attack = {
    "TupoAttack",
    BIND_TYPE.TEXT
  },
  v_tupo_attack_after = {
    "TupoAttackAfter",
    BIND_TYPE.TEXT
  },
  v_tupo_spec_attack = {
    "TupoSpecAttack",
    BIND_TYPE.TEXT
  },
  v_tupo_spec_attack_after = {
    "TupoSpecAttackAfter",
    BIND_TYPE.TEXT
  },
  v_tupo_content = {
    "TupoContent",
    BIND_TYPE.OBJECT
  },
  v_tupo_item_template = {
    "TupoItemTemplate",
    BIND_TYPE.OBJECT
  },
  v_tupo_condition = {
    "TPCondition",
    BIND_TYPE.OBJECT
  },
  v_tupo_condition_desc = {
    "TPConditionDesc",
    BIND_TYPE.TEXT
  },
  v_tupo_cost = {
    "TupoCost",
    BIND_TYPE.TEXT
  },
  v_hp = {
    "Hp",
    BIND_TYPE.TEXT
  },
  v_mp = {
    "Mp",
    BIND_TYPE.TEXT
  },
  v_attack = {
    "Attack",
    BIND_TYPE.TEXT
  },
  v_spec_attack = {
    "SpecAttack",
    BIND_TYPE.TEXT
  },
  v_level_now_text = {
    "LvNow",
    BIND_TYPE.TEXT
  },
  v_level_max_text = {
    "LvMax",
    BIND_TYPE.TEXT
  },
  v_exp_now_text = {
    "ExpNow",
    BIND_TYPE.TEXT
  },
  v_exp_max_text = {
    "ExpMax",
    BIND_TYPE.TEXT
  },
  v_exp_slider = {
    "ExpSlider",
    BIND_TYPE.SLIDER
  },
  v_star1 = {
    "Star1",
    BIND_TYPE.TRANSFORM
  },
  v_star2 = {
    "Star2",
    BIND_TYPE.TRANSFORM
  },
  v_star3 = {
    "Star3",
    BIND_TYPE.TRANSFORM
  },
  v_star4 = {
    "Star4",
    BIND_TYPE.TRANSFORM
  },
  v_add_exp_slider = {
    "ExpAddSlider",
    BIND_TYPE.SLIDER
  }
}
local CHARACTER_CONFIG = require("uimodule.character.character_config")

function ui:ui_finish_load()
  self:set_button("BtnLevelup", function()
    if self.v_item_uis then
      for _, item in pairs(self.v_item_uis) do
        local particls_effect = Util.get_child_gameobj("FX_UI_Items_Particls", item)
        particls_effect:SetActive(false)
      end
    end
    self:_on_click_levelup()
  end)
  self:set_button("BtnTupo", function()
    self:_on_click_tupo()
  end)
  self:set_button("BtnQuickLevelup", function()
    self:_on_click_quick_levelup()
  end)
  self:set_button("BtnClear", function()
    self:clear_use_item_preview()
  end)
  self:init_model(MODEL)
  self:set_button("Lock", function()
    self:click_equip_lock()
  end)
  self:set_button("TuopLock", function()
    self:click_equip_lock()
  end)
  self:set_button("BtnWeaponBreakPre", function()
    local data = {
      weapon_uid = self.v_equip_info.uuid,
      type = 2
    }
    UIMgr:get_ui("break_preview"):ui_show(data)
  end)
  self:register_exist_auto_template(UPGRADE_ITEM_KEY, self.v_item_template, self.v_item_list_content)
  self:register_exist_auto_template(BREAK_ITEM_KEY, self.v_tupo_item_template, self.v_tupo_content)
  self.v_content_rect_trans = Util.get_rect_transform(nil, self.v_item_list_content)
  self.v_use_levelup_items = {}
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self._on_item_update, self)
  local ui_comment = self.v_uicompents
  for index = 1, 2 do
    ui_comment["HpName" .. index .. "_txt"].text = ShareRes.equip_attr_str("hp")
    ui_comment["AtkName" .. index .. "_txt"].text = ShareRes.equip_attr_str("attack")
    ui_comment["EnergyName" .. index .. "_txt"].text = ShareRes.equip_attr_str("energy")
  end
end

function ui:ui_on_hide()
  if self.v_item_uis then
    for _, item in pairs(self.v_item_uis) do
      local particls_effect = Util.get_child_gameobj("FX_UI_Items_Particls", item)
      particls_effect:SetActive(false)
    end
  end
  self.v_item_uis = nil
  self.v_break_cost_item_uis = {}
end

function ui:refresh(equip_uuid, buddy_idx, internal_fresh)
  local equip_info = CharacterMgr:get_equip_info(equip_uuid)
  self.v_equip_info = equip_info
  local buddy_index = CharacterMgr:get_buddy_index_by_equip_uuid(equip_uuid)
  self.v_buddy_idx = buddy_index
  self.v_equip_uuid = equip_uuid
  local need_break = CharacterMgr:is_equip_need_break(self.v_equip_uuid)
  self.v_levelup:SetActive(not need_break)
  self.v_tupo:SetActive(need_break)
  if not need_break then
    self:refresh_buddy_info(buddy_idx)
    self:_refresh_item_ui(internal_fresh)
    self:_refresh_preview()
  else
    self:_refresh_tupo()
  end
  local equip_cfg = ShareRes.get_equip(equip_info.id)
  local name = equip_cfg.Name
  self.v_uicompents.Equip_name_txt.text = name
  self:refresh_lock_view(equip_uuid)
end

function ui:refresh_lock_view()
  local equip_uuid = self.v_equip_info.uuid
  local lock = self:get_uiobject("Lock")
  local equip_info = CharacterMgr:get_equip_info(equip_uuid)
  local img_lock = Util.get_image("img_lock", lock)
  local img_no_lock = Util.get_image("img_no_lock", lock)
  local lock = 1 == equip_info.lock
  img_lock.gameObject:SetActive(lock)
  img_no_lock.gameObject:SetActive(not lock)
end

function ui:_refresh_item_ui(internal_fresh)
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local upgrade_items = ShareRes.create("equip.equip_exp")
  local add_exp_item_data = {}
  for k, v in pairs(upgrade_items) do
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
  self.v_use_levelup_items = {}
  self.v_add_exp_val = 0
  local need_max_exp = CharacterMgr.get_equip_lvmax_need_exp(equip_info)
  if not internal_fresh then
    self:give_back_auto_cache(UPGRADE_ITEM_KEY)
    self.v_item_uis = {}
    self.is_have_up_consum = false
    for _, item_info in ipairs(add_exp_item_data) do
      local item_num = BagMgr:get_item_num(item_info.Id)
      if not self.is_have_up_consum and item_num > 0 then
        self.is_have_up_consum = true
      end
      local item_ui = self:get_auto_cache(UPGRADE_ITEM_KEY)
      local dec_btn = Util.get_button("Dec", item_ui)
      local dec_text = Util.get_text("Text", dec_btn.transform)
      dec_btn.gameObject:SetActive(false)
      dec_text.text = "0"
      self:set_button_listener(Util.get_button(nil, item_ui), function()
        local item_num = BagMgr:get_item_num(item_info.Id)
        if item_num <= 0 then
          UIMgr:get_ui("itemTip"):ui_show({
            item_id = item_info.Id
          })
          return
        end
        if self.v_add_exp_val >= need_max_exp then
          return
        end
        if item_num <= 0 then
          dec_btn.gameObject:SetActive(false)
          return
        end
        local use_items = self.v_use_levelup_items[item_info.Id]
        if not use_items then
          use_items = {
            id = item_info.Id,
            count = 1
          }
          self.v_use_levelup_items[item_info.Id] = use_items
        else
          use_items.count = use_items.count + 1
        end
        use_items.count = math.min(use_items.count, item_num)
        dec_btn.gameObject:SetActive(true)
        dec_text.text = use_items.count
        self:_refresh_preview()
      end)
      self:set_button_listener(dec_btn, function()
        local use_items = self.v_use_levelup_items[item_info.Id]
        use_items.count = use_items.count - 1
        dec_text.text = use_items.count
        self:_refresh_preview()
        if use_items.count <= 0 then
          dec_btn.gameObject:SetActive(false)
          return
        end
      end)
      local cur_num = 0 == item_num and "<color=#e0212c>0</color>" or item_num
      Util.get_text("Amount/Num", item_ui).text = cur_num
      Util.get_child_gameobj("Mask", item_ui):SetActive(0 == item_num)
      self.v_item_uis[item_info.Id] = item_ui
      local item_cfg = ShareRes.create("item.item", item_info.Id)
      local quality_img = Util.get_image(nil, item_ui)
      local quality_cfg = ShareRes.get_item_quality_cfg(item_cfg.Quality)
      local icon_path = ShareRes.get_item_icon_path(item_info.Id)
      local icon_img = Util.get_image("Icon", item_ui)
      if quality_cfg then
        local quality_path = "UICommon/" .. quality_cfg.QualityIcon
        ResMgr:load_set_icon(quality_img, quality_path)
      end
      if icon_path then
        ResMgr:load_set_icon(icon_img, icon_path)
      end
    end
  end
  self:refresh_level_up_btn()
end

function ui:refresh_level_up_btn()
  if self.is_have_up_consum then
    Util.apply_grey_ex(self.v_uiobjects.BtnLevelup, false)
    Util.apply_grey_ex(self.v_uiobjects.BtnQuickLevelup, false)
  else
    Util.apply_grey_ex(self.v_uiobjects.BtnLevelup, true)
    Util.apply_grey_ex(self.v_uiobjects.BtnQuickLevelup, true)
  end
end

function ui:clear_use_item_preview()
  self.v_add_exp_val = 0
  self.v_use_levelup_items = nil
  self:give_back_auto_cache(UPGRADE_ITEM_KEY)
  self:_refresh_item_ui(false)
  self:_refresh_preview()
end

function ui:_refresh_preview(quick_add_exp)
  local add_exp = 0
  if not quick_add_exp then
    for _, item in pairs(self.v_use_levelup_items) do
      local item_cfg = ShareRes.create("item.item", item.id)
      add_exp = add_exp + item_cfg.Arg[1] * item.count
    end
  else
    add_exp = quick_add_exp
  end
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  self.v_uiobjects.ExpSlider:SetActive(true)
  if add_exp <= 0 then
    self.v_after_info:SetActive(false)
    self.v_add_exp_slider.gameObject:SetActive(false)
    self.v_uiobjects.LevelUpSign:SetActive(false)
    self.v_cost_coin = 0
    self.v_diff_level = 0
    self.v_levelup_cost_gold.text = 0
    self.v_add_exp_val = 0
    return
  else
    self.v_add_exp_slider.gameObject:SetActive(true)
    self.v_uiobjects.LevelUpSign:SetActive(true)
    self.v_after_info:SetActive(true)
  end
  self.v_add_exp_val = add_exp
  local target_level, coin_cost = CharacterMgr:get_equip_add_exp_info(equip_info.uuid, add_exp)
  local attrs = CharacterMgr.cal_equip_attr(equip_info.id, equip_info.break_lv, target_level)
  self.v_hp_after.text = attrs.hp
  self.v_mp_after.text = attrs.energy
  self.v_attack_after.text = attrs.attack
  local item_num = BagMgr:get_item_num(Config.COIN_ITEMID)
  local cost_txt
  if coin_cost > item_num then
    cost_txt = Util.set_str_color("<color=#E22525>", coin_cost)
  else
    cost_txt = Util.set_str_color("<color=#FFFFFF>", coin_cost)
  end
  self.v_levelup_cost_gold.text = cost_txt
  self.v_diff_level = target_level - equip_info.lv
  self.v_level_max_text.text = target_level
  self.v_level_add.text = "+" .. self.v_diff_level
  if self.v_diff_level > 1 then
    self.v_uiobjects.ExpSlider:SetActive(false)
  end
  self.v_exp_add.text = "+" .. add_exp
  local next_exp = CharacterMgr:get_equip_next_exp_info(equip_info.uuid)
  self.v_add_exp_slider.value = (add_exp + equip_info.exp) / next_exp
  self.v_cost_coin = coin_cost
end

function ui:_on_click_levelup()
  if next(self.v_use_levelup_items) == nil then
    Util.show_message_tip(2142)
    return
  end
  local coin_cfg = ShareRes.get_item_cfg(Config.COIN_ITEMID)
  local desc = coin_cfg.Name
  if self.v_cost_coin and self.v_cost_coin > 0 then
    local coin_num = CharacterMgr:get_coin() or 0
    if coin_num < self.v_cost_coin then
      Util.show_message_tip(2314, desc)
      return
    end
  end
  local items = {}
  for _, item in pairs(self.v_use_levelup_items) do
    _tinsert(items, item)
    local particls_effect = Util.get_child_gameobj("FX_UI_Items_Particls", self.v_item_uis[item.id])
    particls_effect:SetActive(true)
  end
  CharacterMgr:upgrade_equip(self.v_equip_uuid, items, function(lv_up)
    if self:visible() then
      self:_use_item_clear()
      self.v_use_levelup_items = {}
      self:refresh(self.v_equip_uuid, true)
      local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
      local need_break = CharacterMgr:is_equip_need_break(equip_info.uuid)
      local can_operation = CharacterMgr:check_equip_can_operation(equip_info.uuid)
      if lv_up then
        if not need_break or not can_operation then
          Util.show_message_tip_with_path_data(2317, nil, {
            equip_info.lv,
            "LV"
          })
        else
          Util.show_message_tip(2158)
        end
        self.v_parent_ui:play_level_up_effect()
      else
        Util.show_message_tip(2144)
      end
      self.v_parent_ui:check_can_levelup()
    end
  end)
end

function ui:_use_item_clear()
  local levelup_items = ShareRes.create("equip.equip_exp")
  for _, item_info in pairs(levelup_items) do
    local item_ui = self.v_item_uis[item_info.Id]
    if item_ui then
      local dec_btn = Util.get_button("Dec", item_ui)
      local dec_text = Util.get_text("Text", dec_btn.transform)
      dec_btn.gameObject:SetActive(false)
    end
  end
end

function ui:_on_click_quick_levelup()
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local cost_data = CharacterMgr.get_equip_lvMax_need_cost_data(equip_info)
  if #cost_data <= 0 then
    Util.show_message_tip(2147)
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
        local dec_btn = Util.get_button("Dec", item_ui)
        local dec_text = Util.get_text("Text", dec_btn.transform)
        dec_btn.gameObject:SetActive(true)
        dec_text.text = v_data.count
      end
    end
  end
  local target_level, coin_cost = CharacterMgr:get_equip_add_exp_info(equip_info.uuid, quick_add_exp)
  local item_num = BagMgr:get_item_num(Config.COIN_ITEMID)
  if coin_cost > item_num then
    local item_cfg = Item_Helper.get_item_cfg(Config.COIN_ITEMID)
    Util.show_message_tip(2314, item_cfg.Name)
    self:_use_item_clear()
    self:clear_use_item_preview()
    return
  end
  self:_refresh_preview(quick_add_exp)
end

function ui:_refresh_tupo()
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  local quality = equip_cfg.Quality
  local equip_level_cfgs = ShareRes.get_equip_lv_up_cfg(quality)
  local equip_level_info = equip_level_cfgs[equip_info.break_lv + 1]
  if not equip_level_info then
    return
  end
  local break_lv = equip_info.break_lv
  self.v_tupo_lvnow.text = equip_info.lv
  self.v_tupo_lvafter.text = "1"
  break_lv = break_lv - 1
  local max_break_lv = ShareRes.get_max_equip_break_lv(equip_info.id)
  for i = STAR_START_IDX, STAR_END_IDX do
    local star_obj = self.v_uiobjects["TupoStar" .. i]
    local star_break_obj = self["v_star_break" .. i]
    local star_preview_obj = self["v_star_preview" .. i]
    star_obj:SetActive(i <= max_break_lv)
    star_preview_obj.gameObject:SetActive(i == break_lv + 1)
    star_break_obj.gameObject:SetActive(i <= break_lv)
  end
  local cur_attr = equip_info.attrs
  local next_attr = CharacterMgr.cal_equip_attr(equip_info.id, equip_info.break_lv + 1, 1)
  self.v_tupo_hp.text = cur_attr.hp
  self.v_tupo_hp_after.text = next_attr.hp
  self.v_tupo_mp.text = cur_attr.energy
  self.v_tupo_mp_after.text = next_attr.energy
  self.v_tupo_attack.text = cur_attr.attack
  self.v_tupo_attack_after.text = next_attr.attack
  local equip_break_cfg = ShareRes.create("equip.equip_break", equip_info.id)[equip_info.break_lv]
  local item_num = BagMgr:get_item_num(Config.COIN_ITEMID)
  local cost_num = equip_break_cfg.Coin
  local cost_txt
  if item_num < cost_num then
    cost_txt = Util.set_str_color("<color=#E22525>", cost_num)
  else
    cost_txt = Util.set_str_color("<color=#FFFFFF>", cost_num)
  end
  self.v_tupo_cost.text = cost_txt
  self.v_tupo_condition:SetActive(false)
  if equip_break_cfg.Condition and 0 ~= equip_break_cfg.Condition then
    local condition = Condition:check_condition(equip_break_cfg.Condition)
    if condition then
      self.v_tupo_condition:SetActive(false)
    else
      self.v_tupo_condition:SetActive(true)
      local condition_cfg = ShareRes.create("condition.condition", equip_break_cfg.Condition)
      self.v_tupo_condition_desc.text = condition_cfg.Desc
    end
  end
  self.v_break_cost_item_uis = {}
  self:give_back_auto_cache(BREAK_ITEM_KEY)
  for idx, item_id in ipairs(equip_break_cfg.Item) do
    local item_ui = self:get_auto_cache(BREAK_ITEM_KEY)
    local item_count = BagMgr:get_item_num(item_id)
    local item_need = equip_break_cfg.ItemCount[idx]
    self:refresh_tupo_num_ui(item_count, item_need, item_ui)
    local icon_path, quality_path = UtilUI.get_item_images(item_id)
    local icon = Util.get_image("Icon", item_ui)
    ResMgr:load_set_icon(icon, icon_path)
    local quality_img = Util.get_image(nil, item_ui)
    ResMgr:load_set_icon(quality_img, quality_path)
    self.v_break_cost_item_uis[item_id] = item_ui
    self:set_button_listener(Util.get_button(nil, item_ui), function()
      Util.show_item_tip(item_id)
    end)
  end
end

function ui:refresh_tupo_btn()
  if self:is_can_tupo() then
    Util.apply_grey_ex(self.v_uiobjects.BtnTupo, true)
  else
    Util.apply_grey_ex(self.v_uiobjects.BtnTupo, false)
  end
end

function ui:is_can_tupo()
  local is_can = true
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local equip_break_cfg = ShareRes.create("equip.equip_break", equip_info.id)[equip_info.break_lv]
  if not equip_break_cfg then
    return is_can
  end
  for index, item_id in ipairs(equip_break_cfg.Item) do
    local need_num = equip_break_cfg.ItemCount[index]
    local item_count = BagMgr:get_item_num(item_id)
    if item_count <= 0 then
      is_can = false
    elseif need_num > item_count then
      is_can = false
    end
    if not is_can then
      return is_can
    end
  end
  local need_coin = equip_break_cfg.Coin
  local coin_num = CharacterMgr:get_coin() or 0
  if need_coin > coin_num then
    return false
  end
  return is_can
end

function ui:refresh_tupo_num_ui(now_num, need_num, item_ui)
  local item_count_txt
  if now_num < need_num then
    item_count_txt = Util.set_str_color("<color=#E22525>", now_num)
  else
    item_count_txt = now_num
  end
  Util.get_text("amount/Text_now", item_ui).text = item_count_txt
  Util.get_text("amount/Text_need", item_ui).text = need_num
end

function ui:_on_click_tupo()
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local equip_break_cfg = ShareRes.create("equip.equip_break", equip_info.id)[equip_info.break_lv]
  if not equip_break_cfg then
    return
  end
  if equip_break_cfg.Condition and 0 ~= equip_break_cfg.Condition then
    local condition = Condition:check_condition(equip_break_cfg.Condition)
    if not condition then
      Util.show_message_tip(2145)
      return
    end
  end
  local tip = false
  for index, item_id in ipairs(equip_break_cfg.Item) do
    local need_num = equip_break_cfg.ItemCount[index]
    local item_count = BagMgr:get_item_num(item_id)
    if item_count <= 0 then
      tip = true
    elseif need_num > item_count then
      tip = true
    end
    if tip then
      Util.show_message_tip(2146)
      return
    end
  end
  local need_coin = equip_break_cfg.Coin
  local coin_cfg = ShareRes.get_item_cfg(Config.COIN_ITEMID)
  local desc = coin_cfg.Name
  local coin_num = CharacterMgr:get_coin() or 0
  if need_coin > coin_num then
    Util.show_message_tip(2314, desc)
    return
  end
  CharacterMgr:equip_break(self.v_equip_uuid, function()
    if self:visible() then
      self:refresh(self.v_equip_uuid)
      UIMgr:get_ui("equip_break_detil"):ui_show(self.v_equip_uuid)
    end
  end)
end

function ui:_on_item_update()
  local levelup_items = ShareRes.create("equip.equip_exp")
  for _, item_info in pairs(levelup_items) do
    local item = BagMgr:get_item_num(item_info.Id)
    if self.v_item_uis then
      local item_count = self.v_item_uis[item_info.Id]
      if item_ui then
        Util.get_text("Amount/Num", item_ui).text = item_count
      end
    end
  end
  self:_refresh_tupo()
end

function ui:refresh_buddy_info()
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local attrs = equip_info.attrs
  local equip_cfg = ShareRes.create("equip.equip", equip_info.id)
  self.v_hp.text = attrs.hp
  self.v_mp.text = attrs.energy
  self.v_attack.text = attrs.attack
  self.v_spec_attack.text = attrs.penetrate
  local exp, max_exp = CharacterMgr:get_equip_exp_info(self.v_equip_uuid)
  local level = equip_info.lv
  self.v_exp_now_text.text = exp
  self.v_exp_max_text.text = max_exp
  self.v_exp_slider.value = exp / max_exp
  self.v_level_now_text.text = level
  self.v_level_max_text.text = ShareRes.get_equip_max_level(equip_info.break_lv)
  local break_lv = equip_info.break_lv
  break_lv = break_lv - 1
  local max_star_num = CHAR_HELPER.get_equip_max_break_star_num(equip_info.id)
  for i = STAR_START_IDX, STAR_END_IDX do
    local star_obj = self["v_star" .. i]
    if star_obj then
      star_obj.gameObject:SetActive(false)
      if i <= max_star_num then
        star_obj.gameObject:SetActive(true)
        Util.get_child_gameobj("Lightup", star_obj):SetActive(i <= break_lv)
      end
    end
  end
end

function ui:click_equip_lock()
  if not self.v_equip_info then
    return
  end
  CharacterMgr:equip_lock(self.v_equip_info.uuid, function()
    self:refresh_lock_view()
  end)
end

return ui
