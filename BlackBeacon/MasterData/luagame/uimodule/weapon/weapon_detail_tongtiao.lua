local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TONGTIAO_WEAPON_LIST_ITEM_KEY = "TONGTIAO_WEAPON_LIST_ITEM_KEY"
local CommonDef = require("cs_share.common_define")
local CHAR_HELPER = require("uimodule.character.char_helper")
local AssetBarView = require("ui.asset_bar.asset_bar")

function ui:ui_finish_load()
  self.max_select_count = 4
  self:set_button("BtnAllReduce", function()
    self:un_select_all()
  end)
  self:set_button("BtnAutoAdd", function()
    self:auto_add()
  end)
  self:set_button("BtnTongtiao", function()
    self:click_btn_tong_tiao()
  end)
  self:set_button("CloseBtn", function()
    self:set_left_list_visiable(false)
  end)
  self:set_button("Lock", function()
    CharacterMgr:equip_lock(self.v_equip_uuid, function()
      self:refresh_lock_view()
    end)
  end)
  self:set_button("BtnNextLvPreview", function()
    self:un_select_all()
    self:refresh_skill(true)
    self.v_uiobjects.Cost:SetActiveEx(false)
  end)
  self:set_button("BtnNowLv", function()
    self:refresh_skill()
    self:refresh_cost_view()
  end)
  self.v_uiobjects.MaxText:SetActive(false)
  self.v_anim_cost_change = Util.get_playabledirector("Animation/Ani_Tongtiao_Select", self.v_parent_ui.v_object)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
  self:register_exist_auto_template(TONGTIAO_WEAPON_LIST_ITEM_KEY, self.v_uiobjects.WeaponTem, self.v_uiobjects.Content)
end

function ui:click_btn_tong_tiao()
  if not self.select_equip_list or 0 == #self.select_equip_list then
    Util.show_message_tip(2152)
    if not self.v_left_list_visiable then
      self:set_left_list_visiable(true)
    end
    return
  end
  local is_lock = false
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local send_list = {}
  for i, v in pairs(self.select_equip_list) do
    if 0 ~= v then
      if not is_lock and CHAR_HELPER.is_equip_lock(v) then
        is_lock = true
      end
      send_list[#send_list + 1] = v
    end
  end
  
  local function cb()
    CharacterMgr:advance_equip_new(self.v_equip_uuid, send_list, self.v_cost_item_num, function()
      UIMgr:get_ui("weapon_tongtiao_finish"):ui_show(equip_info.advance, self.v_equip_uuid)
      self:un_select_all()
      self:set_left_list_visiable(false)
    end)
  end
  
  if not is_lock then
    cb()
  else
    Util.show_notify_popup_message(cb, "武器已锁定，是否取消锁定并选为消耗材料？")
  end
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:ui_on_show()
  self:register_event()
  self.v_asset_bar:reset_by_id_list({
    32,
    Config.WEAPON_TONGTIAO_ITEMID
  })
  self.v_asset_bar:on_create()
end

function ui:refresh_by_msg()
  if not self.v_visible then
    return
  end
  self:_init_weapon_list()
  self:refresh_info_view()
end

function ui:refresh(equip_uuid)
  self.v_equip_uuid = equip_uuid
  self.v_uiobjects.LeftList:SetActive(false)
  self:_init_weapon_list()
  self:refresh_info_view()
  self:refresh_lock_view()
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_UPDATE_EQUIP_LOCK, self.response_refresh_equip_view, self)
  self:bind_auto_mq(Const.MSG_ROLE_WEAPENLIST_CHANGE, self.refresh_by_msg, self)
end

function ui:refresh_lock_view()
  local equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local img_lock = Util.get_image("img_lock", self.v_uiobjects.Lock)
  local img_no_lock = Util.get_image("img_no_lock", self.v_uiobjects.Lock)
  local is_lock = 1 == equip_info.lock
  img_lock.gameObject:SetActive(is_lock)
  img_no_lock.gameObject:SetActive(not is_lock)
end

local NORMAL_COLOR = "f5ede2"
local UP_COLOR = "efc66e"

function ui:refresh_info_view()
  self.v_equip_info = CharacterMgr:get_equip_info(self.v_equip_uuid)
  local equip_id = self.v_equip_info.id
  local equip_cfg = ShareRes.create("equip.equip", equip_id)
  local advance_lv = self.v_equip_info.advance
  local uicom = self.v_uicompents
  uicom.Equip_name_txt.text = Util.format_quality_txt_color(equip_cfg.Name, equip_cfg.Quality)
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_id)
  self.v_is_max = advance_lv >= #advance_cfg
  self:refresh_skill()
  self:refresh_cost_view()
end

function ui:get_advance_up_lv()
  if 0 == #self.select_equip_list then
    return 0
  end
  local up_lv = 0
  if self.v_cost_item_num and self.v_cost_item_num > 0 then
    up_lv = self.v_cost_item_num
  end
  for index, equip_uuid in ipairs(self.select_equip_list) do
    if 0 ~= equip_uuid then
      local equip_info = CharacterMgr:get_equip_info(equip_uuid)
      up_lv = up_lv + equip_info.advance
    end
  end
  local equip_id = self.v_equip_info.id
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_id)
  if up_lv > #advance_cfg - self.v_equip_info.advance then
    up_lv = #advance_cfg - self.v_equip_info.advance
  end
  up_lv = up_lv > 0 and up_lv or 0
  return up_lv
end

function ui:refresh_base_gem_slot(up_lv)
  local uicom = self.v_uicompents
  local equip_id = self.v_equip_info.id
  local advance_lv = self.v_equip_info.advance
  local equip_cfg = ShareRes.create("equip.equip", equip_id)
  local base_gem_id = equip_cfg.BirthGemstoneId
  self.v_uiobjects.BaseSlot:SetActive(nil ~= base_gem_id)
  if base_gem_id then
    ResMgr:load_set_icon(uicom.ExSourceIcon_img, ShareRes.get_gem_icon_path(base_gem_id))
  end
  local get_gem_lv_cfg = ShareRes.get_gem_lv_cfg_ex(base_gem_id, advance_lv + up_lv)
  if not get_gem_lv_cfg or not get_gem_lv_cfg.MagicId then
    self.v_uiobjects.SkillContent:SetActive(false)
    self.v_uiobjects.NoSkill:SetActive(true)
    self.v_uiobjects.BaseSlotUpgradeFlag:SetActive(false)
  else
    self.v_uiobjects.SkillContent:SetActive(true)
    self.v_uiobjects.NoSkill:SetActive(false)
    self.v_uiobjects.BaseSlotUpgradeFlag:SetActive(up_lv > 0)
    local use_color = up_lv > 0 and UP_COLOR or NORMAL_COLOR
    uicom.SkillLv_txt.text = Util.format_str("<color=#{1}>Lv.{2}</color>", use_color, get_gem_lv_cfg.Lv)
    if up_lv > 0 then
      uicom.SkillDetail_txt.text = Util.format_str("<color=#{1}>{2}</color>", UP_COLOR, get_gem_lv_cfg.Desc)
    else
      uicom.SkillDetail_txt.text = get_gem_lv_cfg.Desc
    end
  end
end

function ui:refresh_gem_slots(up_lv)
  local equip_info = self.v_equip_info
  local equip_id = equip_info.id
  local advance_lv = equip_info.advance
  local target_lv = advance_lv + up_lv
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
      gem_uuid = 0
    }
  end
  for i, cfg in ipairs(advance_cfg) do
    local lv = cfg.Lv
    if target_lv < lv then
      break
    end
    if cfg.UnlockGemstoneSlotId then
      if type(cfg.UnlockGemstoneSlotId) == "number" then
        local pos = cfg.UnlockGemstoneSlotId
        gem_slot_data[pos].is_lock = false
        if advance_lv < lv then
          gem_slot_data[pos].show_unlock_flag = true
        end
      else
        for _, pos in pairs(cfg.UnlockGemstoneSlotId) do
          gem_slot_data[pos].is_lock = false
          if advance_lv < lv then
            gem_slot_data[pos].show_unlock_flag = true
          end
        end
      end
    end
    if cfg.QualityChange then
      for _, data in pairs(cfg.QualityChange) do
        local pos = data[1]
        local qua = data[2]
        gem_slot_data[pos].quality = qua
        if advance_lv < lv then
          gem_slot_data[pos].show_quality_up_flag = true
        end
      end
    end
  end
  local gemstone_slot = equip_info.gemstone_slot
  for key, data in pairs(gemstone_slot) do
    if data.pos > 0 then
      gem_slot_data[data.pos].gem_uuid = data.uuid or 0
    end
  end
  self:set_gem_icon(gem_slot_data)
end

function ui:set_gem_icon(gem_slot_data)
  local equip_gemstone_quality = ShareRes.create("equip.equip_gemstone_quality")
  for i, data in ipairs(gem_slot_data) do
    local slot_go = self.v_uiobjects["Slot" .. i]
    slot_go:SetActiveEx(not data.is_not_use)
    if not data.is_not_use then
      local quality_cfg = equip_gemstone_quality[data.quality]
      local lock_go = Util.get_child_gameobj("Lock_", slot_go)
      local quality_square_go = Util.get_child_gameobj("Quality", slot_go)
      local unlock_img = Util.get_image("UnLockIcon_", slot_go)
      local quality_img = Util.get_image("QualityBg_", slot_go)
      local icon_img = Util.get_image("QualityBg_/Icon_", slot_go)
      lock_go:SetActiveEx(data.is_lock)
      quality_square_go:SetActiveEx(not data.is_lock)
      unlock_img.gameObject:SetActiveEx(not data.is_lock)
      if not data.is_lock then
        local square_pos = {}
        for _, v in ipairs(quality_cfg.QualitySquarePos) do
          square_pos[v] = 1
        end
        for index = 1, 4 do
          local quality_point_img = Util.get_image("Quality/Point" .. index, slot_go)
          quality_point_img.gameObject:SetActiveEx(1 == square_pos[index])
          if 1 == square_pos[index] then
            ResMgr:load_set_icon(quality_point_img, quality_cfg.QualitySquareIcon)
          end
        end
        quality_img.gameObject:SetActiveEx(false)
        Util.set_color(unlock_img, quality_cfg.LockColor)
      end
      local unlock_flag = Util.get_child_gameobj("Flags/UnlockFlag_", slot_go)
      local upgrade_flag = Util.get_child_gameobj("Flags/UpgradeFlag_", slot_go)
      unlock_flag:SetActiveEx(data.show_unlock_flag == true)
      upgrade_flag:SetActiveEx(true == data.show_quality_up_flag)
    end
  end
end

local desc_format_str = [[
<color=#D56D2E>+%s %s</color>
%s]]
local desc_format_str_percent = [[
<color=#D56D2E>+%s%% %s</color>
%s]]

function ui:refresh_skill(is_preview)
  local advance_up_lv = is_preview and 1 or self:get_advance_up_lv()
  local advance_lv = self.v_equip_info.advance
  local use_color = advance_up_lv > 0 and UP_COLOR or NORMAL_COLOR
  self.v_uicompents.TitleTip_txt.text = Util.format_str("<color=#{1}>同调{2}</color>", use_color, CommonDef.ROME_NUM[advance_lv + advance_up_lv])
  local advance_cfg = ShareRes.create("equip.equip_advance", self.v_equip_info.id)
  local advance_max_lv = advance_cfg[#advance_cfg].Lv
  self.v_uiobjects.LevelLimitText:SetActive(not is_preview and advance_lv >= advance_max_lv)
  self.v_uiobjects.BtnNextLvPreview:SetActive(0 == advance_up_lv and advance_lv < advance_max_lv)
  self.v_uiobjects.BtnNowLv:SetActive(true == is_preview)
  local show_skill_id = advance_cfg[advance_lv + advance_up_lv].SkillId
  local show_skill_cfg = ShareRes.create("equip.equip_skill_level", show_skill_id)
  local no_skill = nil == show_skill_cfg or show_skill_cfg.Name == ""
  local no_attr = 0 == show_skill_cfg.AttrId or 0 == show_skill_cfg.AttrValue
  if no_skill and no_attr then
    self.v_uicompents.SkillName_txt.text = Util.format_str("无同调技能")
    self.v_uicompents.SkillLvNum_txt.text = ""
    self.v_uicompents.SkillDesc_txt.text = ""
    self.v_uiobjects.SkillLvMax:SetActive(false)
    if show_skill_cfg then
      local show_skill_lv = show_skill_cfg.Lv
      local skill_max_lv = ShareRes.get_weapon_skill_max_lv(self.v_equip_info.id)
      self.v_uiobjects.SkillLvMax:SetActive(show_skill_lv == skill_max_lv)
    end
    return
  end
  local show_skill_lv = show_skill_cfg.Lv
  local skill_up_lv = 0
  local skill_max_lv = ShareRes.get_weapon_skill_max_lv(self.v_equip_info.id)
  if advance_up_lv > 0 then
    local real_skill_id = advance_cfg[advance_lv].SkillId
    local real_skill_cfg = ShareRes.create("equip.equip_skill_level", real_skill_id)
    local real_skill_level = real_skill_cfg.Lv
    skill_up_lv = show_skill_lv - real_skill_level
  end
  use_color = skill_up_lv > 0 and UP_COLOR or NORMAL_COLOR
  self.v_uicompents.SkillName_txt.text = Util.format_str("<color=#{1}>{2}</color>", use_color, show_skill_cfg.Name)
  self.v_uicompents.SkillLvNum_txt.text = Util.format_str("<color=#{1}>Lv.{2}</color>", use_color, show_skill_lv)
  self.v_uiobjects.SkillName:SetActive(false)
  self.v_uiobjects.SkillName:SetActive(true)
  if not no_attr then
    local attribute_name = ShareRes.get_attr_name(show_skill_cfg.AttrId)
    local attribute_isratio = ShareRes.get_is_ration_attr(show_skill_cfg.AttrId)
    local isratio = attribute_isratio or 1 == show_skill_cfg.AttrType
    local value = isratio and show_skill_cfg.AttrValue / 100 or show_skill_cfg.AttrValue
    local format_key = isratio and desc_format_str_percent or desc_format_str
    self.v_uicompents.SkillDesc_txt.text = string.format(format_key, value, attribute_name, show_skill_cfg.Desc)
  else
    self.v_uicompents.SkillDesc_txt.text = show_skill_cfg.Desc
  end
  self.v_uiobjects.SkillLvMax:SetActive(show_skill_lv == skill_max_lv)
end

function ui:refresh_cost_view()
  self.v_uiobjects.Cost:SetActiveEx(not self.v_is_max)
  self.v_uiobjects.LevelLimitText:SetActiveEx(self.v_is_max)
  self.v_uiobjects.CostRedPoint:SetActiveEx(false)
  if self.v_is_max then
    return
  end
  for i = 1, self.max_select_count do
    local ui = self.v_uiobjects["CostTem" .. i]
    self:_refresh_cost_item(ui, self.select_equip_list[i])
  end
  self.v_uiobjects.BtnAutoAdd:SetActiveEx(0 == #self.select_equip_list)
  self.v_uiobjects.BtnAllReduce:SetActiveEx(#self.select_equip_list > 0)
end

function ui:_refresh_cost_item(obj, select_equip_uuid)
  local cost_item = Util.get_child_gameobj("CostItem_", obj)
  local cost_btn = Util.get_button("CostBtn_", obj)
  local del_btn = Util.get_button("BtnDel_", obj)
  cost_item:SetActive(nil ~= select_equip_uuid)
  cost_btn.gameObject:SetActive(nil == select_equip_uuid)
  del_btn.gameObject:SetActive(nil ~= select_equip_uuid)
  if select_equip_uuid then
    self:_refresh_equip_ui(select_equip_uuid, cost_item)
    self:set_button_listener(del_btn, function()
      self:on_click_equip(select_equip_uuid, true)
    end)
  else
    self:set_button_listener(cost_btn, function()
      if not self.v_left_list_visiable then
        self:set_left_list_visiable(true)
      end
    end)
  end
end

function ui:set_left_list_visiable(visiable)
  self.v_uicompents.Content_rect:SetAnchoredPositionA(0, 0)
  self.v_left_list_visiable = visiable
  self.v_uiobjects.LeftList:SetActive(visiable)
  self.v_parent_ui:set_left_tab_visiable(not visiable)
end

function ui:refresh_cost_id_list()
  local equip_info = self:get_curr_equip_info()
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_info.id)[equip_info.advance]
  self.v_cost_id_list = {
    [advance_cfg.CostEquipId] = true,
    [advance_cfg.CostCommonId] = true
  }
  local type_config = Util.get_item_type_cfg(advance_cfg.CostCommonId)
  self.v_cost_item_id = nil
  if type_config.AwardType ~= Config.AWARD_TYPE.EQUIP then
    self.v_cost_item_id = advance_cfg.CostCommonId
  end
end

function ui:_init_weapon_list()
  if not self.v_visible then
    return
  end
  self:refresh_cost_id_list()
  self:give_back_auto_cache(TONGTIAO_WEAPON_LIST_ITEM_KEY)
  local new_equip_list = self:get_show_weapon_list()
  self.v_equip_list = {}
  self.select_equip_list = {}
  self.select_image_list = {}
  self.v_cost_item_num = 0
  local mat_count = 0
  for _, equip_info in pairs(new_equip_list) do
    mat_count = mat_count + 1
    local equip_ui = self:get_auto_cache(TONGTIAO_WEAPON_LIST_ITEM_KEY)
    self.v_equip_list[equip_info.uuid] = {object = equip_ui, equip_data = equip_info}
    self:_refresh_equip_ui(equip_info.uuid, equip_ui)
    local selected_obj = Util.get_child_gameobj("Select_", equip_ui)
    selected_obj:SetActive(false)
    self:set_button_listener(Util.get_button(nil, equip_ui), function()
      self:on_click_equip(equip_info.uuid)
    end)
    local btn_del = Util.get_button("Select_/BtnDel_", equip_ui)
    self:set_button_listener(btn_del, function()
      local index = self:check_is_selected(equip_info.uuid)
      if index > 0 then
        self:on_click_equip(equip_info.uuid, true)
      end
    end)
  end
  self:set_none_mat_visible(mat_count <= 0)
end

local SORT_RULE = {
  "lock",
  "advance",
  "break_lv",
  "lv"
}

function ui:sort_weapon_list(equip_list)
  table.sort(equip_list, function(a, b)
    for key, type in ipairs(SORT_RULE) do
      if a[type] ~= b[type] then
        return a[type] < b[type]
      end
    end
    return a.uuid > b.uuid
  end)
end

function ui:get_show_weapon_list()
  local new_equip_list = {}
  if self.v_cost_item_id then
    local item_num = BagMgr:get_item_num(self.v_cost_item_id)
    if item_num > 0 then
      local fake_equip_info = {
        id = self.v_cost_item_id,
        owner = 0,
        quality = ShareRes.get_item_quality(self.v_cost_item_id),
        advance = 0,
        break_lv = 0,
        lock = -1,
        uuid = 0
      }
      table.insert(new_equip_list, fake_equip_info)
    end
  end
  local equip_list = CharacterMgr:get_equip_list()
  for _, equip_info in pairs(equip_list) do
    local id = equip_info.id
    local equip_cfg = ShareRes.create("equip.equip", id)
    equip_info.quality = equip_cfg.Quality
    if self.v_cost_id_list[id] and (not equip_info.owner or 0 == equip_info.owner) and self.v_equip_uuid ~= equip_info.uuid then
      table.insert(new_equip_list, equip_info)
    end
  end
  self:sort_weapon_list(new_equip_list)
  return new_equip_list
end

function ui:change_select_list_with_id(uuid, select_obj, is_delect)
  if self.v_anim_cost_change then
    self.v_anim_cost_change.time = 0
    self.v_anim_cost_change:Play()
  end
  if 0 == uuid then
    local own_item_num = BagMgr:get_item_num(self.v_cost_item_id)
    self.v_cost_item_num = self.v_cost_item_num or 0
    self.v_cost_item_num = is_delect and self.v_cost_item_num - 1 or self.v_cost_item_num + 1
    self.v_cost_item_num = self.v_cost_item_num < 0 and 0 or self.v_cost_item_num
    self.v_cost_item_num = own_item_num < self.v_cost_item_num and own_item_num or self.v_cost_item_num
    if is_delect and 0 == self.v_cost_item_num then
      local index = self:check_is_selected(uuid)
      if index > 0 then
        self.select_image_list[index]:SetActive(false)
        table.remove(self.select_equip_list, index)
        table.remove(self.select_image_list, index)
        self:refresh_info_view()
        return
      end
    end
  else
    local index = self:check_is_selected(uuid)
    if index > 0 then
      self.select_image_list[index]:SetActive(false)
      table.remove(self.select_equip_list, index)
      table.remove(self.select_image_list, index)
      self:refresh_info_view()
      return
    end
  end
  if 0 == uuid then
    local index = self:check_is_selected(uuid)
    if 0 == index then
      self.select_equip_list[#self.select_equip_list + 1] = uuid
      self.select_image_list[#self.select_image_list + 1] = select_obj
      select_obj:SetActive(true)
    end
  else
    if #self.select_equip_list >= self.max_select_count then
      return
    end
    self.select_equip_list[#self.select_equip_list + 1] = uuid
    self.select_image_list[#self.select_image_list + 1] = select_obj
    select_obj:SetActive(true)
  end
  self:refresh_info_view()
end

function ui:un_select_all()
  local count = #self.select_image_list
  for i = count, 1, -1 do
    self.select_image_list[i]:SetActive(false)
  end
  self.select_equip_list = {}
  self.select_image_list = {}
  self.v_cost_item_num = 0
  self:refresh_info_view()
  self:response_refresh_equip_view({mm_x = 0})
end

function ui:auto_add()
  local suc = false
  local new_equip_list = self:get_show_weapon_list()
  self:sort_weapon_list(new_equip_list)
  local need_count = self:get_rich_max_need_count()
  local counter = need_count
  local need_select_list = {}
  for i, equip_info in pairs(new_equip_list) do
    if 0 ~= equip_info.uuid then
      if counter <= 0 then
        break
      end
      counter = counter - equip_info.advance
      need_select_list[#need_select_list + 1] = equip_info
    end
  end
  table.sort(need_select_list, function(a, b)
    if a.advance ~= b.advance then
      return a.advance > b.advance
    end
    return a.uuid < b.uuid
  end)
  local new_list = {}
  for index, info in ipairs(need_select_list) do
    if info.advance + counter > 0 then
      new_list[info.uuid] = true
    else
      counter = info.advance + counter
    end
  end
  for _, equip in pairs(self.v_equip_list) do
    local uuid = equip.equip_data.uuid
    if true == new_list[uuid] then
      local equip_ui = equip.object
      local selected_obj = Util.get_child_gameobj("Select_", equip_ui)
      self:change_select_list_with_id(uuid, selected_obj)
      suc = true
    end
  end
  if not suc then
    if not self.v_left_list_visiable then
      self:set_left_list_visiable(true)
    end
    Util.show_message_tip(2244)
  end
end

function ui:try_fix_data(need_count, select_list)
  if #select_list <= 0 then
    return
  end
  for index = 1, #select_list do
  end
end

function ui:un_select_with_index(index)
  local uuid = self.select_equip_list[index]
  self:on_click_equip(uuid)
end

function ui:check_is_reach_max_tong_tiao(uuid)
  local index = self:check_is_selected(uuid)
  if 0 ~= uuid and index > 0 then
    return false
  end
  local equip_info = self:get_curr_equip_info()
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_info.id)
  if not advance_cfg then
    Log.Error("not found equip_advance cfg, id ", equip_info.id)
  end
  local advance_lv = equip_info.advance
  local max_advance_lv = #advance_cfg
  local up_lv = 0
  if self.v_cost_item_num and self.v_cost_item_num > 0 then
    up_lv = self.v_cost_item_num
  end
  for index, equip_uuid in ipairs(self.select_equip_list) do
    if 0 ~= equip_uuid then
      local equip_info = CharacterMgr:get_equip_info(equip_uuid)
      up_lv = up_lv + equip_info.advance
    end
  end
  if max_advance_lv <= advance_lv + up_lv or #self.select_equip_list >= 4 then
    Util.show_message_tip(2162)
    return true
  end
  if 0 == uuid then
    up_lv = up_lv + 1
  else
    local click_equip_info = CharacterMgr:get_equip_info(uuid)
    up_lv = up_lv + click_equip_info.advance
  end
  local is_overflow = max_advance_lv < advance_lv + up_lv
  return false, is_overflow
end

function ui:get_rich_max_need_count()
  local equip_info = self:get_curr_equip_info()
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_info.id)
  if not advance_cfg then
    Log.Error("not found equip_advance cfg, id ", equip_info.id)
  end
  local max_need_count = #advance_cfg - equip_info.advance
  if max_need_count > self.max_select_count then
    max_need_count = self.max_select_count
  end
  return max_need_count
end

function ui:check_is_selected(uuid)
  local index = 0
  for i = 1, #self.select_equip_list do
    if self.select_equip_list[i] == uuid then
      index = i
      break
    end
  end
  return index
end

function ui:on_click_equip(uuid, is_delect)
  local is_already_max, is_going_overflow = false, false
  if not is_delect then
    is_already_max, is_going_overflow = self:check_is_reach_max_tong_tiao(uuid)
    if is_already_max then
      return
    end
  end
  
  local function cb()
    for _, equip in pairs(self.v_equip_list) do
      if equip.equip_data.uuid == uuid then
        local selected_obj = Util.get_child_gameobj("Select_", equip.object)
        self:change_select_list_with_id(uuid, selected_obj, is_delect)
        return
      end
    end
  end
  
  if is_going_overflow then
    Util.show_notify_popup_message(cb, "选中材料已达到最大值，是否选为消耗材料？")
  else
    cb()
  end
  if 0 == uuid then
    self:response_refresh_equip_view({mm_x = 0})
  end
end

function ui:get_curr_equip_info()
  return CharacterMgr:get_equip_info(self.v_equip_uuid)
end

function ui:set_none_mat_visible(value)
end

function ui:_refresh_item_ui(object)
  local icon = Util.get_image("ItemIcon_", object)
  local quality_icon = Util.get_image("ItemQuality_", object)
  local icon_path, quality_path = UtilUI.get_item_images(self.v_cost_item_id)
  ResMgr:load_set_icon(icon, icon_path)
  ResMgr:load_set_icon(quality_icon, quality_path)
  local item_num = BagMgr:get_item_num(self.v_cost_item_id)
  local cost_item_num = self.v_cost_item_num or 0
  local use_text = Util.get_text("Lower/Item_/ItemChooseNum_", object)
  local own_text = Util.get_text("Lower/Item_/ItemNum_", object)
  use_text.text = cost_item_num
  own_text.text = item_num
end

function ui:_refresh_equip_ui(equip_uuid, object)
  Util.get_child_gameobj("Lower/Weapon_", object):SetActive(0 ~= equip_uuid)
  Util.get_child_gameobj("Lower/Item_", object):SetActive(0 == equip_uuid)
  Util.get_child_gameobj("AdvanceLv", object):SetActive(0 ~= equip_uuid)
  if 0 == equip_uuid then
    self:_refresh_item_ui(object)
    return
  end
  local uuid = equip_uuid
  local equip_info = CharacterMgr:get_equip_info(uuid)
  local id = equip_info.id
  local icon = Util.get_image("ItemIcon_", object)
  local equip_cfg = ShareRes.create("equip.equip", id)
  local path = string.format("Icon/Item/%s", equip_cfg.Icon)
  ResMgr:load_set_icon(icon, path)
  local quality_icon = Util.get_image("ItemQuality_", object)
  local quality_cfg = ShareRes.get_equip_icon_cfg(equip_cfg.Quality)
  path = string.format("UICommon/%s", quality_cfg.Quality_Bg)
  ResMgr:load_set_icon(quality_icon, path)
  local advanceLv_txt = Util.get_text("AdvanceLv/AdvanceLv_", object)
  advanceLv_txt.text = Util.format_str("同调{1}", CommonDef.ROME_NUM[equip_info.advance])
  local lv_text = Util.get_text("Lower/Weapon_/WeaponLV_", object)
  lv_text.text = equip_info.lv
end

function ui:ui_on_hide()
  self:set_left_list_visiable(false)
  self.v_last_uuid = nil
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:on_destroy()
    self.v_weapon_model_rt = nil
  end
  self.v_asset_bar:on_hide()
  self.v_equip_list = {}
end

function ui:update_weapon_view()
  if self.ignore_refresh_model then
    self.ignore_refresh_model = nil
    return
  end
  local equip
  if self.v_open_type == WEAPON_SELECT_TYPE.NORMAL then
    equip = CharacterMgr:get_equip_info(self.v_last_uuid)
  else
    equip = self:get_curr_equip_info()
  end
  if not equip then
    return
  end
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:change_weapon(equip.id)
    self.v_weapon_model_rt:set_rotate_weapon()
    return
  end
  self.v_weapon_model_rt = WeaponModelRtView:new(nil, false, nil, nil, true, "UIModelRtViewWeapon")
  self.v_weapon_model_rt:init_weapon_info(equip.id)
  self.v_weapon_model_rt:set_rotate_weapon()
end

function ui:response_refresh_equip_view(msg)
  if not self.v_visible or nil == msg then
    return
  end
  local equip_uuid = msg.mm_x
  local item_data = self.v_equip_list[equip_uuid]
  if item_data then
    local equip_info = item_data.equip_data
    local equip_ui = item_data.object
    self:_refresh_equip_ui(equip_info.uuid, equip_ui)
  end
end

function ui:ui_on_update()
  if self.v_weapon_model_rt then
    self.v_weapon_model_rt:update()
  end
end

return ui
