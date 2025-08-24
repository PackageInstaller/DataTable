local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:set_data(award_cfg)
  self:refresh_award_items(award_cfg)
end

function ui:refresh_award_items(award_data)
  local award_obj = self.v_uiobjects.ItemObjCom
  local item_id = award_data.ItemId
  local item_num = award_data.Num
  local item_icon_path = ShareRes.get_item_icon_path(item_id)
  local item_quality_path = ShareRes.get_item_quality_path(item_id)
  self:set_award_item(award_obj, item_icon_path, item_quality_path, item_num)
  self:set_button("ItemObjCom", function()
    UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
  end)
end

function ui:set_award_item(obj, item_icon_path, item_quality_path, item_num)
  local item_icon = Util.get_image("ItemIcon_", obj)
  local item_quality = Util.get_image("ItemQuality_", obj)
  local item_num_txt = Util.get_text("ItemAmount_/Bg/ItemNum_", obj)
  ResMgr:load_set_icon(item_icon, item_icon_path)
  ResMgr:load_set_icon(item_quality, item_quality_path)
  item_num_txt.text = item_num
end

function ui:clear_award_item()
  for key, item in pairs(self.v_award_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_award_item_list[key] = nil
  end
end

function ui:clear_static_view()
  if self.v_static_sv then
    self.v_static_sv:clear()
    self.v_static_sv = nil
  end
end

function ui:on_clear()
  self:clear_static_view()
end

return ui
