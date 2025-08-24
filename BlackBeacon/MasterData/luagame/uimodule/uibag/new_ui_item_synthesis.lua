local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local ItemSynthesisList = require("uimodule.uibag.item_synthesis_list")
local AssetBarView = require("ui.asset_bar.asset_bar")
local S_MATERIAL_ITEM_TEM = "S_MATERIAL_ITEM_TEM"
local CONSUMETEM_CLASS = require("uimodule.character.consumeTem")
local BUILDING_CONFIG = require("uimodule.building.building_config")
local Math = require("base.mathx")
local MAX_COMBINE_COUNT = 9999
local asset_config = {
  {
    item_id = Config.COIN_ITEMID,
    func = "_onclick_coin",
    const_event = Const.MSG_ON_COIN_UPDATE,
    bg_click = false
  }
}
local EMPTY_TABLE = {}
local recursion_time = 1000
local sub_count, need_sub_count

function ui:_get_sub_material_info(sub_list, check_sub_count, sub_material_list)
  local combine_cfg
  for combine_id, _sub_list in pairs(sub_list) do
    if self.v_select_data.targetInfo.Id ~= combine_id then
      combine_id = BuildingMgr:get_replace_item_combine_id(combine_id) or combine_id
      combine_cfg = ShareRes.get_item_combine_cfg(combine_id)
      local max_combine_count = math.huge
      local owner_count, synthesis_count
      for key, item_id in pairs(combine_cfg.Material) do
        owner_count = BagMgr:get_item_num(item_id)
        synthesis_count = math.floor(owner_count / combine_cfg.Num[key])
        local single_count = check_sub_count == math.huge and 1 or check_sub_count
        max_combine_count = math.min(synthesis_count, max_combine_count) / single_count
      end
      if max_combine_count ~= math.huge then
        sub_material_list[combine_id] = (sub_material_list[combine_id] or 0) + max_combine_count
        sub_count = sub_count + max_combine_count
      end
      if sub_count >= need_sub_count then
        return
      end
    end
    self:_get_sub_material_info(_sub_list, check_sub_count, sub_material_list)
  end
end

function ui:get_sub_material_info(item_id, check_sub_count)
  if check_sub_count <= 0 then
    return 0
  end
  local sub_material_list = {}
  sub_count = 0
  need_sub_count = check_sub_count
  local list = ShareRes.get_item_combine_alias(item_id)
  if list then
    self:_get_sub_material_info(list, check_sub_count, sub_material_list)
  end
  local combine_count = sub_count
  return sub_material_list, combine_count
end

function ui:on_click_confirm_btn()
  if not self.v_select_data or 0 == self.v_synthesis_count then
    Util.show_message_tip(2227)
    return
  end
  if self.v_max_synthesis_count < self.v_synthesis_count then
    Util.show_message_tip("消耗不满足")
    return
  end
  UIMgr:get_ui("new_ui_synthesis_tips"):ui_show(self.v_tips_show_item_list, self.v_tips_show_coin_count, self.v_select_data, self.v_synthesis_count)
end

function ui:on_click_return()
  if self.v_go_to_main_when_hide then
    UIMgr:go_to_main()
  else
    self:ui_hide()
  end
end

function ui:set_go_to_main_when_hide(val)
  self.v_go_to_main_when_hide = true == val
end

function ui:ui_finish_load()
  self.v_synthesis_count = 1
  self.v_material_item_list = {}
  self:register_exist_auto_template(S_MATERIAL_ITEM_TEM, self.v_uiobjects.Material, self.v_uiobjects.MaterialLayout)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_config)
  self:set_button("BtnRet1", function()
    self:on_click_return()
  end)
  self:set_button("BtnAddition", function()
    self.v_uiobjects.AdditionGroup:SetActive(true)
    BUILDING_CONFIG.REFRESH_ADDTION_GROUP_FUNC(self, Config.CommonDefine.BUILDING_TYPE.COMBINE)
  end)
  self:set_button("BtnCloseTips", function()
    self.v_uiobjects.AdditionGroup:SetActive(false)
  end)
  self:set_button_ex_listener(self.v_uicompents.Button_add_btn, function()
    self.v_adding = true
  end, function()
    self.v_adding = false
  end, nil, function()
    self.v_adding = false
  end)
  self:set_button_ex_listener(self.v_uicompents.Button_reduce_btn, function()
    self.v_reducing = true
  end, function()
    self.v_reducing = false
  end, nil, function()
    self.v_reducing = false
  end)
  self:set_button("BtnConfire", function()
    self:on_click_confirm_btn()
  end)
  self:set_button("SkipEffect", function()
    self:skip_effect_synthesis()
  end)
  self:set_button("Button_Min", function()
    self:change_input_field(1)
    self:on_input_change()
  end)
  self:set_button("Button_Max", function()
    self:change_input_field(self.v_max_synthesis_count)
    self:on_input_change()
  end)
  self:set_button("BtnHomeJump", function()
    if SysOpenMgr:get_sys_is_open(59, true) then
      UIMgr:get_ui("building_tower_view"):ui_show()
    end
  end)
  self.v_page_btns = {}
  for key, tog_name in pairs(Config.SYNTHESIS_CLASSIFY_TO_TOG) do
    local btn = self.v_uicompents[tog_name .. "Btn_btn"]
    local tog = self.v_uicompents[tog_name .. "_tog"]
    self.v_page_btns[key] = {btn = btn, tog = tog}
    self:set_button_listener(btn, function()
      self:on_click_page(key)
      self.item_synthesis_list:select_first_item()
    end)
  end
  self.v_synthesis_effect = self:get_effect_status(nil, self.v_uiobjects.SynthesisEffect)
  self.v_input_field = self:get_inputfield(nil, self.v_uiobjects.ProductNum)
  self:set_inputfield_listener(self.v_input_field, function()
    self:on_input_change()
  end, function()
    self:on_input_change(true)
  end)
end

function ui:ui_on_show(exchange_id, target_count, go_to_main_when_hide)
  self.v_uiobjects.AdditionGroup:SetActive(false)
  self.v_adding = false
  self.v_reducing = false
  self.v_select_exchange_id = exchange_id
  self.v_uiobjects.SkipEffect:SetActive(false)
  self.v_synthesis_count = 1
  self.v_target_data = nil
  self.v_go_to_main_when_hide = true == go_to_main_when_hide
  self:init_item_list()
  self:on_click_page(0, nil ~= exchange_id)
  self.v_asset_bar:on_create()
  if exchange_id then
    self:jump_to_target_synthesis(exchange_id, target_count)
    UIMgr:try_hide_ui("itemTip")
  else
    self.item_synthesis_list:select_first_item()
  end
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self.on_item_update, self)
end

function ui:ui_on_update(delta_time)
  if not self.v_adding and not self.v_reducing then
    self.v_speed = 0.6
    self.v_time_acc = 0.6
    return
  end
  self.v_time_acc = self.v_time_acc + delta_time
  if self.v_time_acc >= self.v_speed then
    self:on_operation_item(self.v_adding == true)
    self.v_time_acc = 0
    if self.v_speed > 0.2 then
      self.v_speed = self.v_speed - 0.15
    elseif self.v_speed > 0.1 then
      self.v_speed = 0.05
    end
  end
end

function ui:on_item_update()
  self:set_select_item_show_data()
end

function ui:ui_on_hide()
  self.v_select_data = nil
  self:remove_all_material_item()
  self.v_asset_bar:on_hide()
  if self.v_synthesis_effect_timer then
    Timer:remove_timer(self.v_synthesis_effect_timer)
    self.v_synthesis_effect_timer = nil
  end
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:init_item_list()
  self.item_synthesis_list = ItemSynthesisList:ui_wrap(self, self.v_uiobjects.Content)
  local items = BagMgr:get_bag(2) or EMPTY_TABLE
  local item_exchange = ShareRes.get_can_show_item_combine_cfg()
  self.item_synthesis_list:setup(items, item_exchange, self.v_uiobjects.Content)
  self.item_synthesis_list:update_bag(items, item_exchange)
end

function ui:refresh_data(is_reload)
  local items = BagMgr:get_bag(2) or EMPTY_TABLE
  local item_exchange = ShareRes.get_can_show_item_combine_cfg()
  self.item_synthesis_list:update_bag(items, item_exchange, is_reload)
  MsgGame:mq_publish2(Const.MSG_BAG_ITEM_SELECT_CHANGE)
end

function ui:set_select_item_show_data(is_first)
  local data = self.v_select_data
  local path = UtilUI.get_quality_icon(data.targetInfo.quality)
  ResMgr:load_set_icon(self.v_uicompents.ItemQuality_img, path)
  path = UtilUI.get_item_icon(data.targetInfo.item_id)
  ResMgr:load_set_icon(self.v_uicompents.ItemIcon_img, path)
  local cfg = UtilUI.get_item_cfg(data.targetInfo.item_id)
  self.v_uicompents.ItemName_txt.text = cfg.Name
  self.v_uicompents.ItemDesc_txt.text = cfg.Desc
  self:cal_max_synthesis_count()
  self:init_count()
  self:refresh_lock_state(is_first)
end

function ui:_cal_max_synthesis_count(data)
  local item_id, infos = data.targetInfo.item_id, data.materialInfos
  local max_combine_count = math.huge
  local owner_count, synthesis_count
  for _, info in pairs(infos) do
    owner_count = BagMgr:get_item_num(info.item_id)
    synthesis_count = math.floor(owner_count / info.single_count)
    max_combine_count = math.min(max_combine_count, synthesis_count)
  end
  if max_combine_count == math.huge then
    max_combine_count = 0
  end
  return max_combine_count
end

function ui:cal_max_synthesis_count()
  recursion_time = 1000
  self.v_combine_id_path = {}
  self:get_material_list(self.v_select_data.targetInfo.Id, math.huge)
  self.v_max_synthesis_count = 0
  local temp_count_map = {}
  for i = 1, #self.v_combine_id_path do
    local combine_id = self.v_combine_id_path[i]
    combine_id = BuildingMgr:get_replace_item_combine_id(combine_id) or combine_id
    local combine_cfg = ShareRes.get_item_combine_cfg(combine_id)
    local can_combine_count = math.huge
    for index, material_id in ipairs(combine_cfg.Material) do
      local need_num = combine_cfg.Num[index]
      local temp_material_count = temp_count_map[material_id] or 0
      local cur_num = BagMgr:get_item_num(material_id) + temp_material_count
      can_combine_count = math.min(can_combine_count, math.floor(cur_num / need_num))
    end
    temp_count_map[combine_cfg.TargetId] = temp_count_map[combine_cfg.TargetId] or 0
    temp_count_map[combine_cfg.TargetId] = temp_count_map[combine_cfg.TargetId] + can_combine_count
    if not self.v_combine_id_path[i + 1] then
      self.v_max_synthesis_count = can_combine_count ~= math.huge and can_combine_count or 0
    end
  end
  self.v_max_synthesis_count = math.max(self.v_max_synthesis_count, 0)
end

function ui:init_count()
  local own_count = BagMgr:get_item_num(self.v_select_data.targetInfo.item_id)
  self.v_uicompents.ProduceNum_txt.text = self.v_max_synthesis_count
  self.v_uicompents.Amonut_txt.text = own_count
  local init_val = 1
  if self.v_target_data and self.v_target_data.target_id == self.v_select_exchange_id then
    local target_count = self.v_target_data.target_count
    local lack_count = own_count < target_count and target_count - own_count or 1
    init_val = lack_count
  end
  self:change_input_field(init_val)
  self:on_input_change()
end

function ui:change_input_field(val)
  self.v_input_field.text = val > 0 and val or 1
end

function ui:on_input_change(is_end)
  local txt = self.v_input_field.text
  local val = tonumber(txt) or 0
  val = val > 0 and val or 0
  if val > MAX_COMBINE_COUNT then
    self.v_input_field.text = MAX_COMBINE_COUNT
    val = MAX_COMBINE_COUNT
  end
  if is_end then
    self:change_input_field(val)
  else
    self:refresh_count(val)
  end
end

function ui:refresh_count(value)
  self.v_synthesis_count = math.min(value, MAX_COMBINE_COUNT)
  self:refresh_button()
  self:show_material_item()
end

function ui:refresh_button()
  Util.apply_grey_ex(self.v_uiobjects.BtnConfire, self.v_max_synthesis_count < 1)
  self.v_uicompents.BtnConfireTxt_txt.text = Util.format_str(self.v_max_synthesis_count < 1 and "材料不足" or "制 作")
  self.v_uicompents.Button_reduce_btn.enabled = self.v_synthesis_count > 1
  if self.v_synthesis_count <= 1 then
    self.v_reducing = false
  end
end

function ui:get_material_list(combine_id, combine_count)
  recursion_time = recursion_time - 1
  if recursion_time < 0 then
    return 0
  end
  combine_id = BuildingMgr:get_replace_item_combine_id(combine_id) or combine_id
  local combine_cfg = ShareRes.get_item_combine_cfg(combine_id)
  for key, material_id in pairs(combine_cfg.Material) do
    local single_count = combine_cfg.Num[key]
    local need_count = combine_count * single_count
    if material_id ~= Config.COIN_ITEMID then
      local cur_count = BagMgr:get_item_num(material_id)
      if need_count > cur_count then
        local list = ShareRes.get_item_combine_alias(material_id)
        if list then
          for combine_material_id in pairs(list) do
            self:get_material_list(combine_material_id, need_count - cur_count)
          end
        end
      end
    end
  end
  self.v_combine_id_path[#self.v_combine_id_path + 1] = combine_id
  if self.v_combine_count_list then
    self.v_combine_count_list[combine_id] = (self.v_combine_count_list[combine_id] or 0) + combine_count
  end
end

function ui:show_material_item()
  self:remove_all_material_item()
  local show_coin = false
  recursion_time = 1000
  local target_item_id = self.v_select_data.targetInfo.item_id
  local target_combine_id = self.v_select_data.targetInfo.Id
  self.v_combine_count_list = {}
  self.v_combine_id_path = {}
  self:get_material_list(target_combine_id, self.v_synthesis_count)
  self.v_tips_show_item_list = {}
  local temp_path = {}
  local force_show = false
  local can_combine = false
  if self.v_max_synthesis_count <= 0 then
    temp_path[#temp_path + 1] = self.v_select_data.targetInfo.Id
    force_show = true
  else
    local temp_count_map = {}
    local path_len = #self.v_combine_id_path
    for i = 1, path_len do
      local combine_id = self.v_combine_id_path[i]
      combine_id = BuildingMgr:get_replace_item_combine_id(combine_id) or combine_id
      local combine_cfg = ShareRes.get_item_combine_cfg(combine_id)
      local can_combine_count = math.huge
      local need_num
      local single_coin = 0
      for index, material_id in ipairs(combine_cfg.Material) do
        if material_id == Config.COIN_ITEMID then
          single_coin = single_coin + combine_cfg.Num[index]
        else
          need_num = combine_cfg.Num[index]
          local temp_material_count = temp_count_map[material_id] or 0
          local cur_num = BagMgr:get_item_num(material_id) + temp_material_count
          can_combine_count = math.min(can_combine_count, math.floor(cur_num / need_num))
        end
      end
      temp_count_map[combine_cfg.TargetId] = temp_count_map[combine_cfg.TargetId] or 0
      temp_count_map[combine_cfg.TargetId] = temp_count_map[combine_cfg.TargetId] + can_combine_count
      temp_path[#temp_path + 1] = combine_id
      if temp_count_map[target_item_id] and temp_count_map[target_item_id] >= self.v_synthesis_count then
        can_combine = true
        break
      end
    end
  end
  local coin_count = 0
  local len = #temp_path
  for i = len, 1, -1 do
    local show_item = true
    local combine_id = temp_path[i]
    local combine_count = target_combine_id ~= combine_id and self.v_combine_count_list[combine_id] or self.v_synthesis_count
    if combine_count and show_item then
      combine_id = BuildingMgr:get_replace_item_combine_id(combine_id) or combine_id
      local combine_cfg = ShareRes.get_item_combine_cfg(combine_id)
      if combine_cfg then
        for index, material_id in ipairs(combine_cfg.Material) do
          local num = combine_cfg.Num[index]
          local material_count = BagMgr:get_item_num(material_id)
          local need_num = num * combine_count
          if material_id == Config.COIN_ITEMID then
            coin_count = coin_count + need_num
          elseif force_show or BagMgr:get_item_num(material_id) / num > 0 then
            local info = {
              single_count = num,
              need_num = (self.v_max_synthesis_count < 0 or 1 == i) and need_num or math.min(need_num, material_count),
              item_id = material_id
            }
            local show_count = math.min(info.need_num, BagMgr:get_item_num(material_id))
            if show_count > 0 then
              self.v_tips_show_item_list[#self.v_tips_show_item_list + 1] = {
                info.item_id,
                show_count
              }
            end
            local obj = self:get_auto_cache(S_MATERIAL_ITEM_TEM)
            local item = CONSUMETEM_CLASS:ui_wrap(self, obj, true)
            item:set_data(info)
            self.v_material_item_list[material_id] = item
          end
        end
      end
    end
  end
  if coin_count > 0 then
    local str = coin_count
    local cur_num = BagMgr:get_item_num(Config.COIN_ITEMID)
    if cur_num < cur_num then
      str = "<color=#e0212c>" .. cur_num .. "</color>"
    end
    self.v_uicompents.GoldNum_txt.text = str
    show_coin = true
  end
  self.v_tips_show_coin_count = coin_count
  self.v_show_coin = show_coin
  self.v_uiobjects.Gold:SetActive(show_coin)
end

function ui:refresh_lock_state(is_first)
  local data = self.v_select_data
  local condition = data.Condition
  local lock = false
  if condition and condition > 0 then
    local pass_condition = Condition:check_condition(condition, not is_first)
    if not pass_condition then
      if not BuildingMgr:check_condition(condition) then
        self.v_uiobjects.UnLockCondition:SetActive(false)
        self.v_uiobjects.Lock:SetActive(true)
        self.v_uiobjects.Gold:SetActive(false)
        self.v_uicompents.Condition_txt.text = ShareRes.get_condition_desc(condition)
      else
        self.v_uiobjects.UnLockCondition:SetActive(true)
        self.v_uiobjects.Lock:SetActive(false)
        self.v_uiobjects.Gold:SetActive(self.v_show_coin)
        self.v_uicompents.ConditionText_txt.text = ShareRes.get_condition_desc(condition)
      end
      self.v_uiobjects.SliderObj:SetActive(false)
      self.v_uiobjects.BtnConfire:SetActive(false)
      lock = true
    end
  end
  if not lock then
    self.v_uiobjects.UnLockCondition:SetActive(false)
    self.v_uiobjects.Lock:SetActive(false)
    self.v_uiobjects.Gold:SetActive(self.v_show_coin)
    self.v_uiobjects.SliderObj:SetActive(true)
    self.v_uiobjects.BtnConfire:SetActive(true)
  end
end

function ui:on_operation_item(is_select)
  local txt = self.v_input_field.text
  local val = tonumber(txt) or 1
  self:change_input_field(is_select and val + 1 or val - 1)
end

function ui:on_click_item(data, is_first)
  if not data then
    return
  end
  self.v_select_exchange_id = data.targetInfo.Id
  self.v_select_data = data
  self.v_synthesis_count = 1
  self:set_select_item_show_data(is_first)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CLICK_SYNTHESIS_ITEM)
  msg.mm_x = self.v_select_exchange_id
end

function ui:set_tog_state(page_key)
  if not self.v_page_btns then
    return
  end
  for k, v in pairs(self.v_page_btns) do
    v.tog.isOn = k == page_key
    v.tog.interactable = k ~= page_key
    v.btn.interactable = k ~= page_key
  end
end

function ui:on_click_page(idx, ignore_select_first)
  self:set_tog_state(idx)
  self.item_synthesis_list:set_bag_type(idx, ignore_select_first)
end

function ui:get_select_exchange_id()
  return self.v_select_exchange_id
end

function ui:set_tog_active(tog_name, active)
  if not self.v_uiobjects[tog_name] then
    return
  end
  self.v_uiobjects[tog_name]:SetActive(active)
end

function ui:remove_all_material_item()
  self:give_back_auto_cache(S_MATERIAL_ITEM_TEM)
  for key, item in pairs(self.v_material_item_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_material_item_list[key] = nil
  end
end

function ui:jump_to_target_synthesis(exchange_id, target_count)
  self.v_target_data = nil
  if target_count and target_count > 0 then
    self.v_target_data = {target_id = exchange_id, target_count = target_count}
  end
  self.item_synthesis_list:set_select_exchange_item(exchange_id)
end

function ui:play_synthesis_effect()
  local life_time = self.v_synthesis_effect.LifeTime
  self.v_synthesis_effect:RestartAll(nil, true)
  if self.v_synthesis_effect_timer then
    Timer:remove_timer(self.v_synthesis_effect_timer)
    self.v_synthesis_effect_timer = nil
  end
  self.v_synthesis_effect_timer = Timer:add_timer(nil, life_time, self.synthesis_effect_cb, self)
  self.v_uiobjects.SkipEffect:SetActive(true)
end

function ui:skip_effect_synthesis()
  if self.v_synthesis_effect_timer then
    Timer:remove_timer(self.v_synthesis_effect_timer)
    self.v_synthesis_effect_timer = nil
  end
  self.v_synthesis_effect:StopAll()
  self:synthesis_effect_cb()
end

function ui:synthesis_effect_cb()
  local send_data = {
    cid = self.v_select_exchange_id,
    num = self.v_synthesis_count
  }
  BagMgr:item_synthesis(send_data, function()
    self:on_click_item(self.v_select_data, true)
  end)
  MsgGame:mq_publish2(Const.MSG_BAG_ITEM_SELECT_CHANGE)
  self.v_uiobjects.SkipEffect:SetActive(false)
  self.v_synthesis_effect_timer = nil
end

function ui:set_toggle_on(is_on, toggle_name)
  local full_name = toggle_name .. "_tog"
  if self.v_uicompents[full_name] then
    self.v_uicompents[full_name].isOn = is_on
  end
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  if self.v_target_data and self.v_target_data.target_id == self.v_select_exchange_id then
    return self.v_select_exchange_id, self.v_target_data.target_count
  end
  return self.v_select_exchange_id
end

return ui
