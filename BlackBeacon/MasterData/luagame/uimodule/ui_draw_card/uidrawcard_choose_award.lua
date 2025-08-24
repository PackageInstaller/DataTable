local Helper = require("uimodule.ui_draw_card.drawcard_helper")
local AssetBarView = require("ui.asset_bar.asset_bar")
local CT_Timer = Global.ct_timer
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local ui_draw_card_choose_award = "ui_draw_card_choose_award"
local award_item = require("uimodule.ui_draw_card.uidrawcard_choose_award_item")
local MODEL = {}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    UIMgr:go_to_main()
  end)
  self:set_button("BtnRecive", function()
    self:get_award()
  end)
  self:register_exist_auto_template(ui_draw_card_choose_award, self.v_uiobjects.CharTem, self.v_uiobjects.CharLayout)
end

function ui:check_pool_status(force_hide)
  force_hide = true == force_hide
  local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
  if not pool_vo then
    local confirmCb
    if not force_hide then
      function confirmCb()
        self:ui_hide()
      end
    end
    NextFrameMgr:add_next_update(function()
      if force_hide then
        self:ui_hide()
      end
      Util.show_notify_popup_message(confirmCb, "活动已结束", nil, "确定", nil, nil, true)
    end)
    return true
  end
end

function ui:ui_on_show(choose_config, curr_count, max_count, select_buddy_id, group_id, pool_id)
  self.v_buddy_id = select_buddy_id
  self.v_choose_config = choose_config
  self.v_curr_count = curr_count
  self.v_max_count = max_count
  self.v_group_id = group_id
  self.v_pool_id = pool_id
  if self:check_pool_status(true) then
    return
  end
  self:refresh_list()
  self:refresh_progress()
  local desc_txt = self.v_uicompents.Tips_txt
  if desc_txt and choose_config.Desc then
    desc_txt.text = choose_config.Desc
  end
  self:bind_auto_mq(Const.MSG_DRAW_GROUP_LIST_UPDATE, self.check_pool_status, self)
end

function ui:set_select_buddy_id(buddy_id)
  self.v_buddy_id = buddy_id
  for _, item in pairs(self.v_wrap_item_list) do
    item:refresh_select()
  end
end

function ui:get_select_buddy_id()
  return self.v_buddy_id
end

function ui:refresh_list()
  self:remove_wrap_items()
  self.v_wrap_item_list = {}
  local buddy_id_list = self.v_choose_config.BuddyId
  self:give_back_auto_cache(ui_draw_card_choose_award)
  local delay = 0
  for _, buddy_id in pairs(buddy_id_list) do
    local buddy_item = self:get_auto_cache(ui_draw_card_choose_award)
    local item_lua_obj = award_item:ui_wrap_ex(self, buddy_item, true)
    item_lua_obj:set_data(buddy_id, delay)
    table.insert(self.v_wrap_item_list, item_lua_obj)
    delay = delay + 0.08
  end
end

function ui:remove_wrap_items()
  if self.v_wrap_item_list then
    for _, item in pairs(self.v_wrap_item_list) do
      item:ui_hide()
      item:ui_destroy()
    end
    self.v_wrap_item_list = nil
  end
end

function ui:refresh_progress()
  self.v_uicompents.ProgressNow_txt.text = tostring(self.v_curr_count)
  self.v_uicompents.ProgressNeed_txt.text = tostring(self.v_max_count)
end

function ui:refresh_receive_btn_status()
  self.v_uiobjects.BtnRecive:SetActive(self.v_curr_count >= self.v_max_count)
end

function ui:get_award()
  if self.v_curr_count < self.v_max_count then
    Util.show_message_tip(2237)
    return
  end
  if not self.v_buddy_id then
    Util.show_message_tip(2238)
    return
  end
  self:check_max_tips()
end

function ui:check_max_tips()
  local need_count = CharacterMgr:get_max_advance_need_mat(self.v_buddy_id)
  local msg
  if not need_count or need_count > 0 then
    msg = Util.format_str("是否选择【{1}】做为自选角色奖励？", ShareRes.get_buddy_name(self.v_buddy_id))
  else
    msg = "角色潜能已满，多余理型将进行转换,是否确定选择"
  end
  Util.show_notify_popup_message(function()
    self:send_choose_award_msg()
  end, msg, "提示", "确定", "取消", nil, false)
end

function ui:send_choose_award_msg()
  DrawCardMgr:get_choose_award(self.v_choose_config.Id, self.v_buddy_id, function()
    MsgGame:mq_publish2(Const.MSG_DRAW_CHOOSE_AWARD_RECEIVE)
    self:ui_hide()
  end)
end

function ui:ui_on_hide()
  self:remove_wrap_items()
end

function ui:get_cache_data()
  return self.v_choose_config, self.v_curr_count, self.v_max_count, self.v_buddy_id, self.v_group_id, self.v_pool_id
end

return ui
