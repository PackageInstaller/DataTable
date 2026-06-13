local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")

function ui:ui_finish_load()
  self:set_button("BtnContinue", function()
    self:on_click_continue_floor()
  end)
  self:set_button("BtnSettle", function()
    self:on_click_settle_btn()
  end)
end

function ui:on_click_settle_btn()
  local fight_info = TowerMgr:get_fight_info()
  if not fight_info then
    return
  end
  local fight_type = fight_info.type
  self:_exit_tower(fight_type)
end

function ui:on_click_continue_floor()
  if not self.v_callback then
    return
  end
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local wait_hero_list = SceneMgr:get_wait_hero()
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_FLOOR_FINISHED, Global.hero, wait_hero_list[1], wait_hero_list[2], tower:get_floor_num())
  self.v_callback()
  MsgGame:mq_publish2(Const.MSG_ON_ENTER_NEW_FLOOR)
  MsgGame:mq_publish2(Const.MSG_PRE_TP_ROOM)
  self:ui_hide()
end

function ui:ui_on_show(_, cb, _)
  self.v_callback = cb
  local tower = TowerMgr:get_tower()
  local progress = TowerMgr:get_tower_progress()
  local point_id = progress.episode_id
  local infinite_id = ShareRes.get_infinite_id_by_point_id(point_id)
  local point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  local max_floor = tower:get_max_floor()
  local str = string.format("已通关第<color=#ec7f00>%d</color>/%d层", tower:get_floor_num(), max_floor)
  self.v_uicompents.StageName_txt.text = point_cfg.PointName
  self.v_uicompents.Tips_txt.text = str
  local cur_score = progress.infinite_progress.score or 0
  self.v_uicompents.ScoreNow_txt.text = cur_score
  local data = ChapterMgr:get_inf_chapter_data(infinite_id)
  local max_score = data and data.history_max_score or 0
  self.v_uicompents.ScoreRecord_txt.text = max_score
  self.v_uiobjects.NewRecord:SetActive(cur_score > max_score)
end

function ui:ui_on_hide()
  self.v_callback = nil
end

function ui:ui_on_destroy()
end

function ui:_exit_tower(fight_type)
  local tip = Util.format_str("是否立即退出关卡")
  local sure_btn = Util.format_str("中继保存")
  local cancel_btn = Util.format_str("直接结算")
  
  local function sure_callback()
    self:ui_hide()
    
    local function cb()
      Global.scene_mgr:on_enter_main_scene()
      UIMgr:revert_cache_ui()
    end
    
    if TowerMgr then
      TowerMgr:on_exit_tower(cb)
    end
  end
  
  local function cancel_callback()
    UIMgr:get_ui("endless_settle"):ui_show(CHAPTER_CONFIG.POINTSTATE.quit)
  end
  
  local uinotice_tips = UIMgr:get_ui("uinotice_tips")
  uinotice_tips:ui_show(sure_callback, cancel_callback, tip, sure_btn, cancel_btn)
  uinotice_tips:enable_bg_click(true)
end

return ui
