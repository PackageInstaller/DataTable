local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BgClose", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(tip)
  self.v_uicompents.EffectDesc_txt.text = tip
end

function ui:ui_on_hide()
end

return ui
