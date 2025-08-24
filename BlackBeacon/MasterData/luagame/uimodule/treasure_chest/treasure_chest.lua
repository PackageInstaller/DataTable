local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ToggleTab = require("ui.widget.widget_toggle_tab")
local LoopListClass = require("ui.widget.infinite_loop_list")
local TreasureChestItemClass = require("uimodule.treasure_chest.treasure_chest_item")
local TreasureChestCfg = require("uimodule.treasure_chest.treasure_chest_configs")
local AssetBarView = require("ui.asset_bar.asset_bar")
local Item_Helper = require("utils.item_helper")
local FIXED_ITEM_KEY = "FIXED_ITEM_KEY"
local PROBABILITY_ITEM_KEY = "PROBABILITY_ITEM_KEY"
local RELEASE_ITEM_KEY = "RELEASE_ITEM_KEY"
local TOGGLE_TEM_KEY = "TOGGLE_TEM_KEY"
local CHECK_MARK = "Checkmark"
local LABEL = "Label"
local _tinsert = table.insert
local util_get_color = Util.get_unity_color_by_hex
local toggle_select_color = util_get_color(tonumber("ffffff", 16))
local toggle_unselect_color = util_get_color(tonumber("8c8473", 16))
local TOGGLE_TYPE = TreasureChestCfg.TOGGLE_TYPE
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_return_btn = {
    "BtnRet",
    BIND_TYPE.BUTTON
  },
  v_empty_text_obj = {
    "EmptyText",
    BIND_TYPE.OBJECT
  },
  v_toggle_layout = {
    "ToggleLayout",
    BIND_TYPE.OBJECT
  },
  v_toggle_tem = {
    "ToggleTem",
    BIND_TYPE.OBJECT
  },
  v_capacity_now = {
    "CapacityNow",
    BIND_TYPE.TEXT
  },
  v_capacity_max = {
    "CapacityMax",
    BIND_TYPE.TEXT
  },
  v_left_view_layout = {
    "LeftViewInfo",
    BIND_TYPE.OBJECT
  },
  v_item_scroll_view = {
    "ItemScrollView",
    BIND_TYPE.OBJECT
  },
  v_right_view_layout = {
    "RightViewInfo",
    BIND_TYPE.OBJECT
  },
  v_item_name = {
    "ItemName",
    BIND_TYPE.TEXT
  },
  v_must_get_layout = {
    "MustGet",
    BIND_TYPE.OBJECT
  },
  v_chance_get_layout = {
    "ChanceGet",
    BIND_TYPE.OBJECT
  },
  v_must_item_tem = {
    "MustTem",
    BIND_TYPE.OBJECT
  },
  v_must_item_content = {
    "MustItemContent",
    BIND_TYPE.OBJECT
  },
  v_chance_item_tem = {
    "ChanceTem",
    BIND_TYPE.OBJECT
  },
  v_chance_item_content = {
    "ChanceItemContent",
    BIND_TYPE.OBJECT
  },
  v_consume_icon = {
    "ConsumeIcon",
    BIND_TYPE.IMAGE
  },
  v_consume_num = {
    "ConsumeNum",
    BIND_TYPE.TEXT
  },
  v_open_btn = {
    "BtnOpen",
    BIND_TYPE.BUTTON
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:_init_component()
end

function ui:ui_on_show()
  self.v_asset_bar:reset_by_id_list({
    Config.PLAYER_SP_ITEMID
  })
  self.v_asset_bar:on_create()
  self.v_is_first = true
  self:_init_toggle_list()
  self.v_toggle_idx = TOGGLE_TYPE.ALL
  self.v_toggle_tab:set_toggle_by_index(self.v_toggle_idx)
  self:_set_init_toggle_mask(self.v_toggle_idx)
  self:_refresh_view(self.v_toggle_idx)
  self:_refresh_count()
end

function ui:ui_on_hide()
  self.v_asset_bar:on_hide()
  self.v_toggle_idx = TOGGLE_TYPE.ALL
  self.v_item_list_view:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
  self.v_item_list_view:ui_on_destroy()
end

function ui:cache_ui()
  return true
end

function ui:_refresh_view(idx)
  if self.v_is_first then
    TreasureChestMgr:set_treasure_chest_list()
    self.v_is_first = false
  else
    TreasureChestMgr:reset_show_state()
  end
  self.v_show_list = TreasureChestMgr:filter_treasure_chest_list(idx)
  self.v_item_list_view:refresh_data(self.v_show_list)
  if #self.v_show_list > 0 then
    self.v_empty_text_obj:SetActive(false)
    self.v_right_view_layout:SetActive(true)
    self.v_item_list_view:get_item_ui(1):force_onclick()
  else
    self.v_empty_text_obj:SetActive(true)
    self.v_right_view_layout:SetActive(false)
  end
end

function ui:_init_component()
  self:set_button_listener(self.v_return_btn, function()
    self:ui_hide()
  end)
  self:set_button_listener(self.v_open_btn, function()
    self:_onclick_open()
  end)
  self.v_item_list_view = LoopListClass:new(self, self.v_item_scroll_view, TreasureChestItemClass)
  self:register_exist_auto_template(FIXED_ITEM_KEY, self.v_must_item_tem, self.v_must_item_content)
  self:register_exist_auto_template(PROBABILITY_ITEM_KEY, self.v_chance_item_tem, self.v_chance_item_content)
  self:register_exist_auto_template(TOGGLE_TEM_KEY, self.v_toggle_tem, self.v_toggle_layout)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
end

function ui:_init_toggle_list()
  local toggle_list = {}
  _tinsert(toggle_list, Util.get_toggle("1", self.v_toggle_layout))
  self:give_back_auto_cache(TOGGLE_TEM_KEY)
  local item_filter_cfg = ShareRes.create("item.treasure_chest_filter")
  for index, data in ipairs(item_filter_cfg) do
    local toggle_obj = self:get_auto_cache(TOGGLE_TEM_KEY)
    toggle_obj.transform.name = index + 1
    Util.get_text(LABEL, toggle_obj.transform).text = data.Name
    _tinsert(toggle_list, Util.get_toggle(nil, toggle_obj))
  end
  self.v_toggle_tab = ToggleTab:new(self)
  self.v_toggle_tab:init_by_toggles(toggle_list, function(cur_select, pre_select, cur_toggle, pre_toggle)
    self:_select_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  end, TOGGLE_TYPE.ALL)
end

function ui:_select_tag_toggle(cur_select, pre_select, cur_toggle, pre_toggle)
  if cur_select == self.v_toggle_idx then
    return
  end
  self.v_toggle_idx = cur_select
  Util.get_child_gameobj(CHECK_MARK, cur_toggle.transform):SetActive(true)
  Util.get_child_gameobj(CHECK_MARK, pre_toggle.transform):SetActive(false)
  Util.get_text(LABEL, cur_toggle.transform).color = toggle_select_color
  Util.get_text(LABEL, pre_toggle.transform).color = toggle_unselect_color
  self:_refresh_view(cur_select)
end

function ui:refresh_right_info(item_cfg, treasure_chest_cfg, info, index)
  self.v_treasure_chest_cfg = treasure_chest_cfg
  self.v_select_item_info = info
  self.v_select_item_index = index
  self.v_item_name.text = item_cfg.Name
  self.v_consume_num.text = self.v_treasure_chest_cfg.itemCount
  ResMgr:load_set_icon(self.v_consume_icon, UtilUI.get_item_icon(self.v_treasure_chest_cfg.itemID))
  self:release_items_by_template_key(RELEASE_ITEM_KEY)
  self:give_back_auto_cache(FIXED_ITEM_KEY)
  self:give_back_auto_cache(PROBABILITY_ITEM_KEY)
  self.v_must_get_layout:SetActive(next(self.v_treasure_chest_cfg.fixedItem) ~= nil)
  self.v_chance_get_layout:SetActive(nil ~= next(self.v_treasure_chest_cfg.probabilityItem))
  for index, item_id in ipairs(self.v_treasure_chest_cfg.fixedItem) do
    local fixed_item = self:get_auto_cache(FIXED_ITEM_KEY)
    local quality_img = Util.get_image("ItemQuality", fixed_item)
    self:create_item_obj(nil, quality_img.gameObject, RELEASE_ITEM_KEY, {
      item_id = item_id,
      click_cb = function()
        UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
      end
    })
  end
  for index, item_id in ipairs(self.v_treasure_chest_cfg.probabilityItem) do
    local probability_item = self:get_auto_cache(PROBABILITY_ITEM_KEY)
    local quality_img = Util.get_image("ItemQuality", probability_item)
    self:create_item_obj(nil, quality_img.gameObject, RELEASE_ITEM_KEY, {
      item_id = item_id,
      click_cb = function()
        UIMgr:get_ui("itemTip"):ui_show({item_id = item_id})
      end
    })
  end
  local Must_scrollrect = Util.get_scrollrect(nil, self.v_uiobjects.MustScroll)
  local Chance_scrollrect = Util.get_scrollrect(nil, self.v_uiobjects.ChanceScroll)
  Must_scrollrect.horizontalNormalizedPosition = 0
  Chance_scrollrect.horizontalNormalizedPosition = 0
end

function ui:_onclick_open()
  if BagMgr:get_item_num(self.v_treasure_chest_cfg.itemID) < self.v_treasure_chest_cfg.itemCount then
    Util.show_message_tip(2314, Item_Helper.get_item_cfg(self.v_treasure_chest_cfg.itemID).Name)
    if self.v_treasure_chest_cfg.itemID == Config.PLAYER_SP_ITEMID then
      UIMgr:get_ui("uiforcerecharg"):ui_show()
    end
    return
  end
  local consume_list = {
    bag_type = TreasureChestCfg.TREASURE_CHEST_TYPE,
    item_list = {
      {
        uuid = self.v_select_item_info.uuid,
        count = self.v_select_item_info.count
      }
    }
  }
  BagMgr:request_use_item(consume_list, function(ok)
    if ok then
      local length = #self.v_show_list
      local next_select_index = length > self.v_select_item_index and self.v_select_item_index or self.v_select_item_index - 1
      TreasureChestMgr:update_treasure_chest_list(self.v_select_item_info.uuid)
      local show_list = TreasureChestMgr:filter_treasure_chest_list(self.v_toggle_idx)
      self.v_item_list_view:refresh_data(show_list)
      self:_refresh_count()
      if length > 1 then
        self.v_empty_text_obj:SetActive(false)
        self.v_right_view_layout:SetActive(true)
        self.v_item_list_view:scroll_to_item(next_select_index - 1)
        self.v_item_list_view:get_item_ui(next_select_index):force_onclick()
      else
        self.v_empty_text_obj:SetActive(true)
        self.v_right_view_layout:SetActive(false)
      end
    end
  end)
end

function ui:_set_init_toggle_mask(toggle_index)
  local item_filter_cfg = ShareRes.create("item.treasure_chest_filter")
  local length = #item_filter_cfg + 1
  for i = 1, length do
    local child_trans = self.v_toggle_layout.transform:GetChild(i)
    Util.get_child_gameobj(CHECK_MARK, child_trans):SetActive(toggle_index == i)
    Util.get_text(LABEL, child_trans).color = toggle_index == i and toggle_select_color or toggle_unselect_color
  end
end

function ui:_refresh_count()
  self.v_capacity_now.text = TreasureChestMgr:get_treasure_chest_count()
  self.v_capacity_max.text = ShareRes.create("item.award_type", TreasureChestCfg.TREASURE_CHEST_TYPE).MaxGrid
end

return ui
