local Base = require("ui.uibase")
local commonDef = require("cs_share.common_define")
local POINT_VIEW_CLASS = require("uimodule.chapter.chapter_point_view")
local ui = Util.create_child_mt(Base)
local POINT_PATH = "prefab/ChapterPoint/TopVerPoint.prefab"
local Act_ID = commonDef.ACTY_TYPE.BEST_CONFIG_FIGHT
local STAGE_STATE = {
  LOCK = 1,
  CHALLENGE = 2,
  PASS = 3
}
local TASK_STATE = {
  NOT_RECEIVE = 0,
  CAN_RECEIVE = 1,
  RECEIVE = 2,
  COMPLETE = 3,
  GET_REWARD = 4
}
local TASK_RED_ID = 27

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self:set_button("BtnTask", function()
    UIMgr:get_ui("top_ver_task"):ui_show()
  end)
end

function ui:ui_on_show()
  self:init_point_obj()
  self:_refresh_task_info()
  self:_regist_client_event()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_SELECT_STAGE_TEM, self.response_click_point_event, self)
end

function ui:ui_on_hide()
  if self.v_chapter_point_lua_obj then
    self:remove_wrap_ui(self.v_chapter_point_lua_obj)
  end
  if self.v_chapter_point_obj then
    ResMgr:destroy_gameobj(self.v_chapter_point_obj)
    self.v_chapter_point_obj = nil
  end
end

function ui:init_point_obj()
  local path = Path.get_language_full_prefab_path(POINT_PATH)
  local chapter_point_obj = ResMgr:load_gameobj(path)
  chapter_point_obj.transform:SetParent(self.v_uiobjects.PointParent.transform, false)
  self.v_chapter_point_obj = chapter_point_obj
  self.v_scroll_rect = Util.get_scrollrect(nil, chapter_point_obj)
  self:_set_point_info()
end

function ui:_set_point_info()
  if not self.v_chapter_point_obj then
    return
  end
  if self.v_chapter_point_lua_obj then
    self:remove_wrap_ui(self.v_chapter_point_lua_obj)
  end
  local game_id = ActivityMgr:invoke(Act_ID, "get_game_id")
  local list = ShareRes.create("activity.best_config_fight_main", game_id)
  self.v_chapter_point_lua_obj = POINT_VIEW_CLASS:ui_wrap_ex(self, self.v_chapter_point_obj, false)
  self.v_chapter_point_lua_obj:set_enable(true, nil, list.EpisodeIds, commonDef.CHALLENGE_TYPE.BEST_CONF)
  local last_idx = 0
  for i, v in ipairs(list.EpisodeIds) do
    if self:_get_stage_state(v, 0) == STAGE_STATE.PASS then
      last_idx = i
    end
  end
  self.v_scroll_rect.horizontalNormalizedPosition = last_idx / #list.EpisodeIds
end

function ui:_refresh_task_info()
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.TaskRed, TASK_RED_ID)
  local cfg = ShareRes.create("activity.best_config_task")
  local cur = 0
  local total = 0
  for _, v in pairs(cfg) do
    total = total + 1
    local state = TaskMgr:get_task_state(v.Id)
    if state >= TASK_STATE.COMPLETE then
      cur = cur + 1
    end
  end
  self.v_uicompents.Progress_txt.text = string.format("%s/%s", cur, total)
end

function ui:response_click_point_event(msg)
  local game_open = ActivityMgr:get_game_is_open(Act_ID)
  if not game_open then
    Util.show_message_tip(2280)
    return
  end
  local stage_cfg = ShareRes.get_chapter_point_cfg(msg.mm_x)
  local state = self:_get_stage_state(stage_cfg.Id, stage_cfg.FrontPointId)
  if state == STAGE_STATE.LOCK then
    if stage_cfg.FrontPointId and stage_cfg.FrontPointId > 0 then
      local str = Util.format_str("请先完成{1}关", ShareRes.get_chapter_point_cfg(stage_cfg.FrontPointId).PointName)
      UIMgr:get_ui("uimessagetip"):ui_show(str)
    end
  else
    UIMgr:get_ui("top_ver_team"):ui_show(ShareRes.create("activity.best_config_fight_episode", msg.mm_x))
  end
  self.v_chapter_point_lua_obj:response_select_stage_tem(msg)
end

function ui:_get_stage_state(stage_id, front_id)
  if front_id > 0 then
    local state = ActivityMgr:invoke(Act_ID, "get_stage_state", front_id)
    if state == STAGE_STATE.PASS then
      return ActivityMgr:invoke(Act_ID, "get_stage_state", stage_id)
    end
    return STAGE_STATE.LOCK
  else
    return ActivityMgr:invoke(Act_ID, "get_stage_state", stage_id)
  end
end

function ui:cache_ui()
  return true
end

return ui
