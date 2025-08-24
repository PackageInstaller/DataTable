local Base = require("ui.uiobject")
local bagConfig = require("gamelogic.character.fight_bag_configs")
local Item_Helper = require("utils.item_helper")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("item_bg", function()
  end)
  local tog = Util.get_toggle(nil, self.v_object)
  self:set_toggle_listener(tog, function(is_on)
    if is_on then
      Item_Helper.show_battle_tips(self.v_item_id, nil, {
        bag_source = bagConfig.BAG_SOURCE.NONE,
        go = self.v_object,
        item_data = self.v_item
      })
    end
  end)
end

function ui:set_data(item)
  if not item then
    return
  end
  self.v_item = item
  local item_id = item.Id
  self.v_item_id = item_id
  local ucom = self.v_uicompents
  local count = item.count
  local item_cfg = item.Cfg
  ucom.ItemNum_txt.text = count
  local icon_img = ucom.Item_icon_img
  local icon_path = UtilUI.get_battle_item_icon(item_id)
  ResMgr:load_set_icon(icon_img, icon_path)
  local quality_image = self.v_uicompents.item_bg_img
  ResMgr:load_set_icon(quality_image, bagConfig.Quality_Img[item_cfg.Quality])
  local is_consume = Item_Helper.get_is_consume(item_id)
  self.v_uiobjects.IsConsume:SetActive(is_consume)
end

function ui:ui_on_hide()
  self.v_item = nil
  self.v_item_id = nil
end

function ui:ui_on_destroy()
end

return ui
