local Base = require("ui.uiobject")
local Shop_Helper = require("uimodule.shop.shop_helper")
local Item_Helper = require("utils.item_helper")
local ShopCfg = require("uimodule.shop.shop_config")
local AssetBarView = require("ui.asset_bar.asset_bar")
local ui = Util.create_child_mt(Base)
local CT_Timer = Global.ct_timer
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_normal_bg = {
    "BgNormal",
    BIND_TYPE.OBJECT
  },
  v_glod_bg = {
    "BgGold",
    BIND_TYPE.OBJECT
  },
  v_curr_icon = {
    "CurrIcon",
    BIND_TYPE.IMAGE
  },
  v_daily_get_desc = {
    "DailyGetDesc",
    BIND_TYPE.TEXT
  },
  v_daily_get = {
    "DailyGet",
    BIND_TYPE.OBJECT
  },
  v_direct_get = {
    "DirectGet",
    BIND_TYPE.OBJECT
  },
  v_discount_num = {
    "DiscountNum",
    BIND_TYPE.OBJECT
  },
  v_discount_bg = {
    "DiscountBg",
    BIND_TYPE.IMAGE
  },
  v_discount = {
    "Discount",
    BIND_TYPE.TEXT
  },
  v_discount_desc = {
    "DiscountDesc",
    BIND_TYPE.TEXT
  },
  v_gift_icon = {
    "GiftIcon",
    BIND_TYPE.IMAGE
  },
  v_gift_item_tem = {
    "GiftItemTem",
    BIND_TYPE.OBJECT
  },
  v_gift_name = {
    "GiftName",
    BIND_TYPE.TEXT
  },
  v_limit_buy = {
    "LimitBuy",
    BIND_TYPE.OBJECT
  },
  v_limit_max = {
    "LimitMax",
    BIND_TYPE.TEXT
  },
  v_limit_now = {
    "LimitNow",
    BIND_TYPE.TEXT
  },
  v_limit_text = {
    "LimitText",
    BIND_TYPE.TEXT
  },
  v_price_num = {
    "PriceNum",
    BIND_TYPE.TEXT
  },
  v_time = {
    "Time",
    BIND_TYPE.IMAGE
  },
  v_remaining_time = {
    "Remaining",
    BIND_TYPE.TEXT
  }
}
local LIMIT_TYPES = ShopCfg.GIFT_LIMIT_TYPES

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_template_key = "GIFT_REWARD" .. self.v_object.name
  self:register_exist_auto_template(self.v_template_key, self.v_gift_item_tem, self.v_uiobjects.ListContent)
  self.v_content_rect = self:get_rect_transform(nil, self.v_uiobjects.ListContent)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
  self:set_button("BuyBtn", function()
    self:_onclick_buy_btn()
  end)
  self:set_button("BtnClose", function()
    self.v_parent_ui:ui_hide()
  end)
end

function ui:ui_on_show(gift_cfg, ...)
  self.v_gift_cfg = gift_cfg
  self.v_reach_limit = Shop_Helper.check_sold_out(self.v_gift_cfg)
  self:_refresh_asset()
  self:_set_goods_info()
  self:_set_limit_info()
  self:_set_time()
  self:_set_discount()
  self:_set_reward()
end

function ui:ui_on_hide()
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
  if self.v_reset_timer2 then
    CT_Timer:remove_timer(self.v_reset_timer2)
    self.v_reset_timer2 = nil
  end
  self.v_asset_bar:on_hide()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:_refresh_asset()
  local list = Shop_Helper.get_asset_list({
    Config.GILTGOLD_ITEMID
  })
  self.v_asset_bar:reset_config(list)
  self.v_asset_bar:on_create()
end

local enough_color = Util.CommonColor_White
local not_enough_color = Util.CommonColor_RedWarm

function ui:_set_goods_info()
  ResMgr:load_set_icon(self.v_gift_icon, self.v_gift_cfg.Icon)
  self.v_gift_name.text = self.v_gift_cfg.Name
  self.v_normal_bg:SetActive(false)
  self.v_glod_bg:SetActive(true)
  local condition_pass = Condition:check_condition(self.v_gift_cfg.Condition)
  self.v_uiobjects.BuyBtn:SetActive(condition_pass)
  self.v_uiobjects.LockCondition:SetActive(not condition_pass)
  self.v_curr_icon:SetActive(not self.v_gift_cfg.ShowPrice and self.v_gift_cfg.CostItem)
  if not condition_pass then
    self.v_uicompents.LockCondition_txt.text = self.v_gift_cfg.LockDesc
  elseif self.v_gift_cfg.ShowPrice then
    local price = Shop_Helper.get_goods_price(self.v_gift_cfg)
    self.v_price_num.text = string.format("%s %s", Shop_Helper.get_money_symbol(self.v_gift_cfg), price)
    self.v_price_num.color = enough_color
  elseif self.v_gift_cfg.CostItem then
    ResMgr:load_set_icon(self.v_curr_icon, Shop_Helper.get_item_icon(self.v_gift_cfg.CostItem))
    local is_enough = BagMgr:get_cost_enough(self.v_gift_cfg.CostItem, self.v_gift_cfg.CostItemNum)
    self.v_price_num.text = self.v_gift_cfg.CostItemNum
    self.v_price_num.color = is_enough and enough_color or not_enough_color
  else
    self.v_price_num.text = Util.format_str("免费")
    self.v_price_num.color = enough_color
  end
  local item_quality_cfg = ShareRes.create("item.item_quality", self.v_gift_cfg.GiftQuality)
  local bg_path = item_quality_cfg.ExchangeColorIcon
  ResMgr:load_set_icon(self.v_uicompents.BgGold_img, bg_path)
end

function ui:_set_limit_info()
  local is_limit = self.v_gift_cfg.BuyLimit ~= nil
  self.v_limit_buy:SetActive(is_limit)
  if not is_limit then
    return
  end
  self.v_limit_text.text = self.v_gift_cfg.ResetType and LIMIT_TYPES[self.v_gift_cfg.ResetType] or Util.format_str("限购")
  self.v_limit_now.text = RechargeMgr:get_gift_buy_count(self.v_gift_cfg.Id)
  self.v_limit_max.text = self.v_gift_cfg.BuyLimit
end

function ui:_set_time()
  local end_time = self.v_gift_cfg.EndTime and Date.get_time_stamp_by_scheme_id(self.v_gift_cfg.EndTime) or 0
  local has_time = end_time > 0
  if self.v_gift_cfg.BuyLimit and has_time then
    has_time = not self.v_reach_limit
  end
  self.v_time:SetActive(has_time)
  if not has_time then
    return
  end
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
  local total_sec = end_time - Date.server_time()
  if total_sec <= 0 then
    self.v_time:SetActive(false)
    return
  end
  self.v_remaining_time.text = Date.get_time_formate_2(total_sec)
  self.v_reset_timer = CT_Timer:add_timer("reset_timer", total_sec, function(sec)
    if sec > 0 then
      self.v_remaining_time.text = Date.get_time_formate_2(sec)
    else
      if self.v_reset_timer then
        CT_Timer:remove_timer(self.v_reset_timer)
        self.v_reset_timer = nil
      end
      UIMgr:try_hide_ui("gift_shop_tips")
    end
  end)
end

function ui:_set_discount()
  local has_tag = self.v_gift_cfg.ShowTag
  self.v_discount_bg:SetActive(has_tag)
  if not has_tag then
    return
  end
  local tag_cfg = ShareRes.create("recharge.gift_tag", self.v_gift_cfg.ShowTag)
  if tag_cfg.TagBgIcon == "" then
    self.v_discount_bg:SetActive(false)
    return
  end
  ResMgr:load_set_icon(self.v_discount_bg, tag_cfg.TagBgIcon, nil, false)
  self.v_discount_num:SetActive(self.v_gift_cfg.Discount)
  if self.v_gift_cfg.Discount then
    local lab = self.v_gift_cfg.Discount
    self.v_discount.text = lab
    self.v_discount_desc.gameObject:SetActive(false)
  else
    local lab = tag_cfg.Name
    self.v_discount_desc.text = lab
    self.v_discount_desc.gameObject:SetActive(true)
  end
end

function ui:_set_reward()
  self.v_content_rect:SetAnchoredPositionA(0, 0)
  self:give_back_auto_cache(self.v_template_key, false)
  local has_dir = self.v_gift_cfg.AwardID ~= nil
  self.v_direct_get:SetActive(has_dir)
  self.v_direct_get.transform:SetAsFirstSibling()
  local has_daily = nil ~= self.v_gift_cfg.MailID
  self.v_daily_get:SetActive(has_daily)
  local child_count = 2
  if has_dir then
    for _, v in ipairs(ShareRes.get_award_item_data(self.v_gift_cfg.AwardID)) do
      local item = self:get_auto_cache(self.v_template_key)
      self:_set_reward_item(item, v[1], v[2])
      child_count = child_count + 1
      item.transform:SetParent(self.v_uiobjects.DirectContent.transform)
    end
  end
  if has_daily then
    self.v_daily_get_desc.text = Util.format_str("连续{1}天，每日{2}:00邮件发放", self.v_gift_cfg.MailDay, Global.daily_reset_hour)
    local reward_id = ShareRes.create("mail_template.mail_template", self.v_gift_cfg.MailID).RewardGroup
    for _, v in ipairs(ShareRes.get_award_item_data(reward_id)) do
      local item = self:get_auto_cache(self.v_template_key)
      item.transform:SetParent(self.v_uiobjects.DailyContent.transform)
      self:_set_reward_item(item, v[1], v[2])
    end
  end
end

function ui:_set_reward_item(item, id, num)
  local function click_cb()
    UIMgr:try_hide_ui("gift_shop_tips")
    
    UIMgr:get_ui("itemTip"):ui_show({item_id = id})
  end
  
  self:create_item_obj(nil, self:get_child_gameobj("ItemBg", item), nil, {item_id = id, click_cb = click_cb})
  local cfg = Item_Helper.get_item_cfg(id)
  local item_name = self:get_text("ItemName", item)
  item_name.text = cfg.Name
  local item_num = self:get_text("ItemNum", item)
  item_num.text = num
end

function ui:_onclick_buy_btn()
  if self.v_reach_limit then
    return
  end
  local end_time = self.v_gift_cfg.EndTime and Date.get_time_stamp_by_scheme_id(self.v_gift_cfg.EndTime)
  if end_time and end_time > 0 and end_time - Date.server_time() < 0 then
    Util.show_message_tip(2273)
    return
  end
  if RechargeMgr:is_recharge_product(self.v_gift_cfg) then
    RechargeMgr:request_buy_product(self.v_gift_cfg, function()
      UIMgr:try_hide_ui("gift_shop_tips")
    end)
  else
    if self.v_gift_cfg.CostItem and not Shop_Helper.check_cost_enough(self.v_gift_cfg.CostItem, self.v_gift_cfg.CostItemNum) then
      UIMgr:try_hide_ui("gift_shop_tips")
      return
    end
    ScreenMaskMgr:open_one_tag(self.v_object.name, math.huge, false)
    RechargeMgr:request_buy_gift(self.v_gift_cfg.Id, function(ok)
      if ok then
        UIMgr:try_hide_ui("gift_shop_tips")
        ScreenMaskMgr:close_one_tag(self.v_object.name)
      end
    end)
  end
end

return ui
