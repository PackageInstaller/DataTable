local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_input_field = {
    "Remark_input",
    BIND_TYPE.INPUT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnConfirm", function()
    local num = Util.get_string_len(self.v_input_field.text)
    if num < 1 then
      Util.show_message_tip(2214)
      return
    end
    if num > 8 then
      Util.show_message_tip(2211)
      local old_str = self.v_input_field.text
      local new_str = Util.get_sub_string_utf8(old_str, 8)
      self.v_input_field.text = new_str
      return
    end
    local name = self.v_input_field.text
    local init_btn_list = BattleSettingMgr:get_btn_layout_list()
    for _, data in pairs(init_btn_list) do
      if name == data.name then
        Util.show_message_tip(2271)
        self.v_input_field.text = ""
        return
      end
    end
    Word_Censor.check_has_sensitive(self.v_parent_ui:ui_get_name(), name, function(ok, lab)
      if self.v_idx == nil then
        return
      end
      local new_name = ok and name or ""
      self:change_name(new_name)
      self:set_enable(false)
    end, "fight_layout_name")
  end)
  self:set_button("BtnCancel", function()
    self:set_enable(false)
  end)
  self:set_button("ReturnBg", function()
    self:set_enable(false)
  end)
end

function ui:ui_on_show(ui_info, tog_idx)
  self.v_input_field.text = ui_info.name
  self.v_idx = tog_idx
end

function ui:ui_on_hide()
  self.v_idx = nil
end

function ui:change_name(name)
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_LAYOUT_NAME)
  msg.mm_obj = {
    name = name,
    idx = self.v_idx
  }
end

return ui
