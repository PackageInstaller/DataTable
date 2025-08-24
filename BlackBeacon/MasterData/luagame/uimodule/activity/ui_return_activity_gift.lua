local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local LoopListClass = require("ui.widget.infinite_loop_list")
local GoodsItemClass = require("uimodule.activity.ui_return_activity_gift_item")
local Shop_Helper = require("uimodule.shop.shop_helper")

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self.v_goods_view = LoopListClass:new(self, self.v_uiobjects.GiftView, GoodsItemClass)
end

function ui:ui_on_show()
  self:refresh_goods()
  self:_regist_client_event()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_GIFT_INFO_UPDATE, self._response_buy_result, self)
  self:bind_auto_mq(Const.MSG_ON_TIME_CUT_FINISH, self._response_buy_result, self)
end

function ui:_response_buy_result(msg)
  self:refresh_goods()
end

function ui:refresh_goods()
  self.v_goods_list = {}
  local cfg = ShareRes.get_return_activity_gift()
  for _, gift_data in pairs(cfg) do
    local v = ShareRes.get_gift_shop_cfg(gift_data.GiftId)
    if v then
      local is_open = Shop_Helper.check_gift_open(v)
      local is_product_valid = not RechargeMgr:is_recharge_product(v) or RechargeMgr:is_product_valid(v)
      if is_open and is_product_valid then
        if Shop_Helper.check_sold_out(v) then
          table.insert(self.v_goods_list, v)
        else
          table.insert(self.v_goods_list, v)
        end
      end
    end
  end
  table.sort(self.v_goods_list, function(a, b)
    local out_a = Shop_Helper.check_sold_out(a) and 1 or 0
    local out_b = Shop_Helper.check_sold_out(b) and 1 or 0
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
  self.v_goods_view:refresh_data(self.v_goods_list)
end

function ui:ui_on_hide()
  self.v_goods_view:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_goods_view:ui_on_destroy()
end

return ui
