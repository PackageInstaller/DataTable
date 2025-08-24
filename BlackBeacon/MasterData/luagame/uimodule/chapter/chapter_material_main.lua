local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local _tinsert = table.insert
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local CHAPTER_MATERIAL_ITEM_KEY = "CHAPTER_MATERIAL_ITEM_KEY"
local _tsort = table.sort
local NUM_WEEK_CHINESE = {
  "周一开放",
  "周二开放",
  "周三开放",
  "周四开放",
  "周五开放",
  "周六开放",
  "周日开放"
}
local MODEL = {
  v_chapter_content = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_chapter_template = {
    "StageTem",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:register_exist_auto_template(CHAPTER_MATERIAL_ITEM_KEY, self.v_chapter_template, self.v_chapter_content)
end

function ui:ui_on_show()
  self:init_chapter_material_list()
  self:bind_auto_mq(Const.MSG_CLOSE_MATERIAL, self.close_material, self)
end

function ui:init_chapter_material_list()
  self.v_all_chapter_material = {}
  self.v_all_ui_go_material = {}
  self.v_week = tonumber(Date:get_week())
  local material_data = ShareRes.get_chapter_material_cfg()
  self:give_back_auto_cache(CHAPTER_MATERIAL_ITEM_KEY)
  local new_data = {}
  for _, data in pairs(material_data) do
    _tinsert(new_data, data)
    self.v_all_chapter_material[data.Id] = data
  end
  _tsort(new_data, function(a, b)
    return a.Priority > b.Priority
  end)
  for index, material_data in ipairs(new_data) do
    self:new_chapter_material(material_data.Id)
  end
end

function ui:new_chapter_material(Id)
  local chapter_ui = self:get_auto_cache(CHAPTER_MATERIAL_ITEM_KEY)
  local material_cfg = self.v_all_chapter_material[Id]
  self.v_all_ui_go_material[Id] = chapter_ui
  local stage_name = Util.get_text("StageName", chapter_ui)
  stage_name.text = material_cfg.Name
  local is_lock = false
  local tip_text
  if not Condition:check_condition(material_cfg.Condition) then
    is_lock = true
    if 0 ~= material_cfg.Condition then
      tip_text = ShareRes.create("condition.condition", material_cfg.Condition).Desc
    end
  end
  local material_data = ChapterMgr:get_material_data_by_id(Id)
  local week_text = "常驻开放"
  local open_time = Util.get_text("OpenTime", chapter_ui)
  if material_cfg.OpenDay then
    week_text = ""
    for index, day in ipairs(material_cfg.OpenDay) do
      week_text = week_text .. NUM_WEEK_CHINESE[day]
    end
  end
  if not material_data then
    is_lock = true
  end
  week_text = Util.format_str(week_text)
  open_time.text = week_text
  local lock_go = Util.get_child_gameobj("Lock", chapter_ui)
  local lock_text = Util.get_text("Lock/Text", chapter_ui)
  lock_go:SetActive(is_lock)
  local temp_text = tip_text or week_text
  lock_text.text = temp_text
  local open_bg_rect = Util.get_rect_transform("BgOpen", chapter_ui)
  open_bg_rect.gameObject:SetActive(not is_lock)
  local open_time_rect = Util.get_rect_transform("OpenTime", chapter_ui)
  open_time_rect.gameObject:SetActive(not is_lock)
  local color = is_lock and tonumber("585858", 16) or tonumber("FFFFFF", 16)
  stage_name.color = Util.get_unity_color_by_hex(color)
  local icon = Util.get_image("BgIcon/Bg", chapter_ui)
  local icon_path = string.format("UIMaterial/%s", material_cfg.Icon)
  ResMgr:load_set_icon(icon, icon_path)
  self:set_button_listener(Util.get_button(nil, chapter_ui), function()
    if is_lock then
      Util.show_message_tip(temp_text)
      return
    end
    UIMgr:get_ui("chapter_material_detail"):ui_show(Id)
  end)
end

function ui:close_material(msg)
  local material_id = msg.mm_obj
  local chapter_ui = self.v_all_ui_go_material[material_id]
  local lock_go = Util.get_child_gameobj("Lock", chapter_ui)
  local text = Util.get_text("Lock/Text", chapter_ui).text
  lock_go:SetActive(true)
  self:set_button_listener(Util.get_button(nil, chapter_ui), function()
    Util.show_message_tip(text)
  end)
end

return ui
