local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_wrap(parent, gameobj)
  self = Base.ui_wrap(self, parent, gameobj)
  self.go = gameobj
  return self
end

function ui:set_data(data, idx)
  if nil == data then
    Log.Info("data is nil", idx, debug.traceback())
    return
  end
  local components = self.v_uicompents
  local icon_path, quality_path = UtilUI.get_item_images(data.id)
  ResMgr:load_set_icon(components.Bg_img, quality_path)
  ResMgr:load_set_icon(components.Icon_img, icon_path)
  self:set_button_listener(components.Bg_btn, function()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = data.id,
      is_exist_jump = false
    })
  end)
  components.Text_txt.text = data.num
  self.v_data = data
  self.v_idx = idx
end

return ui
