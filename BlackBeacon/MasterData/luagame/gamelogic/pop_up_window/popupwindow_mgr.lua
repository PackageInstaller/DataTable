local Base = require("gamelogic.base_system")
local ShopCfg = require("uimodule.shop.shop_config")
local M = Util.create_child_mt(Base)
local RETURN_ACT_CFG_ID = 16
local GUIDE_RECOVE_CFG_ID = 19
local COVER_GUIDE_UI = {ui_capsule_toy_popup = true}
M.is_need_send_all_pop_finish_msg = false

function M:init_sys()
  Base.init_sys(self)
  self.v_pop_up_queue_in_main = {}
  self.v_msg_handles = {}
  self:sys_mq_bind(Const.MSG_ON_CARD_INFO_UPDATE, self.on_month_card_update, self)
end

function M:on_destroy()
  if self.v_block_input_timer then
    Timer:remove_timer(self.v_block_input_timer)
    self.v_block_input_timer = nil
  end
  self.v_pop_up_queue_in_main = nil
  self:sys_all_mq_unbind()
end

function M:on_reconnect()
  self:jump_out()
  UtilTable.clear_list(self.v_pop_up_queue_in_main)
end

function M:pop_widget_list(data)
  self.is_need_send_all_pop_finish_msg = true
  local widget_id_list = data.widget_id_list
  for _, widget_id in ipairs(widget_id_list) do
    if 10 ~= widget_id and widget_id ~= RETURN_ACT_CFG_ID then
      local widget_cfg = ShareRes.get_pop_widget_cfg(widget_id)
      local priority = widget_cfg.Priority
      local pop_up_data = {id = widget_id, priority = priority}
      table.insert(self.v_pop_up_queue_in_main, pop_up_data)
    end
  end
  if RechargeMgr:get_has_buy_card(ShopCfg.DF_CARD_TYPE) then
    local is_got = RechargeMgr:get_has_recive_reward_today(ShopCfg.DF_CARD_TYPE)
    if not is_got then
      RechargeMgr:recive_month_card_daily_award(ShopCfg.DF_CARD_TYPE, function(fixed_award, drop_award)
        local month_card_widget_cfg = ShareRes.get_pop_widget_cfg(10)
        local pop_up_data = {
          id = month_card_widget_cfg.Id,
          priority = month_card_widget_cfg.Priority,
          param = {fixed_award = fixed_award, drop_award = drop_award}
        }
        table.insert(self.v_pop_up_queue_in_main, pop_up_data)
      end)
    end
  end
  local guide_recove_widget_cfg = ShareRes.get_pop_widget_cfg(GUIDE_RECOVE_CFG_ID)
  local pop_up_data_guide = {
    id = guide_recove_widget_cfg.Id,
    priority = guide_recove_widget_cfg.Priority
  }
  table.insert(self.v_pop_up_queue_in_main, pop_up_data_guide)
end

function M:insert_return_act_pop()
  if NoviceMgr:chech_activity_flyback_open() then
    local ret_widget_cfg = ShareRes.get_pop_widget_cfg(RETURN_ACT_CFG_ID)
    local pop_up_data = {
      id = ret_widget_cfg.Id,
      priority = ret_widget_cfg.Priority
    }
    table.insert(self.v_pop_up_queue_in_main, pop_up_data)
  end
end

function M:pop_widget_update(data)
  local widget_cfg = ShareRes.get_pop_widget_cfg(data.widget_id)
  local priority = widget_cfg.Priority
  local pop_up_data = {
    id = data.widget_id,
    priority = priority
  }
  table.insert(self.v_pop_up_queue_in_main, pop_up_data)
end

function M:pop_widget_up(widget_id, callback)
  local send_data = {widget_id = widget_id}
  Network:call("c2gs_pop_widget_up", send_data, function(ok, resp)
    if true == ok and 0 == resp.errcode and callback then
      callback()
    end
  end)
end

function M:check_avoid_guide(ui_name)
  if COVER_GUIDE_UI[ui_name] then
    return false
  end
  return GuideMgr:get_cur_guider() ~= nil
end

function M:pop_up(delay)
  local is_need_run_journey_event = JourneyEventMgr:get_is_need_run_force_journey_event()
  if is_need_run_journey_event then
    self:jump_out()
    return
  end
  if self.v_cur_pop_up_ui then
    self.v_cur_pop_up_ui:ui_hide()
    self.v_cur_pop_up_ui = nil
  end
  if #self.v_pop_up_queue_in_main < 1 then
    if self.is_need_send_all_pop_finish_msg then
      self.is_need_send_all_pop_finish_msg = false
      MsgGame:mq_publish2(Const.ON_ALL_SERVER_WIN_POP_FINISH)
    end
    return
  end
  self:sort_by_priority()
  local pop_up_widget = self.v_pop_up_queue_in_main[1]
  local widget_cfg = ShareRes.get_pop_widget_cfg(pop_up_widget.id)
  local end_time = widget_cfg.EndTime and Date.get_time_stamp_by_scheme_id(widget_cfg.EndTime)
  if end_time and end_time < Date.server_time() then
    table.remove(self.v_pop_up_queue_in_main, 1)
    self:pop_up()
    return
  end
  if self:check_avoid_guide(widget_cfg.UIConfig) then
    return
  end
  local ui = UIMgr:get_ui(widget_cfg.UIConfig)
  if ui then
    if not ui:pop_up_precondition(widget_cfg.Arg[1]) then
      table.remove(self.v_pop_up_queue_in_main, 1)
      self:pop_up()
      return
    end
  elseif widget_cfg.UseFunc then
    table.remove(self.v_pop_up_queue_in_main, 1)
    M[widget_cfg.UseFunc]()
    return
  end
  if delay then
    local uimain = UIMgr:try_get_ui("uimain")
    uimain:change_touch_bg_show(true)
    self.v_block_input_timer = Timer:add_timer(nil, delay, function()
      uimain:change_touch_bg_show(false)
      self:open_pop_widget()
      return true
    end)
  else
    self:open_pop_widget()
    return true
  end
end

function M:jump_out(jump_id)
  if self.v_cur_pop_up_ui then
    self.v_cur_pop_up_ui:ui_hide()
    self.v_cur_pop_up_ui = nil
  end
  if jump_id then
    SysOpenMgr:jump_to_sys(jump_id, true)
  end
end

function M:open_pop_widget()
  local pop_data = self.v_pop_up_queue_in_main[1]
  if not pop_data then
    return
  end
  local pop_widget_cfg = ShareRes.get_pop_widget_cfg(pop_data.id)
  local ui = UIMgr:get_ui(pop_widget_cfg.UIConfig)
  if ui then
    self.v_cur_pop_up_ui = ui
    table.remove(self.v_pop_up_queue_in_main, 1)
    ui:ui_show(pop_widget_cfg.Id, pop_widget_cfg.Arg, pop_data.param)
  end
end

function M:sort_by_priority()
  table.sort(self.v_pop_up_queue_in_main, function(a, b)
    return a.priority > b.priority
  end)
end

function M:on_month_card_update(msg)
  local has_month_card = RechargeMgr:get_has_buy_card(ShopCfg.DF_CARD_TYPE)
  local is_pass_day = msg.mm_obj
  if has_month_card and not RechargeMgr:get_has_recive_reward_today(ShopCfg.DF_CARD_TYPE) then
    RechargeMgr:recive_month_card_daily_award(ShopCfg.DF_CARD_TYPE, function(fixed_award, drop_award)
      local param = {fixed_award = fixed_award, drop_award = drop_award}
      if is_pass_day then
        local month_card_widget_cfg = ShareRes.get_pop_widget_cfg(10)
        local pop_up_data = {
          id = month_card_widget_cfg.Id,
          priority = month_card_widget_cfg.Priority,
          param = param
        }
        table.insert(self.v_pop_up_queue_in_main, pop_up_data)
      else
        UIMgr:get_ui("ui_capsule_toy_popup"):ui_show(nil, nil, param)
      end
    end)
  end
end

function M:_recove_guide()
  GuideMgr:check_sys_guide(nil, true)
end

return M
