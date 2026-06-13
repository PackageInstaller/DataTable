local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local PAGE = {QUALITY = 1, GROUP = 2}
local LEVEL_TO_COLOR = {
  [1] = Util.get_unity_color_by_hex(tonumber("c0c8d5", 16)),
  [2] = Util.get_unity_color_by_hex(tonumber("93bcf1", 16)),
  [3] = Util.get_unity_color_by_hex(tonumber("93bcf1", 16)),
  [4] = Util.get_unity_color_by_hex(tonumber("e1a8fd", 16)),
  [5] = Util.get_unity_color_by_hex(tonumber("fedaa0", 16))
}
local WHITHE = Util.get_unity_color_by_hex(tonumber("ffffff", 16))
local GREY = Util.get_unity_color_by_hex(tonumber("808080", 16))
local ToggleTab = require("ui.widget.widget_toggle_tab")
local SaticSv = require("ui.widget.static_scroll_view")
local ORNAMENTS_GROUP_KEY = "ORNAMENTS_GROUP_KEY"
local ORNAMENTS_GROUP_ITEM_CLASS = require("uimodule.ornaments.ornaments_group_list")
local _tinsert = table.insert
local _tsort = table.sort
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_group_tem = {
    "GroupTem",
    BIND_TYPE.OBJECT
  },
  v_content = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_orn_bg = {
    "OrnBg",
    BIND_TYPE.IMAGE
  },
  v_orn_icon = {
    "OrnIcon",
    BIND_TYPE.IMAGE
  },
  v_orn_name = {
    "OrnName",
    BIND_TYPE.TEXT
  },
  v_orn_effect = {
    "OrnEffect",
    BIND_TYPE.TEXT
  },
  v_orn_lock = {
    "OrnLock",
    BIND_TYPE.TEXT
  },
  v_lock = {
    "Lock",
    BIND_TYPE.OBJECT
  },
  v_lock_bg = {
    "LockBg",
    BIND_TYPE.OBJECT
  },
  v_tog_quality = {
    "TogQuality",
    BIND_TYPE.TOGGLE
  },
  v_tog_orn_group = {
    "TogOrnGroup",
    BIND_TYPE.TOGGLE
  },
  v_icon_effect = {
    "IconEffect",
    BIND_TYPE.IMAGE
  },
  v_orn_icon_lock = {
    "OrnIconLock",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self.v_pages = {}
  self.v_pages_data = {}
  _tinsert(self.v_pages, self.v_tog_quality)
  _tinsert(self.v_pages, self.v_tog_orn_group)
  self.v_page_toggle_tab = ToggleTab:new(self)
  self.v_page_toggle_tab:init_by_toggles(self.v_pages, function(idx)
    self:_on_click_page(idx)
  end, 0, false)
  self.v_static_sv = SaticSv:new(self, self.v_content, ORNAMENTS_GROUP_ITEM_CLASS, ORNAMENTS_GROUP_KEY)
end

function ui:ui_on_show(ornament_list)
  self.v_data = {}
  local ornaments_cfg = ShareRes.get_ornaments()
  if ornament_list then
    self.v_data = ornament_list
    self.v_default_page = PAGE.QUALITY
  else
    self.v_default_page = PAGE.GROUP
    self.v_data = ornaments_cfg
  end
  self:_on_click_page(self.v_default_page)
  self.v_page_toggle_tab:set_toggle_by_index(self.v_default_page)
  self:bind_auto_mq(Const.MSG_ON_ORNAMENT_SELECT, self.on_select_ornament, self)
  self:bind_auto_mq(Const.MSG_ON_ORNAMENT_RED_update, self.on_update_red_point, self)
  self:bind_auto_mq(Const.MSG_ON_ORNAMENT_GROUP_SELECT, self.on_select_ornament_group, self)
end

function ui:divide_into_groups(data, cur_page)
  if not data then
    return
  end
  if self.v_pages_data[cur_page] then
    return self.v_pages_data[cur_page]
  end
  local res = {}
  local group_cfg, find_tag
  if cur_page == PAGE.QUALITY then
    group_cfg = ShareRes.get_ornaments_quality()
    find_tag = "Quality"
  elseif cur_page == PAGE.GROUP then
    group_cfg = ShareRes.get_ornaments_group()
    find_tag = "GroupId"
  else
    assert(group_cfg, "页签丢失")
    group_cfg = ShareRes.get_ornaments_quality()
    find_tag = "Quality"
  end
  for _, cfg in pairs(group_cfg) do
    local temp_data = {}
    temp_data.group_info = cfg
    temp_data.item_info = {}
    temp_data.cur_page = cur_page
    res[cfg.Id] = temp_data
  end
  for _, ornament_cfg in pairs(data) do
    local target_table = res[ornament_cfg[find_tag]]
    if 0 ~= ornament_cfg.GroupId then
      assert(target_table, "饰品配置错误，不存在对应组")
      _tinsert(target_table.item_info, ornament_cfg)
    end
  end
  
  local function sort_func(a, b)
    return a.group_info.Priority < b.group_info.Priority
  end
  
  local arrange_res = {}
  for _, info in pairs(res) do
    if next(info.item_info) then
      _tinsert(arrange_res, info)
    end
  end
  _tsort(arrange_res, sort_func)
  self.v_pages_data[cur_page] = arrange_res
  return arrange_res
end

function ui:_on_click_page(idx)
  if self.v_cur_select == idx then
    return
  end
  self.v_cur_select = idx
  local show_data = self:divide_into_groups(self.v_data, self.v_cur_select)
  self.v_static_sv:update_list(show_data)
end

function ui:on_select_ornament(msg)
  if msg then
    local ornament_id = msg.mm_x
    local is_unlock = msg.mm_y
    local ornament_cfg = ShareRes.get_ornaments(ornament_id)
    ResMgr:load_set_icon(self.v_orn_icon, ornament_cfg.Icon)
    self.v_icon_effect.color = LEVEL_TO_COLOR[ornament_cfg.Quality]
    self.v_orn_name.text = ornament_cfg.Name
    self.v_orn_effect.text = ornament_cfg.Desc
    self.v_orn_icon_lock:SetActive(not is_unlock)
    local _, condition = next(ornament_cfg.Condition)
    if is_unlock or nil == condition or condition < 0 then
      self.v_orn_lock.text = Util.get_i18n("已解锁")
      self.v_lock:SetActive(false)
      self.v_lock_bg:SetActive(true)
      self.v_orn_icon.color = WHITHE
    else
      self.v_lock:SetActive(true)
      self.v_lock_bg:SetActive(false)
      self.v_orn_lock.text = ShareRes.get_condition_desc(ornament_cfg.Condition[1])
      self.v_orn_icon.color = GREY
    end
  end
end

function ui:on_select_ornament_group(msg)
  if self.v_static_sv and msg then
    self.v_static_sv:on_select_change(msg.mm_obj)
  end
end

function ui:on_update_red_point()
  if self.v_static_sv then
    self.v_static_sv:refresh_items()
  end
end

function ui:ui_on_hide()
  self.v_page_toggle_tab:set_toggle_by_index(self.v_default_page or PAGE.GROUP)
  self.v_static_sv:clear()
  self.v_item_list = nil
  self.v_cur_select = nil
  self.v_pages_data = {}
end

return ui
