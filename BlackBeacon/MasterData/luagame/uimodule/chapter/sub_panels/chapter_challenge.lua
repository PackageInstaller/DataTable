local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local commonDef = require("cs_share.common_define")
local ACTY_TYPE = commonDef.ACTY_TYPE
local ActivityCfg = require("gamelogic.activity.activity_config")
local ACTY_TYPE_TO_SYSID = ActivityCfg.ACTY_TYPE_TO_SYSID
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local ENDLESS_SYS_ID = 8
local BUDDY_TEACH_SYS_ID = ACTY_TYPE_TO_SYSID[ACTY_TYPE.BUDDY_TEACH]
local LINEAR_SYS_ID = 49
local BOSS_CHALLENGE_SYS_ID = 64
local CHALLENGE_TYPE_TO_BTN_INDEX = {
  [commonDef.CHALLENGE_TYPE.BUDDY_TEACH] = 1,
  [commonDef.CHALLENGE_TYPE.INFINITE] = 2,
  [commonDef.CHALLENGE_TYPE.LINEAR] = 3,
  [commonDef.CHALLENGE_TYPE.BOSS] = 4
}
local BTN_COUNT = UtilTable.hash_lenth(CHALLENGE_TYPE_TO_BTN_INDEX)

function ui:ui_finish_load()
  self:init_content_layout()
  self:set_button("HeroTeacing", function()
    if SysOpenMgr:get_sys_is_open(BUDDY_TEACH_SYS_ID, true) then
      UIMgr:get_ui("hero_skill_teach"):ui_show()
      ChapterMgr:set_record_select_challenge_type(commonDef.CHALLENGE_TYPE.BUDDY_TEACH)
    end
  end)
  self:set_button("Endless", function()
    if SysOpenMgr:get_sys_is_open(ENDLESS_SYS_ID, true) then
      UIMgr:get_ui("endless_main"):ui_show()
      ChapterMgr:set_record_select_challenge_type(commonDef.CHALLENGE_TYPE.INFINITE)
    end
  end)
  self:set_button("Pendant", function()
    if SysOpenMgr:get_sys_is_open(LINEAR_SYS_ID, true) then
      UIMgr:get_ui("ui_linear_main"):ui_show()
      ChapterMgr:set_record_select_challenge_type(commonDef.CHALLENGE_TYPE.LINEAR)
    end
  end)
  self:set_button("BossChallenge", function()
    if SysOpenMgr:get_sys_is_open(BOSS_CHALLENGE_SYS_ID, true) then
      UIMgr:get_ui("boss_challenge_main"):ui_show()
      ChapterMgr:set_record_select_challenge_type(commonDef.CHALLENGE_TYPE.BOSS)
    end
  end)
  self.v_content_rect = self.v_uicompents.Content_rect
  local scroll_rect = self.v_uicompents.ScrollView_rect:GetComponent(typeof(UnityEngine.UI.ScrollRect))
  self:set_scrollrect_listener(scroll_rect, function()
    local width = self.v_content_rect:GetSizeDeltaA()
    local pos = self.v_content_rect.anchoredPosition.x
    self.v_uiobjects.ScrollTip:SetActiveEx(width + pos > 100)
  end)
end

function ui:ui_on_show()
  self:_regist_client_event()
  self:refresh_sys_open()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_NEW_SYS_OPEN, self.refresh_sys_open, self)
end

function ui:refresh_sys_open()
  local teach_open = SysOpenMgr:get_sys_is_open(BUDDY_TEACH_SYS_ID)
  local endless_open = SysOpenMgr:get_sys_is_open(ENDLESS_SYS_ID)
  local linear_open = SysOpenMgr:get_sys_is_open(LINEAR_SYS_ID)
  local boss_challenge_open = SysOpenMgr:get_sys_is_open(BOSS_CHALLENGE_SYS_ID)
  self:set_ui_lock(self.v_uiobjects.HeroTeacing, not teach_open)
  self:set_ui_lock(self.v_uiobjects.Endless, not endless_open)
  self:set_ui_lock(self.v_uiobjects.Pendant, not linear_open)
  self:set_ui_lock(self.v_uiobjects.BossChallenge, not boss_challenge_open)
  Util.get_child_gameobj("Content/Red", self.v_uiobjects.HeroTeacing):SetActive(false)
  self:bind_red(self.v_uiobjects.Pendant, Global.red_enum.FIGHT_LINEAR_RED, Global.red_enum.FIGHT_CHALLENGE_RED)
  self:bind_red(self.v_uiobjects.Endless, Global.red_enum.FIGHT_ENDLESS_RED, Global.red_enum.FIGHT_CHALLENGE_RED)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_uicompents.Content_rect)
  self:refresh_endless_red()
  self:refresh_content_pos()
end

function ui:refresh_content_pos()
  if self.v_cache_focus then
    return
  end
  local challenge_type = ChapterMgr:get_record_select_challenge_type()
  local index = challenge_type and CHALLENGE_TYPE_TO_BTN_INDEX[challenge_type] or 1
  local focus_idx = index >= BTN_COUNT and index - 2 or index
  local focus_pos = focus_idx < 1 and 0 or -(focus_idx - 1) * self.v_move_step
  self.v_uicompents.Content_rect:SetAnchoredPositionA(focus_pos, 0, 0)
  local width = self.v_uicompents.Content_rect:GetSizeDeltaA()
  local pos = self.v_uicompents.Content_rect.anchoredPosition.x
  self.v_uiobjects.ScrollTip:SetActiveEx(width + pos > 100)
end

function ui:init_content_layout()
  local content_horizon_layout = self.v_uiobjects.Content:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
  local content_spacing = content_horizon_layout.spacing
  local item_width = self.v_uicompents.HeroTeacing_rect.rect.width
  self.v_move_step = item_width + content_spacing
end

function ui:set_ui_lock(obj, is_lock)
  local lock = Util.get_child_gameobj("Content/Lock", obj)
  local name_bg = Util.get_child_gameobj("Content/ChapterName/Bg", obj)
  local bg_canvas_group = Util.get_canvas_group("Content/Bg3", obj)
  local name_canvas_group = Util.get_canvas_group("Content/ChapterName/Name", obj)
  lock:SetActive(is_lock)
  name_bg:SetActive(not is_lock)
  bg_canvas_group.alpha = is_lock and 1 or 0.2
  name_canvas_group.alpha = is_lock and 0.1 or 1
end

function ui:bind_red(obj, red_id, parent_red_id)
  local red = Util.get_child_gameobj("Content/Red", obj)
  RedPointMgr:bind_redpoint(self, red, red_id, parent_red_id)
end

function ui:refresh_endless_red()
  local endless_open = SysOpenMgr:get_sys_is_open(ENDLESS_SYS_ID)
  local is_have_red = endless_open and ChapterEndlessMgr:get_endless_red_state()
  local red_point = Util.get_child_gameobj("Content/Red", self.v_uiobjects.Endless)
  red_point:SetActive(is_have_red)
  RedPointMgr:enable_redpoint(Global.red_enum.FIGHT_ENDLESS_RED, is_have_red)
end

function ui:ui_on_hide()
  ChapterMgr:set_record_select_challenge_type()
end

return ui
