local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local AssetBarView = require("ui.asset_bar.asset_bar")
local SHOP_CARD_ITEM = "SHOP_CARD_ITEM"
local Card_Destory_Help = require("uimodule.stage_activity.challenge_ring_plus.curse_card_destory_helper")
local CURSE_OBJ_CLASS = require("uimodule.stage_activity.challenge_ring_plus.curse_obj")
local DROP_ABILITY_ITEM = require("uimodule.stage_activity.challenge_ring_plus.drop_ability_item")
local SHOP_CARD_ITEM_CLASS = require("uimodule.stage_activity.fate_book.fate_book_shop_card_item")
local FATE_BOOK_EFFECT_ORN = require("uimodule.stage_activity.fate_book.fate_book_effect_orn")
local ORN_VIEW_ITEM = require("uimodule.battle_bag.orn_view_item")
local curse_common_define = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local ADD_CURSE_TYPE = curse_common_define.ADD_CURSE_TYPE
local CURSE_NEW_SHOP_GOOD_TYPE = Config.CommonDefine.CURSE_NEW_SHOP_GOOD_TYPE
local CURSE_NEW_SHOP_GOOD_SELL_TYPE = Config.CommonDefine.CURSE_NEW_SHOP_GOOD_SELL_TYPE
local ASSET_BAR_CONFIG = {
  {
    item_id = Config.CURSE_GOLD,
    const_event = Const.MSG_ON_FIGHT_DIAMOND_UPDATE,
    is_fight_bag = true,
    not_show_max = true,
    bg_click = false
  }
}
local enough_color = Util.CommonColor_White
local not_enough_color = Util.CommonColor_RedWarm

function ui:on_click_slot_item_btn(slot_data)
  if self.v_select_slot_id == slot_data.id then
    return
  end
  self.v_select_slot_id = slot_data.id
  self.v_select_slot_data = slot_data
  self:refresh_select_slot_info()
  for _, item in pairs(self.v_slot_item_map) do
    local is_select = item:set_select(self.v_select_slot_id)
    if is_select and not slot_data.good_state then
      local Recommend = self.v_show_ability_item:get_uiobject("Recommend")
      if Recommend then
        Recommend:SetActive(false)
      end
    end
  end
end

function ui:on_click_refresh_btn()
  if not self:check_can_refresh() then
    return
  end
  
  local function suc_cb()
    if not self:visible() then
      return
    end
    self:refresh_shop_data()
    self:refresh_view()
    self:refresh_select_slot_info()
    ChallengeRingPlusMgr:record_before_fight_view_info()
  end
  
  ChallengeRingPlusMgr:request_curse_refresh_shop_good(self.v_card_index, suc_cb)
end

function ui:on_click_buy_btn()
  if not self.v_select_slot_id or not self.v_card_index then
    return
  end
  if not self:check_can_buy(true) then
    return
  end
  
  local function suc_cb()
    if not self:visible() then
      return
    end
    self:refresh_shop_data()
    self:refresh_view()
    self:refresh_select_slot_info()
  end
  
  ChallengeRingPlusMgr:request_curse_buy_shop_good(self.v_card_index, self.v_select_slot_id, suc_cb)
end

function ui:open_battle_bag()
  UIMgr:get_ui("battle_bag4"):ui_show()
end

function ui:ui_finish_load()
  self:set_button("BtnBuy", function()
    self:on_click_buy_btn()
  end)
  self:set_button("BtnBuyCurse", function()
    self:on_click_buy_btn()
  end)
  self:set_button("BtnBuyHp", function()
    self:on_click_buy_btn()
  end)
  self:set_button("BtnRefresh", function()
    self:on_click_refresh_btn()
  end)
  self:set_button("BtnRet1", function()
    Card_Destory_Help.confirm_quit_ui(self, "是否退出，不可返回")
  end)
  self:set_button("Button_rune", function()
    self:open_battle_bag()
  end)
  self.v_slot_item_map = {}
  self.v_curse_view = CURSE_OBJ_CLASS:ui_wrap(self, self.v_uiobjects.CurseObj, false)
  self:register_exist_auto_template(SHOP_CARD_ITEM, self.v_uiobjects.SlotTem, self.v_uiobjects.SlotList)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, ASSET_BAR_CONFIG)
  self.v_show_ability_item = DROP_ABILITY_ITEM:ui_wrap(self, self.v_uiobjects.TalentInfo, false)
  self.v_show_orn_item = ORN_VIEW_ITEM:ui_wrap(self, self.v_uiobjects.OrnInfo, false)
end

function ui:on_ornament_change()
  self:refresh_view()
  self:refresh_select_slot_info()
end

function ui:on_update_card_data()
  self:refresh_shop_data()
end

function ui:ui_on_show(index, shop_data)
  self:bind_auto_mq(Const.MSG_ON_ORNAMENT_CHANGE, self.on_ornament_change, self)
  self:bind_auto_mq(Const.MSG_ON_PAYMENT_BUFF_CAHNGE, self.on_ornament_change, self)
  self:bind_auto_mq(Const.MSG_ON_BUFF_REMOVE, self.on_ornament_change, self)
  self:bind_auto_mq(Const.MSG_ON_UPDATE_CARD_DATA, self.on_update_card_data, self)
  self.v_curse_view:set_enable(true)
  self.v_curse_view:ui_show()
  self.v_asset_bar:on_create()
  self.v_card_index = index
  self:refresh_shop_data(shop_data)
  if not self.v_shop_cfg then
    Log.Error("获取商店配置失败，商店ID：", self.v_shop_id, debug.traceback())
    return
  end
  self:refresh_view(true)
  self:refresh_effect_orn()
end

function ui:ui_on_hide()
  if self.v_effect_orn then
    self.v_effect_orn:ui_destroy()
    self.v_effect_orn = nil
  end
  self.v_select_slot_data = nil
  self.v_select_slot_id = nil
  self:clear_slot_item()
  self.v_asset_bar:on_hide()
  if self.v_curse_view then
    self.v_curse_view:ui_hide()
  end
  if self.v_show_ability_item then
    self.v_show_ability_item:ui_hide()
  end
  if self.v_show_orn_item then
    self.v_show_orn_item:ui_hide()
  end
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
  if self.v_curse_view then
    self.v_curse_view:ui_destroy()
    self.v_curse_view = nil
  end
  if self.v_show_ability_item then
    self.v_show_ability_item:ui_destroy()
    self.v_show_ability_item = nil
  end
  if self.v_show_orn_item then
    self.v_show_orn_item:ui_destroy()
    self.v_show_orn_item = nil
  end
end

function ui:refresh_effect_orn()
  local card_cfg = ChallengeRingPlusMgr:get_cur_card_cfg_info()
  local type_cfg = ShareRes.get_ring_card_type_cfg(card_cfg.Type)
  if not UtilTable.is_empty(type_cfg.EffectOrnament) then
    if not self.v_effect_orn then
      self.v_effect_orn = FATE_BOOK_EFFECT_ORN:ui_wrap_ex(self, self.v_uiobjects.EffectOrn, true)
    end
    self.v_effect_orn:set_data(type_cfg.EffectOrnament)
    self.v_uiobjects.EffectOrn:SetActive(true)
  else
    self.v_uiobjects.EffectOrn:SetActive(false)
  end
end

function ui:refresh_shop_data(shop_data)
  shop_data = shop_data or ChallengeRingPlusMgr:get_shop_data()
  self.v_shop_data = shop_data
  self.v_shop_id = shop_data.shop_id
  self.v_slot_data = self.v_shop_data.slot_data
  self.v_shop_cfg = ShareRes.get_curse_shop_cfg(self.v_shop_id)
  if self.v_select_slot_id then
    for key, data in pairs(self.v_slot_data) do
      if data.id == self.v_select_slot_id then
        self.v_select_slot_data = data
        break
      end
    end
  end
end

function ui:refresh_view(is_first)
  self:refresh_count()
  self:refresh_button()
  self:refresh_slot(is_first)
end

function ui:refresh_slot(is_first)
  self:clear_slot_item()
  local item, obj, first_item
  for index, data in ipairs(self.v_slot_data) do
    obj = self:get_auto_cache(SHOP_CARD_ITEM)
    item = SHOP_CARD_ITEM_CLASS:ui_wrap(self, obj, true)
    item:set_data(data)
    self.v_slot_item_map[index] = item
    if not first_item and data.state and Util.is_more_than_zero(data.good_id) then
      first_item = item
    end
  end
  if is_first then
    first_item:on_click_btn()
  end
end

function ui:refresh_button()
  if self.v_cur_count <= 0 then
    self.v_uiobjects.BtnRefresh:SetActive(false)
  else
    self.v_uiobjects.BtnRefresh:SetActive(true)
    if self.v_pay_refresh then
      self.v_uiobjects.RefreshCost:SetActive(true)
    elseif self.remain_free > 0 then
      self.v_uiobjects.RefreshCost:SetActive(false)
    else
      local cost = ChallengeRingPlusMgr:get_after_discount_price(self.v_shop_cfg.RefreshCost)
      self.v_uiobjects.RefreshCost:SetActive(Util.is_more_than_zero(cost))
      self.v_uicompents.FreshGoldNeed_txt.text = cost
      local is_enough = Util.check_item_cost_enough(self.v_shop_cfg.RefreshItem, cost)
      self.v_uicompents.FreshGoldNeed_txt.color = is_enough and enough_color or not_enough_color
    end
  end
end

function ui:refresh_count()
  local max_count = self.v_shop_cfg.RefreshCnt
  local free_refresh_count, pay_refresh_count = 0, 0
  local buff57_map = BuffMgr:get_buff_type_map(Config.CommonDefine.BUFF_TYPE.ADD_CURSE_SHOP_RESET_COUNT)
  if buff57_map then
    for key, buff in pairs(buff57_map) do
      local refresh_count = buff.buff_cfg.Arg[1]
      if Util.is_more_than_zero(refresh_count) then
        if 1 == buff.buff_cfg.Arg[2] then
          free_refresh_count = free_refresh_count + refresh_count
        else
          pay_refresh_count = pay_refresh_count + refresh_count
        end
      end
    end
  end
  self.remain_free = free_refresh_count - (self.v_shop_data.free_refresh_cnt or 0)
  local remain_pay = pay_refresh_count - (self.v_shop_data.add_refresh_cnt or 0)
  local remain = self.v_shop_cfg.RefreshCnt - self.v_shop_data.refresh_cnt
  self.v_cur_count = remain + self.remain_free + remain_pay
  self.v_pay_refresh = self.remain_free < 0
  self.v_uicompents.LimitMax_txt.text = max_count + free_refresh_count + pay_refresh_count
  self.v_uicompents.LimitNow_txt.text = self.v_cur_count
end

function ui:refresh_select_slot_info()
  local curse_cost, item_cost, cfg
  local good_id = self.v_select_slot_data.good_id
  if self.v_select_slot_data.good_type == CURSE_NEW_SHOP_GOOD_TYPE.ABILITY then
    self.v_show_ability_item:set_enable(true)
    self.v_show_orn_item:set_enable(false)
    self.v_show_ability_item:set_data(good_id, nil, true, true, 1)
    cfg = ShareRes.get_ability_cfg(good_id)
  elseif self.v_select_slot_data.good_type == CURSE_NEW_SHOP_GOOD_TYPE.ORNAMENTS then
    self.v_show_ability_item:set_enable(false)
    self.v_show_orn_item:set_enable(true)
    self.v_show_orn_item:set_data(good_id, true)
    cfg = ShareRes.get_ornaments(good_id)
  end
  curse_cost = ChallengeRingPlusMgr:get_after_discount_curse_price(cfg.CurseCostCnt)
  item_cost = ChallengeRingPlusMgr:get_after_discount_price(cfg.BuyCostCnt)
  local can_buy = self.v_select_slot_data.good_state
  local sell_type = self.v_select_slot_data.sell_type
  self.v_uiobjects.Purchased:SetActive(not can_buy)
  local have_pay_hp = BuffMgr:have_pay_hp_replace_curse_buff()
  if not can_buy then
    self.v_uiobjects.BtnBuy:SetActive(false)
    self.v_uiobjects.BtnBuyCurse:SetActive(false)
    self.v_uiobjects.BtnBuyHp:SetActive(false)
  elseif sell_type == CURSE_NEW_SHOP_GOOD_SELL_TYPE.ITEM then
    self.v_uiobjects.BtnBuy:SetActive(true)
    self.v_uiobjects.BtnBuyCurse:SetActive(false)
    self.v_uiobjects.BtnBuyHp:SetActive(false)
    self.v_uicompents.BuyGoldNeed_txt.text = item_cost
    local is_enough = Util.check_item_cost_enough(cfg.BuyCostId, item_cost)
    self.v_uicompents.BuyGoldNeed_txt.color = is_enough and enough_color or not_enough_color
  elseif sell_type == CURSE_NEW_SHOP_GOOD_SELL_TYPE.CURSE_VALUE then
    self.v_uiobjects.BtnBuy:SetActive(false)
    self.v_uiobjects.BtnBuyCurse:SetActive(not have_pay_hp)
    self.v_uiobjects.BtnBuyHp:SetActive(have_pay_hp)
    if have_pay_hp then
      local hp_value = ChallengeRingPlusMgr:get_consume_hp_value(curse_cost)
      self.v_uicompents.BuyHpNeed_txt.text = -hp_value / 100 .. "%"
    else
      self.v_uicompents.BuyCurseNeed_txt.text = curse_cost
    end
  end
end

function ui:check_can_buy(click_buy)
  local cfg
  local good_id = self.v_select_slot_data.good_id
  if self.v_select_slot_data.good_type == CURSE_NEW_SHOP_GOOD_TYPE.ABILITY then
    cfg = ShareRes.get_ability_cfg(good_id)
  elseif self.v_select_slot_data.good_type == CURSE_NEW_SHOP_GOOD_TYPE.ORNAMENTS then
    cfg = ShareRes.get_ornaments(good_id)
  end
  local sell_type = self.v_select_slot_data.sell_type
  if sell_type == CURSE_NEW_SHOP_GOOD_SELL_TYPE.ITEM then
    if not cfg then
      return false
    end
    local item_cost = ChallengeRingPlusMgr:get_after_discount_price(cfg.BuyCostCnt)
    local item_id = cfg.BuyCostId
    if Util.is_more_than_zero(item_cost) and Util.is_more_than_zero(item_id) and not Util.check_item_cost_enough(item_id, item_cost) then
      local name = UtilUI.get_item_name(item_id)
      Util.show_message_tip(2314, name)
      return false
    end
  elseif click_buy and sell_type == CURSE_NEW_SHOP_GOOD_SELL_TYPE.CURSE_VALUE then
    local need_curse = cfg.CurseCostCnt or 0
    ChallengeRingPlusMgr:record_fight_add_curse_value(ADD_CURSE_TYPE.SHOP_BUY, need_curse)
  end
  return true
end

function ui:check_can_refresh()
  local refresh_cost = ChallengeRingPlusMgr:get_after_discount_price(self.v_shop_cfg.RefreshCost)
  local refresh_item = self.v_shop_cfg.RefreshItem
  self:refresh_count()
  if self.v_pay_refresh and Util.is_more_than_zero(refresh_cost) and Util.is_more_than_zero(refresh_item) and not Util.check_item_cost_enough(refresh_item, refresh_cost) then
    local name = UtilUI.get_item_name(refresh_item)
    Util.show_message_tip(2314, name)
    return false
  end
  return true
end

function ui:clear_slot_item()
  self:give_back_auto_cache(SHOP_CARD_ITEM)
  for key, item in pairs(self.v_slot_item_map) do
    item:ui_hide()
    item:ui_destroy()
    self.v_slot_item_map[key] = nil
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_card_index
end

return ui
