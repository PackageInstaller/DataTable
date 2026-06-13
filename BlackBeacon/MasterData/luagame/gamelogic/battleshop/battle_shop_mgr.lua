local Base = require("gamelogic.base_system")
local Battle_Shop_Cfg = require("uimodule.battle_shop.battle_shop_cfg")
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
end

function M:on_battle_shop_item_list(data)
  self.v_shop_id = data.shop_id
  self.v_refresh_cnt = data.refresh_cnt
  self.v_grid_list = data.grid_list
  for i, _ in ipairs(self.v_grid_list) do
    self.v_grid_list[i].item_idx = i
  end
  self.v_first_discount_cnt = data.first_discount_cnt
end

function M:get_battle_shop_id()
  return self.v_shop_id
end

function M:get_refresh_cnt()
  return self.v_refresh_cnt
end

function M:on_refresh_battle_shop_discount(data)
  self.v_shop_id = data.shop_id
  self.v_first_discount_cnt = data.first_discount_cnt
end

function M:get_battle_shop_item_list_length()
  local rest_num = 0
  for _, data in pairs(self.v_grid_list) do
    if data.buy == false then
      rest_num = rest_num + 1
    end
  end
  return rest_num
end

function M:is_reach_refresh_limit()
  local refresh_cost_cfg = ShareRes.create(Battle_Shop_Cfg.BATTLE_SHOP_REFRESH)
  local shop_cfg = ShareRes.create("battle.battle_shop")
  local shop_refresh_id = shop_cfg[self.v_shop_id].RefreshId
  local time = self.v_refresh_cnt
  local cost_cfg = refresh_cost_cfg[shop_refresh_id]
  time = time + 1
  if time > cost_cfg.MaxCount then
    return true
  end
  return false
end

function M:get_battle_shop_item_list()
  return self.v_grid_list
end

function M:get_first_discount_cnt()
  return self.v_first_discount_cnt
end

function M:open_battle_shop()
  Network:call("c2gs_battle_shop_open", {}, function(ok)
    if ok then
      local tower = TowerMgr:get_tower()
      if tower:is_challenge_ring_tower() then
        UIMgr:get_ui("ui_cr_shop"):ui_show()
      else
        UIMgr:get_ui("uibattle_shop"):ui_show()
      end
    end
  end)
end

function M:refresh_battle_shop(callback)
  Network:call("c2gs_battle_shop_refresh", {}, function(ok)
    if ok then
      Util.show_message_tip(2047)
      callback()
    end
  end)
end

function M:buy_battle_shop_item(item_index, callback)
  Network:call("c2gs_battle_shop_buy", {index = item_index}, function(ok, resp)
    if ok then
      Util.show_message_tip(2048)
      self.v_grid_list[resp.index].buy = true
      self.v_first_discount_cnt = self.v_first_discount_cnt - 1
    end
    callback()
  end)
end

function M:buy_battle_shop_equip_item(item_index, is_need, callback)
  local function cb(resp)
    Util.show_message_tip(2048)
    
    self.v_grid_list[resp.index].buy = true
    self.v_first_discount_cnt = self.v_first_discount_cnt - 1
    callback()
  end
  
  FightBagMgr:request_operate_equip_item("c2gs_battle_shop_buy", {index = item_index}, is_need, cb)
end

function M:sell_battle_shop_item(item_data, callback)
  Network:call("c2gs_battle_shop_sell", {
    uuid = item_data.uuid,
    id = item_data.id,
    count = item_data.count
  }, function(ok)
    if ok then
      Util.show_message_tip(2049)
    end
    if callback then
      callback()
    end
  end)
end

function M:sell_battle_shop_equip_item(item_data, is_need, callback)
  local function cb(resp)
    Util.show_message_tip(2049)
    
    if callback then
      callback()
    end
  end
  
  local send_data = {
    uuid = item_data.uuid,
    id = item_data.id,
    count = item_data.count
  }
  FightBagMgr:request_operate_equip_item("c2gs_battle_shop_buy", send_data, is_need, cb)
end

function M:get_sell_price_by_item_id(item_id, currency_type)
  local cur_type = currency_type or "BattleCurrencyId"
  local battle_equip_cfg = ShareRes.create(Battle_Shop_Cfg.BATTLE_EQUIP_CFG_PATH)
  local battle_item_cfg = ShareRes.create(Battle_Shop_Cfg.BATTLE_ITEM_CFG_PATH)
  local shop_item_cfg
  local sell_price = 0
  if FightBagMgr:get_is_item_by_id(item_id) then
    shop_item_cfg = battle_item_cfg[item_id]
  elseif FightBagMgr:get_is_collect_by_id(item_id) then
    shop_item_cfg = battle_equip_cfg[item_id]
  end
  if shop_item_cfg then
    local currency_id = ShareRes.get_single_key_define(cur_type)
    sell_price = shop_item_cfg.SaleAward[currency_id]
  end
  if not sell_price then
    Log.Error("get sell price from shop config failure, item_id=", item_id)
  end
  return sell_price or 0
end

function M:get_buy_price_by_item_id(item_id)
  local battle_equip_cfg = ShareRes.create(Battle_Shop_Cfg.BATTLE_EQUIP_CFG_PATH)
  local battle_item_cfg = ShareRes.create(Battle_Shop_Cfg.BATTLE_ITEM_CFG_PATH)
  local shop_item_cfg
  local buy_price = 0
  if FightBagMgr:get_is_item_by_id(item_id) then
    shop_item_cfg = battle_item_cfg[item_id]
  elseif FightBagMgr:get_is_collect_by_id(item_id) then
    shop_item_cfg = battle_equip_cfg[item_id]
  end
  if shop_item_cfg then
    buy_price = shop_item_cfg.BuyCostCnt
  end
  return buy_price
end

return M
