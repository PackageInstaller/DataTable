local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button_listener(Util.get_button(nil, self:get_object()), function()
    Util.show_item_tip(self.v_cfg_data[1])
  end)
end

function ui:ui_on_show(cfg)
  self.v_cfg_data = cfg
  self:update_view()
end

function ui:ui_on_hide()
end

function ui:update_view()
  local cfg = self.v_cfg_data
  local item_id = cfg[1]
  local num = cfg[2]
  local item_cfg = ShareRes.get_item_cfg(item_id)
  local path = UtilUI.get_item_icon(item_id)
  ResMgr:load_set_icon(self.v_uicompents.ItemIcon_img, path)
  local icon_path = ShareRes.create("item.item_quality", item_cfg.Quality).QualityIcon
  local quality_path = string.format("UICommon/%s", icon_path)
  ResMgr:load_set_icon(self.v_uicompents.ItemQuality_img, quality_path)
  self.v_uicompents.ItemNum_txt.text = num
end

return ui
