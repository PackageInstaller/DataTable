local LoopListClass = require("ui.widget.infinite_loop_list")
local GemItemClass = require("uimodule.weapon.gem_item")
local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BtnAllDel", function()
    self:remove_all()
    self:on_click_slot(nil)
  end)
  self:set_button("BtnAutoEquip", function()
    self:auto_use_all()
    self:on_click_slot(nil)
  end)
  self:set_button("CloseBtn", function()
    self:on_click_slot(nil)
  end)
  self:set_button("BtnRet1", function()
    self:on_click_slot(nil)
  end)
  self:set_button("Btn_screenUpDown", function()
    GemStoneMgr:change_sort_drop()
    self:refresh_left_list()
    self:set_select_left_gem(self.v_left_selected_gem_uuid, true)
  end)
  self:set_button("Btn_screen", function()
    UIMgr:get_ui("source_filter_tips"):ui_show(function()
      self:refresh_left_list()
      self:set_select_left_gem(self.v_left_selected_gem_uuid, true)
    end)
  end)
  self.v_anim_add_all = Util.get_playabledirector("Animation/Ani_SourceObj_In", self.v_parent_ui.v_object)
  self.v_anim_left_out = Util.get_playabledirector("Animation/Ani_Source_LeftList_Out", self.v_parent_ui.v_object)
  self.v_anim_select = Util.get_playabledirector("Animation/Ani_SourceObj_Select", self.v_parent_ui.v_object)
  local auto_equip_red = Util.get_child_gameobj("RedPoint", self.v_uiobjects.BtnAutoEquip)
  RedPointMgr:bind_redpoint(self, auto_equip_red, RedEnum.CHAR_EQUIP_SOURCE_WEAR_BTN)
  self.v_uiobjects.BtnRet1:SetActive(true)
  self.v_left_scroll_list = LoopListClass:new(self, self.v_uiobjects.ScrollView, GemItemClass)
end

function ui:remove_all()
  if not self.v_gem_slot_data then
    return
  end
  local remove_pos = {}
  for pos, data in ipairs(self.v_gem_slot_data) do
    if 0 ~= data.gem_uuid then
      remove_pos[#remove_pos + 1] = pos
      self.v_update_blocker = true
    end
  end
  for index, pos in ipairs(remove_pos) do
    local is_end = index == #remove_pos
    GemStoneMgr:req_c2gs_equip_gemstone_down(self.v_equip_uuid, pos, function()
      if is_end then
        self.v_update_blocker = false
        self:refresh_gem_slots()
      end
    end)
  end
end

function ui:auto_use_all()
  if not self.v_gem_slot_data then
    return
  end
  local free_gem_list = GemStoneMgr:get_free_gem_list()
  if not next(free_gem_list) then
    return
  end
  local equip_using_gem = GemStoneMgr:get_equip_using_gem(self.v_equip_uuid)
  local add_data = {}
  for pos, data in ipairs(self.v_gem_slot_data) do
    if not data.is_not_use and not data.is_lock and 0 == data.gem_uuid then
      for index, free_gem in ipairs(free_gem_list) do
        if free_gem.quality <= data.quality and free_gem.quality <= data.quality then
          local is_repeat = false
          for using_gem_pos, using_gem_id in ipairs(equip_using_gem) do
            if using_gem_pos ~= pos and free_gem.id == using_gem_id then
              is_repeat = true
            end
          end
          if not is_repeat then
            add_data[#add_data + 1] = {
              uuid = free_gem.uuid,
              pos = pos
            }
            self.v_update_blocker = true
            table.remove(free_gem_list, index)
            break
          end
        end
      end
    end
  end
  for index, data in ipairs(add_data) do
    local is_end = index == #add_data
    GemStoneMgr:req_c2gs_equip_gemstone_up(self.v_equip_uuid, data.uuid, data.pos, function()
      if is_end then
        self.v_update_blocker = false
        self:refresh_gem_slots()
        if self.v_anim_add_all then
          self.v_anim_add_all.time = 0
          self.v_anim_add_all:Play()
        end
      end
    end)
  end
end

function ui:refresh_slot_red()
  if not self.v_gem_slot_data then
    return
  end
  local page_have_red, red_pos = GemStoneMgr:get_slot_red(self.v_equip_uuid)
  for pos, data in ipairs(self.v_gem_slot_data) do
    data.red_go:SetActive(true == red_pos[pos])
  end
end

function ui:check_auto_use()
  if not self.v_gem_slot_data then
    return
  end
  local free_gem_list = GemStoneMgr:get_free_gem_list()
  if not next(free_gem_list) then
    return
  end
  local equip_using_gem = GemStoneMgr:get_equip_using_gem(self.v_equip_uuid)
  for pos, data in ipairs(self.v_gem_slot_data) do
    if not data.is_not_use and not data.is_lock and 0 == data.gem_uuid then
      for index, free_gem in ipairs(free_gem_list) do
        if free_gem.quality <= data.quality then
          local is_repeat = false
          for using_gem_pos, using_gem_id in ipairs(equip_using_gem) do
            if using_gem_pos ~= pos and free_gem.id == using_gem_id then
              is_repeat = true
            end
          end
          if not is_repeat then
            return true
          end
        end
      end
    end
  end
end

function ui:ui_on_hide()
  self.v_left_scroll_list:ui_on_hide()
end

function ui:ui_on_destroy()
  self.v_left_scroll_list:ui_on_destroy()
end

function ui:ui_on_show()
  self.v_right_selected_gem_pos = 0
  self.v_left_selected_gem_uuid = 0
  self:register_event()
end

function ui:refresh_weapon_info()
  self:refresh_gem_slots()
end

function ui:refresh_by_msg()
  self:refresh_gem_slots()
  self:on_click_slot(self.v_right_selected_gem_pos, self.v_left_selected_gem_uuid)
end

function ui:refresh(equip_uuid, init_selected_pos)
  self.v_equip_uuid = equip_uuid
  if init_selected_pos then
    self.v_right_selected_gem_pos = init_selected_pos
  end
  self:refresh_base_gem_slot()
  self:refresh_gem_slots()
  self:on_click_slot(init_selected_pos)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_CLICK_GEM_LIST, self.on_click_gem_item, self)
  self:bind_auto_mq(Const.MSG_ON_GEM_DELETE, self.refresh_by_msg, self)
  self:bind_auto_mq(Const.MSG_ON_GEM_UPDATE, self.refresh_gem_slots, self)
  self:bind_auto_mq(Const.MSG_ROLE_WEAPENLIST_CHANGE, self.refresh_weapon_info, self)
end

function ui:on_click_gem_item(msg)
  local uuid = msg.mm_x
  self:set_select_left_gem(uuid, true)
end

function ui:on_click_slot(pos, right_selected_gem_uuid)
  if self.v_right_selected_gem_pos ~= pos then
    self.v_right_selected_gem_pos = pos
    if self.v_right_selected_gem_pos ~= nil and self.v_anim_select then
      self.v_anim_select.time = 0
      self.v_anim_select:Play()
    end
  end
  for _pos, selected_obj in ipairs(self.v_slot_selected_obj_list) do
    selected_obj:SetActiveEx(pos == _pos)
  end
  self:set_left_list_visiable(nil ~= pos, right_selected_gem_uuid)
end

function ui:set_left_list_visiable(visiable, _right_selected_gem_uuid)
  local is_change = self.v_left_list_visiable ~= visiable
  self.v_left_list_visiable = visiable
  self.v_parent_ui:set_left_tab_visiable(not visiable)
  if visiable then
    if self.v_anim_left_out then
      self.v_anim_left_out:Stop()
    end
    self:refresh_left_list()
    if _right_selected_gem_uuid then
      self:set_select_left_gem(_right_selected_gem_uuid)
      return
    end
    local right_selected_gem_uuid = GemStoneMgr:get_gem_uuid_by_pos(self.v_equip_uuid, self.v_right_selected_gem_pos)
    if 0 == right_selected_gem_uuid then
      local right_quality = self:get_right_selected_gem_pos_quality()
      for _, v in ipairs(self.v_left_list_data) do
        if right_quality >= v.quality then
          self:set_select_left_gem(v.uuid)
          return
        end
      end
      local first_data = self.v_left_list_data[1]
      if first_data then
        self:set_select_left_gem(first_data.uuid)
      end
    else
      self:set_select_left_gem(right_selected_gem_uuid)
    end
  else
    if self.v_anim_left_out and is_change then
      self.v_anim_left_out.time = 0
      self.v_anim_left_out:Play()
    end
    self:hide_info_tips()
  end
end

function ui:refresh_left_list()
  self.v_left_list_data = GemStoneMgr:get_gem_sort_list()
  self.v_left_scroll_list:refresh_data(self.v_left_list_data)
  local is_list_empty = 0 == #self.v_left_list_data
  self.v_uiobjects.NoItem:SetActive(is_list_empty)
  local rot_z = GemStoneMgr:get_sort_drop() and 180 or 0
  self.v_uicompents.ScreenUpDown_rect:SetEuler(0, 0, rot_z)
end

function ui:set_select_left_gem(uuid, dont_scroll)
  self.v_left_selected_gem_uuid = uuid
  local selected_idx
  for idx, ui_item_data in pairs(self.v_left_list_data) do
    local is_selected = ui_item_data.uuid == self.v_left_selected_gem_uuid
    if is_selected then
      selected_idx = idx
      break
    end
  end
  if not dont_scroll and selected_idx then
    if self.v_left_scroll_list:get_is_in_view(selected_idx) then
      self.v_left_scroll_list:scroll_to_old_pos()
    else
      self.v_left_scroll_list:scroll_to_item(selected_idx - 1)
    end
  end
  local all_itmes = self.v_left_scroll_list:get_all_uis()
  for _, ui_item in pairs(all_itmes) do
    ui_item:update_selected()
  end
  if self.v_left_selected_gem_uuid and 0 ~= self.v_left_selected_gem_uuid then
    self:show_info_tips()
  else
    self:hide_info_tips()
  end
end

function ui:show_info_tips()
  local right_pos_quality = self.v_gem_slot_data[self.v_right_selected_gem_pos].quality
  local source_item_tips = UIMgr:try_get_visible_ui("source_item_tips")
  local operate_data = {
    operate_equip_uuid = self.v_equip_uuid,
    operate_pos = self.v_right_selected_gem_pos,
    operate_pos_quality = right_pos_quality
  }
  if source_item_tips then
    source_item_tips:refresh(self.v_left_selected_gem_uuid, operate_data)
  else
    UIMgr:get_ui("source_item_tips"):ui_show(self.v_left_selected_gem_uuid, operate_data)
  end
end

function ui:hide_info_tips()
  UIMgr:try_hide_ui("source_item_tips")
end

function ui:refresh_base_gem_slot()
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local uicom = self.v_uicompents
  local equip_id = equip_info.id
  local advance_lv = equip_info.advance
  local equip_cfg = ShareRes.create("equip.equip", equip_id)
  local base_gem_id = equip_cfg.BirthGemstoneId
  self.v_uiobjects.ExSourceObj:SetActive(nil ~= base_gem_id)
  self.v_uiobjects.ExSourceBtn:SetActive(nil ~= base_gem_id)
  if base_gem_id then
    ResMgr:load_set_icon(uicom.ExSourceIcon_img, ShareRes.get_gem_icon_path(base_gem_id))
    self:set_button_listener(self.v_uicompents.ExSourceBtn_btn, function()
      Util.show_message_tip(2157)
    end)
  end
  local get_gem_lv_cfg = ShareRes.get_gem_lv_cfg_ex(base_gem_id, advance_lv)
  if not get_gem_lv_cfg or not get_gem_lv_cfg.MagicId then
    self.v_uiobjects.ExSourceDesc:SetActive(false)
    self.v_uiobjects.ExSourceNoDesc:SetActive(true)
  else
    self.v_uiobjects.ExSourceDesc:SetActive(true)
    self.v_uiobjects.ExSourceNoDesc:SetActive(false)
    uicom.ExSourceLv_txt.text = Util.format_str("Lv.{1}", get_gem_lv_cfg.Lv)
    uicom.ExSourceDesc_txt.text = get_gem_lv_cfg.Desc
  end
end

function ui:refresh_gem_slots()
  if self.v_update_blocker then
    return
  end
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local equip_id = equip_info.id
  local advance_lv = equip_info.advance
  local equip_cfg = ShareRes.create("equip.equip", equip_id)
  local quality_cfg = ShareRes.create("equip.equip_quality_icon", equip_cfg.Quality)
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_id)
  local gem_slot_data = {}
  for i = 1, 3 do
    local slot_quality = quality_cfg.GemstoneSlotId[i]
    local is_lock = quality_cfg.BirthSlot[i] ~= true
    gem_slot_data[i] = {
      is_not_use = nil == slot_quality,
      is_lock = is_lock,
      quality = slot_quality,
      gem_uuid = 0,
      id = 0
    }
  end
  for i, cfg in ipairs(advance_cfg) do
    local lv = cfg.Lv
    if advance_lv < lv then
      break
    end
    if cfg.UnlockGemstoneSlotId then
      if type(cfg.UnlockGemstoneSlotId) == "number" then
        local pos = cfg.UnlockGemstoneSlotId
        gem_slot_data[pos].is_lock = false
      else
        for _, pos in pairs(cfg.UnlockGemstoneSlotId) do
          gem_slot_data[pos].is_lock = false
        end
      end
    end
    if cfg.QualityChange then
      for _, data in pairs(cfg.QualityChange) do
        local pos = data[1]
        local qua = data[2]
        gem_slot_data[pos].quality = qua
      end
    end
  end
  local is_all_empty = true
  local gemstone_slot = equip_info.gemstone_slot
  for key, data in pairs(gemstone_slot) do
    if data.pos > 0 then
      local gem_uuid = data.uuid or 0
      gem_slot_data[data.pos].gem_uuid = gem_uuid
      if 0 ~= gem_uuid then
        is_all_empty = false
        local gem_data = GemStoneMgr:get_gem_data(gem_uuid)
        if gem_data then
          gem_slot_data[data.pos].id = gem_data.id
        end
      end
    end
  end
  self.v_gem_slot_data = gem_slot_data
  Util.apply_grey_ex(self.v_uiobjects.BtnAllDel, is_all_empty)
  self.v_uicompents.BtnAllDel_btn.interactable = not is_all_empty
  local can_auto_use = self:check_auto_use()
  Util.apply_grey_ex(self.v_uiobjects.BtnAutoEquip, not can_auto_use, true)
  self.v_uicompents.BtnAutoEquip_btn.interactable = can_auto_use
  GemStoneMgr:set_equip_gem_red(can_auto_use)
  self:set_gem_icon(gem_slot_data)
  self:refresh_slot_red()
end

function ui:set_gem_icon(gem_slot_data)
  self.v_slot_selected_obj_list = {}
  local equip_gemstone_quality = ShareRes.create("equip.equip_gemstone_quality")
  for i, data in ipairs(gem_slot_data) do
    local slot_go = self.v_uiobjects["Slot" .. i]
    local btn = Util.get_button("Btn_", slot_go)
    local not_use_desc = Util.get_child_gameobj("DescBg/NotUseDesc_", slot_go)
    local empty_desc = Util.get_child_gameobj("DescBg/EmptyDesc_", slot_go)
    local lock_desc = Util.get_child_gameobj("DescBg/LockDesc_", slot_go)
    local desc = Util.get_text("DescBg/Desc_", slot_go)
    data.red_go = Util.get_child_gameobj("Btn_/RedPoint", slot_go)
    self.v_slot_selected_obj_list[i] = Util.get_child_gameobj("UnlockObj_/Select_", slot_go)
    btn.gameObject:SetActiveEx(not data.is_not_use)
    not_use_desc:SetActive(data.is_not_use)
    empty_desc:SetActiveEx(not data.is_not_use and not data.is_lock and 0 == data.gem_uuid)
    lock_desc:SetActiveEx(not data.is_not_use and data.is_lock)
    desc.gameObject:SetActiveEx(not data.is_not_use and not data.is_lock and 0 ~= data.gem_uuid)
    local lock_go = Util.get_child_gameobj("Lock_", slot_go)
    local unlock_go = Util.get_child_gameobj("UnlockObj_", slot_go)
    lock_go:SetActiveEx(not data.is_not_use and data.is_lock)
    unlock_go:SetActiveEx(not data.is_not_use and not data.is_lock)
    if not data.is_not_use then
      local quality_cfg = equip_gemstone_quality[data.quality]
      local gem_go = Util.get_child_gameobj("UnlockObj_/QualityBg_", slot_go)
      local lv_txt = Util.get_text("UnlockObj_/LvBg_/SourceLv_", slot_go)
      local quality_img = Util.get_image("UnlockObj_/QualityBg_", slot_go)
      local icon_img = Util.get_image("UnlockObj_/QualityBg_/SourceIcon_", slot_go)
      local lv_bg_go = Util.get_child_gameobj("UnlockObj_/LvBg_", slot_go)
      gem_go:SetActiveEx(not data.is_lock and 0 ~= data.gem_uuid)
      lv_bg_go:SetActiveEx(not data.is_lock and 0 ~= data.gem_uuid)
      if not data.is_lock then
        local square_pos = {}
        for _, v in ipairs(quality_cfg.QualitySquarePos) do
          square_pos[v] = 1
        end
        for index = 1, 4 do
          local quality_point_img = Util.get_image("UnlockObj_/HoleQuality/Point" .. index, slot_go)
          quality_point_img.gameObject:SetActiveEx(1 == square_pos[index])
          if 1 == square_pos[index] then
            ResMgr:load_set_icon(quality_point_img, quality_cfg.QualitySquareIcon)
          end
        end
        if 0 ~= data.gem_uuid then
          local gem_data = GemStoneMgr:get_gem_data(data.gem_uuid)
          local gem_quality = ShareRes.get_gem_quality(gem_data.id)
          ResMgr:load_set_icon(quality_img, equip_gemstone_quality[gem_quality].QualityIcon)
          ResMgr:load_set_icon(icon_img, ShareRes.get_gem_icon_path(gem_data.id))
          lv_txt.text = Util.format_str("Lv.{1}", gem_data.level)
          local level_cfg = ShareRes.get_gem_lv_cfg(gem_data.id)
          desc.text = level_cfg[gem_data.level].Desc
        end
      end
      self:set_button_listener(btn, function()
        if data.is_lock then
          Util.show_message_tip(2243)
        else
          self:on_click_slot(i)
        end
      end)
    end
  end
end

function ui:get_right_selected_gem_pos_quality()
  if not (0 ~= self.v_right_selected_gem_pos and self.v_gem_slot_data) or not self.v_gem_slot_data[self.v_right_selected_gem_pos] then
    return 5
  end
  return self.v_gem_slot_data[self.v_right_selected_gem_pos].quality or 5
end

function ui:is_repeat_right_unselected_gem(gem_id)
  if not (0 ~= self.v_right_selected_gem_pos and self.v_gem_slot_data) or not self.v_gem_slot_data[self.v_right_selected_gem_pos] then
    return false
  end
  for pos, slot_data in ipairs(self.v_gem_slot_data) do
    if pos ~= self.v_right_selected_gem_pos and gem_id == slot_data.id then
      return true
    end
  end
  return false
end

return ui
