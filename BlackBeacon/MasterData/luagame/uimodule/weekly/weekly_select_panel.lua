local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local _sformat = string.format
local MODEL = {}
local HURDLE_ITEM_KEY = "HURDLE_ITEM_KEY"
local POS_PREFIX = "StagePos"
local LOCK_TIP1 = "通关%s后解锁"
local LOCK_TIP2 = "【%s】%s星后解锁"
local WEEKLY_CFG = require("gamelogic.weekly.weekly_config")
local RANK_TYPE = WEEKLY_CFG.RANK_TYPE

function ui:on_click_award_btn()
  local task_group_id = ShareRes.get_weekly_prepare_war_epi_task_group_id()
  if not task_group_id then
    Log.Error("获取周常备战任务组失败")
    return
  end
  UIMgr:get_ui("chapter_task"):ui_show(nil, task_group_id, "星级奖励", true)
end

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    UIMgr:go_to_main()
  end)
  self:set_button("BtnRule", function()
    UIMgr:get_ui("weekly_rule"):ui_show()
  end)
  self:set_button("BtnShop", function()
    local main_cfg = ShareRes.get_weekly_pvp_activity_cfg()
    if Util.is_more_than_zero(main_cfg.ShopId) then
      SysOpenMgr:jump_to_sys(main_cfg.ShopId, true)
    end
  end)
  self:set_button("BtnStageAward", function()
    self:on_click_award_btn()
  end)
  self:set_button("BtnPVP", function()
    self:click_pvp_btn()
  end)
  self:set_button("BtnLock", function()
    local cfg = ShareRes.get_weekly_pvp_activity_cfg()
    local condition = ShareRes.create("condition.condition", cfg.Condition)
    Util.show_message_tip(condition.Desc)
  end)
  self:register_exist_auto_template(HURDLE_ITEM_KEY, self.v_uiobjects.StageTem, self.v_uiobjects.HurdleContent)
end

function ui:click_pvp_btn()
  if not WeeklyMgr:check_weekly_pvp_opn() then
    return
  end
  UIMgr:get_ui("weekly_pvp_detail_stage1"):ui_show()
end

function ui:cache_ui()
  return true
end

function ui:ui_update()
end

function ui:ui_on_show()
  self.is_need_show_pvp_unlock_tip = false
  WeeklyMgr:set_battle_type(1)
  self.v_hurdle_list = {}
  self:bind_auto_mq(Const.MSG_ON_WEEKLY_REFRESH_HURDLE_DATA, self.refresh_hurdle_data, self)
  self:bind_auto_mq(Const.MSG_ON_WEEKLY_GET_STAR_REWARD_SUC, self.update_star_reward_info, self)
  self:bind_auto_mq(Const.MSG_ON_AWARD_SHOW_PANEL_HIDE, self.check_pvp_unlock_tip, self)
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.update_star_reward_info, self)
  self:init_hurdle_view()
  self:update_pvp_open_state()
end

function ui:ui_on_hide()
  self.is_need_show_pvp_unlock_tip = false
end

function ui:update_pvp_open_state()
  local is_open = WeeklyMgr:check_weekly_pvp_opn()
  self.v_uiobjects.UnlockPd:SetActive(false)
  if not is_open or false == is_open then
    self.v_uiobjects.LoopPd:SetActive(false)
    self.v_uiobjects.BtnLock:SetActive(true)
    self.v_uiobjects.BtnPVP:SetActive(false)
    self.v_uiobjects.PVPUnlockCondition:SetActive(true)
    return
  end
  local mine_rank_data = WeeklyMgr:get_mine_rank()
  if mine_rank_data and 0 == mine_rank_data.value and 0 == WeeklyMgr:get_week_activity_pvp_opened() then
    local award_show_ui = UIMgr:try_get_ui("award_show_panel")
    if award_show_ui then
      if false == award_show_ui.v_object.activeSelf then
        self:play_unlock_effect()
      else
        self.is_need_show_pvp_unlock_tip = true
      end
    else
      self:play_unlock_effect()
    end
  end
  self.v_uiobjects.LoopPd:SetActive(not self.is_need_show_pvp_unlock_tip)
  self.v_uiobjects.BtnLock:SetActive(false)
  self.v_uiobjects.BtnPVP:SetActive(true)
  self.v_uiobjects.PVPUnlockCondition:SetActive(false)
end

function ui:check_pvp_unlock_tip()
  if self.is_need_show_pvp_unlock_tip ~= nil and self.is_need_show_pvp_unlock_tip == true then
    self:play_unlock_effect()
    self.is_need_show_pvp_unlock_tip = false
  end
end

function ui:play_unlock_effect()
  self.v_uicompents.LoopPd_pd:ResetPD()
  self.v_uiobjects.UnlockPd:SetActive(true)
  self.v_uicompents.UnlockPd_pd:ResetPD()
  self.v_uicompents.UnlockPd_pd:Play()
  WeeklyMgr:set_week_activity_pvp_opened(1)
end

function ui:init_hurdle_view()
  local all_hurdle_cfg = ShareRes.get_weekly_prepare_war()
  if not all_hurdle_cfg then
    return
  end
  self:give_back_auto_cache(HURDLE_ITEM_KEY)
  self.v_is_show_red = false
  for idx, cfg in ipairs(all_hurdle_cfg) do
    local item = self:get_auto_cache(HURDLE_ITEM_KEY)
    self:update_hurdle_info(item, cfg)
    self.v_hurdle_list[cfg.EpiID] = item
  end
  self:update_star_reward_info()
end

function ui:update_hurdle_info(item, cfg)
  local name = cfg.EpiName
  local name_txt_obj = Util.get_text("StageNum", item)
  name_txt_obj.text = name
  local bg_res = cfg.BgRes
  local bg_path = WEEKLY_CFG.TEXTURE_PATH .. bg_res
  local bg_img_obj = Util.get_image("Icon", item)
  ResMgr:load_set_icon(bg_img_obj, bg_path, nil, true, self)
  local lock_obj = Util.get_child_gameobj("Lock", item)
  local is_lock = WeeklyMgr:check_hurdle_lock(cfg.EpiID)
  lock_obj:SetActive(is_lock)
  local bg1 = Util.get_child_gameobj("Bg1", item)
  Util.apply_grey_ex(bg1.gameObject, is_lock)
  local score_txt_obj = Util.get_text("ScoreLayout/Score", item)
  local score_val = WeeklyMgr:get_hurdle_score(cfg.EpiID)
  score_txt_obj.text = score_val
  local star_map = WeeklyMgr:get_hurdle_star_map(cfg.EpiID)
  local is_need_gray = true
  local star_count = 0
  for idx = 1, 3 do
    local star_obj = Util.get_child_gameobj("Star" .. idx, item)
    star_obj:SetActive(not is_lock)
    local value = star_map[idx]
    local star_light_obj = Util.get_child_gameobj("Light" .. idx, item)
    star_light_obj:SetActive(value)
    if value then
      star_count = star_count + 1
    end
    if true == is_need_gray and true == value then
      is_need_gray = false
    end
  end
  self:refresh_effect(item, not is_lock and 0 == star_count)
  local pos_name = POS_PREFIX .. cfg.Pos
  local parent = self.v_uiobjects[pos_name]
  if parent then
    item.transform:SetParent(parent.transform)
    item.transform.localPosition = UnityVector3.zero
  end
  local fight_btn = Util.get_button(nil, item)
  self:set_button_listener(fight_btn, function()
    if is_lock then
      local str = self:get_lock_condition_text(item, cfg)
      if str then
        Util.show_message_tip(str)
      end
      return
    end
    UIMgr:get_ui("weekly_battle_detail"):ui_show(cfg.EpiID)
  end)
  self.v_uicompents.StarNow_txt.text = WeeklyMgr:get_now_star()
  self.v_uicompents.StarMax_txt.text = WeeklyMgr:get_total_star()
end

function ui:refresh_effect(obj, visible)
  local anim_obj = Util.get_child_gameobj("Animation", obj)
  local effect_obj = Util.get_child_gameobj("Icon/Fx_WeekAct1_StageList", obj)
  anim_obj:SetActive(visible)
  effect_obj:SetActive(visible)
end

function ui:get_lock_condition_text(item, cfg)
  local condition_epi_id = cfg.UnLockEpiId
  local tip
  local is_return = false
  if condition_epi_id and 0 ~= condition_epi_id then
    local condition_epi_cfg = ShareRes.get_weekly_hundle_cfg(condition_epi_id)
    local is_first_suc = WeeklyMgr:check_hurdle_first_suc(condition_epi_id)
    if is_first_suc then
      tip = _sformat(LOCK_TIP1, condition_epi_cfg.EpiName)
      is_return = true
    end
    local star_map = WeeklyMgr:get_hurdle_star_map(cfg.EpiID)
    local condition_start = cfg.UnLockEpiStar
    if condition_start and not star_map[condition_start] then
      if condition_start > 1 then
        tip = _sformat(LOCK_TIP2, condition_epi_cfg.EpiName, condition_start)
      else
        tip = "通关前置关卡"
      end
      is_return = true
    end
  end
  if is_return then
    return tip
  end
  local condition_id = cfg.OpenCondition
  if not Condition:check_condition(condition_id) then
    tip = ShareRes.get_condition_desc(condition_id)
  end
  return tip
end

function ui:refresh_award_icon_status(item, is_need_gray)
  local icon = Util.get_image("BtnStarAward/AwardUnlock/Icon", item)
  if nil ~= icon then
    Util.apply_grey_ex(icon.gameObject, is_need_gray)
  end
end

function ui:update_star_reward_info()
  local task_group_id = ShareRes.get_weekly_prepare_war_epi_task_group_id()
  if not task_group_id then
    Log.Error("获取周常备战任务组失败")
    return
  end
  self.v_is_show_red = TaskMgr:get_task_group_red(task_group_id)
  self.v_uiobjects.AwardRedpoint:SetActive(self.v_is_show_red)
end

function ui:refresh_hurdle_data(msg)
  local idx = msg.mm_obj
  local item = self.v_hurdle_list[idx]
  if not item then
    return
  end
  local cfg = ShareRes.get_weekly_hundle_cfg(idx)
  Util.assert(cfg, "缺少周常关卡配置" .. idx)
  self.v_is_show_red = false
  self:update_hurdle_info(item, cfg)
  self.v_uiobjects.AwardRedpoint:SetActive(self.v_is_show_red)
end

return ui
