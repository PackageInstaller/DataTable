local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local STROY_ITEM_KEY = "STROY_ITEM_KEY"
local PAGE_STROY_ITEM_KEY = "PAGE_STROY_ITEM_KEY"
local ToggleTab = require("ui.widget.widget_toggle_tab")
local _tinsert = table.insert
local TagLockColcor = {
  color = Util.get_unity_color_by_hex(tonumber("6a6a6a", 16)),
  a = 1.0
}
local TagNormalColcor = {
  color = Util.get_unity_color_by_hex(tonumber("ffffff", 16)),
  a = 1.0
}

function ui:ui_finish_load()
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnMain", function()
    UIMgr:go_to_main()
  end)
  self:register_exist_auto_template(STROY_ITEM_KEY, self.v_uiobjects.ButtonTem, self.v_uiobjects.Content)
  self:register_exist_auto_template(PAGE_STROY_ITEM_KEY, self.v_uiobjects.StageTem, self.v_uiobjects.PageContent)
  self.v_group_id = nil
end

function ui:ui_on_show(gruop_id, cur_tog)
  self.v_group_id = gruop_id
  self:build_list()
  self:init_small_group_tog(cur_tog)
  self:close_story_full_bg()
  self:register_event()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_UI_ON_HIDE_OF_STORY, self.close_story_full_bg, self)
end

function ui:build_list()
  self.v_stroy_list = nil
  self.v_item_toggle = nil
  self.v_stroy_list = ShareRes.create("archives.video_list_group", self.v_group_id)
  if not self.v_stroy_list then
    Log.Error("此组ID的配置有误--组ID---", self.v_group_id)
    return
  end
  local temp = {}
  for _, info in pairs(self.v_stroy_list) do
    temp[info.SmallGroupId] = temp[info.SmallGroupId] or {
      cfg = ShareRes.get_archive_small_group_cfg(info.SmallGroupId),
      stroy = {},
      groupId = info.groupId
    }
    _tinsert(temp[info.SmallGroupId].stroy, info)
  end
  local sort_temp = {}
  for _, info_table in pairs(temp) do
    table.sort(info_table.stroy, function(a, b)
      if a.ShowPriority ~= b.ShowPriority then
        return a.ShowPriority > b.ShowPriority
      end
      return a.Id < b.Id
    end)
    _tinsert(sort_temp, info_table)
  end
  table.sort(sort_temp, function(a, b)
    if a.cfg.ShowPriority ~= b.cfg.ShowPriority then
      return a.cfg.ShowPriority > b.cfg.ShowPriority
    end
    return a.cfg.Id < b.cfg.Id
  end)
  self.v_show_group_list = sort_temp
end

function ui:init_small_group_tog(cur_tog)
  self.v_page_toggle = {}
  self.v_page_cfg = {}
  self.v_page_red_point = {}
  self:give_back_auto_cache(PAGE_STROY_ITEM_KEY)
  for index, data in ipairs(self.v_show_group_list) do
    local page = self:get_auto_cache(PAGE_STROY_ITEM_KEY)
    local cfg = data.cfg
    local desc = Util.get_text("StageName", page)
    local red_point = Util.get_child_gameobj("StageName/Redpoint", page)
    red_point:SetActive(false)
    desc.text = cfg.Name
    local tog = Util.get_toggle(nil, page)
    _tinsert(self.v_page_toggle, tog)
    _tinsert(self.v_page_cfg, cfg)
    _tinsert(self.v_page_red_point, red_point)
    self:update_red(index)
    if not ArchiveMgr:is_to_achieve_Condition(cfg.ConditionID, false) then
      desc.text = "???"
    end
  end
  self.v_cur_tog = cur_tog or self:get_frist_unlock_index()
  self.v_small_group_tog_tab = ToggleTab:new(self)
  self.v_small_group_tog_tab:init_by_toggles(self.v_page_toggle, function(cur_select)
    if ArchiveMgr:is_to_achieve_Condition(self.v_page_cfg[cur_select].ConditionID, true) then
      self.v_cur_tog = cur_select
      self:refresh_story(cur_select)
      self.v_uicompents.Content_rect:SetAnchoredPositionA(5000, 0, 0)
    elseif cur_select ~= self.v_cur_tog then
      self.v_page_toggle[self.v_cur_tog].isOn = false
      self.v_page_toggle[self.v_cur_tog].isOn = true
    end
  end, self.v_cur_tog)
  self:refresh_story(self.v_cur_tog)
end

function ui:refresh_story(cur_select)
  local show_group = self.v_show_group_list[cur_select]
  self.v_stroy_list = show_group.stroy
  self.v_stroy_item_red_point = {}
  self.v_page_red_point[cur_select]:SetActive(false)
  self.v_cur_page = cur_select
  self:give_back_auto_cache(STROY_ITEM_KEY)
  for index, data in ipairs(self.v_stroy_list) do
    local item = self:get_auto_cache(STROY_ITEM_KEY)
    local desc = Util.get_text("Name", item)
    local red_point = Util.get_child_gameobj("Red", item)
    local btn = Util.get_button(nil, item)
    local lock_state = ArchiveMgr.v_move_video_list[data.Id].lock_state
    self:set_button_listener(btn, function()
      if lock_state then
        ArchiveMgr:is_to_achieve_Condition(data.ConditionID, true)
      else
        self:click_play_btn(index)
      end
    end)
    local red_point_flag = ArchiveMgr.v_move_video_list[data.Id].red_state
    red_point:SetActive(red_point_flag)
    _tinsert(self.v_stroy_item_red_point, red_point)
    if red_point_flag then
      self.v_page_red_point[cur_select]:SetActive(true)
    end
    desc.text = data.Name
    local color
    if lock_state then
      color = TagLockColcor.color
      color.a = TagLockColcor.a
    else
      color = TagNormalColcor.color
      color.a = TagNormalColcor.a
    end
    desc.color = color
  end
  local page_cfg = self.v_page_cfg[cur_select]
  ResMgr:load_set_icon(self.v_uicompents.FullBg_img, page_cfg.Bg, nil, true, self)
  self.v_uicompents.StageName_txt.text = page_cfg.Name
  local group_id = show_group.groupId
  local group_cfg = ShareRes.get_archive_group_list_cfg(group_id)
  local small_group_cfg = show_group.cfg
  local story_cfg_info = ShareRes.create("story.story_info", small_group_cfg.PoltId)
  self.v_uicompents.StageName_txt.text = group_cfg.Name
  self.v_uicompents.StoryName_txt.text = small_group_cfg.Name
  self.v_uicompents.StoryDesc_txt.text = story_cfg_info.StoryContent
  self.v_uicompents.StageTitleNum_txt.text = group_cfg.StageNum
  if small_group_cfg.ScreenWriterName and small_group_cfg.StoryWriterName and 0 ~= string.len(small_group_cfg.ScreenWriterName) and 0 ~= string.len(small_group_cfg.StoryWriterName) then
    self.v_uiobjects.ScreenWriters:SetActive(true)
    self.v_uiobjects.StoryWriters:SetActive(true)
    self.v_uicompents.ScreenWritersContent_txt.text = small_group_cfg.ScreenWriterName
    self.v_uicompents.StoryWritersContent_txt.text = small_group_cfg.StoryWriterName
  else
    self.v_uiobjects.ScreenWriters:SetActive(false)
    self.v_uiobjects.StoryWriters:SetActive(false)
  end
end

function ui:click_play_btn(cur_select)
  local stroy_id = self.v_stroy_list[cur_select].Id
  local story_cfg = ShareRes.get_archive_video_cfg(stroy_id)
  local polt_id = story_cfg.PoltId
  local info = self.v_stroy_list[cur_select]
  local red_point = self.v_stroy_item_red_point[cur_select]
  if ArchiveMgr.v_move_video_list[info.Id].red_state then
    ArchiveMgr:req_click_action(ArchiveMgr.CommonDefind.ARCH_TYPE.MOVE_VIDEO, info.Id, function()
      if self:has_inited() and self:visible() then
        red_point:SetActive(ArchiveMgr.v_move_video_list[info.Id].red_state)
        self:update_red(self.v_cur_page)
      end
    end)
  end
  if Util.is_more_than_zero(story_cfg.TowerID) and Util.is_more_than_zero(story_cfg.Floor) and Util.is_more_than_zero(story_cfg.RoomID) then
    UIMgr:set_main_scene_after_load_ui(self.v_cfg.name, self.v_group_id, self.v_cur_tog)
    TowerMgr:enter_story_room(stroy_id)
    return
  end
  UIMgr:get_ui("uistory"):ui_show(polt_id)
  local story_bg = story_cfg.StoryBg
  if story_bg then
    ResMgr:load_set_icon(self.v_uicompents.FullBg2_img, story_bg, function()
      self.v_uiobjects.FullBg2:SetActive(true)
    end, true, self)
  end
end

function ui:update_red(cur_select)
  local show_group = self.v_show_group_list[cur_select]
  self.v_page_red_point[cur_select]:SetActive(false)
  for index, data in ipairs(show_group.stroy) do
    local red_point_flag = ArchiveMgr.v_move_video_list[data.Id].red_state
    if red_point_flag then
      self.v_page_red_point[cur_select]:SetActive(true)
    end
  end
end

function ui:get_frist_unlock_index()
  for index, data in ipairs(self.v_page_cfg) do
    if ArchiveMgr:is_to_achieve_Condition(data.ConditionID, false) then
      return index
    end
  end
  return 1
end

function ui:close_story_full_bg()
  self.v_uiobjects.FullBg2:SetActive(false)
end

return ui
