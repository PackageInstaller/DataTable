local Base = require("ui.uiobject")
local ResSvList = require("uimodule.uibag.res_list")
local BagCfg = require("uimodule.uibag.uibag_configs")
local _clamp = require("base.mathx").Clamp
local _insert = table.insert
local TEMP_VEC2 = UnityVector2(0, 0)
local ui = Util.create_child_mt(Base)
local Cfg = require("uimodule.uibag.uibag_configs")
local ITEM_IDX = Cfg.ITEM_IDX
local IMPORTANT_QUALITY = Cfg.IMPORTANT_QUALITY
local TRIGGER_DYNAMIC_EFFECT_TYPE = BagCfg.TRIGGER_DYNAMIC_EFFECT_TYPE
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_res_list_root = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_slider = {
    "Slider",
    BIND_TYPE.SLIDER
  },
  v_add_btn = {
    "Button_add",
    BIND_TYPE.BUTTON
  },
  v_reduce_btn = {
    "Button_reduce",
    BIND_TYPE.BUTTON
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button_listener(self.v_add_btn, function()
    self:onclick_add_btn()
  end)
  self:set_button_listener(self.v_reduce_btn, function()
    self:onclick_reduce_btn()
  end)
  self:set_slider_listener(self.v_slider, function()
    self:onclick_slider()
  end)
  self.v_res_list = ResSvList:ui_wrap(self, self.v_res_list_root, ITEM_IDX)
  self:_reset_self_data()
  self.v_item_sv_rect = self.v_parent_ui:get_item_scroll_view_rect()
  self.v_item_sr_view = self.v_item_sv_rect:GetComponent(typeof(UnityEngine.UI.ScrollRect))
end

function ui:ui_on_show()
  self:bind_event()
  self.v_uicompents.Amount_txt.text = 0
  self:btn_and_slider_init()
  self.v_init_x = self.v_item_sv_rect.sizeDelta.x
  self.v_init_con_x = self.v_item_sr_view.content.sizeDelta.x
  TEMP_VEC2.x = self.v_init_x - 370
  TEMP_VEC2.y = self.v_item_sv_rect.sizeDelta.y
  self.v_item_sv_rect.sizeDelta = TEMP_VEC2
  self.v_parent_ui:play_decompose_show_pd()
end

function ui:ui_on_hide()
  self.v_parent_ui:set_delete_btn_active(true)
  self.v_parent_ui:set_return_btn_active(true)
  local bag_list = self.v_parent_ui.v_parent_ui.bag_list
  bag_list:clear_select()
  bag_list:reset_show()
  bag_list:update_item_filt(nil, false)
  self:_reset_self_data()
  if self.v_remove_dynamic_effect_timer then
    Timer:remove_timer(self.v_remove_dynamic_effect_timer)
  end
  self.v_remove_dynamic_effect_timer = nil
  TEMP_VEC2.x = self.v_init_x
  TEMP_VEC2.y = self.v_item_sv_rect.sizeDelta.y
  self.v_item_sv_rect.sizeDelta = TEMP_VEC2
  TEMP_VEC2.x = self.v_init_con_x
  TEMP_VEC2.y = self.v_item_sr_view.content.sizeDelta.y
  self.v_item_sr_view.content.sizeDelta = TEMP_VEC2
end

function ui:bind_event()
  self:bind_auto_mq(Const.MSG_BAG_ITEM_SELECT_CHANGE, self.on_select_change, self)
end

function ui:on_select_change()
  local bag_list = self.v_parent_ui.v_parent_ui.bag_list
  local uuid_list, id_list = bag_list:get_selected_list(ITEM_IDX)
  self.v_parent_ui:set_button_grey(0 == #id_list)
  if 0 == #id_list then
    self:_reset_self_data(0)
    self:btn_and_slider_init()
    return
  end
  self.v_cur_item_id = id_list[1]
  self.v_cur_item_uuid = uuid_list[1]
  self.v_cur_item_max = BagMgr:get_grid(self.v_cur_item_uuid).count
  local awards = ShareRes.get_item_sell_res(self.v_cur_item_id)
  if not awards then
    return
  end
  local res_list = {}
  if self.v_cur_item_id then
    self.v_choose_num = 1
    self.v_uicompents.Amount_txt.text = self.v_choose_num
    self:set_select_state()
    local temp
    for i = 1, #awards do
      temp = awards[i]
      _insert(res_list, {
        id = temp.ItemId,
        num = temp.Num,
        single_num = temp.Num,
        icon = "",
        quality = 1
      })
    end
  end
  self.v_res_list:update_list(res_list)
end

function ui:_reset_self_data(num)
  self.v_cur_item_id = nil
  self.v_cur_item_uuid = nil
  self.v_choose_num = num or 1
  self.v_cur_item_max = 0
  self.v_uicompents.Amount_txt.text = self.v_choose_num
  self.v_res_list:update_list()
end

function ui:on_select_num_change()
  local list = self.v_res_list.cur_res_list
  if not list then
    return
  end
  for i = 1, #list do
    list[i].num = list[i].single_num * self.v_choose_num
  end
  self.v_uicompents.Amount_txt.text = self.v_choose_num
  self.v_res_list:update_list(list)
end

function ui:onclick_add_btn()
  self.v_choose_num = _clamp(self.v_choose_num + 1, 1, self.v_cur_item_max)
  self.v_add_btn.interactable = self.v_choose_num == self.v_cur_item_max
  self.v_slider.value = self.v_choose_num
  self:on_select_num_change()
end

function ui:onclick_reduce_btn()
  self.v_choose_num = _clamp(self.v_choose_num - 1, 1, self.v_cur_item_max)
  self.v_reduce_btn.interactable = 1 == self.v_choose_num
  self.v_slider.value = self.v_choose_num
  self:on_select_num_change()
end

function ui:onclick_slider()
  self.v_choose_num = math.modf(self.v_slider.value)
  self.v_add_btn.interactable = self.v_choose_num < self.v_cur_item_max
  self.v_reduce_btn.interactable = self.v_choose_num > 1
  self:on_select_num_change()
end

function ui:btn_and_slider_init()
  self.v_slider.minValue = 1
  self.v_slider.maxValue = 1
  self.v_slider.value = 1
  self.v_add_btn.interactable = false
  self.v_reduce_btn.interactable = false
  self.v_slider.interactable = false
end

function ui:set_select_state()
  if 1 == self.v_cur_item_max then
    self.v_slider.minValue = 0
    self.v_slider.maxValue = 1
    self.v_slider.value = 1
    self.v_add_btn.interactable = false
    self.v_reduce_btn.interactable = false
    self.v_slider.interactable = false
  else
    self.v_slider.minValue = 1
    self.v_slider.maxValue = self.v_cur_item_max
    self.v_slider.value = 1
    self.v_add_btn.interactable = true
    self.v_reduce_btn.interactable = false
    self.v_slider.interactable = true
  end
end

return ui
