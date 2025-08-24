local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:get_bubble_root(idx)
  return self.v_uicompents["Pos" .. idx .. "_rect"]
end

function ui:shake_monkey(idx)
  local obj = self.v_uiobjects["Pos" .. idx]
  obj:SetActiveEx(false)
  obj:SetActive(true)
end

return ui
