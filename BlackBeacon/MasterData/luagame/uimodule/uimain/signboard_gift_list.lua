local SIGNBOARD_GIFT_ITEM_KEY = "SIGNBOARD_GIFT_ITEM_KEY"
local GIFT_ITEM_CLASS = require("uimodule.uimain.signboard_gift_list_item")
local FAVOR_ITEM_SUBTYPE_ID = ShareRes.create("item.item_subtype", "favor_item").SubtypeId
local FAVOR_ITEM_TYPE_ID = ShareRes.create("item.item_subtype", "favor_item").TypeId
local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local JUMPID = ShareRes.get_comm_value("BuddyGiftGetWayJumpId") or 22706

function ui:ui_finish_load()
  self:set_button("BtnClearGift", function()
    self:clear_selected()
  end)
  self:set_button("BtnGetGift", function()
    SysOpenMgr:jump_to_sys(JUMPID, true)
  end)
  self:set_button("BtnUseGift", function()
    if not next(self.v_selected_item_map) then
      return
    end
    local consume_list = {
      bag_type = FAVOR_ITEM_TYPE_ID,
      item_list = {}
    }
    for item_id, count in pairs(self.v_selected_item_map) do
      local item_info = BagMgr:get_item(item_id)
      if item_info then
        table.insert(consume_list.item_list, {
          uuid = item_info.uuid,
          count = count,
          param = self.v_buddy_id
        })
      end
    end
    local old_lv = CharacterMgr:get_buddy_by_id(self.v_buddy_id).favor_lv
    local final_lv = self:get_final_lv()
    BagMgr:request_use_item(consume_list, function(ok)
      if ok then
        if final_lv > old_lv then
          SignBoardGirlMgr:play_favor_lv_up_action(self.v_buddy_id, final_lv)
        else
          SignBoardGirlMgr:play_favor_exp_up_action(self.v_buddy_id)
        end
        self:refresh_data_list()
        self:clear_selected()
        self.v_parent_ui:on_favor_up()
        Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.gift_UI_SOUND)
      end
    end)
  end)
  self:register_exist_auto_template(SIGNBOARD_GIFT_ITEM_KEY, self.v_uiobjects.ItemObjCom1, self.v_uiobjects.Content)
end

function ui:clear_selected()
  UtilTable.clear_map(self.v_selected_item_map)
  for _, data in ipairs(self.v_item_list) do
    data.item_ui:update_selected()
  end
  self:refresh_btn()
end

function ui:ui_on_show(buddy_id)
  self.v_selected_item_map = {}
  self:refresh_data_list(buddy_id)
  self:bind_auto_mq(Const.MSG_FAVOR_ITEM_SELECTED_CHANGE, self.refresh_selected_items, self)
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self._on_item_update, self)
end

function ui:ui_on_hide()
  self:clear_selected()
  self:remove_wrap_list()
end

function ui:ui_on_destroy()
end

function ui:_on_item_update()
  self:refresh_data_list()
end

function ui:refresh_data_list(buddy_id)
  self.v_buddy_id = buddy_id or self.v_buddy_id
  local show_item_cfg = ShareRes.get_favor_show_item_cfg()
  self:remove_wrap_list()
  self.v_item_list = {}
  self.v_id2_favor_val = {}
  for item_id, _ in pairs(show_item_cfg) do
    local own_num = BagMgr:get_item_num(item_id)
    if own_num > 0 then
      local item_cfg = ShareRes.get_item_cfg(item_id)
      local favor_item_cfg = ShareRes.get_favor_item_cfg(item_id, self.v_buddy_id)
      local favor_val, is_favorite
      if favor_item_cfg then
        is_favorite = true
        favor_val = favor_item_cfg.RepeatFavor
      elseif item_cfg.Type == FAVOR_ITEM_TYPE_ID and item_cfg.Subtype == FAVOR_ITEM_SUBTYPE_ID then
        favor_val = item_cfg.Arg[1]
      end
      self.v_item_list[#self.v_item_list + 1] = {
        item_id = item_id,
        favor_val = favor_val,
        priority = item_cfg.Priority,
        quality = item_cfg.Quality,
        own_num = own_num,
        is_favorite = is_favorite
      }
      self.v_id2_favor_val[item_id] = favor_val
    end
  end
  table.sort(self.v_item_list, function(a, b)
    if a.priority ~= b.priority then
      return a.priority > b.priority
    end
    if a.favor_val and b.favor_val and a.favor_val ~= b.favor_val then
      return a.favor_val > b.favor_val
    end
    if a.quality ~= b.quality then
      return a.quality > b.quality
    end
    return a.item_id > b.item_id
  end)
  self:refresh_item_list()
  self:refresh_btn()
end

function ui:refresh_item_list()
  local is_empty = not self.v_item_list or 0 == #self.v_item_list
  self.v_uiobjects.NoItem:SetActive(is_empty)
  self.v_uiobjects.BtnGetGift:SetActive(is_empty)
  self.v_uiobjects.BtnClearGift:SetActive(not is_empty)
  self.v_uiobjects.BtnUseGift:SetActive(not is_empty)
  self.v_uiobjects.GiftScroll:SetActive(not is_empty)
  self:give_back_auto_cache(SIGNBOARD_GIFT_ITEM_KEY)
  if 0 == #self.v_item_list then
    return
  end
  for _, data in ipairs(self.v_item_list) do
    local item_go = self:get_auto_cache(SIGNBOARD_GIFT_ITEM_KEY)
    local item_ui = GIFT_ITEM_CLASS:ui_wrap_ex(self, item_go, true)
    item_ui:set_data(data)
    item_ui:update_selected(self.v_selected_item_map[data.item_id])
    data.item_ui = item_ui
  end
end

function ui:refresh_btn()
  Util.apply_grey_ex(self.v_uiobjects.BtnUseGift, next(self.v_selected_item_map) == nil)
  self.v_parent_ui:refresh_favors()
end

function ui:refresh_selected_items(msg)
  local item_id = msg.mm_x
  local add_num = msg.mm_y
  if add_num > 0 and self:check_selected_overflow() then
    self:refresh_btn()
    return
  end
  local selected_num = self.v_selected_item_map[item_id]
  local own_num = BagMgr:get_item_num(item_id)
  local cur_num = selected_num and selected_num + add_num or add_num
  cur_num = own_num < cur_num and own_num or cur_num
  if cur_num <= 0 then
    self.v_selected_item_map[item_id] = nil
  else
    self.v_selected_item_map[item_id] = cur_num
  end
  for _, data in ipairs(self.v_item_list) do
    if data.item_id == item_id then
      data.item_ui:update_selected(self.v_selected_item_map[item_id])
    end
  end
  self:refresh_btn()
end

function ui:check_selected_overflow()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local favor_already_exp = buddy_info.favor_item_already_exp or 0
  local day_max_exp = ShareRes.get_comm_value("DayItemGrantFavorMaxCount")
  local add_favor_val = 0
  for item_id, num in pairs(self.v_selected_item_map) do
    if self.v_id2_favor_val[item_id] then
      add_favor_val = add_favor_val + self.v_id2_favor_val[item_id] * num
    end
  end
  local favor_lv_cfg = ShareRes.get_favor_lv_cfg(self.v_buddy_id)
  if buddy_info.favor_lv >= #favor_lv_cfg then
    Util.show_message_tip(1891)
    return true
  elseif day_max_exp <= favor_already_exp + add_favor_val then
    Util.show_message_tip(2231)
    return true
  else
    local to_max_exp = -buddy_info.favor_exp
    for i = buddy_info.favor_lv, #favor_lv_cfg - 1 do
      to_max_exp = to_max_exp + favor_lv_cfg[i].Exp
    end
    if add_favor_val >= to_max_exp then
      Util.show_message_tip(1891)
      return true
    end
  end
  return false
end

function ui:get_final_lv()
  if not self.v_buddy_id or not self.v_selected_item_map then
    return 0, 0
  end
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local favor_already_exp = buddy_info.favor_item_already_exp or 0
  local day_max_exp = ShareRes.get_comm_value("DayItemGrantFavorMaxCount")
  local add_favor_val = 0
  for item_id, num in pairs(self.v_selected_item_map) do
    if self.v_id2_favor_val[item_id] then
      add_favor_val = add_favor_val + self.v_id2_favor_val[item_id] * num
    end
  end
  if day_max_exp <= favor_already_exp + add_favor_val then
    add_favor_val = day_max_exp - favor_already_exp
  end
  local final_lv
  local favor_lv_cfg = ShareRes.get_favor_lv_cfg(self.v_buddy_id)
  local favor_val = add_favor_val + buddy_info.favor_exp
  for i = buddy_info.favor_lv, #favor_lv_cfg - 1 do
    final_lv = i
    favor_val = favor_val - favor_lv_cfg[i].Exp
    if favor_val < 0 then
      return final_lv, add_favor_val
    elseif i == #favor_lv_cfg - 1 then
      return #favor_lv_cfg, add_favor_val
    end
  end
  return 0, 0
end

function ui:remove_wrap_list()
  if self.v_item_list then
    for _, item in pairs(self.v_item_list) do
      item.item_ui:ui_hide()
      item.item_ui:ui_destroy()
    end
    self.v_item_list = nil
  end
end

return ui
