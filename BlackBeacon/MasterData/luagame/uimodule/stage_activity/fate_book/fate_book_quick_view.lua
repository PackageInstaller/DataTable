local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local QUICK_EQUATION_TEMP = "QUICK_EQUATION_TEMP"
local QUICK_GENRES_TEMP = "QUICK_GENRES_TEMP"
local EQUATION_HORI_ITEM = require("uimodule.stage_activity.fate_book.equation_hori_item")
local ccd = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local EQUATION_OPERATION_TYPE = ccd.EQUATION_OPERATION_TYPE

local function out_pd_stopped_cb(self)
  self:give_back_auto_cache(QUICK_GENRES_TEMP)
  self:clear_equation_hori_item_map()
  self.v_uiobjects.QuickViewContent:SetActive(self.v_show_panel)
end

function ui:on_click_BtnClose()
  self:change_show_state(false)
end

function ui:on_click_BtnDetail()
  self:change_show_state(false, true)
  local battle_bag4 = UIMgr:get_ui("battle_bag4")
  battle_bag4:ui_show()
  battle_bag4:switch_to_target_panel(6)
end

function ui:on_click_BtnDropDown()
  self:change_show_state(true)
end

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:on_click_BtnClose()
  end)
  self:set_button("BtnDetail", function()
    self:on_click_BtnDetail()
  end)
  self:set_button("BtnDropDown", function()
    self:on_click_BtnDropDown()
  end)
  self.v_uicompents.BtnDropDown_cg.alpha = 0
  self.v_drop_down_dotween = self.v_uicompents.BtnDropDown_cg:DOFade(1, 0.25)
  self.v_drop_down_dotween:ChangeStartValue(0)
  self.v_drop_down_dotween:Pause()
  self.v_equation_hori_item_map = {}
  self.v_genres_btn_list = {}
  self.v_save_area_canvas_group = self:get_canvas_group(nil, self.v_uiobjects.SafeArea).component
  self:register_exist_auto_template(QUICK_EQUATION_TEMP, self.v_uiobjects.EquationTem, self.v_uiobjects.EquationContent)
  self:register_exist_auto_template(QUICK_GENRES_TEMP, self.v_uiobjects.TalentTem, self.v_uiobjects.TalentContent)
end

function ui:ui_on_show(visible, pause_active, cur_top_order)
  self:change_show_state(false, true)
  self:set_save_area_visible(visible, pause_active, cur_top_order)
end

function ui:ui_on_hide()
  self.v_save_area_visible = nil
  self:change_show_state(false, true)
  self:clear_out_pd_stopped_cb_timer()
end

function ui:ui_on_destroy()
  self.v_drop_down_dotween = nil
end

function ui:change_show_state(new_state, skip_pd)
  self.v_show_panel = new_state
  self:on_show_state_change(skip_pd)
end

function ui:on_show_state_change(skip_pd)
  if self.v_show_panel and not skip_pd then
    self.v_uiobjects.BtnClose:SetActive(self.v_show_panel)
    self.v_uiobjects.QuickViewContent:SetActive(self.v_show_panel)
  end
  self:refresh_view(skip_pd)
end

function ui:refresh_view(skip_pd)
  if self.v_show_panel then
    if not skip_pd then
      self.v_uicompents.Ani_QuickViewContent_Out_pd:ResetPD()
      self.v_uicompents.Ani_QuickViewContent_In_pd:ResetPD()
      self.v_uicompents.Ani_QuickViewContent_In_pd:Play()
    end
    self:refresh_content()
  else
    if not skip_pd then
      self.v_uicompents.Ani_QuickViewContent_In_pd:ResetPD()
      self.v_uicompents.Ani_QuickViewContent_Out_pd:ResetPD()
      self.v_uicompents.Ani_QuickViewContent_Out_pd:Play()
      self:clear_out_pd_stopped_cb_timer()
      self.v_out_pd_stopped_cb_timer = Timer:add_timer("out_pd_stopped_cb_timer", self.v_uicompents.Ani_QuickViewContent_Out_pd.duration, out_pd_stopped_cb, self)
    else
      out_pd_stopped_cb(self)
    end
    self.v_uiobjects.BtnClose:SetActive(false)
  end
end

function ui:refresh_content()
  local genres_map = GenresMgr:get_genres_map()
  
  local function genres_click_cb(genres_id)
    self:change_show_state(false, true)
    local battle_bag4 = UIMgr:get_ui("battle_bag4")
    battle_bag4:ui_show()
    battle_bag4:switch_to_target_panel(6)
    local ability_view = battle_bag4:get_panel("ability_view")
    ability_view:force_select_genres(genres_id)
  end
  
  for genres_id, genres_data in pairs(genres_map) do
    local obj = self:get_auto_cache(QUICK_GENRES_TEMP)
    local icon_img = self:get_image("Icon", obj)
    local genres_cfg = ShareRes.get_genres_cfg(genres_id)
    ResMgr:load_set_icon(icon_img, genres_cfg.IconPath, nil, true, self)
    local num_txt = self:get_text("Num", obj)
    num_txt.text = UtilTable.hash_lenth(genres_data.sect_ability)
    local btn = self:get_button(nil, obj)
    self:set_button_listener(btn, function()
      genres_click_cb(genres_id)
    end)
    self.v_genres_btn_list[genres_id] = btn
    btn.enabled = self.v_pause_active
  end
  local equation_data_map = FateBookMgr:get_equation_data_map()
  local build_data
  
  local function click_cb()
    UIMgr:try_show_ui("equation_show_tips")
  end
  
  for equation_id, equation_data in pairs(equation_data_map) do
    local obj = self:get_auto_cache(QUICK_EQUATION_TEMP)
    build_data = {
      branch_id = equation_data.branch_id,
      equation_id = equation_id,
      level = equation_data.level,
      click_cb = click_cb
    }
    self.v_equation_hori_item_map[equation_id] = EQUATION_HORI_ITEM:ui_wrap_ex(self, obj, true)
    self.v_equation_hori_item_map[equation_id]:set_data(build_data, EQUATION_OPERATION_TYPE.QUICK_VIEW)
    self.v_equation_hori_item_map[equation_id]:set_button_active(true)
  end
end

function ui:set_save_area_visible(visible, pause_active, cur_top_order)
  local order = self.canvas.sortingOrder
  if cur_top_order < order and self.v_save_area_visible ~= visible then
    if visible then
      self.v_drop_down_dotween:Restart()
    end
    self.v_save_area_visible = visible
    self.v_save_area_canvas_group.alpha = visible and 1 or 0
    self.v_save_area_canvas_group.interactable = visible
    self.v_uicompents.BtnDropDown_img.enabled = visible
  end
  self.v_uiobjects.BtnDetail:SetActive(pause_active)
  self.v_pause_active = pause_active
  for key, btn in pairs(self.v_genres_btn_list) do
    btn.enabled = self.v_pause_active
  end
end

function ui:clear_out_pd_stopped_cb_timer()
  if self.v_out_pd_stopped_cb_timer then
    Timer:remove_timer(self.v_out_pd_stopped_cb_timer)
    self.v_out_pd_stopped_cb_timer = nil
  end
end

function ui:clear_equation_hori_item_map()
  self.v_genres_btn_list = {}
  self:give_back_auto_cache(QUICK_EQUATION_TEMP)
  for index, equation_hori_item in pairs(self.v_equation_hori_item_map) do
    equation_hori_item:ui_hide()
    equation_hori_item:ui_destroy()
    self.v_equation_hori_item_map[index] = nil
  end
end

return ui
