local Base = require("ui.widget.widget_base")
local SimpleListClass = require("uimodule.battle_equip.local_widgets.simple_sv_list")
local ToggleTabClass = require("ui.widget.widget_toggle_tab")
local M = Util.create_child_mt(Base)
local TOGGLE_ICON_PATH = "UICommon/%d"

function M:_init(parent_ui, content, template_class, constraint_count, template_key)
  self.v_toggle_obj_list = SimpleListClass:new(parent_ui, content, template_class, constraint_count, template_key)
end

function M:refresh_tog_list(data_cfg, cb)
  local filt_tog_list = {}
  self.data_cfg = data_cfg
  self.v_tog_cb = cb
  self.v_toggle_obj_list:update_list(data_cfg)
  for i = 1, #data_cfg do
    if self.v_toggle_obj_list.v_items[i] ~= nil then
      table.insert(filt_tog_list, Util.get_toggle(nil, self.v_toggle_obj_list.v_items[i].go))
    else
      Log.Error("从缓存列表中获取toggle组件失败！！")
    end
  end
  self.v_filt_tog = ToggleTabClass:new(self)
  self.v_filt_tog:init_by_toggles(filt_tog_list, function(cur_idx, pre_idx)
    self:_on_click_page_tog(cur_idx, pre_idx)
  end, -1)
  self.v_cur_select_idx = -1
  self.v_pre_select_idx = -1
  self.v_filt_tog:set_toggle_by_index(1)
end

function M:_on_click_page_tog(cur_idx, pre_idx)
  if cur_idx == self.v_cur_select_idx then
    return
  end
  self.v_pre_select_idx = self.v_cur_select_idx
  self.v_cur_select_idx = cur_idx
  if self.v_tog_cb then
    self.v_tog_cb(cur_idx, pre_idx)
  else
    Log.Error("没有自定义tog回调")
  end
end

function M:get_cur_idx()
  return self.v_cur_select_idx
end

function M:get_tog_ui_list()
  return self.v_toggle_obj_list.v_items
end

function M:ui_on_hide()
end

function M:ui_on_destroy()
  self.v_toggle_obj_list = nil
  self.v_filt_tog = nil
  self.v_tog_cb = nil
end

return M
