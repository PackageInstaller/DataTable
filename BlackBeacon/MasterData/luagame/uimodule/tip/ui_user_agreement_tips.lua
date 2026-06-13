local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("Button_yes", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show()
  self.v_uiobjects.Button_no:SetActive(false)
  local text = self:get_text("Text", self.v_uiobjects.Button_yes)
  text.text = "确定"
end

return ui
