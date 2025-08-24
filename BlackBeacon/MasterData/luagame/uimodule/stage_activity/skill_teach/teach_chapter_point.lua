local Base = require("ui.uibase")
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local CommonDef = require("cs_share.common_define")
local ui = Util.create_child_mt(Base)
local Timer = Global.timer
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local horizon_group = UnityEngine.UI.HorizontalLayoutGroup
local _tinsert = table.insert
local _abs = math.abs
local Scroll_Anim_Time = 0.7
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_stage_content = {
    "StMain",
    BIND_TYPE.OBJECT
  },
  v_left_up_panel = {
    "LeftUp",
    BIND_TYPE.OBJECT
  },
  v_right_up_panel = {
    "RightUp",
    BIND_TYPE.OBJECT
  },
  v_teach_panel = {
    "TeachPanel",
    BIND_TYPE.OBJECT
  }
}
local PREFAB_PATH = "prefab/ChapterPoint/TeachPoint.prefab"
local Act_ID = CommonDef.ACTY_TYPE.BUDDY_TEACH
local AbilityList = {
  [1] = "Abnormal",
  [2] = "Survive",
  [3] = "Auxiliary",
  [4] = "Motor",
  [5] = "Difficulty",
  [6] = "Damage"
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
    UIMgr:try_hide_ui("chapter_inf")
  end)
  self.v_polygon = self.v_uiobjects.EvaluationIcon:GetComponent(typeof(CS.Game.UICustomPolygon))
end

function ui:ui_on_show(point_id, buddy_id, closeCallBack)
  self.v_fight_type = CommonDef.CHALLENGE_TYPE.BUDDY_TEACH
  if point_id then
    self.v_teach_cfg = ShareRes.get_buddy_teach_cfg_by_point_id(point_id)
    buddy_id = self.v_teach_cfg.BuddyID
  elseif buddy_id then
    self.v_teach_cfg = ShareRes.get_buddy_teach_cfg_by_buddy_id(buddy_id)
    point_id = self.v_teach_cfg.EpisodeId
  end
  self.v_point_id = point_id
  self.v_buddy_id = buddy_id
  self.v_uiobjects.EvaluationBg:SetActive(nil ~= buddy_id)
  if not self.v_teach_cfg then
    return
  end
  self.v_left_up_panel:SetActive(false)
  self.v_right_up_panel:SetActive(false)
  self.v_teach_panel:SetActive(true)
  self:_set_readability()
  self:_set_point_obj()
  self:_set_stage_info()
  UIMgr:remove_stace_by_ui_name("chapter_inf")
  self:_regist_client_event()
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_ON_POINT_UPDATE, self._refresh_point_info, self)
  self:bind_auto_mq(Const.MSG_ON_CHAPTER_DETAIL_INFO_HIDE, self.on_detail_info_hide, self)
end

function ui:ui_on_hide()
  if self.v_chapter_point_obj then
    ResMgr:destroy_gameobj(self.v_chapter_point_obj)
    self.v_chapter_point_obj = nil
  end
  if self.v_callback then
    self.v_callback()
  end
  if self.close_call_back then
    self.close_call_back()
  end
  if self.v_tween then
    self.v_tween:Kill(false)
    self.v_tween = nil
  end
  self.v_callback = nil
  self.close_call_back = nil
end

function ui:_set_readability()
  local list = {}
  local show_poly = true
  for _, v in ipairs(AbilityList) do
    local ability = self.v_teach_cfg[v] / 5
    show_poly = show_poly and ability > 0
    table.insert(list, ability)
  end
  if self.v_buddy_id then
    self.v_uiobjects.EvaluationBg:SetActive(show_poly)
  end
  if show_poly then
    self.v_polygon:DrawPolygon(list)
  end
end

function ui:_set_point_obj()
  local path = Path.get_language_full_prefab_path(PREFAB_PATH)
  local chapter_point_obj = ResMgr:load_gameobj(path)
  chapter_point_obj.transform:SetParent(self.v_stage_content.transform, false)
  self.v_chapter_point_obj = chapter_point_obj
  self.v_scroll_rect = Util.get_scrollrect(nil, chapter_point_obj)
  self.v_content_rect = self:get_rect_transform("Viewport/Content", chapter_point_obj)
  self.v_content_init_pos_x = self.v_content_rect.anchoredPosition.x
  self.v_content_init_pos_y = self.v_content_rect.anchoredPosition.y
  self.v_viewport_width = self:get_rect_transform("Viewport", chapter_point_obj).rect.width
  local item_width = self:get_rect_transform("Viewport/Content/StageTem1", chapter_point_obj).rect.width
  local content_horizon_layout = self.v_content_rect:GetComponent(typeof(horizon_group))
  local content_spacing = content_horizon_layout.spacing
  self.v_move_step = item_width + content_spacing
  self.v_set_center_time = 0
  self:_set_point_info()
end

function ui:build_floor_list(all_floor_cfg)
  self.v_floor_cfg_list = {}
  for key, cfg in pairs(all_floor_cfg) do
    self.v_floor_cfg_list[#self.v_floor_cfg_list + 1] = cfg
  end
  table.sort(self.v_floor_cfg_list, function(a, b)
    if a.FloorIdx ~= b.FloorIdx then
      return a.FloorIdx < b.FloorIdx
    else
      return false
    end
  end)
end

function ui:_set_point_info()
  if not self.v_chapter_point_obj then
    return
  end
  local chapter_point_obj = self.v_chapter_point_obj
  local content = self:get_child_gameobj("Viewport/Content", chapter_point_obj).transform
  for i = 0, content.childCount - 1 do
    content:GetChild(i):SetActive(false)
  end
  local teach_cfg = self.v_teach_cfg
  if not teach_cfg then
    return
  end
  local all_floor_cfg = ShareRes.get_buddy_teach_floor_by_point_id(teach_cfg.EpisodeId)
  local point_cfg = ShareRes.get_chapter_point_cfg(teach_cfg.EpisodeId)
  self.v_new_obj = nil
  self:build_floor_list(all_floor_cfg)
  self.v_open_list = {}
  for index, floor_cfg in ipairs(self.v_floor_cfg_list) do
    local floor_index = floor_cfg.FloorIdx
    local point_btn = Util.get_button("Viewport/Content/StageTem" .. index, chapter_point_obj.transform)
    if point_btn then
      point_btn.gameObject:SetActive(false)
      if ActivityMgr:invoke(Act_ID, "get_floor_has_open", self.v_buddy_id or self.v_point_id, floor_index) then
        self.v_new_obj = point_btn
        _tinsert(self.v_open_list, point_btn)
        point_btn.gameObject:SetActive(true)
        local st_fight = Util.get_rect_transform("Content/StFight_", point_btn.transform)
        local st_story = Util.get_rect_transform("Content/StStory_", point_btn.transform)
        st_fight.gameObject:SetActive(false)
        st_story.gameObject:SetActive(false)
        if not Util.is_empty(floor_cfg.PointBgPath) then
          local icon = Util.get_image("Content/StFight_/StBg_", point_btn.transform)
          ResMgr:load_set_icon(icon, floor_cfg.PointBgPath, nil, true)
        end
        local has_pass = ActivityMgr:invoke(Act_ID, "get_floor_has_passed", self.v_buddy_id or self.v_point_id, floor_index)
        local img_complete = Util.get_image("Content/StCom_", point_btn.transform)
        img_complete:SetActive(has_pass)
        local archives_content = self:get_rect_transform("Content/ArchivesContent", point_btn.transform)
        archives_content.gameObject:SetActive(false)
        local nowObj = self:get_child_gameobj("Content/StFight_/StNow_", point_btn.transform)
        local pass_all = ActivityMgr:invoke(Act_ID, "get_has_pass_all", self.v_buddy_id or self.v_point_id)
        nowObj:SetActive(not pass_all and not has_pass)
        if point_cfg.PointType == CHAPTER_CONFIG.POINT_TYPE.FIGHT then
          local has_open = ActivityMgr:invoke(Act_ID, "get_floor_has_open", self.v_buddy_id or self.v_point_id, floor_index)
          self:update_fight_point_item_info(point_btn, floor_index, has_open)
          st_fight.gameObject:SetActive(true)
        end
        self:set_button_listener(point_btn, function()
          if point_cfg.PointType == CHAPTER_CONFIG.POINT_TYPE.FIGHT then
            self:move_click_to_first(floor_cfg.Id, floor_index, index)
          end
        end)
      end
    end
  end
  self:focus_on_new()
  self:refresh_select_obj()
end

function ui:_set_stage_info()
  self.v_uicompents.StageName_txt.text = self.v_teach_cfg.StageName
  local progress = ActivityMgr:invoke(Act_ID, "get_teach_progress", self.v_buddy_id or self.v_point_id)
  self.v_uicompents.Progress_txt.text = progress
  local icon = self.v_teach_cfg.DetailHeroIcon
  if self.v_teach_cfg.BuddyID then
    if not icon then
      icon = UtilUI.get_hero_images(self.v_teach_cfg.BuddyID, Config.HERO_ICON_LV.HD_FULL_IMG)
    end
  elseif not icon then
    Log.Error("获取立绘失败，请检查角色教学副本表ID：", self.v_teach_cfg.Id)
    return
  end
  ResMgr:load_set_icon(self.v_uicompents.HeroImg_img, icon, nil, true, self)
  if self.v_teach_cfg.Detail_Bg_Pos ~= nil then
    self.v_uicompents.HeroImg_rect:SetAnchoredPositionA(self.v_teach_cfg.Detail_Bg_Pos[1], self.v_teach_cfg.Detail_Bg_Pos[2], self.v_teach_cfg.Detail_Bg_Pos[3])
  end
  ResMgr:load_set_icon(self.v_uicompents.Bg_img, self.v_teach_cfg.Detail_Hero_Bg, nil, true, self)
end

function ui:_refresh_point_info()
  self.v_set_center_time = 0.02
  self:_set_point_info()
end

function ui:update_fight_point_item_info(point_ui, floor_index, has_open)
  local transform_ui = point_ui.transform
  local teach_floor_cfg
  if self.v_buddy_id then
    teach_floor_cfg = ShareRes.get_buddy_teach_floor_cfg_by_buddy_id(self.v_buddy_id, floor_index)
  else
    teach_floor_cfg = ShareRes.get_buddy_teach_floor_cfg_by_point_id(self.v_point_id, floor_index)
  end
  local name_txt = self:get_text("Content/StFight_/StName_", transform_ui)
  name_txt.text = teach_floor_cfg.PointName
  local mask1 = self:get_child_gameobj("Content/ComMask1_", transform_ui)
  mask1:SetActive(not has_open)
  local mask2 = self:get_child_gameobj("Content/ComMask2_", transform_ui)
  mask2:SetActive(not has_open)
end

function ui:_check_floor_open(index)
  local passed_floor_index = ActivityMgr:invoke(Act_ID, "get_passed_floor_index", self.v_buddy_id or self.v_point_id)
  return index >= passed_floor_index
end

function ui:click_point_fight_btn(point_id, floor_index)
  self.v_uiobjects.EvaluationBg:SetActive(false)
  local not_complete = not ActivityMgr:invoke(Act_ID, "get_floor_has_passed", self.v_buddy_id or self.v_point_id, floor_index)
  UIMgr:get_ui("ui_chapter_detail_info"):ui_show({
    point_id = point_id,
    buddy_id = self.v_buddy_id,
    first_pass = not_complete,
    floor_index = floor_index,
    fight_type = CommonDef.CHALLENGE_TYPE.BUDDY_TEACH
  })
end

function ui:on_detail_info_hide()
  if self.v_buddy_id then
    self.v_uiobjects.EvaluationBg:SetActive(true)
  end
  self:_set_readability()
  self:revert_scroll()
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_point_id
end

function ui:focus_on_new()
  self.v_scroll_rect.movementType = 1
  if not self.v_open_list or #self.v_open_list < 3 then
    return
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_content_rect)
  self.v_content_pos_x = self.v_content_rect.anchoredPosition.x
  local content_target_pos_x = -1 * (#self.v_open_list - 2) * self.v_move_step
  local move_width = self.v_content_pos_x - content_target_pos_x
  local rate = move_width / self.v_viewport_width
  self.v_anim_time = _abs(Scroll_Anim_Time * rate)
  self.v_content_rect:DOAnchorPosX(content_target_pos_x, 0)
end

function ui:move_click_to_first(point_id, floor_index, idx)
  self.v_scroll_rect.movementType = 0
  self.v_content_pos_x = self.v_content_rect.anchoredPosition.x
  local content_target_pos_x = -1 * (idx - 1) * self.v_move_step
  local move_width = self.v_content_pos_x - content_target_pos_x
  local rate = move_width / self.v_viewport_width
  self.v_anim_time = _abs(Scroll_Anim_Time * rate)
  if self.v_tween then
    self.v_tween:Kill(false)
    self.v_tween = nil
  end
  self.v_tween = self.v_content_rect:DOAnchorPosX(content_target_pos_x, self.v_anim_time)
  self.v_uiobjects.EvaluationBg:SetActive(false)
  self:refresh_select_obj(idx)
  local not_complete = not ActivityMgr:invoke(Act_ID, "get_floor_has_passed", self.v_buddy_id or self.v_point_id, floor_index)
  UIMgr:get_ui("ui_chapter_detail_info"):ui_show({
    point_id = point_id,
    buddy_id = self.v_buddy_id,
    first_pass = not_complete,
    floor_index = floor_index,
    fight_type = CommonDef.CHALLENGE_TYPE.BUDDY_TEACH
  })
end

function ui:revert_scroll(alpha)
  if self.v_move_item_obj then
    local item_canvas = self:get_canvas_group(nil, self.v_move_item_obj)
    item_canvas.alpha = alpha
  end
  self.v_scroll_rect.movementType = 1
  if self.v_tween then
    self.v_tween:Kill(false)
    self.v_tween = nil
  end
  self.v_tween = self.v_content_rect:DOAnchorPosX(self.v_content_init_pos_x, self.v_anim_time)
  self:refresh_select_obj()
end

function ui:refresh_select_obj(idx)
  if not self.v_open_list then
    return
  end
  for i, obj in ipairs(self.v_open_list) do
    self:get_child_gameobj("Content/StFight_/StNow_", obj.transform):SetActive(i == idx)
  end
end

return ui
