local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local AssetBarView = require("ui.asset_bar.asset_bar")
local LoopListClass = require("ui.widget.infinite_loop_list")
local Shop_Helper = require("uimodule.shop.shop_helper")
local SHOP_TYPE = Shop_Helper.SHOP_TYPE
local summer_shop_item = require("uimodule.shop.ui_activity_summer_shop_item")

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self.v_goods_view = LoopListClass:new(self, self.v_uiobjects.ItemList, summer_shop_item)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:ui_on_show(activity_id, shop_id)
  shop_id = shop_id or 1007
  self.v_activity_id = activity_id
  self.v_shop_id = shop_id
  self:refresh_asset_bar()
  self:refresh_goods_list()
  self:register_client_event()
  self:refresh_timer()
end

function ui:register_client_event()
  self:bind_auto_mq(Const.MSG_ON_EXCHANGE_GOODS_UPDATE, self.refresh_goods_list, self)
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_SERVER_STOCK_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_COIN_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_DIAMOND_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_PLAYER_SP_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_DP_UPDATE, self.response_bag_update_event, self)
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:refresh_timer()
  self:clear_timer()
  local activity_cfg = ShareRes.get_activity_cfg(self.v_activity_id)
  local remain_time = NoviceMgr:get_time_remaining(activity_cfg.TimeType, activity_cfg.StopTime, activity_cfg.OpenTime, activity_cfg.SustainTime)
  self.v_timer = Global.ct_timer:add_timer("ui_summer_shop_timer", remain_time, function(time)
    self.v_uicompents.Time_txt.text = Date.get_time_format_7(time)
  end)
end

function ui:clear_timer()
  if self.v_timer then
    Global.ct_timer:remove_timer(self.v_timer)
  end
  self.v_timer = nil
end

function ui:response_bag_update_event(msg)
  if self.v_goods_view then
    self.v_goods_view:reload_data()
  end
end

function ui:refresh_goods_list()
  self.v_goods_list = ShopMgr:get_goods_list(self.v_shop_id, SHOP_TYPE.COOMMON_SHOP)
  if not self.v_goods_list then
    Log.Error("商品列表为空，商店id：", self.v_shop_id)
    return
  end
  self.v_goods_view:refresh_data(self.v_goods_list)
end

function ui:refresh_asset_bar()
  local data = ShareRes.create("shop.exchange_shop")
  self.v_cur_shop_data = data[self.v_shop_id]
  self.v_cur_shop_type = self.v_cur_shop_data.Type
  local key, value = next(self.v_cur_shop_data.ItemId)
  if 0 ~= value then
    local list = Shop_Helper.get_asset_list(self.v_cur_shop_data.ItemId)
    self.v_asset_bar:reset_config(list)
  else
    self.v_asset_bar:reset_config()
  end
  self.v_asset_bar:on_create()
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name)
end

function ui:ui_on_hide()
  self.v_asset_bar:on_hide()
  self:clear_timer()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

return ui
