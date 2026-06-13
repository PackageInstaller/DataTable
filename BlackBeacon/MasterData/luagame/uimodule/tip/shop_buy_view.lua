local Base = require("ui.uiobject")
local AssetBarView = require("ui.asset_bar.asset_bar")
local Shop_Helper = require("uimodule.shop.shop_helper")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_amount_panel = {
    "ItemAmoutPanel",
    BIND_TYPE.OBJECT
  },
  v_buy_num = {
    "ItemAmount",
    BIND_TYPE.TEXT
  },
  v_max_buy = {
    "ItemLimit",
    BIND_TYPE.TEXT
  },
  v_item_limit_line = {
    "ItemLimitLine",
    BIND_TYPE.TEXT
  },
  v_cost_panel = {
    "CostPanel",
    BIND_TYPE.OBJECT
  },
  v_money_cost = {
    "MoneyCostTem",
    BIND_TYPE.OBJECT
  },
  v_money_icon = {
    "MoneyCostIcon",
    BIND_TYPE.IMAGE
  },
  v_money_need = {
    "MoneyCostAmount",
    BIND_TYPE.TEXT
  },
  v_stock_cost = {
    "StockCostTem",
    BIND_TYPE.OBJECT
  },
  v_stock_need = {
    "StockCostAmount",
    BIND_TYPE.TEXT
  },
  v_sold_out = {
    "SlodOut",
    BIND_TYPE.OBJECT
  },
  v_operate_panel = {
    "OperatePanel",
    BIND_TYPE.OBJECT
  },
  v_slider = {
    "Slider",
    BIND_TYPE.SLIDER
  },
  v_add_btn = {
    "BtnAdd",
    BIND_TYPE.BUTTON
  },
  v_reduce_btn = {
    "BtnReduce",
    BIND_TYPE.BUTTON
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnBuy", function()
    self:_onclick_buy_btn()
  end)
  self:set_button("BtnAdd", function()
    self:_onclick_add_btn()
  end)
  self:set_button("BtnReduce", function()
    self:_onclick_reduce_btn()
  end)
  self:set_slider_listener(self.v_slider, function()
    self:_onclick_slider()
  end)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
  self.v_cost_id = 0
  self.v_cost_price = 0
  self.v_stock_id = 0
  self.v_item_id = 0
  self.v_goods_id = 0
end

function ui:ui_on_show(data, ...)
  self.v_goods_cfg = data.goods_cfg
  self.v_break_mat_enough = data.enough
  if self.v_goods_cfg == nil or nil == self.v_goods_cfg.Item then
    return
  end
  self.v_item_cfg = ShareRes.get_item_cfg(self.v_goods_cfg.Item)
  self.v_goods_id = self.v_goods_cfg.Id
  self.v_item_id = self.v_goods_cfg.Item
  self.v_stock_id = self.v_goods_cfg.StockItem
  self.v_cost_id = self.v_goods_cfg.CostId[1]
  self.v_buy_amount = 1
  self.v_reach_limit = false
  self:_refresh_view()
end

function ui:ui_on_hide()
  self.v_cost_id = 0
  self.v_cost_price = 0
  self.v_stock_id = 0
  self.v_item_id = 0
  self.v_goods_id = 0
  self.v_break_mat_enough = nil
  self.v_asset_bar:on_hide()
end

function ui:_refresh_view()
  local money_has = BagMgr:get_item_num(self.v_cost_id)
  self.v_cost_price = self:_get_goods_price(self.v_goods_cfg)
  self.v_max_buy_batch = self:_get_max_buy_batch(self.v_goods_cfg, money_has, self.v_cost_price, self.v_stock_id, self.v_goods_cfg.Quota)
  local limit_type = -1
  local quota = self.v_goods_cfg.Quota
  if quota and 0 ~= quota then
    limit_type = self.v_goods_cfg.ResetType or 0
  end
  self.v_cost_panel:SetActiveEx(self.v_reach_limit == false)
  self.v_amount_panel:SetActiveEx(self.v_reach_limit == false)
  self.v_operate_panel:SetActiveEx(self.v_reach_limit == false)
  self.v_sold_out:SetActiveEx(self.v_reach_limit)
  if self.v_reach_limit == false then
    ResMgr:load_set_icon(self.v_money_icon, UtilUI.get_item_icon(self.v_cost_id))
    self.v_stock_cost:SetActiveEx(self.v_stock_id > 0)
    self.v_max_buy.gameObject:SetActiveEx(-1 ~= limit_type)
    self.v_item_limit_line.gameObject:SetActiveEx(-1 ~= limit_type)
    if -1 ~= limit_type then
      local has_buy = ShopMgr:get_buy_amount(self.v_goods_id)
      self.v_max_buy.text = self.v_goods_cfg.Quota - has_buy
    end
    local limit = self.v_max_buy_batch > 0 and self.v_max_buy_batch or 1
    local force_limit = self.v_goods_cfg.Limit
    if force_limit and limit > force_limit then
      limit = force_limit
    end
    self.v_slider.maxValue = limit
    self.v_slider.minValue = 1
    self.v_slider.value = 1
    self:_refresh_changed_info()
  end
  local list = Shop_Helper.get_asset_list(self.v_goods_cfg.CostId)
  self.v_asset_bar:reset_config(list)
  self.v_asset_bar:set_jump_callback(function()
    UIMgr:try_hide_ui("shop_item_tips")
  end)
  self.v_asset_bar:on_create()
end

function ui:_refresh_changed_info()
  local need = math.modf(self.v_buy_amount * self.v_cost_price)
  local color = need <= BagMgr:get_item_num(self.v_cost_id) and "%s" or "<color=red>%s</color>"
  self.v_money_need.text = string.format(color, need)
  self.v_buy_num.text = math.modf(self.v_buy_amount)
  need = math.modf(self.v_buy_amount * self.v_goods_cfg.ItemCnt)
  color = need <= BagMgr:get_item_num(self.v_stock_id) and "%s" or "<color=red>%s</color>"
  self.v_stock_need.text = string.format(color, Shop_Helper.get_num_formate(need))
  self.v_add_btn.interactable = self.v_buy_amount < self.v_max_buy_batch
  self.v_reduce_btn.interactable = self.v_buy_amount > 1
  self.v_slider.interactable = self.v_max_buy_batch > 0
end

function ui:_get_text_color()
  if 0 == self.v_max_buy_batch then
    return "<color=red>%s</color>"
  else
    return "%s"
  end
end

function ui:_get_goods_price(shop_cfg)
  local has_discount = shop_cfg.Discount > 0
  local need = shop_cfg.CostCnt[1]
  if has_discount then
    if 1 == shop_cfg.Discount then
      return math.ceil(need * (shop_cfg.DiscountVal / 100))
    else
      local num = ShopMgr:get_stock_amount(self.v_stock_id)
      local discount = Shop_Helper.get_break_item_discount(num, self.v_goods_cfg.DiscountVal)
      return math.ceil(need * (discount / 100))
    end
  end
  return need
end

function ui:_get_max_buy_batch(shop_cfg, money_has, money_cost, stock_id, limit)
  local money_max_buy = 0
  if money_cost <= money_has then
    money_max_buy = math.floor(money_has / money_cost)
  end
  local stock_max_buy = 0
  if stock_id > 0 then
    local stock_num = BagMgr:get_item_num(stock_id)
    if stock_num >= shop_cfg.ItemCnt then
      stock_max_buy = math.floor(stock_num / shop_cfg.ItemCnt)
    end
  end
  local limit_max_buy = 0
  if limit > 0 then
    local has_buy = ShopMgr:get_buy_amount(self.v_goods_id)
    if limit - has_buy > 0 then
      if limit - has_buy >= 1 then
        limit_max_buy = math.floor(limit - has_buy)
      end
    else
      limit_max_buy = 0
    end
  end
  if 0 == stock_max_buy and stock_id > 0 then
    local cfg = ShareRes.get_item_cfg(stock_id)
    self.v_notice_desc = Util.format_str("{1}数量不足", cfg.Name)
  elseif 0 == money_max_buy then
    local cfg = ShareRes.get_item_cfg(self.v_goods_cfg.CostId[1])
    self.v_notice_desc = Util.format_str("{1}数量不足", cfg.Name)
  elseif limit > 0 and 0 == limit_max_buy then
    self.v_reach_limit = true
  end
  if limit > 0 and stock_id > 0 then
    return math.min(money_max_buy, stock_max_buy, limit_max_buy)
  elseif limit > 0 then
    return math.min(money_max_buy, limit_max_buy)
  elseif stock_id > 0 then
    return math.min(money_max_buy, stock_max_buy)
  end
  return money_max_buy
end

function ui:_onclick_buy_btn()
  if 0 == self.v_max_buy_batch then
    if self.v_notice_desc then
      Util.show_message_tip(self.v_notice_desc)
    else
      Util.show_message_tip(2343)
    end
    return
  end
  local shop_id = self.v_goods_id
  local buy_amount = self.v_buy_amount
  
  local function buy_cb()
    ScreenMaskMgr:open_one_tag(self.v_object.name, math.huge)
    ShopMgr:request_buy_ex_shop_goods(shop_id, buy_amount, function()
      ScreenMaskMgr:close_one_tag(self.v_object.name)
      UIMgr:try_hide_ui("shop_item_tips")
    end)
  end
  
  if self.v_break_mat_enough == true then
    local tip = Util.format_str("{1}道具已经溢出，是否继续购买？", self.v_item_cfg.Name)
    
    local function sure_callback()
      buy_cb()
    end
    
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip)
  else
    buy_cb()
  end
  UIMgr:try_hide_ui("itemTip")
end

function ui:_onclick_add_btn()
  self.v_buy_amount = self.v_buy_amount + 1
  self:_refresh_changed_info()
  self.v_slider.value = self.v_buy_amount
end

function ui:_onclick_reduce_btn()
  self.v_buy_amount = self.v_buy_amount - 1
  self:_refresh_changed_info()
  self.v_slider.value = self.v_buy_amount
end

function ui:_onclick_slider()
  self.v_buy_amount = math.floor(self.v_slider.value)
  self:_refresh_changed_info()
end

return ui
