local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local _tinsert = table.insert
local _tsort = table.sort
local LoopListClass = require("ui.widget.infinite_loop_list")
local TITLE_TEM_CLASS = require("uimodule.player.player_title_tem")
local MODEL = {
  v_title_tem = {
    "TitleTem",
    BIND_TYPE.OBJECT
  },
  v_hold_now = {
    "HoldNow",
    BIND_TYPE.TEXT
  },
  v_member_title = {
    "MemberTitle",
    BIND_TYPE.OBJECT
  },
  v_course_title = {
    "CourseTitle",
    BIND_TYPE.OBJECT
  },
  v_bg_member = {
    "MemberTitle",
    BIND_TYPE.IMAGE
  },
  v_bg_course = {
    "CourseTitle",
    BIND_TYPE.IMAGE
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
  v_quality_bg_member = {
    "QualityBg2",
    BIND_TYPE.IMAGE
  },
  v_quality_bg_course = {
    "QualityBg1",
    BIND_TYPE.IMAGE
  },
  v_icon_member = {
    "MemberEyes",
    BIND_TYPE.IMAGE
  },
  v_icon_course = {
    "CourseIcon2",
    BIND_TYPE.IMAGE
  },
  v_un_lock_way = {
    "UnLockWay",
    BIND_TYPE.TEXT
  },
  v_title_desc = {
    "TitleDesc",
    BIND_TYPE.TEXT
  },
  v_title_loop_list = {
    "TitleListScrollView",
    BIND_TYPE.OBJECT
  },
  v_title_info = {
    "TitleInfo",
    BIND_TYPE.OBJECT
  },
  v_no_desc = {
    "NoDesc",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("CloseBtn", function()
    self:set_enable(false)
  end)
  self:set_button("CloseBtn1", function()
    self:set_enable(false)
  end)
  self.v_title_loop_list = LoopListClass:new(self, self.v_title_loop_list, TITLE_TEM_CLASS)
end

function ui:ui_on_show(data)
  self.v_hold_now.text = #data.active_titles
  self.v_titles = {}
  for k, v in pairs(data.active_titles) do
    local info = {}
    local title_cfg = ShareRes.get_title(v)
    local other_info = {}
    other_info.is_get = 1
    other_info.status = v == data.title and 1 or 0
    info.cfg = title_cfg
    info.other_info = other_info
    _tinsert(self.v_titles, info)
  end
  
  local function sort_func(a, b)
    if a.other_info.status == b.other_info.status then
      return a.cfg.Id < b.cfg.Id
    else
      return b.other_info.status < a.other_info.status
    end
  end
  
  _tsort(self.v_titles, sort_func)
  self.v_title_info:SetActive(next(self.v_titles) ~= nil)
  self.v_title_loop_list:refresh_data(self.v_titles)
  self.v_title_loop_list:select_item(1)
  self.v_no_desc:SetActive(next(self.v_titles) == nil)
end

function ui:on_click_title(i)
  local data = self.v_titles[i].cfg
  self.v_member_title:SetActive(1 == data.Type)
  self.v_course_title:SetActive(2 == data.Type)
  self.v_lv_member.gameObject:SetActive(1 == data.ShowLevel)
  self.v_lv_course.gameObject:SetActive(1 == data.ShowLevel)
  local suffix
  local title_cfg = data
  local title_quality_path_cfg = ShareRes.get_title_quality_path(data.Quality)
  if 1 == data.Type then
    suffix = "_member"
  elseif 2 == data.Type then
    suffix = "_course"
  else
    return
  end
  self.v_title_desc.text = data.Describe
  self.v_un_lock_way.text = data.UnlockingMethod
  ResMgr:load_set_icon(self["v_quality_bg" .. suffix], title_quality_path_cfg.Qualitybox)
  self["v_lv" .. suffix].text = data.Level
  self["v_name" .. suffix].text = data.Name
  ResMgr:load_set_icon(self["v_icon" .. suffix], title_cfg.BaseMapPreview)
  ResMgr:load_set_icon(self["v_bg" .. suffix], title_cfg.BaseMap)
end

function ui:ui_on_hide()
  if self.v_title_loop_list then
    self.v_title_loop_list:ui_on_hide()
  end
end

function ui:ui_on_destroy()
  if self.v_title_loop_list then
    self.v_title_loop_list:ui_on_destroy()
  end
end

return ui
