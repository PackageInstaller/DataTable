local Base = require("ui.uiobject")
local ABILITY_UI = Util.create_child_mt(Base)

function ABILITY_UI:ui_finish_load()
end

function ABILITY_UI:ui_on_show()
end

function ABILITY_UI:ui_on_hide()
end

function ABILITY_UI:ui_on_destroy()
end

function ABILITY_UI:set_data(ability_info)
  local ability_cfg = ShareRes.get_ability_cfg(ability_info.ability_id)
  local genres_cfg = ShareRes.get_genres_cfg(ability_cfg.Sect)
  local quality_cfg = ShareRes.get_ability_quality_cfg(ability_cfg.Quality)
  local ability_upgrade_cfg = ShareRes.get_ability_upgrade_cfg(ability_info.ability_id, ability_info.ability_grade)
  ResMgr:load_set_icon(self.v_uicompents.QualityBg_img, quality_cfg.QualityBg2, nil, true, self)
  ResMgr:load_set_icon(self.v_uicompents.SectIcon_img, genres_cfg.IconPath, nil, true, self)
  self.v_uicompents.TalentName_txt.text = ability_upgrade_cfg.Name
  self.v_uicompents.TalentDesc_txt.text = ability_upgrade_cfg.Desc
  local start_layout_tf = self.v_uiobjects.StarLayout.transform
  if start_layout_tf.childCount < ability_cfg.Star then
    for index = start_layout_tf.childCount, ability_cfg.Star do
      local child_tf = start_layout_tf:GetChild(0)
      UnityGameObject.Instantiate(child_tf.gameObject, start_layout_tf)
    end
  end
  for index = 1, start_layout_tf.childCount do
    local child_tf = start_layout_tf:GetChild(index - 1)
    if index <= ability_cfg.Star and index <= ability_cfg.Star then
      child_tf.gameObject:SetActive(true)
    else
      child_tf.gameObject:SetActive(false)
    end
  end
end

Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self.v_ability_item_map = {}
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  for key, ability_item in pairs(self.v_ability_item_map) do
    ability_item:ui_hide()
    ability_item:ui_destroy()
    self.v_ability_item_map[key] = nil
  end
end

function ui:ui_on_destroy()
end

function ui:set_data(genres_id)
  local genres_cfg = ShareRes.get_genres_cfg(genres_id)
  if genres_cfg then
    self.v_uicompents.SectName_txt.text = genres_cfg.Name
  end
  self.v_uicompents.TalentNum_txt.text = GenresMgr:get_ability_count(genres_id)
end

function ui:add_ability_to_group(ability_info, obj)
  local ability_id = ability_info.ability_id
  local ability_item = self.v_ability_item_map[ability_id] or ABILITY_UI:ui_wrap(self, obj, true)
  ability_item:set_data(ability_info)
  self.v_ability_item_map[ability_id] = ability_item
  obj.transform:SetParent(self.v_object_transform)
end

return ui
