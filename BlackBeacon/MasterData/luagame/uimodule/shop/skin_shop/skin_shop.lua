local Base = require("ui.uibase")
local LoopListClass = require("ui.widget.infinite_loop_list")
local GoodsItemClass = require("uimodule.shop.skin_shop.skin_shop_item")
local ShopCfg = require("uimodule.shop.shop_config")
local Shop_Helper = require("uimodule.shop.shop_helper")
local AssetBarView = require("ui.asset_bar.asset_bar")
local CT_Timer = Global.ct_timer
local INTERVAL_TIME = 0.1
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_asset_bar = {
    "AssetBar",
    BIND_TYPE.OBJECT
  }
}
local PAGE_TYPE = {BUDDY = 1, WEAPON = 2}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_toggle("Page_1", function(isOn)
    if isOn then
      self.v_cur_page = PAGE_TYPE.BUDDY
      self.v_parent_panel:set_sub_page_idx(PAGE_TYPE.BUDDY)
      self:_set_goods()
    end
  end, true)
  self:set_toggle("Page_2", function(isOn)
    if isOn then
      self.v_cur_page = PAGE_TYPE.WEAPON
      self.v_parent_panel:set_sub_page_idx(PAGE_TYPE.WEAPON)
      self:_set_goods()
    end
  end, true)
  self.v_goods_view = LoopListClass:new(self, self.v_uiobjects.FishionList, GoodsItemClass)
  self.v_asset_bar = AssetBarView:new(self, self.v_asset_bar)
end

function ui:ui_on_show(page)
  local cache_page = self.v_parent_panel:get_sub_page_idx()
  self.v_cur_page = page or cache_page or PAGE_TYPE.BUDDY
  self:_init_tog()
  self:_set_goods()
  self:_refresh_asset()
  self:_regist_client_event()
end

function ui:ui_on_hide()
  self.v_stop_ani = nil
  self.v_goods_view:ui_on_hide()
  self.v_asset_bar:on_hide()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
  self.v_goods_view:ui_on_destroy()
end

function ui:_init_tog()
  self.v_uicompents.Page_1_tog.isOn = self.v_cur_page == PAGE_TYPE.BUDDY
  self.v_uicompents.Page_2_tog.isOn = self.v_cur_page == PAGE_TYPE.WEAPON
end

function ui:_set_goods()
  local list = Shop_Helper.get_skin_shop_goods_list(self.v_cur_page == PAGE_TYPE.WEAPON)
  self.v_need_ani = true
  self.v_goods_view:refresh_data(list)
  self.v_uiobjects.NoShopItem:SetActiveEx(0 == #list)
  self.v_need_ani = false
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  if self.v_visible then
    self.v_sequence = Util.create_sequence()
    local all_itmes = self.v_goods_view:get_all_uis()
    for _, ui_item in pairs(all_itmes) do
      if ui_item:is_visible_item() then
        ui_item:eff_init()
        self.v_sequence:AppendCallback(function()
          ui_item:play_in_eff()
        end)
        self.v_sequence:AppendInterval(INTERVAL_TIME)
      end
    end
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.shop_item_refresh_UI_SOUND)
  end
end

function ui:_refresh_asset()
  local list = Shop_Helper.get_asset_list({
    Config.GILTGOLD_ITEMID
  })
  self.v_asset_bar:reset_config(list)
  self.v_asset_bar:on_create()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_GIFT_INFO_UPDATE, self._set_goods, self)
  self:bind_auto_mq(Const.MSG_ON_TIME_CUT_FINISH, self._set_goods, self)
end

function ui:get_need_ani()
  return self.v_need_ani
end

return ui
