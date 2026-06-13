local _clamp = require("base.mathx").Clamp
local Item_Helper = require("utils.item_helper")
local ShopCfg = require("uimodule.shop.shop_config")
local QUALITY_ICON_PATH = "UICommon/%s"
local ITEM_ICON_PATH = "Icon/Item/%s"
local helper = {}
helper.SHOP_TYPE = {COOMMON_SHOP = 101, BREAK_SHOP = 102}
helper.ex_shop_cfg = ShareRes.create("shop.exchange_shop")
helper.ex_goods_cfg = ShareRes.create("shop.exchange_goods")
helper.item_cfg = ShareRes.create("item.item")
helper.battle_item_cfg = ShareRes.create("battle.battle_item")

function helper.get_num_formate(num)
  if num > 0 then
    if num >= 100000 then
      if 0 == num % 10000 then
        return string.format("%sw", math.modf(num / 10000))
      else
        return string.format("%.1fw", num / 10000)
      end
    else
      return num
    end
  else
    return 0
  end
end

function helper.get_quality(quality)
  return _clamp(quality - 2, 1, 3)
end

function helper.get_item_quality_icon(quality)
  local icon_path = ShareRes.create("item.item_quality", quality).QualityIcon
  return string.format(QUALITY_ICON_PATH, icon_path)
end

function helper.get_item_icon(item_id)
  return UtilUI.get_item_icon(item_id)
end

function helper.get_break_item_discount(cur_num, dis_str)
  local discount_list = helper._convert_discount(dis_str)
  for i = #discount_list, 1, -1 do
    if cur_num > discount_list[i].endVal then
      return nil == discount_list[i + 1] and 100 or discount_list[i + 1].discount
    end
  end
  return discount_list[1].discount
end

function helper._convert_discount(str)
  local ret = {}
  for k, v in string.gmatch(str, "(%d+)#(%d+)") do
    assert(k, str)
    assert(v)
    table.insert(ret, {
      endVal = tonumber(k),
      discount = tonumber(v)
    })
  end
  table.sort(ret, function(a, b)
    return a.endVal < b.endVal
  end)
  return ret
end

function helper.get_asset_list(list)
  local rect = {}
  for _, item_id in pairs(list) do
    if 0 ~= item_id then
      local cfg = helper.item_cfg[item_id]
      local is_battle
      if cfg then
        is_battle = false
      else
        cfg = helper.battle_item_cfg[item_id]
        is_battle = true
      end
      local tb = {}
      local func_name, event_id = helper._get_currency_param(item_id)
      tb.name = cfg.Name
      tb.item_id = item_id
      tb.const_event = event_id
      if is_battle then
        tb.is_fight_bag = true
        tb.not_show_max = true
        tb.bg_click = false
      else
        tb.func = func_name
      end
      table.insert(rect, tb)
    end
  end
  return rect
end

function helper.get_asset_list_by_info_list(info_list)
  local rect = {}
  for _, info in pairs(info_list) do
    local item_id = info.item_id
    if 0 ~= item_id then
      local cfg = helper.item_cfg[item_id]
      local is_battle
      if cfg then
        is_battle = false
      else
        cfg = helper.battle_item_cfg[item_id]
        is_battle = true
      end
      local tb = {}
      local func_name, event_id = helper._get_currency_param(item_id)
      tb.name = cfg.Name
      tb.item_id = item_id
      tb.const_event = info.event_id or event_id
      if is_battle then
        tb.is_fight_bag = true
        tb.not_show_max = true
        tb.bg_click = false
      else
        tb.func = info.func_name or func_name
      end
      table.insert(rect, tb)
    end
  end
  return rect
end

function helper._get_currency_param(item_id)
  if item_id == Config.DIAMOND_ITEMID then
    return "_onclick_diamond", Const.MSG_ON_DIAMOND_UPDATE
  elseif item_id == Config.COIN_ITEMID then
    return "_onclick_coin", Const.MSG_ON_COIN_UPDATE
  elseif item_id == Config.PLAYER_SP_ITEMID then
    return "_onclick_stamina", Const.MSG_ON_PLAYER_SP_UPDATE
  elseif item_id == Config.GILTGOLD_ITEMID then
    return "_onclick_gold", Const.MSG_ON_GOLD_UPDATE
  elseif item_id == ShopCfg.SKIN_COUPON_ID then
    return "_onclick_skin_item", Const.MSG_ROLE_RES_CHANGE
  elseif item_id == Config.CURSE_GOLD then
    return nil, Const.MSG_ON_FIGHT_DIAMOND_UPDATE
  else
    local award_type = ShareRes.create("item.award_type")
    for k, v in pairs(award_type) do
      if item_id >= v.IdBegin and item_id <= v.IdEnd then
        if v.BagType == Config.BAG_TYPE.RESOURCE then
          return "_on_click_item", Const.MSG_ROLE_RES_CHANGE
        elseif v.BagType == Config.BAG_TYPE.ITEM then
          return "_on_click_item", Const.MSG_ON_ITEM_UPDATE
        end
      end
    end
  end
end

function helper.check_break_mat_enough(item_id, buddy_id)
  local break_cfg = ShareRes.create("buddy.buddy_break", buddy_id)
  if nil == break_cfg then
    Log.Error("获取角色突破配置失败，buddy_id=", buddy_id)
    return
  end
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  if nil ~= buddy_info then
    local mat_has_num = BagMgr:get_item_num(item_id)
    return helper.get_need_break_mat(break_cfg, buddy_info.break_lv, item_id, mat_has_num)
  end
end

function helper.get_need_break_mat(break_cfg, start_lv, mat_item_id, mat_has_num)
  local total_need = 0
  while nil ~= break_cfg[start_lv] do
    local cfg = break_cfg[start_lv]
    if cfg.Item[1] == mat_item_id then
      total_need = total_need + cfg.ItemCount[1]
    elseif cfg.Item[2] == mat_item_id then
      total_need = total_need + cfg.ItemCount[2]
    end
    if mat_has_num < total_need then
      return false, total_need - mat_has_num, start_lv
    end
    start_lv = start_lv + 1
  end
  if mat_has_num < total_need then
    return false, total_need - mat_has_num, start_lv - 1
  end
  return true
end

function helper.format_discount(dis)
  local a, b = math.modf(dis)
  if 0 == b then
    return a
  end
  return dis
end

function helper.get_money_symbol(product_cfg)
  return RechargeMgr:get_currency_symbol(product_cfg)
end

function helper.check_cost_enough(item_id, need)
  local enough = need <= BagMgr:get_item_num(item_id)
  if not enough then
    local cfg = Item_Helper.get_item_cfg(item_id)
    if item_id == Config.GILTGOLD_ITEMID then
      helper.jump_to_recharge()
    elseif item_id == ShopCfg.SKIN_COUPON_ID then
      Util.show_message_tip(2314, cfg.Name)
      helper.show_short_gift_shop()
    else
      Util.show_message_tip(2314, cfg.Name)
    end
    return false
  else
    return true
  end
end

function helper.jump_to_recharge()
  local function sure_cb()
    SysOpenMgr:jump_to_sys(12106, true)
  end
  
  local cfg = Item_Helper.get_item_cfg(Config.GILTGOLD_ITEMID)
  local desc = Util.format_str("{1}不足，是否前往{2}", cfg.Name, ShopCfg.SHOP_NAME[ShopCfg.SHOP_TYPE.Recharge])
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_cb, nil, desc)
end

function helper.check_gift_has_special_item(gift_cfg, item_id)
  if gift_cfg.AwardID then
    for _, v in ipairs(ShareRes.get_award_item_data(gift_cfg.AwardID)) do
      if v[1] == item_id then
        return true
      end
    end
  end
  if gift_cfg.MailID then
    local mail_cfg = ShareRes.create("mail_template.mail_template", gift_cfg.MailID)
    if not mail_cfg then
      Log.Error("get main config failure! mail_id =", gift_cfg.MailID)
      return
    end
    for _, v in ipairs(ShareRes.get_award_item_data(mail_cfg.RewardGroup)) do
      if v[1] == item_id then
        return true
      end
    end
  end
  return false
end

function helper.check_gift_open(gift_cfg, ignore_condition)
  local is_open = true
  if gift_cfg.Paging then
    local page_cfg = ShareRes.create("recharge.gift_shop_page", gift_cfg.Paging)
    local check_page
    if page_cfg and Util.is_more_than_zero(page_cfg.Limit) then
      if 1 == page_cfg.Limit then
        check_page = gift_cfg.Paging
      else
        return false
      end
    end
    local is_privilege_gift, privilege_open = NewbieTowerMgr:check_is_privilege_gift(check_page, gift_cfg.Id)
    if is_privilege_gift and not privilege_open then
      return false
    end
  end
  if gift_cfg.FacingID then
    is_open = is_open and RechargeMgr:get_gift_buy_count(gift_cfg.FacingID) > 0
    if not is_open then
      return false
    end
  end
  if not ignore_condition and gift_cfg.Condition then
    is_open = is_open and Condition:check_condition(gift_cfg.Condition)
    if not is_open then
      return false
    end
  end
  local start_time = gift_cfg.StartTime and Date.get_time_stamp_by_scheme_id(gift_cfg.StartTime)
  if Util.is_more_than_zero(start_time) then
    is_open = is_open and start_time < Date.server_time()
    if not is_open then
      return false
    end
  end
  local end_time = gift_cfg.EndTime and Date.get_time_stamp_by_scheme_id(gift_cfg.EndTime)
  if Util.is_more_than_zero(end_time) then
    is_open = is_open and end_time > Date.server_time()
  end
  return is_open
end

function helper.check_sold_out(gift_cfg)
  if gift_cfg.Paging == ShopCfg.SKIN_GIFT_SHOP_SHELF then
    local skin_id = helper.get_skin_id(gift_cfg)
    return FashionMgr:check_has_bought_fashion(skin_id) or RechargeMgr:get_gift_buy_count(gift_cfg.Id) >= 1
  end
  if gift_cfg.BuyLimit then
    return RechargeMgr:get_gift_buy_count(gift_cfg.Id) >= gift_cfg.BuyLimit
  end
  return false
end

function helper.get_skin_id(gift_cfg)
  local award = ShareRes.get_award_item_data(gift_cfg.AwardID)
  local skin_cfg = ShareRes.create("buddy.buddy_fashion", award[1][1])
  return skin_cfg.Id
end

function helper.show_short_gift_shop()
  UIMgr:get_ui("gift_shop_tips"):ui_show(ShopCfg.GIFT_TIPS_TYPE.SKIN_SHORT)
end

function helper.jump_to_gift_shop(gift_cfg)
  local jump_id = ShopCfg.GIFT_SHOP_SHELF[gift_cfg.Paging].JumpId
  if jump_id then
    SysOpenMgr:jump_to_sys(jump_id, true, gift_cfg)
  end
end

function helper.jump_to_gift_shop_not_open(gift_cfg, not_force)
  local jump_id = ShopCfg.GIFT_SHOP_SHELF[gift_cfg.Paging].JumpId
  if jump_id then
    SysOpenMgr:jump_to_sys(jump_id, true, {gift_cfg = gift_cfg, not_force_to_gift = not_force})
  end
end

function helper.get_goods_price(goods_cfg)
  if not RechargeMgr:is_recharge_product(goods_cfg) and not goods_cfg.ShowPrice then
    Log.Error("get sdkkey and ShowPrice field failure!", goods_cfg, debug.traceback())
    return
  end
  return RechargeMgr:get_goods_price(goods_cfg)
end

function helper.collect_skin_shop_goods_by_type(type, list)
  local gift_list = ShareRes.create("recharge.gift_shop_type", type)
  if gift_list then
    for _, v in ipairs(gift_list) do
      local is_open = helper.check_gift_open(v)
      if is_open then
        if helper.check_sold_out(v) then
          if 1 == v.SoldoutShow then
            table.insert(list, v)
          end
        else
          table.insert(list, v)
        end
      end
    end
  end
end

function helper.get_skin_shop_goods_list(get_weapon)
  local list = {}
  if get_weapon then
    helper.collect_skin_shop_goods_by_type(ShopCfg.WEAPON_SKIN_GIFT_SHOP_SHELF, list)
  else
    helper.collect_skin_shop_goods_by_type(ShopCfg.SKIN_GIFT_SHOP_SHELF, list)
  end
  table.sort(list, function(a, b)
    local out_a = helper.check_sold_out(a) and 1 or 0
    local out_b = helper.check_sold_out(b) and 1 or 0
    if out_a == out_b then
      if a.Priority == b.Priority then
        return a.Id > b.Id
      else
        return a.Priority > b.Priority
      end
    else
      return out_a < out_b
    end
  end)
  return list
end

function helper.get_skin_list(goods_list)
  local list = {}
  for _, v in ipairs(goods_list) do
    if next(v) then
      local award = ShareRes.get_award_item_data(v.AwardID)
      local skin_cfg = ShareRes.create("buddy.buddy_fashion", award[1][1])
      table.insert(list, skin_cfg)
    end
  end
  return list
end

function helper.get_weapon_skin_list(goods_list)
  local list = {}
  for _, v in ipairs(goods_list) do
    if next(v) then
      local award = ShareRes.get_award_item_data(v.AwardID)
      local skin_cfg = ShareRes.get_weapon_fashion_cfg(award[1][1])
      table.insert(list, skin_cfg)
    end
  end
  return list
end

function helper.check_shop_free_gift()
  for i, v in pairs(ShareRes.create("recharge.gift_shop_type")) do
    for _, t in ipairs(v) do
      local is_open = helper.check_gift_open(t)
      if is_open and not helper.check_sold_out(t) then
        local check_price = t.ShowPrice or t.CostItem
        if not check_price then
          return true
        end
      end
    end
  end
  return false
end

return helper
