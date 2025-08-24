local Base = require("uimodule.pop_up_widget.ui_popup_base")
local ShopCfg = require("uimodule.shop.shop_config")
local Item_Helper = require("utils.item_helper")
local ui = Util.create_child_mt(Base)
local StaicSv = require("ui.widget.static_scroll_view")
local SvItem = require("uimodule.sign_in.local_widgets.reward_item")
local Timer = Global.timer
local CT_Timer = Global.ct_timer
local BIND_TYPE = Config.BIND_TYPE
local icon_path_prefix = "Icon/item/%s"
local MODEL = {
  v_item_content = {
    "ItemList",
    BIND_TYPE.OBJECT
  }
}
local limit_time = 86400
local _tinsert = table.insert

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:init_reward_item()
  self.v_timer = {}
end

function ui:ui_on_show(widget_id)
  self.v_widget_id = widget_id
  self.v_widget_cfg = ShareRes.get_pop_widget_cfg(widget_id)
  self:set_button("BtnReturn", function()
    if self.v_widget_id then
      Base:manual_close()
    else
      self:ui_hide()
    end
  end)
  self:set_button("ReturnBg", function()
    if self.v_widget_id then
      Base:manual_close()
    else
      self:ui_hide()
    end
  end)
  SignInMgr:on_open_sign_in(function()
    if not self:visible() then
      return
    end
    self.v_month_reward_list = SignInMgr:get_month_reward_list()
    self:refresh_view()
    local today_done = self.v_month_reward_list.today_done
    if not today_done then
      self.v_uiobjects.BtnSign:SetActive(true)
      self:auto_sign_in()
    else
      self.v_uiobjects.BtnSign:SetActive(false)
      self.v_uiobjects.touch_bg:SetActive(false)
    end
  end)
  self.v_month_reward_list = SignInMgr:get_month_reward_list()
  self:refresh_view()
  self:register_listener()
  self:refresh_remain_time()
  self:create_countdown_timer()
end

function ui:pop_up_precondition()
  self.v_month_reward_list = SignInMgr:get_month_reward_list()
  local today_done = self.v_month_reward_list.today_done
  return not today_done
end

function ui:ui_on_hide()
  self.v_month_reward_list = nil
  self.v_child_list:clear()
  self:remove_timer()
  if self.v_ct_timer then
    CT_Timer:remove_timer(self.v_ct_timer)
    self.v_ct_timer = nil
  end
  if self.v_widget_id then
    PopUpWindowMgr:pop_widget_up(self.v_widget_id)
    self.v_widget_id = nil
  end
end

function ui:ui_on_destroy()
  self.v_child_list = nil
  self.v_timer = nil
end

function ui:create_countdown_timer()
  self.v_ct_timer = CT_Timer:add_timer("sign_in_timer", limit_time, function()
    self:refresh_remain_time()
  end)
end

function ui:refresh_view()
  local uobj = self.v_uiobjects
  local today_done = self.v_month_reward_list.today_done
  local today = self.v_month_reward_list.completed_days
  local today_data = self.v_month_reward_list[today]
  local month = self.v_month_reward_list.month
  self:refresh_month_title_time(month)
  uobj.touch_bg:SetActive(true)
  if not today_done then
    uobj.BtnSign:SetActive(true)
  else
    uobj.BtnSign:SetActive(false)
  end
  self:refresh_reward_item()
  local msg = {}
  msg.mm_obj = today_data
  self:on_item_selected(msg, true)
end

function ui:refresh_month_title_time(month)
  self.v_uicompents.Month_Title_txt.text = Date.get_language_month(month)
end

function ui:auto_sign_in()
  local uobj = self.v_uiobjects
  local commcfg = ShareRes.create("commcfg.system_commcfg")
  local today = self.v_month_reward_list.completed_days
  local today_data = self.v_month_reward_list[today]
  uobj.touch_bg:SetActive(true)
  local timer_idx = Timer:add_timer("sign_in_timer", commcfg.SignInAnimationDelayTime.value, function()
    SignInMgr:on_try_sign_in(function()
      today_data.is_sign = true
      self:refresh_reward_item()
      uobj.BtnSign:SetActive(false)
      uobj.touch_bg:SetActive(false)
      local msg = {}
      msg.mm_obj = today_data
      self:on_item_selected(msg, true)
    end)
  end)
  _tinsert(self.v_timer, timer_idx)
end

function ui:remove_timer()
  if not self.v_timer then
    return
  end
  for _, timer_idx in pairs(self.v_timer) do
    Timer:remove_timer(timer_idx)
  end
  UtilTable.clear_map(self.v_timer)
end

function ui:init_reward_item()
  self.v_child_list = StaicSv:new(self, self.v_item_content, SvItem, "SIGN_IN_REWARD_ITEM")
end

function ui:refresh_reward_item()
  self.v_child_list:update_list(self.v_month_reward_list)
end

function ui:refresh_remain_time()
  local next_sign_in_time = SignInMgr:get_next_sign_in_time() or 0
  local remain_time = next_sign_in_time - Date.server_time()
  local rest_time = remain_time < 0 and 0 or remain_time
  local remain_hour = math.floor(rest_time / 3600)
  rest_time = rest_time % 3600
  local remain_min = math.floor(rest_time / 60)
  local remain_sec = rest_time % 60
  self.v_uicompents.LeftTime_txt.text = string.format("%d时%d分%d秒", remain_hour, remain_min, remain_sec)
  if 0 == remain_time then
    self:ui_hide()
  end
end

function ui:refresh_item_context(data)
  local item_cfg = data.item_cfg
  local normal_icon_path = string.format(icon_path_prefix, item_cfg.Icon)
  local normal_amount = data.num
  self.v_uicompents.Day_amount_txt.text = normal_amount
  ResMgr:load_set_icon(self.v_uicompents.Day_ItemIcon_img, normal_icon_path)
  local card_cfg = ShareRes.create("recharge.monthly_card", ShopCfg.DF_CARD_TYPE)
  local card_reward = ShareRes.create("award.award", card_cfg.DailyAwardId)
  local card_item_cfg = Item_Helper.get_item_cfg(card_reward.ItemId)
  local month_icon_path = string.format(icon_path_prefix, card_item_cfg.Icon)
  self.v_uicompents.Month_amount_txt.text = card_reward.Num
  ResMgr:load_set_icon(self.v_uicompents.Month_ItemIcon_img, month_icon_path)
  ResMgr:load_set_icon(self.v_uicompents.DayItemQualityBg_img, UtilUI.get_item_quality_icon(item_cfg.Id))
  ResMgr:load_set_icon(self.v_uicompents.MonthItemQualityBg_img, UtilUI.get_item_quality_icon(card_reward.ItemId))
  local month_card_obj = self.v_uiobjects.MonthCard
  local month_card_txt = Util.get_text("Text", month_card_obj)
  local has_month_card = RechargeMgr:get_has_buy_card(ShopCfg.DF_CARD_TYPE)
  if not has_month_card then
    month_card_txt.text = Util.format_str("开通可获得")
  else
    month_card_txt.text = Util.format_str("月卡剩余{1}天", RechargeMgr:get_month_card_remain_days(ShopCfg.DF_CARD_TYPE))
  end
  self:set_button("Day_ItemIcon", function()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = item_cfg.Id
    })
  end)
  self:set_button("Month_ItemIcon", function()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = card_reward.ItemId
    })
  end)
end

function ui:register_listener()
  self:bind_auto_mq(Const.MSG_ON_SELECTED_SING_IN_REWARD, self.on_item_selected, self)
end

function ui:on_item_selected(msg, dont_show_tips)
  local data = msg.mm_obj
  local item_id = data.item_cfg.Id
  if dont_show_tips then
    local select_idx = data.idx
    local select_item = self.v_child_list:get_item_by_idx(select_idx)
    self.v_child_list:on_select_change(select_item)
    self:refresh_item_context(data)
  else
    UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
  end
end

return ui
