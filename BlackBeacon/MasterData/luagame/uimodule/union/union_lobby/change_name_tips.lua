local Base = require("ui.uiobject")
local UnionHelper = require("uimodule.union.union_helper")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_input = {
    "InputField",
    BIND_TYPE.INPUT
  },
  v_limit = {
    "Limit",
    BIND_TYPE.TEXT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BgReturn", function()
    self:ui_hide()
  end)
  self:set_button("Cancel", function()
    self:ui_hide()
  end)
  self:set_button("Submit", function()
    self:_onclick_sure_btn()
  end)
  self:set_inputfield_listener(self.v_input, function()
    self:_on_input()
  end)
end

function ui:ui_on_show(callback, cbdata, ...)
  self.v_callback = callback
  self.v_cbdata = cbdata
  self.v_input.text = ""
  self.v_input.characterLimit = 0
  self.v_max_len = ShareRes.get_system_comm_value("GuildNameMaxLen")
  self.v_limit.text = string.format("%s/%s", 0, self.v_max_len)
end

function ui:ui_on_hide()
end

function ui:_on_input()
  local new_str = UnionHelper.filter_special_char(self.v_input.text)
  self.v_input.text = new_str
  local len = Util.get_string_len(self.v_input.text)
  self.v_limit.text = string.format("%s/%s", len, self.v_max_len)
  if len > self.v_max_len then
    local tip = Util.format_str("不可超过{1}字", self.v_max_len)
    UIMgr:get_ui("uimessagetip"):ui_show(tip)
    local old_str = self.v_input.text
    local new_str = Util.get_sub_string_utf8(old_str, self.v_max_len)
    self.v_input.text = new_str
  end
end

function ui:_onclick_sure_btn()
  local new_name = self.v_input.text
  self.v_callback(self.v_cbdata, new_name)
  self:ui_hide()
end

return ui
