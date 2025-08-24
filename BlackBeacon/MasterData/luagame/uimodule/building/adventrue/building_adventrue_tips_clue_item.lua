local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:on_click_reduce_button()
  self.v_parent_ui:on_operat_clue(false, self.v_clue_id)
end

function ui:on_click_button()
  self.v_parent_ui:on_operat_clue(true, self.v_clue_id)
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data_on_add_clue(data, select_count)
  self.v_clue_id = data.id
  local count = BuildingMgr:get_clue_data_count(self.v_clue_id)
  local cfg = ShareRes.get_building_clue_cfg(self.v_clue_id)
  local path = UtilUI.get_item_icon(self.v_clue_id)
  ResMgr:load_set_icon(self.v_uicompents.ClueIcon_img, path)
  self.v_uicompents.ClueNum_txt.text = count
  self.v_uicompents.ClueEffect_txt.text = cfg.Desc
  self:on_select(select_count)
  self:set_button("BtnReduce", function()
    self:on_click_reduce_button()
  end)
  self:set_button_listener(self:get_button(), function()
    self:on_click_button()
  end)
end

function ui:set_data_on_select_clue(clue_id, is_select)
  self.v_clue_id = clue_id
  local count = BuildingMgr:get_clue_data_count(self.v_clue_id)
  local cfg = ShareRes.get_building_clue_cfg(self.v_clue_id)
  local path = UtilUI.get_item_icon(self.v_clue_id)
  ResMgr:load_set_icon(self.v_uicompents.ClueIcon_img, path)
  self.v_uicompents.ClueNum_txt.text = count
  self.v_uicompents.ClueEffect_txt.text = cfg.Desc
  self.v_uiobjects.Select:SetActive(is_select)
  self:set_button_listener(self:get_button(), function()
    self:on_click_button()
  end)
end

function ui:on_select(select_count)
  if select_count and select_count > 0 then
    self.v_uiobjects.Select:SetActive(true)
    self.v_uicompents.AddNum_txt.text = select_count
  else
    self.v_uiobjects.Select:SetActive(false)
  end
end

return ui
