local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_currency_obj = {
    "CurrencyObj",
    BIND_TYPE.OBJECT
  },
  v_exit_obj = {
    "ExitObj",
    BIND_TYPE.BUTTON
  },
  v_max_ring_num = {
    "MaxRingNum",
    BIND_TYPE.TEXT
  },
  v_now_ring_num = {
    "NowRingNum",
    BIND_TYPE.TEXT
  },
  v_now_round_num = {
    "NowRoundNum",
    BIND_TYPE.TEXT
  },
  v_reward_show_obj = {
    "RewardShowObj",
    BIND_TYPE.BUTTON
  },
  v_ring_num_obj = {
    "RingNumObj",
    BIND_TYPE.OBJECT
  },
  v_round_num_obj = {
    "RoundNumObj",
    BIND_TYPE.OBJECT
  },
  v_save_and_exit_obj = {
    "SaveAndExitObj",
    BIND_TYPE.BUTTON
  },
  vinterval = {
    "interval",
    BIND_TYPE.TEXT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("ExitObj", function()
    self:exit_and_show_settlement()
  end)
  self:set_button("RewardShowObj", function()
    self:show_award()
  end)
  self:set_button("SaveAndExitObj", function()
    self:save_and_exit()
  end)
end

function ui:ui_on_show()
  local tower = TowerMgr:get_tower()
  local tower_id = tower:get_tower_id()
  local ring_by_tower = ShareRes.create("activity.rings_of_challenge_ring_by_tower", tower_id)
  local now_round = ChallengeRingMgr:get_cur_round()
  local now_ring_num = ChallengeRingMgr:get_cur_ring_num()
  self.v_now_ring_num.text = now_ring_num
  self.v_max_ring_num.text = #ring_by_tower
  self.v_now_round_num.text = now_round
  self.v_uiobjects.PassTowerObj:SetActive(false)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:save_and_exit()
  self:ui_hide()
  
  local function cb()
    Global.scene_mgr:on_enter_main_scene()
    UIMgr:revert_cache_ui()
  end
  
  if TowerMgr then
    TowerMgr:on_exit_tower(cb)
  end
end

function ui:exit_and_show_settlement()
  UIMgr:get_ui("ui_challenge_ring"):ui_hide()
  UIMgr:get_ui("fight_settlement"):ui_show()
end

function ui:show_award()
  local award_list = ChallengeRingMgr:get_cur_ring_award()
  if not award_list or not next(award_list) then
    Util.show_message_tip(2281)
    return
  end
  UIMgr:get_ui("award_show_panel"):ui_show(award_list)
end

return ui
