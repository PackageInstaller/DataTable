local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:on_click_BtnStart()
  self:ui_hide()
  NoviceMgr.ponder_maze_mgr:start_battle()
end

function ui:ui_finish_load()
  self:set_button("BtnStart", function()
    self:on_click_BtnStart()
  end)
end

function ui:ui_on_show(node_id, option_id)
  UIMgr:clear_main_scene_after_load_ui()
  self:refresh_view(node_id, option_id)
end

function ui:refresh_view(node_id, option_id)
  self.v_node_id, self.v_option_id = node_id, option_id
  local option_cfg = ShareRes.get_ponder_maze_node_option_cfg(option_id)
  self.v_point_id = option_cfg.Param[1]
  local point_cfg = ShareRes.get_chapter_point_cfg(self.v_point_id)
  self.v_uicompents.StageName_txt.text = point_cfg.PointName
  self.v_uicompents.Condition_txt.text = option_cfg.Param[3]
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

return ui
