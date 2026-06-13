local Base = require("ui.uiobject")
local Shop_Helper = require("uimodule.shop.shop_helper")
local ShopCfg = require("uimodule.shop.shop_config")
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local ease_linear = CS.DG.Tweening.Ease.OutQuart
local LIMIT_TYPES = ShopCfg.EXCHANGE_LIMIT_TYPES
local CT_Timer = Global.ct_timer
local M = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local SHOP_TYPE = Shop_Helper.SHOP_TYPE
local BUTTOM_TYPE = {
  PRICE = 1,
  SOULD_OUT = 2,
  LOCK = 3,
  EXPAND = 4,
  COND_LOCK = 5
}

function M:ui_finish_load()
end

function M:ui_on_hide()
  if self.v_ct_timer then
    CT_Timer:remove_timer(self.v_ct_timer)
    self.v_ct_timer = nil
  end
end

function M:set_data(go, data_list, index)
  self.v_goods_data = data_list[index]
  self.v_obj = go
  self.v_item_cfg = UtilUI.get_item_cfg(self.v_goods_data.Item)
  self.v_uicompents.GiftName_txt.text = self.v_item_cfg.Name
  ResMgr:load_set_icon(self.v_uicompents.GoodsIcon_img, Shop_Helper.get_item_icon(self.v_item_cfg.Id))
  self.v_condition_txt = Util.get_text("Text", self.v_uiobjects.Unlock)
  self:refresh_quality()
  self:refresh_limit()
  self:refresh_discount()
  self:refresh_label()
  self:refresh_price()
  self:refresh_time()
  self:refresh_condition()
  self:refresh_count()
  self:refresh_red()
  Global.listener_mgr:add_listener(self.v_object, self.v_uicompents.BuyBtn_btn.onClick, function()
    self:on_item_click()
  end)
  Global.listener_mgr:add_listener(self.v_object, self.v_uicompents.Sellout_btn.onClick, function()
    Util.show_message_tip(1103)
  end)
  Global.listener_mgr:add_listener(self.v_object, self.v_uicompents.Unlock_btn.onClick, function()
    local condition = ShareRes.create("condition.condition", self.v_goods_data.Condition)
    if condition and condition.Desc then
      Util.show_message_tip(condition.Desc)
    end
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = self.v_item_cfg.Id
    })
  end)
end

function M:refresh_quality()
  local item_quality_cfg = ShareRes.create("item.item_quality", self.v_item_cfg.Quality)
  local bg_path = item_quality_cfg.ActivitySummerBgIcon
  ResMgr:load_set_icon(self.v_uicompents.QualityBg_img, bg_path)
end

function M:refresh_limit()
  local limit_type = -1
  local quota = self.v_goods_data.Quota
  if quota and 0 ~= quota then
    limit_type = self.v_goods_data.ResetType or 0
  end
  self.v_reach_limit = false
  self.v_uiobjects.LimitGroup:SetActiveEx(-1 ~= limit_type)
  if -1 ~= limit_type then
    local has_buy = ShopMgr:get_buy_amount(self.v_goods_data.Id)
    local max_buy = self.v_goods_data.Quota
    has_buy = has_buy > max_buy and max_buy or has_buy
    self.v_uicompents.CurrentNum_txt.text = Shop_Helper.get_num_formate(has_buy)
    self.v_uicompents.MustNum_txt.text = Shop_Helper.get_num_formate(max_buy)
    self.v_reach_limit = has_buy >= max_buy
  end
  self.v_uiobjects.Sellout:SetActiveEx(self.v_reach_limit)
end

function M:refresh_discount()
  local has_discount = self.v_goods_data.Discount > 0
  self.v_uiobjects.DiscountBg:SetActiveEx(has_discount)
  self.v_price_discount = 100
  if false == has_discount then
    return
  end
  if self.v_shop_type == SHOP_TYPE.BREAK_SHOP then
    if self.v_goods_data.StockItem > 0 then
      local num = ShopMgr:get_stock_amount(self.v_goods_data.StockItem)
      self.v_price_discount = Shop_Helper.get_break_item_discount(num, self.v_goods_data.DiscountVal)
    end
    if 100 == self.v_price_discount then
      self.v_uicompents.DiscountBg:SetActiveEx(false)
    else
      local discount_str = Shop_Helper.format_discount(self.v_price_discount)
      self.v_uicompents.DiscountNum.text = discount_str
    end
  else
    self.v_price_discount = tonumber(self.v_goods_data.DiscountVal)
    local discount_str = Shop_Helper.format_discount(self.v_goods_data.DiscountVal)
    self.v_uicompents.DiscountNum.text = discount_str
  end
end

function M:refresh_label()
  local has_label = self.v_goods_data.Label > 0
  if Util.is_nil(self.v_uiobjects.LabelBg) then
    return
  end
  self.v_uiobjects.LabelBg:SetActive(has_label)
  if has_label then
    self.v_uicompents.LabelNum_txt.text = self.v_goods_data.LabelText
  end
end

function M:refresh_price()
  ResMgr:load_set_icon(self.v_uicompents.PriceIcon_img, Shop_Helper.get_item_icon(self.v_goods_data.CostId[1]))
  local has_discount = self.v_goods_data.Discount > 0 and self.v_price_discount < 100
  local has = BagMgr:get_item_num(self.v_goods_data.CostId[1])
  local need = self.v_goods_data.CostCnt[1]
  if has_discount then
    local discount_need = math.ceil(need * (self.v_price_discount / 100))
    self.v_uicompents.GoodsNum_txt.text = has >= discount_need and discount_need or string.format("<color=#F56344>%d</color>", discount_need)
  else
    self.v_uicompents.GoodsNum_txt.text = has >= need and need or string.format("<color=#F56344>%d</color>", need)
  end
end

function M:refresh_time()
  local end_time = 0
  if self.v_goods_data.EndTime then
    end_time = Date.get_time_stamp_by_scheme_id(self.v_goods_data.EndTime) or 0
  end
  local has_time = end_time > 0
  self.v_uiobjects.BuyTime:SetActive(has_time)
  if not has_time then
    return
  end
  if self.v_ct_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_ct_timer = nil
  end
  local total_sec = end_time - Date.server_time()
  if total_sec <= 0 then
    self.v_uicompents.BuyTime_txt.text = Date.get_time_formate_2(1)
    return
  end
  self.v_uicompents.BuyTime_txt.text = Date.get_time_formate_2(total_sec)
  self.v_ct_timer = CT_Timer:add_timer("exchange_shop_timer", total_sec, function(sec)
    if sec > 0 then
      self.v_uicompents.BuyTime_txt.text = Date.get_time_formate_2(sec)
    else
      self.v_uicompents.BuyTime_txt.text = Date.get_time_formate_2(1)
    end
  end)
end

function M:refresh_condition()
  local goods_data = ShopMgr:get_goods_data(self.v_goods_data.Id)
  self.v_uiobjects.Unlock:SetActive(false)
  if self.v_goods_data.Condition and 0 ~= self.v_goods_data.Condition and not goods_data then
    self.v_uiobjects.Unlock:SetActive(true)
    local condition = ShareRes.create("condition.condition", self.v_goods_data.Condition)
    self.v_condition_txt.text = condition.Desc
  end
end

function M:refresh_count()
  self.v_uicompents.ItemNmu_txt.text = self.v_goods_data.ItemCnt
end

function M:refresh_red()
  if not self.v_goods_data.RedDotShow or 0 == self.v_goods_data.RedDotShow then
    self.v_uiobjects.redpoint:SetActiveEx(false)
    return
  end
  local is_can_buy = ShopMgr:get_is_can_buy_goods_red(self.v_goods_data, SHOP_TYPE.COOMMON_SHOP)
  self.v_uiobjects.redpoint:SetActiveEx(is_can_buy)
end

function M:on_item_click()
  if self.v_goods_data == nil then
    return
  end
  if self.v_reach_limit then
    Util.show_message_tip(2272)
    return
  end
  if ShopMgr:get_new_mark(self.v_goods_data.Id) then
    ShopMgr:request_remove_goods_mark(self.v_goods_data.Id)
  end
  local show_param = {
    tips_type = Config.ITEM_TIPS_TYPE.SHOP,
    item_id = self.v_goods_data.Item,
    param = {
      goods_cfg = self.v_goods_data
    }
  }
  UIMgr:get_ui("shop_item_tips"):ui_show(show_param)
end

return M
