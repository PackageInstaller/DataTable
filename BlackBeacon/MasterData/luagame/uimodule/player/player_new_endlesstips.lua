local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local PLAYER_NEW_ENDLESSTIPS_ITEM = require("uimodule.player.player_new_endlesstips_item")
local PALYER_NEW_ENDLESSTIPS_ITEM_TEMP_KEY = "PLAYER_NEW_ENDLESSTIPS_ITEM_TEMP_KEY"
local _tinsert = table.insert
local INFINITE_EPISODE_TYPE = Config.CommonDefine.INFINITE_EPISODE_TYPE

local function sort_func(a, b)
  if a.Priority ~= b.Priority then
    return a.Priority < b.Priority
  else
    return false
  end
end

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
    if self.v_select_chapter then
      self:set_infinite_id()
    end
  end)
  self.v_uiobjects.BossChal:SetActive(false)
  self.v_uiobjects.EndLess:SetActive(true)
  self.v_point_type = ChapterEndlessMgr:is_week_infinite_open() and INFINITE_EPISODE_TYPE.WEEK or INFINITE_EPISODE_TYPE.ALWAYS
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.Content, PLAYER_NEW_ENDLESSTIPS_ITEM, PALYER_NEW_ENDLESSTIPS_ITEM_TEMP_KEY)
  self.v_toggle_tab = ToggleTab:new(self)
end

function ui:ui_on_show(select_id)
  local infinite_list = ChapterMgr:get_inf_chapter_map()
  local chapter_list = {}
  local cfg
  for k, v in pairs(infinite_list) do
    cfg = ShareRes.get_inf_chapter_cfg(v.id)
    if not cfg.IsHide then
      _tinsert(chapter_list, v)
    end
  end
  if UtilTable.is_empty(chapter_list) then
    _tinsert(chapter_list, {id = -1, score = 0})
    self.v_static_sv:update_list(chapter_list)
  else
    self.v_static_sv:update_list(chapter_list)
    local togs = {}
    local items = self.v_static_sv:get_items()
    local defualt_index
    for index, item in ipairs(items) do
      local tog = item.v_uicompents.Bg_tog
      if item.v_chapter_id == select_id then
        defualt_index = index
      end
      _tinsert(togs, tog)
    end
    
    local function init_cb()
      local items = self.v_static_sv:get_items()
      for i, v in ipairs(items) do
        if v.v_chapter_id == select_id then
          v.v_uiobjects.Active:SetActive(true)
          goto lbl_21
        end
      end
      ::lbl_21::
    end
    
    self.v_toggle_tab:init_by_toggles(togs, function(index)
      self:refresh_select_view(index)
    end, defualt_index, nil, init_cb)
  end
end

function ui:init_infinite_list()
  self.v_infinite_list = {}
  for key, point_type in pairs(INFINITE_EPISODE_TYPE) do
    self.v_infinite_list[point_type] = {}
  end
  local all_infinite_cfg = ShareRes.get_inf_chapter_cfg()
  local type_list
  for key, cfg in pairs(all_infinite_cfg) do
    type_list = self.v_infinite_list[cfg.Type]
    if type_list then
      type_list[#type_list + 1] = cfg
    end
  end
  for key, list in pairs(self.v_infinite_list) do
    table.sort(list, sort_func)
  end
end

function ui:refresh_select_view(index)
  local items = self.v_static_sv:get_items()
  for idx, item in ipairs(items) do
    if idx == index then
      item.v_uiobjects.Active:SetActive(true)
      self.v_select_chapter = item.v_chapter_id
      print(item.v_chapter_id)
    else
      item.v_uiobjects.Active:SetActive(false)
    end
  end
end

function ui:set_infinite_id()
  local spine_info = PlayerMgr:get_buddy_spine_info()
  spine_info.infiniter_id = self.v_select_chapter
  PlayerMgr:request_buddy_spine_info(spine_info, false, true)
end

function ui:ui_on_hide()
  self.v_static_sv:clear()
  self.v_point_type = ChapterEndlessMgr:is_week_infinite_open() and INFINITE_EPISODE_TYPE.WEEK or INFINITE_EPISODE_TYPE.ALWAYS
end

function ui:ui_on_destroy()
  self.v_static_sv = nil
end

return ui
