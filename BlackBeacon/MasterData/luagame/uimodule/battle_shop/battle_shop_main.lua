local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Battle_Shop_Cfg = require("uimodule.battle_shop.battle_shop_cfg")
local ToggleTabClass = require("ui.widget.widget_toggle_tab")
local LoopListClass = require("ui.widget.infinite_loop_list")
local ShopItemClass = require("uimodule.battle_shop.local_widget.shop_item")
local CurrentyClass = require("uimodule.battle_shop.local_widget.shop_item_currency_view")
local SimpleListClass = require("uimodule.battle_shop.local_widget.simple_sv_list")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local _tinsert = table.insert
local util_get_color = Util.get_unity_color_by_hex
local refresh_normal_color = util_get_color(tonumber("FFFFFF", 16))
local refresh_limit_color = util_get_color(tonumber("9FA3A8", 16))
local Buy_can_btn_img_path = "UICommon2/Btn/Common_mbtn_confirm"
local Buy_not_can_btn_img_path = "UICommon2/Btn/Common_mbtn_white"
local Buy_can_color = util_get_color(tonumber("FFFFFF", 16))
local Buy_not_can_color = util_get_color(tonumber("9A9A9A", 16))
local item_choose_color = util_get_color(tonumber("FFFFFF", 16))
local item_not_choose_color = util_get_color(tonumber("BEBEBE", 16))
local Item_Helper = require("utils.item_helper")
local MODEL = {
  v_buy_toggle = {
    "Buy",
    BIND_TYPE.TOGGLE
  },
  v_sell_toggle = {
    "Sell",
    BIND_TYPE.TOGGLE
  },
  v_equip_toggle = {
    "Equip",
    BIND_TYPE.TOGGLE
  },
  v_item_toggle = {
    "Item",
    BIND_TYPE.TOGGLE
  },
  v_Item_context_obj = {
    "Item_context",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("Refresh", function()
    self:refresh_shop()
  end)
  self:set_button("On_btn", function()
    self:click_action_button()
  end)
  self:init_toggle_list()
  self.v_shop_item_loop_list = LoopListClass:new(self, self.v_uiobjects.Shop_item_list, ShopItemClass)
  self:register_exist_auto_template(Battle_Shop_Cfg.BATTLE_SHOP_ELETEM_KEY, self.v_uiobjects.EleTem, self.v_uiobjects.Elecontent)
  self.v_currenct_view = SimpleListClass:new(self, self.v_uiobjects.CurrList, CurrentyClass, 1, "FIGHT_SHOP_CURRENCY")
end

function ui:ui_on_show()
  self.v_sell_item = {}
  self.v_shop_mode_select_toggle_idx = Battle_Shop_Cfg.SHOP_TOGGLE.BUY
  self.v_item_type_toggle_idx = Battle_Shop_Cfg.ITEM_TYPE_TOGGLE.EQUIP
  self.v_battle_shop_item_list = {}
  self.v_shop_id = BattleShopMgr:get_battle_shop_id()
  self.v_battle_shop_item_list = BattleShopMgr:get_battle_shop_item_list()
  self.v_fresh_time = BattleShopMgr:get_refresh_cnt()
  self:_regist_client_event()
  self:init_toggle_tab()
  self:init_view()
end

function ui:ui_on_hide()
  self.v_shop_item_loop_list:ui_on_hide()
  self.v_select_item_idx = nil
  self.v_shop_mode_select_toggle_idx = nil
  self.v_item_type_toggle_idx = nil
  self.v_shop_id = nil
  self.v_fresh_time = nil
  self.v_select_item_tog = nil
end

function ui:ui_on_destroy()
  self.v_shop_item_loop_list:ui_on_destroy()
  self.v_shop_item_loop_list = nil
  self.v_sell_item = nil
  self.v_battle_shop_item_list = nil
  self.v_shop_mode_toggle_tab = nil
  self.v_item_type_toggle_tab = nil
  self.v_currenct_view = nil
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_CLICK_ITEM_TIPS, self.response_click_item_event, self)
  self:bind_auto_mq(Const.MSG_ON_SHOP_ITEM_SELL, self.sell_multiple_item, self)
  self:bind_auto_mq(Const.MSG_ON_FIGHT_DIAMOND_UPDATE, self.response_currency_update_event, self)
end

function ui:init_toggle_list()
  self.v_shop_tag_toggles = {
    self.v_buy_toggle,
    self.v_sell_toggle
  }
  self.v_item_type_tag_toggles = {
    self.v_equip_toggle,
    self.v_item_toggle
  }
  self.v_shop_mode_toggle_tab = ToggleTabClass:new(self)
  self.v_shop_mode_toggle_tab:init_by_toggles(self.v_shop_tag_toggles, function(cur_select, pre_select, cur_toggle, pre_toggle)
    self:select_shop_type_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  end, Battle_Shop_Cfg.SHOP_TOGGLE.BUY)
  self.v_shop_mode_toggle_tab:set_color("000000", "BEBEBE")
  self.v_item_type_toggle_tab = ToggleTabClass:new(self)
  self.v_item_type_toggle_tab:init_by_toggles(self.v_item_type_tag_toggles, function(cur_select, pre_select, cur_toggle, pre_toggle)
    self:select_item_type_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  end, Battle_Shop_Cfg.ITEM_TYPE_TOGGLE.EQUIP)
end

function ui:init_view()
  self.v_select_item_idx = 1
  self:refresh_view()
  self.v_shop_item_loop_list:select_item(self.v_select_item_idx)
end

function ui:sell_multiple_item(msg)
  if nil == msg then
    return
  end
  local item_uuid = msg.mm_x
  if FightBagMgr:get_had_item_by_uuid(item_uuid) then
    self:refresh_view()
    self.v_shop_item_loop_list:select_item(self.v_select_item_idx)
  else
    self:init_view()
  end
end

function ui:refresh_view()
  local discount_cnt = BattleShopMgr:get_first_discount_cnt() or 0
  local uobj = self.v_uiobjects
  self:response_currency_update_event()
  self:refresh_refresh_shop_cnt()
  local Item_type_list_obj = uobj.Item_type_list
  local Refresh = uobj.Refresh
  local UseMode = uobj.UseMode
  local On_btn = uobj.On_btn
  local Rest_num_obj = uobj.Rest_item_num
  local discount_obj = uobj.DiscountBg
  discount_obj:SetActive(false)
  if self.v_shop_mode_select_toggle_idx == Battle_Shop_Cfg.SHOP_TOGGLE.BUY then
    Item_type_list_obj:SetActive(false)
    Refresh:SetActive(true)
    UseMode:SetActive(true)
    Rest_num_obj:SetActive(true)
    ResMgr:load_set_icon(Util.get_image(nil, On_btn), "UICommon2/Btn/Common_mbtn_confirm")
    Util.get_text("Text", On_btn).text = Util.format_str("购买")
    if discount_cnt > 0 then
      discount_obj:SetActive(true)
    end
    self:refresh_shop_buy_item()
  elseif self.v_shop_mode_select_toggle_idx == Battle_Shop_Cfg.SHOP_TOGGLE.SELL then
    Item_type_list_obj:SetActive(true)
    Refresh:SetActive(false)
    UseMode:SetActive(false)
    Rest_num_obj:SetActive(false)
    ResMgr:load_set_icon(Util.get_image(nil, On_btn), "UICommon2/Btn/Common_mbtn_orange")
    Util.get_text("Text", On_btn).text = Util.format_str("出售")
    self:refresh_shop_sell_item()
  end
end

function ui:refresh_refresh_shop_cnt()
  local refresh_cost_cfg = ShareRes.create(Battle_Shop_Cfg.BATTLE_SHOP_REFRESH)
  local shop_cfg = ShareRes.create("battle.battle_shop")
  local shop_refresh_id = shop_cfg[self.v_shop_id].RefreshId
  local time = self.v_fresh_time
  time = time + 1
  local max_time = 0
  local cost_cfg = refresh_cost_cfg[shop_refresh_id]
  local refresh_img = self.v_uicompents.Refresh_img
  if time > cost_cfg.MaxCount then
    refresh_img.color = refresh_limit_color
  else
    refresh_img.color = refresh_normal_color
  end
  if cost_cfg.ItemCount ~= nil then
    max_time = #cost_cfg.ItemCount
  end
  if time > max_time then
    time = max_time
  end
  Util.get_text("UseNumTxt", refresh_img.gameObject).text = cost_cfg.ItemCount[time]
end

function ui:init_toggle_tab()
  self.v_item_type_toggle_tab:set_toggle_by_index(self.v_item_type_toggle_idx)
  self.v_shop_mode_toggle_tab:set_toggle_by_index(self.v_shop_mode_select_toggle_idx)
end

function ui:refresh_shop_buy_item()
  local battle_equip_cfg = ShareRes.create(Battle_Shop_Cfg.BATTLE_EQUIP_CFG_PATH)
  local battle_item_cfg = ShareRes.create(Battle_Shop_Cfg.BATTLE_ITEM_CFG_PATH)
  local bag_list = {}
  for index, item in pairs(self.v_battle_shop_item_list) do
    local shop_item_cfg
    local item_id = item.item_id
    if FightBagMgr:get_is_item_by_id(item_id) then
      shop_item_cfg = battle_item_cfg[item_id]
    elseif FightBagMgr:get_is_collect_by_id(item_id) then
      shop_item_cfg = battle_equip_cfg[item_id]
    end
    local temp = {
      item_cfg = shop_item_cfg,
      item_data = {
        id = item_id,
        count = item.item_count
      },
      index = index,
      buy = item.buy
    }
    _tinsert(bag_list, temp)
  end
  self.v_uicompents.Rest_num_txt.text = BattleShopMgr:get_battle_shop_item_list_length()
  self.v_shop_item_loop_list:refresh_data(bag_list)
end

function ui:response_currency_update_event()
  local tb = BagCfg.SHOW_CURRENCY
  self.v_currenct_view:update_list(tb)
end

function ui:response_shop_update()
  self.v_shop_id = BattleShopMgr:get_battle_shop_id()
  self.v_battle_shop_item_list = BattleShopMgr:get_battle_shop_item_list()
  self.v_fresh_time = BattleShopMgr:get_refresh_cnt()
  self:refresh_view()
end

function ui:refresh_item_context(item_data)
  local battle_equip_cfg = ShareRes.create("battle.battle_collection")
  local battle_equip_fixed_entry_cfg = ShareRes.create("entry.battle_fixed_entry")
  local battle_item_type_cfg = ShareRes.create("battle.battle_item_type")
  local is_buy = item_data.buy
  local btn_color, icon_path
  if is_buy then
    btn_color = Buy_not_can_color
    icon_path = Buy_not_can_btn_img_path
    self.v_uicompents.On_btn_btn.interactable = false
  else
    btn_color = Buy_can_color
    icon_path = Buy_can_btn_img_path
    self.v_uicompents.On_btn_btn.interactable = true
  end
  self.v_uicompents.On_btn_img.color = btn_color
  ResMgr:load_set_icon(self.v_uicompents.On_btn_img, icon_path)
  self.v_Item_context_obj:SetActive(true)
  if self.v_shop_mode_select_toggle_idx == Battle_Shop_Cfg.SHOP_TOGGLE.SELL then
    self.v_sell_item = item_data
  end
  self.v_select_item_idx = item_data.index
  local item_cfg = item_data.item_cfg
  local item_id = item_data.item_data.id
  local type_name
  local item_info_obj = self.v_uiobjects.ItemInfo
  local equip_info_obj = self.v_uiobjects.EquipInfo
  if FightBagMgr:get_is_item_by_id(item_id) then
    item_info_obj:SetActive(true)
    equip_info_obj:SetActive(false)
    type_name = battle_item_type_cfg[item_cfg.Type].name
    self.v_uicompents.Effect_content_txt.text = Util.format_str(item_cfg.Desc or "")
    self.v_uicompents.World_view_txt_text = Util.format_str(item_cfg.WorldDesc or "")
  elseif FightBagMgr:get_is_collect_by_id(item_id) then
    equip_info_obj:SetActive(true)
    item_info_obj:SetActive(false)
    self:give_back_auto_cache(Battle_Shop_Cfg.BATTLE_SHOP_ELETEM_KEY)
    local fixed_entry = battle_equip_cfg[item_id].FixedEntry
    local RandomGroupId_entry = battle_equip_cfg[item_id].RandomGroupId_entry
    if nil ~= fixed_entry then
      for _, fixed_id in pairs(fixed_entry) do
        local fixed_data = battle_equip_fixed_entry_cfg[fixed_id]
        for _, attr_data in pairs(fixed_data.Attr) do
          local attr_idx = attr_data.Attr
          local item_obj = self:get_auto_cache(Battle_Shop_Cfg.BATTLE_SHOP_ELETEM_KEY)
          local name, value = UtilUI.get_equip_attr_str(attr_idx, attr_data.Type, attr_data.Num)
          Util.get_text("Ele_name", item_obj).text = name
          local color = tonumber("ff8e23", 16)
          Util.get_text("Ele_num", item_obj).text = "+" .. value
          Util.get_image("Line", item_obj).color = Util.get_unity_color_by_hex(color)
        end
      end
    end
    if nil ~= RandomGroupId_entry then
      for _, RandomGroupId in pairs(RandomGroupId_entry) do
        for _, attr_data in pairs(RandomGroupId.Attr) do
          local attr_idx = attr_data.Attr
          local item_obj = self:get_auto_cache(Battle_Shop_Cfg.BATTLE_SHOP_ELETEM_KEY)
          local name, value = UtilUI.get_equip_attr_str(attr_idx, attr_data.Type, attr_data.Num)
          Util.get_text("Ele_name", item_obj).text = name
          local color = tonumber("ffffff", 16)
          Util.get_text("Ele_num", item_obj).text = "+" .. value
          Util.get_image("Line", item_obj).color = Util.get_unity_color_by_hex(color)
        end
      end
    end
    local Type = item_cfg.Type
    local Arg = item_cfg.Arg
    if Type == BagCfg.CollectType.COMMON then
      self.v_uiobjects.Effect_Obj:SetActive(true)
      self.v_uiobjects.suit_obj:SetActive(false)
      local normal_desc = Arg[2]
      if not normal_desc then
        self.v_uicompents.Equip_Effect_Text_txt.text = Util.format_str("效果（受职业等级影响）")
        normal_desc = self:_set_job_attr_detail(item_cfg.CareerDesc)
      else
        self.v_uicompents.Equip_Effect_Text_txt.text = Util.format_str("效果")
      end
      self.v_uicompents.Equip_effect_content_txt.text = Util.format_str(normal_desc)
    elseif Type == BagCfg.CollectType.SUIT then
      local suit_id = Arg[1]
      self.v_uiobjects.Effect_Obj:SetActive(false)
      self.v_uiobjects.suit_obj:SetActive(true)
      local suit_cfg = ShareRes.create("battle.battle_collection_suit", suit_id)
      local tb = {
        [2] = {
          name = "two_suit_desc_txt",
          suit_field = "TwoPieceContext",
          job_field = "TwoPieceCareerDesc"
        },
        [4] = {
          name = "four_suit_desc_txt",
          title_name = "Equip_Effect_Text_txt",
          suit_field = "FourPieceContext",
          job_field = "FourPieceCareerDesc"
        }
      }
      for _, v in pairs(tb) do
        if self.v_uicompents[v.title_name] then
          self.v_uicompents[v.title_name].text = Util.format_str("套装效果")
        end
        local desc = ""
        if suit_cfg[v.suit_field] then
          desc = suit_cfg[v.suit_field]
        end
        if suit_cfg[v.job_field] then
          if "" == desc then
            desc = self:_set_job_attr_detail(suit_cfg[v.job_field])
          else
            desc = string.format([[
%s
%s]], desc, self:_set_job_attr_detail(suit_cfg[v.job_field]))
          end
        end
        self.v_uicompents[v.name].text = desc
      end
    end
  end
  self.v_uicompents.Current_num_txt.text = FightBagMgr:get_item_num_by_id(item_cfg.Id)
  self.v_uicompents.Item_name_txt.text = Util.format_str(item_cfg.Name or "")
  self.v_uicompents.Item_type_txt.text = Util.format_str(type_name or "")
end

function ui:_set_job_attr_detail(job_attr_id)
  local desc = ""
  local cfg = ShareRes.create("battle.battle_collection_job_entry", job_attr_id)
  for _, v in ipairs(cfg) do
    local attr_str = ""
    local engough = true
    for i = 1, 2 do
      if v.AttrId[i] then
        engough = engough and Item_Helper.get_job_attr_enough(v.AttrId[i], v.Level[i])
        attr_str = string.format("%s%sLv.%d", attr_str, ShareRes.equip_attr_str(v.AttrId[i]), v.Level[i])
      else
        attr_str = string.format("%s     ", attr_str)
      end
    end
    local color_str = engough and "<color=#349ee3>" or "<color=#838383>"
    if "" == desc then
      desc = string.format("%s%s%s%s</color>", desc, color_str, attr_str, v.Desc)
    else
      desc = string.format([[
%s
%s%s%s</color>]], desc, color_str, attr_str, v.Desc)
    end
  end
  return desc
end

function ui:is_have_sell_item(item_type)
  local check_bag = {}
  if item_type == Battle_Shop_Cfg.ITEM_TYPE_TOGGLE.ITEM then
    check_bag = FightBagMgr:get_bag(Config.BAG_TYPE.FIGHT_ITEM, true)
  elseif item_type == Battle_Shop_Cfg.ITEM_TYPE_TOGGLE.EQUIP then
    check_bag = FightBagMgr:get_bag(Config.BAG_TYPE.FIGHT_WEAPON, true)
  end
  if next(check_bag) ~= nil then
    return true
  end
  return false
end

function ui:is_have_sell_page()
  for idx, _ in pairs(Battle_Shop_Cfg.ITEM_TYPE_IDX) do
    if self:is_have_sell_item(idx) then
      self.v_item_type_toggle_idx = idx
      self.v_item_type_toggle_tab:set_toggle_by_index(idx)
      return true
    end
  end
  return false
end

function ui:refresh_shop_sell_item()
  local bag_list = {}
  local item_type_cfg = ShareRes.create("battle.battle_item_type")
  if self.v_item_type_toggle_idx == Battle_Shop_Cfg.ITEM_TYPE_TOGGLE.ITEM then
    for _, item in pairs(FightBagMgr:get_bag(Config.BAG_TYPE.FIGHT_ITEM, true)) do
      local cfg = item.Cfg
      local item_type = item_type_cfg[cfg.Type]
      if not item_type or 0 == item_type.IsNoSell then
        local temp = {
          item_cfg = cfg,
          item_data = {
            id = item.id,
            count = item.count,
            uuid = item.uuid
          }
        }
        _tinsert(bag_list, temp)
      end
    end
  elseif self.v_item_type_toggle_idx == Battle_Shop_Cfg.ITEM_TYPE_TOGGLE.EQUIP then
    local battle_equip_cfg = ShareRes.create(Battle_Shop_Cfg.BATTLE_EQUIP_CFG_PATH)
    for _, equip in pairs(FightBagMgr:get_bag(Config.BAG_TYPE.FIGHT_WEAPON, true)) do
      local cfg = battle_equip_cfg[equip.id]
      local item_type = item_type_cfg[cfg.Type]
      if not item_type or 0 == item_type.IsNoSell then
        local temp = {
          item_cfg = cfg,
          item_data = {
            id = equip.id,
            count = equip.count,
            uuid = equip.uuid
          }
        }
        _tinsert(bag_list, temp)
      end
    end
  end
  local rest_num
  if next(bag_list) ~= nil then
    rest_num = #bag_list
  else
    if not self:is_have_sell_page() then
      self.v_shop_mode_toggle_tab:set_toggle_by_index(Battle_Shop_Cfg.SHOP_TOGGLE.BUY)
    end
    return
  end
  self.v_uicompents.Rest_num_txt.text = rest_num
  table.sort(bag_list, function(a, b)
    local a_master = -1 == a.item_data.master
    local b_master = -1 == b.item_data.master
    if a_master == b_master then
      local a_quality = a.item_cfg.Quality
      local b_quality = b.item_cfg.Quality
      if a_quality == b_quality then
        return a.item_cfg.ShowPriority > b.item_cfg.ShowPriority
      else
        return a_quality > b_quality
      end
    else
      return not a_master
    end
  end)
  for idx, data in pairs(bag_list) do
    data.index = idx
  end
  self.v_shop_item_loop_list:refresh_data(bag_list)
end

function ui:select_shop_type_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  if cur_select == Battle_Shop_Cfg.SHOP_TOGGLE.SELL and not self:is_have_sell_page() then
    Util.show_message_tip(2128)
    if pre_select then
      self.v_shop_mode_toggle_tab:set_toggle_by_index(pre_select)
    end
    return
  end
  self.v_shop_mode_select_toggle_idx = cur_select
  self:init_view()
end

function ui:select_item_type_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  if not self:is_have_sell_item(cur_select) then
    Util.show_message_tip(2129)
    if pre_select then
      self.v_item_type_toggle_tab:set_toggle_by_index(pre_select)
    end
    return
  end
  self.v_item_type_toggle_idx = cur_select
  for idx, data in pairs(Battle_Shop_Cfg.ITEM_TYPE_CFG) do
    local obj_name = data.obj_name
    local choose_obj = self.v_uiobjects[obj_name]
    local label_txt = Util.get_text("Label", choose_obj)
    if idx == cur_select then
      label_txt.color = item_choose_color
    else
      label_txt.color = item_not_choose_color
    end
  end
  self:init_view()
end

function ui:response_click_item_event(msg)
  if nil == msg or nil == msg.mm_obj or nil == next(msg.mm_obj) then
    return
  end
  self:refresh_item_context(msg.mm_obj)
end

function ui:refresh_shop()
  local is_reach_limit = BattleShopMgr:is_reach_refresh_limit()
  if is_reach_limit then
    Util.show_message_tip(2130)
  end
  BattleShopMgr:refresh_battle_shop(function()
    self:response_shop_update()
  end)
end

function ui:click_action_button()
  local sell_item = self.v_sell_item
  if self.v_shop_mode_select_toggle_idx == Battle_Shop_Cfg.SHOP_TOGGLE.BUY then
    if -1 ~= self.v_select_item_idx then
      BattleShopMgr:buy_battle_shop_item(self.v_select_item_idx, function()
        self:refresh_view()
        self.v_shop_item_loop_list:select_item(self.v_select_item_idx)
      end)
    else
      Util.show_message_tip(2131)
    end
  elseif self.v_shop_mode_select_toggle_idx == Battle_Shop_Cfg.SHOP_TOGGLE.SELL then
    if next(sell_item) ~= nil then
      UIMgr:get_ui("uiitem_sell_select"):ui_show(sell_item)
    else
      Util.show_message_tip(2132)
    end
  end
end

return ui
