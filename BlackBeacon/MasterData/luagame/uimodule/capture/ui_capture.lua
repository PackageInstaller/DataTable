local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
    UIMgr:get_ui("ui_capture_main"):ui_show()
  end)
  self:set_button("StartAgainBtn", function()
    self:ui_hide()
    UIMgr:get_ui("ui_capture_main"):ui_show()
  end)
  self:set_button("SaveBtn", function()
    UIMgr:get_ui("ui_blackfade"):ui_show(0, 0, 1, function()
      local ui_pov = UIMgr:try_get_visible_ui("ui_capture")
      if ui_pov then
        ui_pov:ui_hide()
      end
      CaptureMgr:capture()
      CaptureMgr:deactivate_pov_camera()
    end)
  end)
end

function ui:ui_on_show(rt)
  local raw_image = Util.get_rawimage(nil, self.v_uiobjects.PhotographRawImage)
  raw_image.texture = rt
  CaptureMgr:enable_pov_input(false)
end

function ui:ui_on_hide()
  CaptureMgr:enable_pov_input(true)
end

function ui:ui_on_destroy()
end

return ui
