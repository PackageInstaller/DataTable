local Helper = require("uimodule.ui_draw_card.drawcard_helper")
local Player_Hero_Helper = require("uimodule.friend.player_hero_info.player_hero_helper")
local CT_Timer = Global.ct_timer
local AssetBarView = require("ui.asset_bar.asset_bar")
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self.v_draw_btn_elements = {
    {
      btn = self.v_uicompents.DrawBtn_1_btn,
      amount_txt = self.v_uicompents.DrawBtn_1_Amount_txt,
      cnt_txt = self.v_uicompents.DrawBtn_1_Cnt_txt,
      icon = self.v_uicompents.DrawBtn_1_Icon_img
    },
    {
      btn = self.v_uicompents.DrawBtn_2_btn,
      amount_txt = self.v_uicompents.DrawBtn_2_Amount_txt,
      cnt_txt = self.v_uicompents.DrawBtn_2_Cnt_txt,
      icon = self.v_uicompents.DrawBtn_2_Icon_img
    }
  }
  self:set_button("DetailBtn", function()
    UIMgr:get_ui("uidrawcard_rule"):ui_show(self.v_group_id, self.v_pool_id)
  end)
  self:set_button("ExchangeBtn", function()
    local group_config = ShareRes.get_draw_pool_group(self.v_group_id)
    if SysOpenMgr:get_is_ui_open("shopexchange", true) then
      SysOpenMgr:jump_to_sys(group_config.Jump, true)
    end
    self.v_uimain = UIMgr:try_get_visible_ui("uimain")
    if self.v_uimain then
      self.v_uimain:set_model_view_visible(false)
    end
  end)
  self:set_button("DrawBtn_1", function()
    self:_try_draw(1)
  end)
  self:set_button("DrawBtn_2", function()
    self:check_track()
    self:_try_draw(2)
  end)
  for i = 1, 3 do
    if self.v_uicompents["PurpleCharBtn" .. i .. "_btn"] then
      self:set_button("PurpleCharBtn" .. i, function()
        self:on_click_purple_char_btn(i)
      end)
    end
  end
  if self.v_uicompents.BtnFreeDrawInfo_btn then
    self:set_button("BtnFreeDrawInfo", function()
      if self.v_daily_free_rule_id then
        UIMgr:get_ui("info_tips"):ui_show(self.v_daily_free_rule_id)
      end
    end)
  end
  self.v_ui_in_pd = Util.get_playabledirector("SafeArea/Animation/UIDrawCard_Detail_UI_In", self.v_object)
  self.v_ui_out_pd = Util.get_playabledirector("SafeArea/Animation/UIDrawCard_Detail_UI_Out", self.v_object)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:ui_on_show(pool_id)
  self.v_ui_in_pd.time = 0
  self.v_ui_in_pd:Play()
  self.v_pool_config = ShareRes.get_drawcard_pool(pool_id)
  self.v_group_id = self.v_pool_config.Group
  self.v_pool_id = pool_id
  self.v_btn_status_list = {}
  self:_refresh_left_time()
  self:_refresh_daily_free_left_time()
  self:_refresh_cnt()
  self:_refresh_desc()
  self:_refresh_btns()
  self:register_event()
  MsgGame:mq_publish2(Const.MSG_RELEASE_COMMON_BATTLE_TIPS_HOLD_TASK)
  DrawCardMgr:watche_red(pool_id)
  self:refresh_choose_award()
  self:refresh_purple_char()
  self:_refresh_asset_bar(self.v_pool_config.CostId)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_DRAW_GROUP_UPDATE, self._handle_group_update, self)
  self:bind_auto_mq(Const.MSG_DRAW_CHOOSE_AWARD_RECEIVE, self.on_draw_choose_award_receive, self)
  self:bind_auto_mq(Const.MSG_DRAW_FREE_DATA_UPDATE, self._refresh_btns, self)
end

function ui:ui_on_hide()
  self:_remove_left_time_timer()
  self.v_asset_bar:on_hide()
  UIMgr:try_hide_ui("uidrawcard_recharge")
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:_refresh_asset_bar(item_id)
  local config = {
    self.v_asset_bar:get_default_config_by_id(Config.DIAMOND_ITEMID),
    {
      item_id = item_id,
      func = "_on_click_draw_item",
      const_event = Const.MSG_ROLE_RES_CHANGE,
      bg_click = true
    }
  }
  self.v_asset_bar:reset_config(config)
  self.v_asset_bar:on_create()
end

function ui:_draw(idx)
  self.v_parent_panel:enable_mask(true)
  DrawCardMgr:send_draw(self.v_group_id, self.v_pool_id, idx, function()
    local function stopped_func()
      if self.v_parent_panel then
        self.v_parent_panel:enable_mask(false)
      end
    end
    
    UIMgr:get_ui("uidrawcard_trigger_panel"):ui_show()
    Global.sound_mgr:play_sound_by_id(Config.ENTER_DRAWCARD_AUDIO_ID1)
    Global.sound_mgr:play_sound_by_id(Config.ENTER_DRAWCARD_AUDIO_ID2)
    self.v_ui_in_pd:Stop()
    self.v_ui_out_pd.time = 0
    self.v_ui_out_pd:Play()
    self.v_parent_panel:focus_on_clock(stopped_func)
  end, function()
    if self.v_parent_panel then
      self.v_parent_panel:enable_mask(false)
    end
  end)
end

function ui:_exchange_and_draw(idx, exchange_config_id, cnt)
  CharacterMgr:request_exchange_item(exchange_config_id, cnt, function()
    self:_try_draw(idx)
  end)
end

function ui:_try_draw(idx)
  if not self:_is_unlimit_draw_count(idx) then
    UIMgr:get_ui("uinotice_tips"):ui_show(nil, nil, "该卡池已达本日次数上限", "确认", nil, nil, true)
    return
  end
  if self:_check_choose_empty() then
    return
  end
  if self:_can_draw_directly(idx) then
    self:_draw(idx)
    return
  end
  local cost_info = self:_calculate_cost_info(idx)
  if not cost_info then
    return
  end
  self:_handle_resource_exchange(idx, cost_info)
end

function ui:_can_draw_directly(idx)
  local is_free = self.v_btn_status_list[idx]
  if is_free then
    return true
  end
  local ex_free_times = DrawCardMgr:get_free_draw_times(self.v_pool_config.LimitedTimeFreeId, idx)
  if 0 ~= ex_free_times then
    return true
  end
  if self:_is_res_enough_for_btn(idx) then
    return true
  end
  return false
end

function ui:_calculate_cost_info(idx)
  local config = self.v_pool_config
  local cost_id = config.CostId
  local cur_cnt = BagMgr:get_item_num(cost_id)
  local exchange_config = CharacterMgr:get_exchange_config_by_target_id(Config.EXCHANGE_TYPE.DEFAULT, cost_id)
  if not exchange_config then
    Log.Error("缺少兑换寻访证配置, 道具id = " .. cost_id)
    return nil
  end
  local discount = 1 == idx and 1 or config.Discount
  local need_cnt = math.floor(config.CostCnt * config.DrawCnt[idx] * discount)
  local lack_cnt = need_cnt - cur_cnt
  return {
    cost_id = cost_id,
    lack_cnt = lack_cnt,
    exchange_config = exchange_config,
    exchange_cost_id = exchange_config.Material[1],
    exchange_cost_cnt = exchange_config.Num[1] * lack_cnt
  }
end

function ui:_handle_resource_exchange(idx, cost_info)
  local current_cost_cnt = BagMgr:get_item_num(cost_info.exchange_cost_id)
  local next_exchange_config = CharacterMgr:get_exchange_config_by_target_id(Config.EXCHANGE_TYPE.DEFAULT, cost_info.exchange_cost_id)
  if not next_exchange_config then
    Log.Error("缺少兑换配置, 道具id = " .. cost_info.exchange_cost_id)
    return
  end
  if current_cost_cnt >= cost_info.exchange_cost_cnt then
    self:_show_direct_exchange_box(idx, cost_info)
  else
    self:_show_secondary_exchange_box(idx, cost_info, current_cost_cnt, next_exchange_config)
  end
end

function ui:_show_direct_exchange_box(idx, cost_info)
  Util.show_recharge_box(cost_info.cost_id, cost_info.lack_cnt, cost_info.exchange_cost_id, cost_info.exchange_cost_cnt, nil, nil, function()
    self:_exchange_and_draw(idx, cost_info.exchange_config.Id, cost_info.lack_cnt)
  end)
end

function ui:_show_secondary_exchange_box(idx, cost_info, current_cost_cnt, next_exchange_config)
  local next_lack_cnt = cost_info.exchange_cost_cnt - current_cost_cnt
  local next_exchange_cost_id = next_exchange_config.Material[1]
  local next_exchange_cost_cnt = next_exchange_config.Num[1] * (current_cost_cnt > 0 and next_lack_cnt or cost_info.exchange_cost_cnt)
  local next_exchange_cost_name = ShareRes.get_item_cfg(next_exchange_cost_id).Name
  Util.show_recharge_box(cost_info.cost_id, cost_info.lack_cnt, current_cost_cnt > 0 and cost_info.exchange_cost_id or nil, current_cost_cnt > 0 and current_cost_cnt or nil, next_exchange_cost_id, next_exchange_cost_cnt, function(is_enough)
    if is_enough then
      self:_process_secondary_exchange(idx, cost_info, next_exchange_config, next_lack_cnt, current_cost_cnt)
    else
      self:_show_shop_redirect_tip(next_exchange_cost_name)
    end
  end, {
    Config.DIAMOND_ITEMID,
    Config.GILTGOLD_ITEMID
  })
end

function ui:_process_secondary_exchange(idx, cost_info, next_exchange_config, next_lack_cnt, current_cost_cnt)
  local exchange_cnt = current_cost_cnt > 0 and next_lack_cnt or cost_info.exchange_cost_cnt
  CharacterMgr:request_exchange_item(next_exchange_config.Id, exchange_cnt, function()
    self:_exchange_and_draw(idx, cost_info.exchange_config.Id, cost_info.lack_cnt)
  end)
end

function ui:_show_shop_redirect_tip(item_name)
  local tip = Util.format_str("{1}不足，是否前往商店兑换{2}", item_name, item_name)
  Util.show_conform_tip(tip, nil, nil, nil, function()
    if SysOpenMgr:get_is_ui_open("recharge_shop", true) then
      SysOpenMgr:jump_to_sys(12106, true)
    end
  end)
end

function ui:check_track()
  local guide_tips = UIMgr:try_get_visible_ui("ui_guide")
  if not guide_tips then
    return
  end
  local free_obj = Util.get_child_gameobj("Free", self.v_uiobjects.DrawBtn_2)
  if free_obj.activeSelf == true then
    SDKManager:track_adjust_event("34_first_10gacha")
  end
end

function ui:_check_choose_empty()
  local config = self.v_pool_config
  if 4 == config.Type then
    local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
    if pool_vo and 0 == pool_vo.choose_id then
      local choose_group_id = config.Arg[1]
      local award_item_type = self:get_award_item_type(choose_group_id)
      local sure_callback, tip
      if award_item_type == Config.AWARD_TYPE.EQUIP then
        function sure_callback()
          UIMgr:get_ui("uidrawcard_select_panel"):ui_show(self.v_pool_id)
        end
        
        tip = Util.format_str("未选择目标武器，是否前往选择？")
      elseif award_item_type == Config.AWARD_TYPE.CHARA then
        function sure_callback()
          UIMgr:get_ui("uidrawcard_select_panel_char"):ui_show(self.v_pool_id)
        end
        
        tip = Util.format_str("未选择目标角色，是否前往选择？")
      end
      UIMgr:get_ui("uinotice_tips"):ui_show(sure_callback, nil, tip)
      return true
    end
  end
  return false
end

function ui:get_award_item_type(choose_group_id)
  local any_item_id
  local choose_group_cfg = ShareRes.create("draw.draw_pool_choose_group")
  for _, cfg in ipairs(choose_group_cfg) do
    if choose_group_id == cfg.Group then
      any_item_id = cfg.ItemId
      break
    end
  end
  if not any_item_id then
    Log.Error("卡池未找到指定id自选组，卡池id、自选组id：", self.v_pool_id, choose_group_id)
    return
  end
  return Util.get_item_type_cfg(any_item_id).AwardType
end

function ui:_remove_left_time_timer()
  if self.v_reset_timer then
    CT_Timer:remove_timer(self.v_reset_timer)
    self.v_reset_timer = nil
  end
end

function ui:_refresh_left_time()
  self:_remove_left_time_timer()
  local left_time_obj = self.v_uiobjects.LeftTimeObj
  local refresh_time_txt = self.v_uicompents.RefreshTime_txt
  local pool_config = self.v_pool_config
  local group_config = ShareRes.get_draw_pool_group(self.v_group_id)
  local end_time = pool_config.EndTime and Date.get_time_stamp_by_scheme_id(pool_config.EndTime)
  local group_end_time = group_config.EndTime and Date.get_time_stamp_by_scheme_id(group_config.EndTime)
  if not group_end_time and not end_time and not pool_config.ContinueTime then
    left_time_obj:SetActiveEx(false)
    return
  end
  local target_end_time
  if group_end_time then
    target_end_time = Util.conver_config_time_str2(group_end_time)
  end
  if end_time then
    local pool_end_time = end_time
    target_end_time = target_end_time and math.min(pool_end_time, target_end_time) or pool_end_time
  end
  if pool_config.ContinueTime then
    local system_open_time = DrawCardMgr:get_system_open_time()
    if system_open_time then
      local pool_end_time = pool_config.ContinueTime * 86400 + Date.get_day_start(system_open_time)
      target_end_time = target_end_time and math.min(pool_end_time, target_end_time) or pool_end_time
    end
  end
  if nil == target_end_time then
    left_time_obj:SetActiveEx(false)
    return
  end
  local total_sec = target_end_time - Date.server_time()
  if total_sec <= 0 then
    left_time_obj:SetActiveEx(false)
    return
  else
    refresh_time_txt.text = Date.get_time_desc(total_sec, true, true)
  end
  left_time_obj:SetActiveEx(true)
  self.v_reset_timer = CT_Timer:add_timer("ui_draw_card.refresh_left_time", total_sec, function(sec)
    if sec > 0 then
      if refresh_time_txt and not refresh_time_txt:IsNull() then
        refresh_time_txt.text = Date.get_time_desc(sec, true, true)
      end
    else
      self:_remove_left_time_timer()
    end
  end)
end

function ui:_refresh_daily_free_left_time()
  self.v_daily_free_act_start_time = nil
  self.v_daily_free_act_end_time = nil
  self.v_daily_free_rule_id = nil
  self.v_daily_free_act_state = nil
  local pool_config = self.v_pool_config
  local tips_obj = self.v_uiobjects.FreeDrawTips
  if not pool_config.LimitedTimeFreeId then
    if tips_obj then
      tips_obj:SetActiveEx(false)
    end
    return
  end
  local free_times_cfg = ShareRes.get_drawcard_free_times_cfg(pool_config.LimitedTimeFreeId)
  self.v_daily_free_rule_id = free_times_cfg.RuleId
  self.v_daily_free_act_start_time = free_times_cfg.StartTime and Date.get_time_stamp_by_scheme_id(free_times_cfg.StartTime) or 0
  self.v_daily_free_act_end_time = free_times_cfg.EndTime and Date.get_time_stamp_by_scheme_id(free_times_cfg.EndTime) or 0
  local server_time = Date.server_time()
  local is_in_act = server_time > self.v_daily_free_act_start_time and server_time < self.v_daily_free_act_end_time
  if tips_obj then
    tips_obj:SetActiveEx(is_in_act)
    if is_in_act then
      self.v_uicompents.FreeDrawTime_txt.text = Date.get_time_desc(self.v_daily_free_act_end_time - server_time, true, true)
    end
  end
end

function ui:_handle_group_update(msg)
  if msg.mm_obj == self.v_group_id then
    self:_refresh_cnt()
    self:_refresh_btns()
  end
end

local format_key1 = "<color=\"#FFD07B\">%d</color><color=\"#FFFFFF\">/%d</color>"
local format_key2 = "<color=\"#EFC66E\">%d</color><color=\"#FFFFFF\">/%d</color>"

function ui:_refresh_cnt()
  local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
  if nil == pool_vo then
    return
  end
  local config = pool_vo:get_config()
  self.v_uiobjects.DailyLimitCntObj:SetActiveEx(nil ~= config.DayLimitCnt)
  if config.DayLimitCnt then
    self.v_uicompents.DailyLimitCnt_txt.text = string.format(format_key1, pool_vo.day_limit_cnt, config.DayLimitCnt)
  end
  self.v_uiobjects.LeftCntObj:SetActiveEx(nil ~= config.Count)
  if config.Count then
    local lack_cnt = config.Count - pool_vo.draw_cnt
    lack_cnt = lack_cnt < 0 and 0 or lack_cnt
    self.v_uicompents.LeftCnt_txt.text = string.format(format_key1, lack_cnt, config.Count)
  end
  if config.Type == Helper.POOL_TYPE.CNT_LIMIT then
    self.v_uiobjects.HistoryCntObj:SetActiveEx(false)
  else
    self.v_uiobjects.HistoryCntObj:SetActiveEx(true)
    self.v_uicompents.HistoryCnt_txt.text = string.format(format_key2, pool_vo.guarantee_cur, pool_vo.guarantee_max)
  end
end

function ui:_refresh_desc()
  local uiobj = self.v_uiobjects
  local uicomp = self.v_uicompents
  local tips = self.v_pool_config.Tips or {}
  if uiobj.GuaranteeDesc_1 then
    uiobj.GuaranteeDesc_1:SetActiveEx(nil ~= tips[1])
    uicomp.GuaranteeDesc_1_txt.text = tips[1]
  end
  if uiobj.GuaranteeDesc_2 then
    uiobj.GuaranteeDesc_2:SetActiveEx(nil ~= tips[2])
    uicomp.GuaranteeDesc_2_txt.text = tips[2]
  end
  if uiobj.GuaranteeDesc_3 then
    uiobj.GuaranteeDesc_3:SetActiveEx(nil ~= tips[3])
    uicomp.GuaranteeDesc_3_txt.text = tips[3]
  end
end

function ui:_is_res_enough_for_btn(idx)
  local config = self.v_pool_config
  if config.DrawCnt[idx] then
    local discount = 1 == idx and 1 or config.Discount
    local cur_res_cnt = BagMgr:get_item_num(config.CostId)
    local cost_res_cnt = config.CostCnt * config.DrawCnt[idx] * discount
    return cur_res_cnt >= cost_res_cnt
  end
  return false
end

function ui:_is_unlimit_draw_count(idx)
  local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
  local config = self.v_pool_config
  return config.DayLimitCnt == nil or pool_vo.day_limit_cnt + config.DrawCnt[idx] <= config.DayLimitCnt
end

function ui:_refresh_one_btn(idx)
  local pool_vo = DrawCardMgr:get_pool_vo(self.v_group_id, self.v_pool_id)
  if nil == pool_vo then
    return
  end
  local config = pool_vo:get_config()
  local element = self.v_draw_btn_elements[idx]
  local btn = element.btn
  local amount_txt = element.amount_txt
  local cnt_txt = element.cnt_txt
  local icon = element.icon
  if config.DrawCnt[idx] then
    btn.gameObject:SetActiveEx(true)
    local cost_res_cnt = config.CostCnt * config.DrawCnt[idx]
    if 2 == idx then
      self.v_uiobjects.AmountBefore:SetActiveEx(config.Discount < 1)
      self.v_uiobjects.DiscountTips:SetActiveEx(config.Discount < 1)
      self.v_uicompents.DiscountTipsTxt_txt.text = Util.format_str("{1}折", math.floor(config.Discount * 10))
      self.v_uicompents.AmountBefore_txt.text = "×" .. cost_res_cnt
      cost_res_cnt = math.floor(cost_res_cnt * config.Discount)
    end
    amount_txt.text = "×" .. cost_res_cnt
    if self:_is_res_enough_for_btn(idx) then
      amount_txt.color = Util.get_unity_color_by_hex(tonumber("ffffff", 16))
    else
      amount_txt.color = Util.get_unity_color_by_hex(tonumber("ffffff", 16))
    end
    local count_text = string.format("检索%d次", config.DrawCnt[idx])
    local cnt_Str = Util.format_str(count_text)
    cnt_txt.text = cnt_Str
    local item_config = ShareRes.get_item_cfg(config.CostId)
    local path = string.format("Icon/Item/%s", item_config.Icon)
    ResMgr:load_set_icon(icon, path)
  else
    btn.gameObject:SetActiveEx(false)
  end
  self:refresh_btn_status(btn, idx, pool_vo)
end

function ui:refresh_btn_status(btn, idx, pool_vo)
  local show_red = false
  local red_obj = Util.get_child_gameobj("RedPoint", btn.gameObject)
  if red_obj then
    red_obj:SetActiveEx(false)
  end
  local free_obj = Util.get_child_gameobj("Free", btn.gameObject)
  local not_free_obj = Util.get_child_gameobj("NotFree", btn.gameObject)
  if not free_obj or not not_free_obj then
    return
  end
  local ex_free_obj = self.v_uiobjects["BtnActFree" .. idx]
  if ex_free_obj then
    ex_free_obj:SetActiveEx(false)
  end
  local free_cnt = pool_vo.free_cnts[idx]
  local total_free_cnt = pool_vo:get_config().FreeCount[idx]
  local remain_free_ctn = total_free_cnt - free_cnt
  free_obj:SetActiveEx(remain_free_ctn > 0)
  not_free_obj:SetActiveEx(remain_free_ctn <= 0)
  self.v_btn_status_list[idx] = remain_free_ctn > 0
  if remain_free_ctn > 0 then
    local free_obj_text = Util.get_text("FreeText", free_obj)
    free_obj_text.text = 1 == remain_free_ctn and "本次免费" or Util.format_str("免费{1}次", remain_free_ctn)
  elseif ex_free_obj then
    local ex_free_times, is_daily_refresh = DrawCardMgr:get_free_draw_times(self.v_pool_config.LimitedTimeFreeId, idx)
    if 0 == ex_free_times then
      return
    end
    show_red = true
    ex_free_obj:SetActiveEx(true)
    not_free_obj:SetActiveEx(false)
    self.v_uiobjects["ActFreeTime" .. idx]:SetActiveEx(is_daily_refresh)
    self.v_uicompents["ActFreeText" .. idx .. "_txt"].text = Util.format_str("免费{1}次", ex_free_times)
    if is_daily_refresh then
      local server_time = Date.server_time()
      local next_day = Date.get_day_start(server_time + 86400)
      local day_left_time = next_day - server_time - 1
      if day_left_time > 0 then
        self.v_uicompents["ActFreeTime" .. idx .. "_txt"].text = Date.get_time_formate_2(day_left_time, true)
      end
    end
  end
  if red_obj then
    red_obj:SetActiveEx(show_red)
  end
end

function ui:_refresh_btns()
  self:_refresh_one_btn(1)
  self:_refresh_one_btn(2)
end

function ui:on_draw_choose_award_receive()
  self:refresh_choose_award()
end

function ui:refresh_choose_award()
  local choose_btn_obj = self.v_uiobjects.BtnChooseAward
  if not choose_btn_obj then
    return
  end
  local next_choose_config = DrawCardMgr:get_next_choose_config(self.v_pool_id)
  if not next_choose_config then
    choose_btn_obj:SetActive(false)
    return
  end
  choose_btn_obj:SetActive(true)
  local draw_count = DrawCardMgr:get_curr_card_pool_draw_count(self.v_pool_id)
  local is_can_choose = false
  if draw_count >= next_choose_config.Count then
    draw_count = next_choose_config.Count
    is_can_choose = true
  end
  self.v_uicompents.ProgressNow_txt.text = tostring(draw_count)
  self.v_uicompents.ProgressNeed_txt.text = tostring(next_choose_config.Count)
  self.v_uiobjects.BtnChooseAwardRed:SetActive(is_can_choose)
  self.v_uicompents.AwardBarFill_img.fillAmount = draw_count / next_choose_config.Count
  self.v_uiobjects.Fx_UI_BtnChooseAward:SetActive(is_can_choose)
  self:set_button("ChooseAwardBtn", function()
    UIMgr:get_ui("uidrawcard_choose_award"):ui_show(next_choose_config, draw_count, next_choose_config.Count, nil, self.v_group_id, self.v_pool_id)
  end)
end

function ui:refresh_purple_char()
  if not self.v_uiobjects.PurpleChar then
    return
  end
  local major_buddy_id = self.v_pool_config.MajorBuddy
  local show_buddys = self.v_pool_config.BuddyId
  self.v_uiobjects.PurpleChar:SetActive(nil ~= major_buddy_id)
  if major_buddy_id then
    for idx, buddy_id in ipairs(show_buddys) do
      local obj = self.v_uiobjects["PurpleCharBtn" .. idx]
      if obj then
        obj:SetActive(0 ~= buddy_id)
        if 0 ~= buddy_id then
          ResMgr:load_set_icon(self.v_uicompents["PurpleCharIcon" .. idx .. "_img"], UtilUI.get_hero_images(buddy_id, 2))
        end
      end
    end
  end
end

function ui:on_click_purple_char_btn(idx)
  local show_buddy = self.v_pool_config.BuddyId[idx] or 0
  if 0 ~= show_buddy then
    Player_Hero_Helper.build_fake_buddy(show_buddy)
    UIMgr:get_ui("player_hero"):ui_show()
  end
end

function ui:ui_on_update(delta_time)
  if not self.v_cache_second then
    self.v_cache_second = 0
  end
  self.v_cache_second = self.v_cache_second + delta_time
  if self.v_cache_second < 2 then
    return
  end
  self.v_cache_second = 0
  if self.v_daily_free_act_start_time and self.v_daily_free_act_end_time and self.v_daily_free_act_end_time > 0 then
    local server_time = Date.server_time()
    local is_in_act = server_time > self.v_daily_free_act_start_time and server_time < self.v_daily_free_act_end_time
    local act_left_time = is_in_act and self.v_daily_free_act_end_time - server_time or 0
    if self.v_uiobjects.FreeDrawTips then
      self.v_uiobjects.FreeDrawTips:SetActiveEx(is_in_act)
      if is_in_act then
        self.v_uicompents.FreeDrawTime_txt.text = Date.get_time_desc(act_left_time, true, true)
      end
    end
    if self.v_daily_free_act_state ~= is_in_act then
      self.v_daily_free_act_state = is_in_act
      self:_refresh_btns()
    end
    if is_in_act then
      local next_day = Date.get_day_start(server_time + 86400)
      local day_left_time = next_day - server_time - 1
      if day_left_time > 0 and self.v_uicompents.ActFreeTime1_txt then
        local str = Date.get_time_formate_2(day_left_time, true)
        self.v_uicompents.ActFreeTime1_txt.text = str
        self.v_uicompents.ActFreeTime2_txt.text = str
      end
    end
  end
end

return ui
