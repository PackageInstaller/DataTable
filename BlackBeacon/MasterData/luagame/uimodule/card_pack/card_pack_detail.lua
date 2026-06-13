local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local DETAIL_RELEASE_ITEM_KEY = "DETAIL_RELEASE_ITEM_KEY"
local DETAIL_FIXED_ITEM_KEY = "DETAIL_FIXED_ITEM_KEY"
local DETAIL_PROBABILITY_ITEM_KEY = "DETAIL_PROBABILITY_ITEM_KEY"
local ITEM_ICON_PATH = "Icon/Item/"
local Item_Helper = require("utils.item_helper")
local bagConfig = require("gamelogic.character.fight_bag_configs")

function ui:ui_finish_load()
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self:register_exist_auto_template(DETAIL_FIXED_ITEM_KEY, self.v_uiobjects.FixedTem, self.v_uiobjects.FixedContent)
  self:register_exist_auto_template(DETAIL_PROBABILITY_ITEM_KEY, self.v_uiobjects.ChanceTem, self.v_uiobjects.ChanceContent)
end

function ui:ui_on_show(data)
  self.v_card_data = data
  local treasure_chest_cfg = self.v_card_data.treasure_chest_cfg
  self.v_uicompents.CardName_txt.text = self.v_card_data.item_cfg.Name
  ResMgr:load_set_icon(self.v_uicompents.ConsumeItem_img, UtilUI.get_item_icon(treasure_chest_cfg.itemID))
  self.v_uicompents.ConsumeNum_txt.text = treasure_chest_cfg.itemCount
  ResMgr:load_set_icon(self.v_uicompents.CardIcon_img, self.v_card_data.img_name, nil, true)
  self:give_back_auto_cache(DETAIL_FIXED_ITEM_KEY)
  self:give_back_auto_cache(DETAIL_PROBABILITY_ITEM_KEY)
  for index, data_list in ipairs(treasure_chest_cfg.fixedItem) do
    local fixed_item = self:get_auto_cache(DETAIL_FIXED_ITEM_KEY)
    
    local function click_cb()
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = data_list[1],
        jump_cb = function()
          self:ui_hide()
        end
      })
    end
    
    self:set_item(fixed_item, data_list[1], data_list[2] > 0, data_list[3], data_list[4], click_cb)
  end
  for index, data_list in ipairs(treasure_chest_cfg.probabilityItem) do
    local probability_item = self:get_auto_cache(DETAIL_PROBABILITY_ITEM_KEY)
    
    local function click_cb()
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = data_list[1],
        jump_cb = function()
          self:ui_hide()
        end
      })
    end
    
    self:set_item(probability_item, data_list[1], data_list[2] > 0, data_list[3], data_list[4], click_cb)
  end
end

function ui:set_item(item, item_id, is_show_probab, min_count, max_count, click_cb)
  local item_btn = Util.get_button(nil, item)
  self:set_button_listener(item_btn, click_cb)
  local item_cfg = Item_Helper.get_item_cfg(item_id)
  local ItemQuality_img = Util.get_image("ItemQuality_", item)
  ResMgr:load_set_icon(ItemQuality_img, bagConfig.Quality_Img[item_cfg.Quality])
  local ItemIcon_img = Util.get_image("ItemIcon_", item)
  ResMgr:load_set_icon(ItemIcon_img, ITEM_ICON_PATH .. item_cfg.Icon)
  local ItemAmount_obj = Util.get_child_gameobj("ItemAmount_", item)
  local ChanceGet_obj = Util.get_child_gameobj("ChanceGet_", item)
  local ItemNum_txt = Util.get_text("ItemAmount_/Bg/ItemNum_", item)
  if min_count and max_count then
    ItemAmount_obj:SetActive(true)
    ItemNum_txt.text = min_count .. "~" .. max_count
  elseif min_count then
    ItemAmount_obj:SetActive(min_count > 1)
    ItemNum_txt.text = min_count
  elseif max_count then
    ItemAmount_obj:SetActive(max_count > 1)
    ItemNum_txt.text = max_count
  else
    ItemAmount_obj:SetActive(false)
  end
  ChanceGet_obj:SetActive(is_show_probab)
end

function ui:ui_on_hide()
end

return ui
