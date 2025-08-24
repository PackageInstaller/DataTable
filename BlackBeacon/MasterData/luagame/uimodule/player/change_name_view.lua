local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local RENAME_CARD_ID = 99
local NAME_MAX_LEN = 9
local MODEL = {
  v_input_field = {
    "InputField",
    BIND_TYPE.INPUT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("Cancel", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BgReturn", function()
    self:ui_hide()
  end)
  self:set_inputfield_listener(self.v_input_field, nil, function()
    self:_on_input_complete()
  end)
  self:set_button("Submit", function()
    if self.v_is_click == nil or self.v_is_click == true then
      return
    end
    if self.v_is_illegal then
      self.v_is_illegal = false
      return
    end
    local name = self.v_input_field.text
    if string.gsub(name, " ", "") == "" then
      Util.show_message_tip(2212)
      return
    end
    if BagMgr:get_item_num(RENAME_CARD_ID) < 1 then
      Util.show_message_tip(2213)
      return
    end
    local num = Util.get_string_len(name)
    if num < 1 then
      Util.show_message_tip(2214)
      return
    end
    if Util.has_special_char(name) then
      Util.show_message_tip(2356)
      return
    end
    local old_name = PlayerMgr:on_get_player_info_list().base_info.name
    if name == old_name then
      Util.show_message_tip("不可更改为原昵称")
      return
    end
    self.v_is_click = true
    Word_Censor.check_has_sensitive(self:ui_get_name(), name, function(ok)
      if ok then
        PlayerMgr:upgrade_player_name(name, function(ok)
          if ok then
            local msg = MsgGame:mq_publish2(Const.MSG_ON_CHANGE_NAME_SUCCESS)
            msg.mm_obj = name
            self:ui_hide()
          else
            self.v_input_field.text = ""
          end
          self.v_is_click = false
        end)
      else
        self.v_input_field.text = ""
        self.v_is_click = false
      end
    end, "player_rename")
  end)
end

function ui:ui_on_show(data)
  self.v_data = data
  self.v_is_click = false
  self:refresh_view()
end

function ui:ui_on_hide()
  self.v_input_field.text = ""
  self.v_data = nil
  self.v_is_click = nil
end

function ui:refresh_view()
  local item_num_txt = self.v_uicompents.ItemNum_txt
  item_num_txt.text = self.v_data.num
end

function ui:_on_input_complete()
  local input = self.v_input_field
  local len = Util.get_string_len(input.text)
  if len > NAME_MAX_LEN then
    self.v_is_illegal = true
    input.text = Util.get_sub_string_utf8(input.text, NAME_MAX_LEN)
    input:ActivateInputField()
    Util.show_message_tip(2211)
  else
    self.v_is_illegal = false
  end
  self.v_input_team_name = input.text
end

return ui
