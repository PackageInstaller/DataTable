local Base = require("ui.uiobject")
local CommonDef = require("cs_share.common_define")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local ui = Util.create_child_mt(Base)
local ACTY_TYPE = CommonDef.ACTY_TYPE
local ST_INFO_WIDTH = 600
local BSET_FIGHT_STAGE_STATE = {
  LOCK = 1,
  CHALLENGE = 2,
  PASS = 3
}
local OVERLAY_STATE = {NONE = 1, CHANGE = 2}

function ui:ui_finish_load()
end

function ui:ui_on_show(point_id, chapter_id, fight_type, index)
  self.v_point_id = point_id
  self.v_chapter_id = chapter_id
  self.v_point_cfg = ShareRes.get_chapter_point_cfg(point_id)
  self.v_chapter_cfg = ShareRes.get_chapter_cfg(self.v_chapter_id)
  self.v_fight_type = fight_type
  self.v_index = index
  self:refresh_mark_state(false)
  self:load_chapter_bg()
  self:refresh_chapter_index()
  self:refresh_chapter_state()
  self:refresh_chapter_name()
  self:refresh_point_type_icon()
  self:refresh_lock_state()
  self:refresh_best_fight_score()
  local btn = Util.get_button(nil, self.v_object)
  self:set_button_listener(btn, function()
    if self.v_is_lock == false then
      self:click_stage_tem()
    else
      self:show_lock_info()
    end
  end)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh_mark_state(is_visible)
  local mark_img = Util.get_child_gameobj("IconNow", self.v_uiobjects.StNow)
  mark_img:SetActive(is_visible)
end

function ui:load_chapter_bg()
  if not self.v_chapter_id then
    return
  end
  local bg_path = self.v_point_cfg.PointBgPath
  local img = self.v_uicompents.StBg_img
  ResMgr:load_set_icon(img, bg_path, nil, true)
end

function ui:refresh_chapter_name()
  local name_txt = self.v_uicompents.StName_txt
  local name = self.v_point_cfg.PointName
  name_txt.text = name
end

function ui:refresh_chapter_index()
  if not self.v_chapter_id then
    return
  end
  local index_txt = self.v_uicompents.StNum_txt
  local index = self.v_point_cfg.SerialNum
  index_txt.text = index
end

function ui:refresh_point_type_icon()
  local point_cfg = self.v_point_cfg
  local fight_obj = self.v_uiobjects.StFight
  local story_obj = self.v_uiobjects.StStory
  fight_obj:SetActive(point_cfg.PointType == CHAPTER_CONFIG.POINT_TYPE.FIGHT)
  story_obj:SetActive(point_cfg.PointType == CHAPTER_CONFIG.POINT_TYPE.STORY)
end

function ui:click_stage_tem()
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SELECT_STAGE_TEM)
  msg.mm_x = self.v_point_id
  if 1 == self.v_chapter_cfg.ChapterType then
    local item_rect
    local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
    if point_cfg.PointType == CHAPTER_CONFIG.POINT_TYPE.FIGHT then
      item_rect = Util.get_rect_transform(nil, self.v_uiobjects.StBg)
    elseif point_cfg.PointType == CHAPTER_CONFIG.POINT_TYPE.STORY then
      item_rect = Util.get_rect_transform(nil, self.v_uiobjects.StCom)
    end
    local position = item_rect.position
    local screen_x = UIMgr.root_camera:WorldToScreenPoint(position).x
    local screen_y = UIMgr.root_camera:WorldToScreenPoint(position).y
    local half_width = item_rect.rect.width / 2
    if screen_x - half_width < 0 or screen_x + half_width + ST_INFO_WIDTH > Global.screen_width then
      msg.mm_y = OVERLAY_STATE.CHANGE
    else
      msg.mm_y = OVERLAY_STATE.NONE
    end
    msg.mm_z = self.v_index
  end
end

function ui:refresh_chapter_state()
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.BEST_CONF then
    self:_refresh_best_point_state()
  else
    self:_refresh_chapter_point_state()
  end
end

function ui:_refresh_best_point_state()
  local front_id = self.v_point_cfg.FrontPointId
  local show = self:_get_stage_state(self.v_point_id, front_id) == BSET_FIGHT_STAGE_STATE.PASS
  local complete_obj = self.v_uiobjects.StCom
  complete_obj:SetActive(show)
  self.v_uiobjects.ComMask1:SetActive(show)
  self.v_uiobjects.ComMask2:SetActive(show)
end

function ui:_refresh_chapter_point_state()
  local no_first_suc = ChapterMgr:check_no_first_suc_by_point_id(self.v_chapter_id, self.v_point_id)
  local complete_obj = self.v_uiobjects.StCom
  complete_obj:SetActive(not no_first_suc)
  self.v_uiobjects.ComMask1:SetActive(not no_first_suc)
  self.v_uiobjects.ComMask2:SetActive(not no_first_suc)
end

function ui:refresh_lock_state()
  if not self.v_uiobjects.Lock then
    return
  end
  if self.v_fight_type == CommonDef.CHALLENGE_TYPE.BEST_CONF then
    self:_refresh_best_lock_state()
  else
    self.v_uiobjects.Lock:SetActive(self.v_is_lock)
  end
end

function ui:_refresh_best_lock_state()
  local front_id = self.v_point_cfg.FrontPointId
  local show = self:_get_stage_state(self.v_point_id, front_id) == BSET_FIGHT_STAGE_STATE.LOCK
  self.v_uiobjects.Lock:SetActive(show)
  local canvas_group = self:get_canvas_group(nil, self.v_object)
  canvas_group.alpha = show and 0.3 or 1
end

function ui:set_self_lock(is_lock)
  self.v_is_lock = is_lock
end

function ui:show_lock_info()
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  local conditon_cfg = ShareRes.create("condition.condition", point_cfg.Condition)
  Util.show_message_tip(conditon_cfg.Desc)
end

function ui:_get_stage_state(stage_id, front_id)
  if front_id > 0 then
    local state = ActivityMgr:invoke(ACTY_TYPE.BEST_CONFIG_FIGHT, "get_stage_state", front_id)
    if state == BSET_FIGHT_STAGE_STATE.PASS then
      return ActivityMgr:invoke(ACTY_TYPE.BEST_CONFIG_FIGHT, "get_stage_state", stage_id)
    end
    return BSET_FIGHT_STAGE_STATE.LOCK
  else
    return ActivityMgr:invoke(ACTY_TYPE.BEST_CONFIG_FIGHT, "get_stage_state", stage_id)
  end
end

function ui:refresh_best_fight_score()
  if not self.v_uiobjects.Score then
    return
  end
  self.v_uiobjects.Score:SetActive(self.v_fight_type == CommonDef.CHALLENGE_TYPE.BEST_CONF)
  if self.v_fight_type ~= CommonDef.CHALLENGE_TYPE.BEST_CONF then
    return
  end
  local front_id = self.v_point_cfg.FrontPointId
  local show = self:_get_stage_state(self.v_point_id, front_id)
  self.v_uiobjects.Score:SetActive(show == BSET_FIGHT_STAGE_STATE.PASS)
  if show == BSET_FIGHT_STAGE_STATE.PASS then
    self.v_uicompents.PTScore_txt.text = ActivityMgr:invoke(ACTY_TYPE.BEST_CONFIG_FIGHT, "get_stage_score", self.v_point_id)
  end
end

return ui
