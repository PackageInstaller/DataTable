local Base = require("ui.uiobject")
local ResSvList = require("uimodule.uibag.res_list")
local BagCfg = require("uimodule.uibag.uibag_configs")
local Item_Helper = require("utils.item_helper")
local _insert = table.insert
local _floor = math.floor
local _tsort = table.sort
local TEMP_VEC2 = UnityVector2(0, 0)
local ui = Util.create_child_mt(Base)
local QUALITYS = BagCfg.QUALITYS
local IMPORTANT_QUALITY = BagCfg.IMPORTANT_QUALITY
local TRIGGER_DYNAMIC_EFFECT_TYPE = BagCfg.TRIGGER_DYNAMIC_EFFECT_TYPE
local WEAPEN_IDX = BagCfg.WEAPEN_IDX
local BIND_TYPE = Config.BIND_TYPE
local decompose_max_num = 0
local MODEL = {
  v_res_list_root = {
    "DecWeaponResContent",
    BIND_TYPE.OBJECT
  },
  v_amount_num = {
    "Amount_num",
    BIND_TYPE.TEXT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_toggle()
  decompose_max_num = ShareRes.get_comm_value("DecomposeMaxNum")
  self.v_res_list = ResSvList:ui_wrap(self, self.v_res_list_root, WEAPEN_IDX)
  self.v_item_sv_rect = self.v_parent_ui:get_item_scroll_view_rect()
  self.v_item_sr_view = self.v_item_sv_rect:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function ui:ui_on_show()
  self.v_amount_num.text = 0
  self.v_select_quality_list = {}
  self.v_dont_callback = false
  for _, quality in pairs(QUALITYS) do
    self.v_select_quality_list[quality] = false
  end
  self:bind_auto_mq(Const.MSG_BAG_ITEM_SELECT_CHANGE, self.on_select_change, self)
  self:bind_auto_mq(Const.MSG_ROLE_WEAPENLIST_CHANGE, self.on_weapon_list_change, self)
  self.v_tog_q3.isOn = false
  self.v_tog_q4.isOn = false
  self.v_init_x = self.v_item_sv_rect.sizeDelta.x
  self.v_init_con_x = self.v_item_sr_view.content.sizeDelta.x
  TEMP_VEC2.x = self.v_init_x - 370
  TEMP_VEC2.y = self.v_item_sv_rect.sizeDelta.y
  self.v_item_sv_rect.sizeDelta = TEMP_VEC2
  local bag_list = self.v_parent_ui.v_parent_ui.bag_list
  bag_list:set_bag_type(1)
  self.v_parent_ui:play_decompose_show_pd()
end

function ui:ui_on_hide()
  self.v_parent_ui:set_delete_btn_active(true)
  self.v_parent_ui:set_return_btn_active(true)
  self.v_parent_ui:update_sort_type()
  self:_reset_self_data()
  TEMP_VEC2.x = self.v_init_x
  TEMP_VEC2.y = self.v_item_sv_rect.sizeDelta.y
  self.v_item_sv_rect.sizeDelta = TEMP_VEC2
  TEMP_VEC2.x = self.v_init_con_x
  TEMP_VEC2.y = self.v_item_sr_view.content.sizeDelta.y
  self.v_item_sr_view.content.sizeDelta = TEMP_VEC2
  local bag_list = self.v_parent_ui.v_parent_ui.bag_list
  bag_list:clear_select()
  bag_list:reset_show()
  bag_list:update_weapon_filt(nil)
end

function ui:on_weapon_list_change()
  local common_tog_to_quality = self:get_toggle_list()
  if common_tog_to_quality then
    for tog, _ in pairs(common_tog_to_quality) do
      tog.isOn = false
    end
  end
end

function ui:on_select_change()
  local bag_list = self.v_parent_ui.v_parent_ui.bag_list
  local uuid_list, id_list, select_quality_3_count, select_quality_4_count, total_quality_3_count, total_quality_4_count, equip_datas = bag_list:get_selected_list(WEAPEN_IDX, QUALITYS.QUALITY_3, QUALITYS.QUALITY_4)
  self.v_parent_ui:set_button_grey(0 == #id_list)
  if 0 == #id_list then
    self:_reset_self_data()
  end
  if select_quality_3_count == total_quality_3_count - 1 and self.v_tog_q3.isOn then
    self.v_dont_callback = true
    bag_list:set_pre_quality(QUALITYS.QUALITY_3, false)
    self.v_tog_q3.isOn = false
  elseif select_quality_4_count == total_quality_4_count - 1 and self.v_tog_q4.isOn then
    self.v_dont_callback = true
    bag_list:set_pre_quality(QUALITYS.QUALITY_4, false)
    self.v_tog_q4.isOn = false
  end
  self.v_amount_num.text = #equip_datas
  self.v_uicompents.Amount_Maxnum_txt.text = decompose_max_num
  local id2num = {}
  local temp_awards, temp_num, temp_id
  local has_novice_privilege, privilege_id = NewbieTowerMgr:check_have_resolve_privilege()
  local add_exp_item_data = {}
  local levelup_items = ShareRes.create("equip.equip_exp")
  for k, v in pairs(levelup_items) do
    local item_cfg = ShareRes.create("item.item", v.Id)
    local data = {
      Exp = item_cfg.Arg[1],
      Id = v.Id
    }
    table.insert(add_exp_item_data, data)
  end
  table.sort(add_exp_item_data, function(a, b)
    return a.Exp > b.Exp
  end)
  local gold_ratio, exp_ratio, break_ratio
  local exp_cost = 0
  if has_novice_privilege then
    gold_ratio, exp_ratio, break_ratio = ShareRes.get_privilege_remodel_percent(privilege_id)
  end
  for i = 1, #equip_datas do
    local equip_data = equip_datas[i]
    temp_awards = ShareRes.get_equip_dec_res(equip_data.id)
    for j = 1, #temp_awards do
      temp_id = temp_awards[j].ItemId
      temp_num = id2num[temp_id] or 0
      id2num[temp_id] = temp_num + temp_awards[j].Num
    end
    if has_novice_privilege then
      id2num, exp_cost = CharacterMgr:calcu_weapon_reduction_rebate(equip_data, gold_ratio, exp_ratio, break_ratio, add_exp_item_data, id2num, exp_cost, has_novice_privilege)
    else
      local decompose_cfgs = ShareRes.create("equip.equip_decompose", equip_data.quality)
      gold_ratio = decompose_cfgs.GoldLossRatio
      exp_ratio = decompose_cfgs.ExpLossRatio
      break_ratio = decompose_cfgs.BreakLossRatio
      id2num, exp_cost = CharacterMgr:calcu_weapon_reduction_rebate(equip_data, gold_ratio, exp_ratio, break_ratio, add_exp_item_data, id2num, nil, has_novice_privilege)
    end
    if equip_data.gem_uuid_list then
      for key, gem_uuid in pairs(equip_data.gem_uuid_list) do
        local gem_id = GemStoneMgr:get_gem_data_id(gem_uuid)
        temp_id = gem_id
        temp_num = id2num[temp_id] or 0
        id2num[temp_id] = temp_num + 1
      end
    end
  end
  if has_novice_privilege then
    local single_return_exp = math.ceil(exp_cost * exp_ratio / 10000)
    CharacterMgr:calcu_exp(id2num, single_return_exp, add_exp_item_data)
  end
  local res_list = {}
  for id, num in pairs(id2num) do
    if num > 0 then
      local item_cfg = Item_Helper.get_item_cfg(id)
      local is_gem = Item_Helper.get_is_gem_item(id)
      _insert(res_list, {
        id = id,
        num = num,
        priority = item_cfg.Priority,
        quality = item_cfg.Quality,
        is_gem = is_gem
      })
    end
  end
  _tsort(res_list, function(a, b)
    if a.is_gem ~= b.is_gem then
      return b.is_gem
    end
    if a.quality ~= b.quality then
      return a.quality > b.quality
    end
    if a.priority ~= b.priority then
      return a.priority > b.priority
    end
    return a.id > b.id
  end)
  self.v_res_list:update_list(res_list)
  self.v_uiobjects.NoItem:SetActive(0 == #res_list)
end

function ui:_reset_self_data()
  self.v_res_list:update_list()
  self.v_amount_num.text = 0
end

function ui:set_toggle()
  local bag_list = self.v_parent_ui.v_parent_ui.bag_list
  local common_tog_to_quality = self:get_toggle_list()
  
  local function comm_tog_func(is_on, tog)
    self.v_select_quality_list[common_tog_to_quality[tog]] = is_on
    if self.v_dont_callback then
      self.v_dont_callback = false
      return
    end
    local need_select_count = decompose_max_num
    if is_on then
      local now_select_count = #bag_list:get_selected_list(WEAPEN_IDX)
      if need_select_count and decompose_max_num > 0 then
        need_select_count = need_select_count - now_select_count
      end
    end
    bag_list:update_weapon_filt(self.v_select_quality_list, nil, need_select_count)
  end
  
  for tog, _ in pairs(common_tog_to_quality) do
    self.set_toggle_listener(self, tog, function(is_on)
      if true == is_on then
        local is_rich_max = bag_list:check_is_select_rich_max(true, WEAPEN_IDX)
        if is_rich_max then
          tog.isOn = false
          return
        end
      end
      comm_tog_func(is_on, tog)
    end)
  end
end

function ui:get_toggle_list()
  self.v_tog_q3 = self:get_toggle("Select_list/Select_BiaoPei", self.v_object)
  self.v_tog_q4 = self:get_toggle("Select_list/Select_JingXuan", self.v_object)
  local common_tog_to_quality = {
    [self.v_tog_q3] = QUALITYS.QUALITY_3,
    [self.v_tog_q4] = QUALITYS.QUALITY_4
  }
  return common_tog_to_quality
end

return ui
