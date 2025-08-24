local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder

function ui:ui_on_show()
  self.v_buddy_id = PlayerMgr:get_signboard_girl_id()
end

function ui:ui_on_hide()
  self.v_buddy_id = nil
end

function ui:change_content(dialog)
  self.v_uicompents.Dialog_txt.text = Util.check_replace_player_name(dialog)
  self:refresh_dialog_list()
end

function ui:refresh_dialog_list()
  local dia_content = Util.get_rect_transform(nil, self.v_uiobjects.Dialog_Content)
  local view = Util.get_rect_transform(nil, self.v_object)
  LayoutRebuilder.ForceRebuildLayoutImmediate(dia_content)
  LayoutRebuilder.ForceRebuildLayoutImmediate(view)
end

return ui
