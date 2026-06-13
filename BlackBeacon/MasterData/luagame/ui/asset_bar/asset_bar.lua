local M = Util.create_class()
local Shop_Helper = require("uimodule.shop.shop_helper")
local default_config = {
  {
    name = "钻石",
    item_id = Config.DIAMOND_ITEMID,
    func = "_onclick_diamond",
    const_event = Const.MSG_ON_DIAMOND_UPDATE,
    bg_click = false
  },
  {
    name = "金币",
    item_id = Config.COIN_ITEMID,
    func = "_onclick_coin",
    const_event = Const.MSG_ON_COIN_UPDATE,
    bg_click = false
  },
  {
    name = "体力",
    item_id = Config.PLAYER_SP_ITEMID,
    func = "_onclick_stamina",
    const_event = Const.MSG_ON_PLAYER_SP_UPDATE,
    bg_click = false
  }
}
local SPETIAL_ID_MAP = {
  [Config.DIAMOND_ITEMID] = {
    item_id = Config.DIAMOND_ITEMID,
    func = "_onclick_diamond",
    const_event = Const.MSG_ON_DIAMOND_UPDATE,
    bg_click = false
  },
  [Config.COIN_ITEMID] = {
    item_id = Config.COIN_ITEMID,
    func = "_onclick_coin",
    const_event = Const.MSG_ON_COIN_UPDATE,
    bg_click = false
  },
  [Config.PLAYER_SP_ITEMID] = {
    item_id = Config.PLAYER_SP_ITEMID,
    func = "_onclick_stamina",
    const_event = Const.MSG_ON_PLAYER_SP_UPDATE,
    bg_click = false
  },
  [Config.PUZZLE_REFINE_COIN] = {
    item_id = Config.PUZZLE_REFINE_COIN,
    func = "_on_click_item",
    const_event = Const.MSG_ROLE_RES_CHANGE,
    bg_click = true
  },
  [Config.WEAPON_TONGTIAO_ITEMID] = {
    item_id = Config.WEAPON_TONGTIAO_ITEMID,
    func = "_on_click_item",
    const_event = Const.MSG_ROLE_RES_CHANGE,
    bg_click = true
  }
}

function M:_init(ui, asset_bar, config)
  self.jump_callback = nil
  self.v_ui = ui
  self.v_handles_list = {}
  self.v_ui_root = ui:get_object()
  self.v_asset_bar = asset_bar
  self.v_asset_config = nil ~= config and config or default_config
  self.asset_item = Util.get_child_gameobj("Asset_Item", self.v_asset_bar)
  self:_register_exist_auto_template()
end

function M:on_create()
  self.v_state = Config.ASSET_BAR_STATE.ON_CREATE
  self:_refresh_asset_bar()
  self:_add_event_listener()
  UIMgr:insert_asset_bar_in_list(self)
end

function M:on_hide()
  self.v_handles_list = {}
  self.v_state = Config.ASSET_BAR_STATE.ON_HIDE
  UIMgr:remove_asset_bar_on_list(self)
end

function M:on_destory()
  self.v_asset_bar = nil
  self.v_handles_list = {}
  self.v_state = Config.ASSET_BAR_STATE.ON_DESTROY
  UIMgr:remove_asset_bar_on_list(self)
end

function M:on_clear()
  self.v_ui:give_back_auto_cache(self.template_key, false)
  self.v_state = Config.ASSET_BAR_STATE.ON_CLREA
end

function M:get_default_config_by_id(item_id)
  return SPETIAL_ID_MAP[item_id]
end

function M:reset_by_id_list(id_list)
  if nil == id_list or nil == next(id_list) then
    self:reset_config()
    return
  end
  local config = {}
  local config_item
  for _, id in ipairs(id_list) do
    config_item = SPETIAL_ID_MAP[id]
    if nil == config_item then
      config_item = {
        item_id = id,
        func = "_on_click_item",
        const_event = Const.MSG_ON_ITEM_UPDATE,
        bg_click = true
      }
    end
    table.insert(config, config_item)
  end
  self:reset_config(config)
end

function M:set_jump_callback(cb)
  self.jump_callback = cb
end

function M:reset_config(config)
  self.v_asset_config = nil ~= config and config or default_config
  for i, v in ipairs(self.v_handles_list) do
    self.v_ui:unbind_auto_mq(v)
  end
  self.v_handles_list = {}
end

function M:get_state()
  return self.v_state
end

function M:_register_exist_auto_template()
  self.template_key = string.format("ASSET_BAR_%s_%s", self.v_ui, self.v_ui.v_ui_name or "")
  self.v_ui:register_exist_auto_template(self.template_key, self.asset_item, self.v_asset_bar)
end

function M:_add_event_listener()
  for k, asset_config in ipairs(self.v_asset_config) do
    local const_event = asset_config.const_event
    local func = asset_config.func
    self.v_handles_list[k] = self.v_ui:bind_auto_mq(const_event, function()
      self:_refresh_asset_bar()
    end, self)
  end
end

function M:_refresh_asset_bar()
  self.v_ui:give_back_auto_cache(self.template_key)
  for _, asset_config in ipairs(self.v_asset_config) do
    local asset_item = self.v_ui:get_auto_cache(self.template_key)
    self:_refresh_asset_item(asset_item, asset_config)
  end
end

function M:_refresh_asset_item(asset_item, asset_config)
  local item_config
  if asset_config.is_fight_bag then
    item_config = ShareRes.create("battle.battle_item", asset_config.item_id)
  else
    item_config = ShareRes.create("item.item", asset_config.item_id)
  end
  if nil == item_config or nil == next(item_config) then
    Log.Error("没有对应的货币配置，请检查！！", asset_config.item_id)
    return
  end
  local item_num = BagMgr:get_item_num(asset_config.item_id)
  local item_maxnum = item_config.MaxCount
  local add1_gameobj = Util.get_child_gameobj("AddBtn (1)", asset_item)
  if add1_gameobj then
    add1_gameobj.gameObject:SetActive(not asset_config.hide_add_btn)
  end
  local is_hide_add1 = false
  if asset_config.item_id == Config.PLAYER_SP_ITEMID then
    item_maxnum = CharacterMgr:get_res_force_max_val()
  elseif asset_config.item_id == Config.DIAMOND_ITEMID and self.v_ui.ui_get_name and self.v_ui:ui_get_name() == "dia_exchange" then
    if add1_gameobj then
      add1_gameobj.gameObject:SetActive(false)
      is_hide_add1 = true
    end
  elseif asset_config.item_id == Config.GILTGOLD_ITEMID and self.v_ui.ui_get_name and self.v_ui:ui_get_name() == "recharge_shop" and add1_gameobj then
    add1_gameobj.gameObject:SetActive(false)
    is_hide_add1 = true
  end
  local item_img = Util.get_image("Label", asset_item)
  ResMgr:load_set_icon(item_img, UtilUI.get_item_icon(asset_config.item_id))
  if not asset_config.not_show_max and 0 ~= item_maxnum and 99999999 ~= item_maxnum then
    Util.get_text("Aomunt", asset_item).text = string.format("%s/%s", item_num, item_maxnum)
  else
    Util.get_text("Aomunt", asset_item).text = item_num
  end
  local add_btn = Util.get_button("AddBtn", asset_item)
  self.v_ui:set_button_listener(add_btn, function()
    if asset_config.add_func then
      asset_config.add_func()
      return
    end
    if not is_hide_add1 then
      local func = asset_config.func
      if func and self[func] then
        self[func](self, item_config)
      end
    else
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = asset_config.item_id,
        jump_cb = self.jump_callback
      })
    end
  end)
  local bg_btn = Util.get_button("Bg", asset_item)
  self.v_ui:set_button_listener(bg_btn, function()
    if asset_config.bg_click then
      if not is_hide_add1 then
        local func = asset_config.func
        if func and self[func] then
          self[func](self, item_config)
        end
      else
        UIMgr:get_ui("itemTip"):ui_show({
          item_id = asset_config.item_id,
          jump_cb = self.jump_callback
        })
      end
    end
  end)
end

function M:_onclick_coin()
  UIMgr:get_ui("itemTip"):ui_show({
    item_id = Config.COIN_ITEMID,
    jump_cb = self.jump_callback
  })
  UIMgr:try_hide_ui("dia_exchange")
end

function M:_onclick_diamond()
  if UIMgr:try_get_visible_ui("dia_exchange") then
    return
  end
  local dia_exchange = UIMgr:get_ui("dia_exchange")
  local uiforcerecharg = UIMgr:try_get_visible_ui("uiforcerecharg")
  if uiforcerecharg then
    uiforcerecharg:ui_hide()
    dia_exchange:set_open_charg_on_hide(true)
  end
  dia_exchange:ui_show()
end

function M:_onclick_stamina()
  if UIMgr:try_get_visible_ui("uiforcerecharg") then
    return
  end
  UIMgr:get_ui("uiforcerecharg"):ui_show()
end

function M:_onclick_fate_book_tickets(item_config)
  local target_id = item_config.Id
  local exchange_cfg = ShareRes.create("item.item_exchange", 6)
  local item_id = exchange_cfg.Material[1]
  if UIMgr:try_get_visible_ui("fate_exchange") then
    return
  end
  local fate_exchange = UIMgr:get_ui("fate_exchange")
  fate_exchange:ui_show(target_id, nil, item_id)
end

function M:_on_click_item(item_config)
  UIMgr:get_ui("itemTip"):ui_show({
    item_id = item_config.Id,
    jump_cb = self.jump_callback
  })
  UIMgr:try_hide_ui("dia_exchange")
end

function M:_on_click_draw_item(item_config)
  UIMgr:get_ui("itemTip"):ui_show({
    item_id = item_config.Id
  })
end

function M:_onclick_gold()
  MsgGame:mq_publish2(Const.MSG_ON_JUMP_TO_RECHARGE)
  if not SysOpenMgr:get_sys_is_open(32, true) then
    return
  end
  if self.v_ui.ui_get_name and self.v_ui:ui_get_name() == "dia_exchange" then
    if not UIMgr:try_get_visible_ui("shop") then
      local recharge_shop = UIMgr:get_ui("recharge_shop")
      recharge_shop:set_open_exchange_on_hide(true, self.v_ui.v_open_charg_on_hide)
    end
    self.v_ui:set_open_charg_on_hide(nil)
    UIMgr:try_hide_ui("dia_exchange")
    UIMgr:try_hide_ui("ui_monthtask_buy_lv_tips")
    UIMgr:try_hide_ui("ui_chapter_detail_info")
  end
  SysOpenMgr:jump_to_sys(12106, false, true)
end

function M:_onclick_skin_item()
  Shop_Helper.show_short_gift_shop()
end

return M
