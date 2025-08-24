local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_canvas = self.v_object:GetComponent(typeof(UnityEngine.Canvas))
end

function ui:ui_on_show()
  self.v_canvas.sortingOrder = 0
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:skip_sort_order()
  return true
end

return ui
