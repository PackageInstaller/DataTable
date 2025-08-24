local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_mark_label = {
    "MarkLabel",
    BIND_TYPE.TEXT
  },
  v_mark = {
    "Mark",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
end

function ui:ui_on_show()
  local uid = Global.player_uuid
  self.v_mark_label.text = "当前版本为先遣服测试版本，不代表正式内容 UID:" .. uid
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

return ui
