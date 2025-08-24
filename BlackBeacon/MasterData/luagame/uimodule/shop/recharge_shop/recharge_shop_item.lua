local Base = require("ui.uiobject")
local Shop_Helper = require("uimodule.shop.shop_helper")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_goods_num = {
    "GoodsNum",
    BIND_TYPE.TEXT
  },
  v_price = {
    "Price",
    BIND_TYPE.TEXT
  },
  v_extra_icon = {
    "ExtraGoodsIcon",
    BIND_TYPE.IMAGE
  },
  v_extra_num = {
    "ExtraGiveNum",
    BIND_TYPE.TEXT
  },
  v_double_reward = {
    "DoubleRecharge",
    BIND_TYPE.OBJECT
  },
  v_extra_reward = {
    "ExtraGive",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BuyBtn", function()
    self:_onclick_buy_btn()
  end)
  self.v_goods_bg = self:get_image(nil, self.v_object)
  self.v_canvas_group = self:get_canvas_group(nil, self.v_object)
end

function ui:ui_on_hide()
  if self.v_sq then
    self.v_sq:Kill()
  end
end

function ui:set_data(go, data_list, index)
  self.v_goods_cfg = data_list[index]
  self:_set_goods_info()
  self:_set_extra_goods_info()
  self.v_canvas_group.alpha = 0
  self:_set_ani(index)
  self:unbind_all_auto_mq()
  self:_regist_client_event()
end

function ui:_set_goods_info()
  ResMgr:load_set_icon(self.v_uicompents.Bg_img, self.v_goods_cfg.Icon, nil, true)
  self.v_goods_num.text = self.v_goods_cfg.Desc
  self.v_price.text = string.format("%s <size=48>%s</size>", Shop_Helper.get_money_symbol(self.v_goods_cfg), Shop_Helper.get_goods_price(self.v_goods_cfg))
end

function ui:_set_extra_goods_info()
  local is_first = RechargeMgr:get_is_first_recharge(self.v_goods_cfg.Id)
  self.v_double_reward:SetActive(is_first)
  if is_first then
    self:_set_first_extra_reward()
  else
    self:_set_extra_reward()
  end
end

function ui:_set_first_extra_reward()
  local has_extra = self.v_goods_cfg.FirstItemId ~= nil and self.v_goods_cfg.FirstItemNum > 0
  self.v_extra_reward:SetActive(has_extra)
  if not has_extra then
    return
  end
  ResMgr:load_set_icon(self.v_extra_icon, Shop_Helper.get_item_icon(self.v_goods_cfg.FirstItemId))
  self.v_extra_num.text = self.v_goods_cfg.FirstItemNum
end

function ui:_set_extra_reward()
  local has_extra = self.v_goods_cfg.ExtraItemId ~= nil and self.v_goods_cfg.ExtraItemNum > 0
  self.v_extra_reward:SetActive(has_extra)
  if not has_extra then
    return
  end
  ResMgr:load_set_icon(self.v_extra_icon, Shop_Helper.get_item_icon(self.v_goods_cfg.ExtraItemId))
  self.v_extra_num.text = self.v_goods_cfg.ExtraItemNum
end

function ui:_set_ani(index)
  if self.v_sq then
    self.v_sq:Kill()
  end
  self.v_sq = Util.create_sequence()
  self.v_sq:AppendInterval(0.1 * index)
  self.v_sq:Append(self.v_canvas_group:DOFade(1, 0.1))
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_RECHARGE_UPDATE, self._response_buy_result, self)
end

function ui:_response_buy_result(msg)
  self:_set_goods_info()
  self:_set_extra_goods_info()
end

function ui:_onclick_buy_btn()
  RechargeMgr:request_buy_product(self.v_goods_cfg, nil)
end

function ui:play_in_eff()
  self.v_object:SetActive(true)
end

function ui:eff_init()
  self.v_object:SetActive(false)
end

function ui:is_visible_item()
  return self.v_visible
end

return ui
