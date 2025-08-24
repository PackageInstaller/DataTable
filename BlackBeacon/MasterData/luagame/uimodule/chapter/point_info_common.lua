local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local CHAPTER_POINT_ITEM_CLASS = require("uimodule.chapter.chapter_point_item")
local _insert = table.insert
local ELEMENT_ITEM_KEY = "ELEMENT_ITEM_KEY"
local KEYWORLD_ITEM_KEY = "KEYWORLD_ITEM_KEY"

function ui:ui_finish_load()
  self:set_button("StageInfoButton", function()
    self:update_stageinfo_view()
  end)
  if self.v_parent_ui then
    local name = self.v_parent_ui.v_object.name
    ELEMENT_ITEM_KEY = ELEMENT_ITEM_KEY .. name
    KEYWORLD_ITEM_KEY = KEYWORLD_ITEM_KEY .. name
  end
  self:register_exist_auto_template(ELEMENT_ITEM_KEY, self.v_uiobjects.EleTempl, self.v_uiobjects.EleContent)
  self:register_exist_auto_template(KEYWORLD_ITEM_KEY, self.v_uiobjects.KeyTempl, self.v_uiobjects.KeyContent)
end

function ui:ui_on_show(chapter_id, point_id)
  self.v_chapter_id = chapter_id
  self.v_point_id = point_id
  self.v_point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  self.v_detail_cfg = ShareRes.get_chapter_point_details_cfg(self.v_point_cfg.PointDetail)
  self.v_uiobjects.StageInfoButton:SetActive(false)
  if self.v_detail_cfg then
    self:update_point_element()
    self:update_point_keyword()
  end
  self.v_show_stage_info = false
  self:update_stageinfo_view()
end

function ui:ui_on_hide()
  self:unregister_all_auto_template()
end

function ui:update_stageinfo_view()
  self.v_show_stage_info = not self.v_show_stage_info
  self.v_uiobjects.SiKey:SetActive(self.v_show_stage_info)
  self.v_uiobjects.SiEle:SetActive(self.v_show_stage_info)
  local img_obj = Util.get_image("Image", self.v_uiobjects.StageInfoButton)
  local scale_y = self.v_show_stage_info and -0.2 or 0.2
  img_obj.transform:SetLocalScaleA(0.2, scale_y, 1)
end

function ui:update_point_element()
  local element_list = self.v_detail_cfg.ElementId
  local element_data = {}
  for _, element_id in ipairs(element_list) do
    local element_obj = self:get_auto_cache(ELEMENT_ITEM_KEY)
    local element_cfg = ShareRes.get_element_cfg(element_id)
    Util.assert(element_cfg, "element_cfg is nil element id = " .. element_id)
    local element_text = Util.get_text("ElementName", element_obj)
    element_text.text = element_cfg.ElementName
    local element_icon = Util.get_image("ElementIcon", element_obj)
    ResMgr:load_set_icon(element_icon, element_cfg.ElementIconPath)
  end
end

function ui:update_point_keyword()
  local keyword_data = self.v_detail_cfg.Keyword
  self:give_back_auto_cache(KEYWORLD_ITEM_KEY)
  for _, keyword_id in ipairs(keyword_data) do
    if 0 ~= keyword_id then
      local keyword_cfg = ShareRes.get_chapter_keyword_cfg(keyword_id)
      local keyword_ui = self:get_auto_cache(KEYWORLD_ITEM_KEY)
      Util.get_text(nil, keyword_ui).text = keyword_cfg.KeywordDesc
    end
  end
end

function ui:update_info_btn_visible(is_visible)
  self.v_uiobjects.StageInfoButton:SetActive(is_visible)
end

return ui
