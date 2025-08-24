local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_on_show(err_msg, title)
  self:set_button_listener(self.v_uicompents.Btn_Close_btn, function()
    self:ui_hide()
  end)
  self.v_uicompents.Text_txt.text = err_msg
  self.v_uicompents.TitleText_txt.text = title or ""
end

return ui
