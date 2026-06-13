local Base = require("ui.uiobject")
local ResSvList = require("uimodule.uibag.res_list")
local BagCfg = require("uimodule.uibag.uibag_configs")
local _insert = table.insert
local _floor = math.floor
local _tsort = table.sort
local TEMP_VEC2 = UnityVector2(0, 0)
local ui = Util.create_child_mt(Base)
local QUALITYS = BagCfg.QUALITYS
local IMPORTANT_QUALITY = BagCfg.IMPORTANT_QUALITY
local TRIGGER_DYNAMIC_EFFECT_TYPE = BagCfg.TRIGGER_DYNAMIC_EFFECT_TYPE
local SOURCE_IDX = BagCfg.SOURCE_IDX
local BIND_TYPE = Config.BIND_TYPE
local decompose_max_num = 0
local MODEL = {
  v_amount_maxnum = {
    "Amount_Maxnum",
    BIND_TYPE.TEXT
  },
  v_amount_num = {
    "Amount_num",
    BIND_TYPE.TEXT
  },
  v_dec_source_res_content = {
    "DecSourceResContent",
    BIND_TYPE.OBJECT
  },
  v_fj_template = {
    "Fj_template",
    BIND_TYPE.OBJECT
  },
  v_no_item = {
    "NoItem",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_toggle()
  decompose_max_num = ShareRes.get_comm_value("DecomposeMaxNum")
  self.v_res_list = ResSvList:ui_wrap(self, self.v_dec_source_res_content, SOURCE_IDX)
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
  self.v_tog_q3.isOn = false
  self.v_tog_q4.isOn = false
  self.v_init_x = self.v_item_sv_rect.sizeDelta.x
  self.v_init_con_x = self.v_item_sr_view.content.sizeDelta.x
  TEMP_VEC2.x = self.v_init_x - 370
  TEMP_VEC2.y = self.v_item_sv_rect.sizeDelta.y
  self.v_item_sv_rect.sizeDelta = TEMP_VEC2
  local bag_list = self.v_parent_ui.v_parent_ui.bag_list
  bag_list:set_bag_type(SOURCE_IDX)
  self.v_parent_ui:play_decompose_show_pd()
end

function ui:ui_on_hide()
  self.v_parent_ui:set_delete_btn_active(true)
  self.v_parent_ui:set_return_btn_active(true)
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
  bag_list:update_source_filt()
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
  local uuid_list, id_list, select_quality_3_count, select_quality_4_count, total_quality_3_count, total_quality_4_count, equip_datas = bag_list:get_selected_list(SOURCE_IDX, QUALITYS.QUALITY_3, QUALITYS.QUALITY_4)
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
  for _, equip_data in ipairs(equip_datas) do
    temp_awards = ShareRes.get_source_dec_res(equip_data.quality)
    for _, award in ipairs(temp_awards) do
      temp_id = award.ItemId
      temp_num = id2num[temp_id] or 0
      id2num[temp_id] = temp_num + award.Num
    end
  end
  local res_list = {}
  for id, num in pairs(id2num) do
    if num > 0 then
      local item_cfg = ShareRes.create("item.item", id)
      _insert(res_list, {
        id = id,
        num = num,
        priority = item_cfg.Priority,
        quality = item_cfg.Quality
      })
    end
  end
  _tsort(res_list, function(a, b)
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
      local now_select_count = #bag_list:get_selected_list(SOURCE_IDX)
      if need_select_count and decompose_max_num > 0 then
        need_select_count = need_select_count - now_select_count
      end
    end
    bag_list:update_source_filt(self.v_select_quality_list, nil, need_select_count)
  end
  
  for tog, _ in pairs(common_tog_to_quality) do
    self.set_toggle_listener(self, tog, function(is_on)
      if true == is_on then
        local is_rich_max = bag_list:check_is_select_rich_max(true, SOURCE_IDX)
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
