local Base = require("ui.uibase")
local POINT_VIEW_CLASS = require("uimodule.stage_activity.online_battle.online_point_view")
local commonDef = require("cs_share.common_define")
local OnlineHelper = require("uimodule.stage_activity.online_battle.online_battle_helper")
local ui = Util.create_child_mt(Base)
local POINT_PATH = "prefab/ChapterPoint/OnlinePoint.prefab"
local Act_ID = commonDef.ACTY_TYPE.ONLINE_BATTLE
local STAGE_STATE = {
  LOCK = 1,
  CHALLENGE = 2,
  PASS = 3
}

function ui:ui_finish_load()
  self:set_button("BtnReturn", function()
    self:_onclick_close_btn()
  end)
  self.v_notice_rect = self:get_rect_transform(nil, self.v_uiobjects.MathingNotice)
end

function ui:ui_on_show(...)
  self.v_uiobjects.MathingNotice:SetActive(false)
  self:init_point_obj()
  self:_regist_client_event()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_SELECT_STAGE_TEM, self._response_click_point_event, self)
  self:bind_auto_mq(Const.MSG_ON_ENTER_MATCH_QUEUE, self._response_enter_match_event, self)
end

function ui:ui_on_hide()
  if self.v_chapter_point_lua_obj then
    self:remove_wrap_ui(self.v_chapter_point_lua_obj)
  end
  if self.v_chapter_point_obj then
    ResMgr:destroy_gameobj(self.v_chapter_point_obj)
    self.v_chapter_point_obj = nil
  end
  if self.v_notice_seqence then
    self.v_notice_seqence:Kill()
    self.v_notice_seqence = nil
  end
end

function ui:init_point_obj()
  local path = Path.get_language_full_prefab_path(POINT_PATH)
  local chapter_point_obj = ResMgr:load_gameobj(path)
  chapter_point_obj.transform:SetParent(self.v_uiobjects.PointParent.transform, false)
  self.v_chapter_point_obj = chapter_point_obj
  self.v_set_center_time = 0
  self:_set_point_info()
end

function ui:_set_point_info()
  if not self.v_chapter_point_obj then
    return
  end
  if self.v_chapter_point_lua_obj then
    self:remove_wrap_ui(self.v_chapter_point_lua_obj)
  end
  local chapter_cfg = ShareRes.create("activity.online_battle", 1)
  self.v_chapter_point_lua_obj = POINT_VIEW_CLASS:ui_wrap_ex(self, self.v_chapter_point_obj, false)
  self.v_chapter_point_lua_obj:set_enable(true, nil, chapter_cfg.EpisodeIds, nil)
end

function ui:_response_click_point_event(msg)
  local game_open = ActivityMgr:get_game_is_open(Act_ID)
  if not game_open then
    Util.show_message_tip(2280)
    return
  end
  local point_id = msg.mm_x
  local stage_cfg = ShareRes.get_chapter_point_cfg(point_id)
  if stage_cfg.FrontPointId > 0 and not ActivityMgr:invoke(Act_ID, "get_has_pass_point", stage_cfg.FrontPointId) then
    local str = Util.format_str("请先完成{1}关", ShareRes.get_chapter_point_cfg(stage_cfg.FrontPointId).PointName)
    UIMgr:get_ui("uimessagetip"):ui_show(str)
  else
    UIMgr:get_ui("online_battle_point_detail"):ui_show(point_id)
  end
end

function ui:_response_enter_match_event()
  self.v_uiobjects.MathingNotice:SetActive(true)
  self.v_notice_rect:SetLocalScaleA(0.5, 0.1, 1)
  self.v_notice_seqence = Util.create_sequence()
  self.v_notice_seqence:SetUpdate(true)
  self.v_notice_seqence:Append(self.v_notice_rect:DOScaleX(1, 0.1))
  self.v_notice_seqence:AppendInterval(0.1)
  self.v_notice_seqence:Append(self.v_notice_rect:DOScaleY(1, 0.1))
  self.v_notice_seqence:AppendInterval(1)
  self.v_notice_seqence:Append(self.v_notice_rect:DOScaleY(0.1, 0.1))
  self.v_notice_seqence:AppendInterval(0.1)
  self.v_notice_seqence:Append(self.v_notice_rect:DOScaleX(0.5, 0.1))
  self.v_notice_seqence:OnComplete(function()
    self.v_uiobjects.MathingNotice:SetActive(false)
  end)
end

function ui:_onclick_close_btn()
  local in_matching = ActivityMgr:invoke(Act_ID, "get_in_matching")
  if in_matching then
    OnlineHelper.quit_match(self)
    return
  end
  local in_room = ActivityMgr:invoke(Act_ID, "get_match_room_info") ~= nil
  if in_room then
    OnlineHelper.quit_room(self)
    return
  end
  self:ui_hide()
end

function ui:cache_ui()
  return true
end

return ui
