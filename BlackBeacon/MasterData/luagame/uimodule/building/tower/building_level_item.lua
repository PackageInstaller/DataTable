local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:on_click_btn()
  local level_up_view = self.v_parent_ui:get_panel("level_up_view")
  level_up_view:set_enable(true, self.v_building_type, self.v_item_level)
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  local parent_id = BuildingMgr:get_build_lv_up_red_id(self.v_building_type)
  RedPointMgr:unbind_redpoint_by_id(self, self.v_item_level, parent_id)
end

function ui:ui_on_destroy()
end

function ui:set_data(building_type, lv_cfg, cur_level)
  self.v_building_type = building_type
  self.v_building_level = cur_level
  self.v_item_level = lv_cfg.Level
  local max_lv = ShareRes.get_building_max_level(self.v_building_type)
  local objs = self.v_uiobjects
  local level = self.v_item_level
  local is_unlock = cur_level >= level
  local is_cur_level = cur_level == level
  local is_next_level = cur_level + 1 == level
  local condition_pass = BuildingMgr:check_condition_list(lv_cfg.Condition)
  local enough = Util.check_item_cost_enough(lv_cfg.ConsumeItemId, lv_cfg.ConsumeItemCount)
  objs.Line:SetActive(level ~= max_lv)
  objs.LineActive:SetActive(is_unlock)
  objs.BgNor:SetActive(is_unlock)
  objs.BgNow:SetActive(not is_unlock and condition_pass and enough and is_next_level)
  objs.BgUnLock:SetActive(not is_unlock and condition_pass and (not enough or not is_next_level))
  objs.UnlockBg:SetActive(is_unlock)
  objs.BgLock:SetActive(not is_unlock and not condition_pass)
  self.v_uicompents.LvNum_txt.text = Config.NUM_2_ROMAN[level]
  local parent_id = BuildingMgr:get_build_lv_up_red_id(self.v_building_type)
  local redpoint_id = RedPointMgr:create_dynamic_id(level, parent_id)
  RedPointMgr:bind_redpoint(self, objs.RedPoint, redpoint_id, parent_id)
  self:set_button_listener(nil, function()
    self:on_click_btn()
  end)
end

return ui
