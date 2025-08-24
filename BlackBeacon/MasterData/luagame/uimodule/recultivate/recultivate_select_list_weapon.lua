local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SELECT_ITEM_CLASS = require("uimodule.recultivate.recultivate_select_list_item_weapon")
local _insert = table.insert
local GridLayoutGroup = UnityEngine.UI.GridLayoutGroup
local LoopListClass = require("ui.widget.infinite_loop_list")
local SORT_RULE = {
  "lv",
  "break_lv",
  "quality",
  "id"
}

function ui:ui_finish_load()
  self:set_button("FullBg", function()
    if self.v_is_closing then
      return
    end
    self.v_is_closing = true
    self.v_uiobjects.Mask:SetActive(true)
    self:remove_delay_close_timer()
    self.v_is_closing = false
    self.v_uiobjects.Mask:SetActive(false)
    self:ui_hide()
  end)
  self.v_content_grid_layout_group = Util.get_component(nil, self.v_uiobjects.Content, typeof(GridLayoutGroup))
  self.v_goods_view = LoopListClass:new(self, self.v_uiobjects.ScrollView, SELECT_ITEM_CLASS)
end

function ui:ui_on_show(item_id, selected_weapon_uuid)
  self.v_selected_uuid = selected_weapon_uuid
  self.v_target_range = ShareRes.get_item_reset_develop_list(item_id)
  self.v_is_closing = false
  self.v_uiobjects.Mask:SetActive(false)
  self:refresh_select_list()
  self:bind_auto_mq(Const.MSG_ON_BUDDY_CHANGE, self.refresh_select_list, self)
end

function ui:ui_on_hide()
  self:remove_delay_close_timer()
  self.v_goods_view:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_goods_view:ui_on_destroy()
end

function ui:remove_delay_close_timer()
  if self.v_delay_close_timer then
    Timer:remove_timer(self.v_delay_close_timer)
    self.v_delay_close_timer = nil
  end
end

function ui:refresh_select_list()
  self:set_screen_list()
  local select_idx = 0
  self.v_goods_view:refresh_data(self.v_screen_list)
  self:update_item_selected(self.v_selected_uuid)
  for idx, equip_info in ipairs(self.v_screen_list) do
    if self.v_selected_uuid == equip_info.uuid then
      select_idx = idx
    end
  end
  self.v_uicompents.Content_rect:SetAnchoredPositionA(0, 0)
  self.v_uiobjects.EmptyTips:SetActiveEx(0 == #self.v_screen_list)
end

function ui:set_screen_list()
  self.v_screen_list = {}
  local own_list = UtilTable.copy_table(CharacterMgr:get_equip_list())
  for _, info in pairs(own_list) do
    if info.lv > 1 then
      local in_target_range = self.v_target_range and UtilTable.contains(self.v_target_range, info.id)
      if in_target_range then
        info.quality = ShareRes.create("equip.equip", info.id).Quality
        _insert(self.v_screen_list, info)
      end
    end
  end
  table.sort(self.v_screen_list, function(info_a, info_b)
    for _, type in ipairs(SORT_RULE) do
      if info_a[type] ~= info_b[type] then
        return info_a[type] > info_b[type]
      end
    end
  end)
end

function ui:on_click_weapon(uuid)
  if self.v_is_closing then
    return
  end
  if uuid == self.v_selected_uuid then
    return
  end
  self.v_selected_uuid = uuid
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_RECULTIVATE_TARGET)
  msg.mm_x = uuid
  self:update_item_selected(uuid)
end

function ui:update_item_selected(uuid)
  if self.v_goods_view then
    local all_itmes = self.v_goods_view:get_all_uis()
    for _, ui_item in pairs(all_itmes) do
      if ui_item.v_visible then
        ui_item:update_item_selected(uuid)
      end
    end
  end
end

return ui
