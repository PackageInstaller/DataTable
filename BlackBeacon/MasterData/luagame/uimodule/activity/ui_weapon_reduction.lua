local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local WEAPON_REDUCTION_ITEM = require("uimodule.activity.weapon_reduction_item")
local LoopListClass = require("ui.widget.infinite_loop_list")
local BagCfg = require("uimodule.uibag.uibag_configs")
local MATERIAL_ITEM_TEMPLETE_KEY = "MATERIAL_ITEM_TEMPLETE_KEY"

local function _build_equip_gem_list(gemstone_slot)
  if not gemstone_slot then
    return nil
  end
  local list = {}
  for _, pos_data in pairs(gemstone_slot) do
    if pos_data.uuid and 0 ~= pos_data.uuid then
      list[#list + 1] = pos_data.uuid
    end
  end
  return list
end

local function _rebuild_list(weapon)
  local ret_weapon = {}
  local wp_cfg = ShareRes.create("equip.equip", weapon.id)
  ret_weapon.uuid = weapon.uuid
  ret_weapon.id = weapon.id
  ret_weapon.lv = weapon.lv
  ret_weapon.exp = weapon.exp
  ret_weapon.create_time = weapon.create_time
  ret_weapon.create_time_sort = Date.server_time() - weapon.create_time
  ret_weapon.break_lv = weapon.break_lv
  ret_weapon.advance = weapon.advance
  ret_weapon.owner = weapon.owner
  ret_weapon.is_wear = 0 == weapon.owner and 1 or 0
  ret_weapon.lock = weapon.lock
  ret_weapon.priority = ShareRes.get_equip_priority(weapon.id)
  ret_weapon.icon = wp_cfg.Icon
  ret_weapon.quality = wp_cfg.Quality
  ret_weapon.gem_uuid_list = _build_equip_gem_list(weapon.gemstone_slot)
  ret_weapon.is_showing = 1
  return ret_weapon
end

function ui:_build_list(list)
  local build_list = {}
  for i = 1, #list do
    if list[i].lv > 0 or list[i].break_lv > 0 then
      table.insert(build_list, _rebuild_list(list[i]))
    end
  end
  return build_list
end

function ui:ui_finish_load()
  self:register_exist_auto_template(MATERIAL_ITEM_TEMPLETE_KEY, self.v_uiobjects.Item, self.v_uiobjects.Content)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BgBtn", function()
    self:ui_hide()
  end)
  self:set_button("BtnReduce", function()
    if self.v_select_uuid then
      local show_text = 1 == self.v_select_item_lock and "当前武器已锁定，是否解锁并重塑？重塑后将变更为初始状态(同调等级不受影响) ，并返还所有培养材料" or "重塑后，武器被还原成初始状态（同调等级不会变动），并返还所有培养材料，是否确认"
      Util.show_conform_tip(show_text, nil, nil, nil, function()
        CharacterMgr:reshape_equip(self.v_select_uuid, self.v_privilege_id, function()
          self:refresh()
        end)
      end)
    else
      Util.show_message_tip(2331)
    end
  end)
  self.v_title_loop_list = LoopListClass:new(self, self.v_uiobjects.WeaponList, WEAPON_REDUCTION_ITEM)
end

function ui:ui_on_show(activity_id)
  self.v_activity_id = activity_id
  self:refresh()
  self:bind_auto_mq(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.check_close, self)
end

function ui:check_close()
  NoviceMgr:check_close_activity_ui(self.v_activity_id, self.v_ui_name)
end

function ui:ui_on_hide()
  self.v_privilege_id = nil
  self.v_select_uuid = nil
end

function ui:refresh()
  self:give_back_auto_cache(MATERIAL_ITEM_TEMPLETE_KEY)
  self.v_select_uuid = nil
  local equips = CharacterMgr:get_equip_list() or {}
  self:refresh_weapon(equips)
end

function ui:refresh_weapon(equips)
  self.v_show_list = {}
  local list = equips
  for i = 1, #list do
    if list[i].lv > 1 or list[i].break_lv > 1 then
      table.insert(self.v_show_list, _rebuild_list(list[i]))
    end
  end
  if next(self.v_show_list) == nil then
    self.v_uiobjects.NoWeapon:SetActive(true)
    self.v_uiobjects.NoWeapon1:SetActive(true)
  else
    self.v_uiobjects.NoWeapon:SetActive(false)
    self.v_uiobjects.NoWeapon1:SetActive(false)
  end
  table.sort(self.v_show_list, function(a, b)
    if a.quality ~= b.quality then
      return a.quality > b.quality
    end
    if a.lv ~= b.lv then
      return a.lv > b.lv
    end
    if a.lv ~= b.lv then
      return a.lv > b.lv
    end
    if a.is_wear ~= b.is_wear then
      return a.is_wear > b.is_wear
    end
    return false
  end)
  self.v_title_loop_list:refresh_data(self.v_show_list)
end

function ui:on_click_item(item)
  local data = item.v_data
  self.v_select_uuid = data.uuid
  self.v_select_item_lock = data.lock
  local msg = MsgGame:mq_publish2(Const.MSG_ON_SELECT_REDUCTION_WEAPON)
  msg.mm_x = self.v_select_uuid
  self:give_back_auto_cache(MATERIAL_ITEM_TEMPLETE_KEY)
  local gold_rebate_percent, exp_rebate_percent, break_rebate_percent
  if self.v_privilege_id then
    gold_rebate_percent, exp_rebate_percent, break_rebate_percent = ShareRes.get_privilege_remodel_percent(self.v_privilege_id)
  else
    gold_rebate_percent, exp_rebate_percent, break_rebate_percent = ShareRes.get_remodel_percent()
  end
  local tb = CharacterMgr:calcu_weapon_reduction_rebate(data, gold_rebate_percent, exp_rebate_percent, break_rebate_percent)
  local res_list = {}
  res_list[1] = {
    id = data.id,
    num = 1,
    priority = 99999,
    quality = data.quality,
    item_type = 0
  }
  for id, num in pairs(tb) do
    local item_cfg = ShareRes.create("item.item", id)
    if num > 0 then
      table.insert(res_list, {
        id = id,
        num = num,
        priority = item_cfg.Priority,
        quality = item_cfg.Quality,
        item_type = 1
      })
    end
  end
  if data.gem_uuid_list and next(data.gem_uuid_list) ~= nil then
    local id2num = {}
    for key, gem_uuid in pairs(data.gem_uuid_list) do
      local gem_id = GemStoneMgr:get_gem_data_id(gem_uuid)
      id2num[gem_id] = (id2num[gem_id] or 0) + 1
    end
    for id, num in pairs(id2num) do
      local gem_quality = ShareRes.get_gem_quality(id)
      res_list[#res_list + 1] = {
        id = id,
        num = num,
        priority = 0,
        quality = gem_quality,
        item_type = 2
      }
    end
  end
  table.sort(res_list, function(a, b)
    if a.item_type ~= b.item_type then
      return a.item_type < b.item_type
    end
    if a.quality ~= b.quality then
      return a.quality > b.quality
    end
    if a.priority ~= b.priority then
      return a.priority > b.priority
    end
    return a.id > b.id
  end)
  for index, data in ipairs(res_list) do
    local obj = self:get_auto_cache(MATERIAL_ITEM_TEMPLETE_KEY)
    local icon_path, quality_path = UtilUI.get_item_images(data.id)
    local quality = self:get_image("ItemQuality_", obj)
    local icon = self:get_image("ItemIcon_", obj)
    ResMgr:load_set_icon(quality, quality_path)
    ResMgr:load_set_icon(icon, icon_path)
    local num = self:get_text("ItemAmount_/Bg/ItemNum_", obj)
    local amount = self:get_child_gameobj("ItemAmount_", obj)
    amount:SetActive(data.num > 1)
    num.text = data.num
  end
end

function ui:get_select_uuid()
  return self.v_select_uuid
end

return ui
