local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local SORT_TYPE = GemStoneMgr.SORT_TYPE
local SORT_TYPE2_TOGGLE = {
  [SORT_TYPE.QUALITY] = "v_quanilty",
  [SORT_TYPE.LEVEL] = "v_level"
}
local MODEL = {
  v_level = {
    "Level",
    BIND_TYPE.TOGGLE
  },
  v_quanilty = {
    "Quanilty",
    BIND_TYPE.TOGGLE
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnBack", function()
    self:ui_hide()
  end)
  self:set_button("Btn_Cancel", function()
    self:ui_hide()
  end)
  self:set_button("Btn_Close", function()
    self:ui_hide()
  end)
  self:set_button("Btn_SetDefault", function()
    self:reset_data()
  end)
  self:set_button("Btn_Sure", function()
    self:try_save_data()
  end)
end

function ui:ui_on_show(save_cb)
  self.v_save_cb = save_cb
  self:init_sort_list()
  self:refresh_tog_by_mgr_data()
  self.v_uicompents.TagList_rect:SetLocalPositionA(0, 0, 0)
end

function ui:init_sort_list()
  for sort_type, tog_name in ipairs(SORT_TYPE2_TOGGLE) do
    self:set_toggle_listener(self[tog_name], function(is_on)
      if not is_on then
        return
      end
      self.v_new_sort_type = sort_type
    end)
  end
end

function ui:refresh_tog_by_mgr_data()
  self.v_new_sort_type = GemStoneMgr.v_sort_type or SORT_TYPE.QUALITY
  self[SORT_TYPE2_TOGGLE[self.v_new_sort_type]].isOn = true
end

function ui:reset_data()
  self.v_new_sort_type = SORT_TYPE.QUALITY
  self[SORT_TYPE2_TOGGLE[self.v_new_sort_type]].isOn = true
end

function ui:try_save_data()
  GemStoneMgr:set_sort_type(self.v_new_sort_type)
  if self.v_save_cb then
    self.v_save_cb()
  end
  self:ui_hide()
end

function ui:ui_on_hide()
end

return ui
