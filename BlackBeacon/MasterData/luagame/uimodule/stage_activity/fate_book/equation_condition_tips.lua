local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SECTCONTENT_SECTTEM_TEMP_KEY = "SECTCONTENT_SECTTEM_TEMP_KEY"

function ui:on_click_BgClose()
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:on_click_BgClose()
  end)
  self.v_condition_sect_item_map = {}
  self:register_exist_auto_template(SECTCONTENT_SECTTEM_TEMP_KEY, self.v_uiobjects.SectTem, self.v_uiobjects.SectContent)
end

function ui:ui_on_show(condition_sect_list, ability_count_map)
  self:refresh_view(condition_sect_list, ability_count_map)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh_view(condition_sect_list, ability_count_map)
  local obj, icon_img, name_txt, neednum_txt, num_txt, genres_id, genres_cfg, ability_need_count
  for key, sect_info in pairs(condition_sect_list) do
    genres_id = sect_info.Sect
    ability_need_count = sect_info.Count
    genres_cfg = ShareRes.get_genres_cfg(genres_id)
    obj = self:get_auto_cache(SECTCONTENT_SECTTEM_TEMP_KEY)
    icon_img = self:get_image("Icon", obj)
    ResMgr:load_set_icon(icon_img, genres_cfg.IconPath, nil, true, self)
    name_txt = self:get_text("Name", obj)
    name_txt.text = genres_cfg.Name
    neednum_txt = self:get_text("NeedNum", obj)
    neednum_txt.text = ability_need_count
    local cur_count = ability_count_map and ability_count_map[genres_id] or GenresMgr:get_ability_count(genres_id)
    local enough = ability_need_count <= cur_count
    local color_str = enough and "476DBB" or "D74343"
    num_txt = self:get_text("Slash/Num", neednum_txt.gameObject)
    num_txt.text = cur_count
    Util.set_color(num_txt, color_str)
  end
end

return ui
