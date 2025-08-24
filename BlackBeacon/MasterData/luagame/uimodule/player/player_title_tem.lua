local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_lock = {
    "Lock",
    BIND_TYPE.OBJECT
  },
  v_member_title = {
    "MemberTitle",
    BIND_TYPE.OBJECT
  },
  v_course_title = {
    "CourseTitle",
    BIND_TYPE.OBJECT
  },
  v_no_achivev = {
    "NoAchivev",
    BIND_TYPE.OBJECT
  },
  v_lv_member = {
    "MemberLv",
    BIND_TYPE.TEXT
  },
  v_lv_course = {
    "CourseLv",
    BIND_TYPE.TEXT
  },
  v_name_member = {
    "MemberName",
    BIND_TYPE.TEXT
  },
  v_name_course = {
    "CourseName",
    BIND_TYPE.TEXT
  },
  v_bg_member = {
    "MemberTitle",
    BIND_TYPE.IMAGE
  },
  v_bg_course = {
    "CourseTitle",
    BIND_TYPE.IMAGE
  },
  v_quality_bg_member = {
    "QualityBg2",
    BIND_TYPE.IMAGE
  },
  v_quality_bg_course = {
    "QualityBg1",
    BIND_TYPE.IMAGE
  },
  v_icon_course = {
    "CourseIcon2",
    BIND_TYPE.IMAGE
  },
  v_icon_member = {
    "MemberEyes",
    BIND_TYPE.IMAGE
  },
  v_title_obj = {
    "TitleObj",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_toggle = Util.get_toggle(nil, self.v_object)
  self.v_toggle.onValueChanged:RemoveAllListeners()
  self:set_toggle_listener(self.v_toggle, function(is_on)
    if is_on then
      self.v_linked_parent:on_click_title(self.v_index)
      self:show_check_mark()
    end
  end)
end

function ui:set_data(go, data_list, index)
  local data = data_list[index]
  self.v_data = data
  self:show_check_mark()
  self.v_index = index
  self.v_lock:SetActive(1 ~= data.other_info.is_get and 3 ~= data.cfg.Type)
  self.v_member_title:SetActive(1 == data.cfg.Type)
  self.v_course_title:SetActive(2 == data.cfg.Type)
  self.v_no_achivev:SetActive(3 == data.cfg.Type)
  local get_title = PlayerMgr:get_title(self.v_data.cfg.Id)
  local status
  if get_title then
    status = get_title.status
  else
    status = data.other_info.status
  end
  Util.get_child_gameobj("Image", self.v_object):SetActive(1 == status)
  local suffix
  local title_cfg = data.cfg
  local title_quality_path_cfg = ShareRes.get_title_quality_path(title_cfg.Quality)
  if 1 == data.cfg.Type then
    suffix = "_member"
  elseif 2 == data.cfg.Type then
    suffix = "_course"
  else
    return
  end
  self["v_lv" .. suffix].gameObject:SetActive(1 == data.cfg.ShowLevel)
  self["v_lv" .. suffix].text = data.cfg.Level
  self["v_name" .. suffix].text = data.cfg.Name
  ResMgr:load_set_icon(self["v_quality_bg" .. suffix], title_quality_path_cfg.Qualitybox)
  ResMgr:load_set_icon(self["v_icon" .. suffix], title_cfg.BaseMapPreview)
  ResMgr:load_set_icon(self["v_bg" .. suffix], title_cfg.BaseMap)
end

function ui:show_check_mark()
  local select_title_data = self.v_linked_parent.v_click_title_data
  self.v_uiobjects.Checkmark:SetActive(select_title_data and select_title_data.cfg.Id == self.v_data.cfg.Id)
end

function ui:on_click_tog()
  self.v_toggle = Util.get_toggle(nil, self.v_object)
  self.v_toggle.isOn = false
  self.v_toggle.isOn = true
end

function ui:set_linked_parent(parent)
  self.v_linked_parent = parent
end

return ui
