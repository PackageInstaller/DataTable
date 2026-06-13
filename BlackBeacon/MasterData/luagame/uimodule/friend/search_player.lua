local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local Timer = Global.timer
local _insert = table.insert
local _sort = table.sort
local _time = os.time
local PLAY_SET_TITLE = require("uimodule.player.player_set_title")
local FRIEND_MAX_NUM = ShareRes.get_system_comm_value("FriendNumLimit")
local APPLY_MAX_NUM = ShareRes.get_system_comm_value("ApplyFriendNumLimit")
local COLOR_NAME = Util.get_unity_color_by_hex(tonumber("292929", 16))
local COLOR_MARK = Util.get_unity_color_by_hex(tonumber("8D4B15", 16))
local MODEL = {
  v_player_content = {
    "PlayerContent",
    BIND_TYPE.OBJECT
  },
  v_player_template = {
    "PlayerTem",
    BIND_TYPE.OBJECT
  }
}
local PLAYER_ITEM_KEY = "PLAYER_ITEM_KEY"
local CommonDefind = require("cs_share.common_define")
local FRIEND_STATE = CommonDefind.FRIEND_STATE

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self.v_uiobjects.Main:SetActive(false)
    self.input.text = ""
    self:give_back_auto_cache(PLAYER_ITEM_KEY)
    FriendMgr:clear_search_role_list()
  end)
  self:set_button("BtnBack", function()
    self.v_uiobjects.Main:SetActive(false)
  end)
  self:set_button("BtnSearchPre", function()
    self.v_uiobjects.Main:SetActive(true)
    self.input:ActivateInputField()
  end)
  self:set_button("BtnSearch", function()
    self:click_search()
  end)
  self.input = Util.get_inputfield(nil, self.v_uiobjects.PlayerMessage)
  self:set_inputfield_listener(self.input, function()
    self:_on_check_input_len(self.input)
  end)
  self:set_button("BtnClear", function()
    self.input.text = ""
    FriendMgr:clear_search_role_list()
  end)
  self.v_set_title_obj = {}
  self:register_exist_auto_template(PLAYER_ITEM_KEY, self.v_player_template, self.v_player_content)
end

function ui:init_event()
  self:bind_auto_mq(Const.MSG_ON_CHANGE_FRIEND_STATE, self.update_player_state, self)
end

function ui:ui_on_show()
  self:init_event()
  self.v_uiobjects.Main:SetActive(false)
  self:_on_check_input_len(self.input)
  local search_list
  search_list = FriendMgr:get_search_role_list()
  if search_list and next(search_list) then
    self.v_uiobjects.Main:SetActive(true)
    self:update_player_list()
  end
end

function ui:ui_on_hide()
end

function ui:click_search()
  local input_txt = self.input.text
  if Util.is_empty(input_txt) then
    Util.show_message_tip(2198)
    return
  end
  if tonumber(input_txt) then
    input_txt = tonumber(input_txt)
  else
    Util.show_message_tip(2198)
    return
  end
  if input_txt == Global.player_uuid then
    Util.show_message_tip(2336)
    return
  end
  
  local function search_back()
    local search_list = FriendMgr:get_search_role_list()
    if #search_list <= 0 then
      Util.show_message_tip(2198)
    else
      self:update_player_list()
      self.v_uicompents.BtnRefresh_btn.gameObject:SetActive(false)
    end
  end
  
  if type(input_txt) == "string" then
    FriendMgr:request_search_role(nil, input_txt, search_back)
  elseif type(input_txt) == "number" then
    FriendMgr:request_search_role(input_txt, nil, search_back)
  end
end

function ui:_on_check_input_len(input)
  local len = Util.get_string_len(input.text)
  if len <= 0 then
    self.v_uicompents.BtnClear_btn.gameObject:SetActive(false)
    return
  end
  self.v_uicompents.BtnClear_btn.gameObject:SetActive(true)
end

function ui:arrange_list(search_list)
  for key, data in pairs(search_list) do
    data.sort_line = 0
    if 0 ~= data.offline_time then
      data.sort_line = 1
    end
  end
  _sort(search_list, function(a, b)
    if a.sort_line == b.sort_line then
      return a.lv > b.lv
    end
    return a.sort_line < b.sort_line
  end)
end

function ui:update_player_list(msg)
  local search_list
  search_list = FriendMgr:get_search_role_list()
  if not search_list then
    return
  end
  table.sort(search_list, function(a, b)
    if a.lv ~= b.lv then
      return a.lv > b.lv
    end
    return a.uuid < b.uuid
  end)
  self:give_back_auto_cache(PLAYER_ITEM_KEY)
  self.v_player_list = {}
  for index, data in ipairs(search_list) do
    local obj = self:get_auto_cache(PLAYER_ITEM_KEY)
    _insert(self.v_player_list, {obj = obj, data = data})
    self:update_player_info(obj, data, index)
  end
end

function ui:update_player_info(obj, player_data, index)
  local red_point_obj = Util.get_child("RedPoint_", obj)
  red_point_obj:SetActive(false)
  local player_mark_obj = Util.get_text("PlayerMarkName_", obj)
  player_mark_obj:SetActive(false)
  local lv_txt = Util.get_text("LvAmountBg/PlayerLv", obj)
  lv_txt.text = player_data.lv
  local name_txt = Util.get_text("PlayerName", obj)
  name_txt.text = player_data.name
  name_txt.color = COLOR_NAME
  local friend_info = FriendMgr:get_friend_info_by_id(player_data.uuid)
  if friend_info and friend_info.note and friend_info.note ~= "" then
    name_txt.text = friend_info.note
    name_txt.color = COLOR_MARK
  end
  local state_bg = Util.get_child_gameobj("PlayerStateBg", obj)
  local state_bg_img = Util.get_image("PlayerStateBg", obj)
  local online_txt = Util.get_text("PlayerState", state_bg)
  local player_quotation = Util.get_text("PlayerQuotation", obj)
  local line_txt = "离线"
  local color = "c9c5bc"
  local color_img = "535353"
  if 0 == player_data.offline_time then
    line_txt = "在线"
    color = "ffffff"
    color_img = "1f725c"
    online_txt.text = Util.format_str(line_txt)
  else
    local now_time = Date.server_time()
    local online_time = now_time - player_data.offline_time
    local time_tip = Date.get_time_desc2(online_time)
    online_txt.text = Util.format_str("{1}前在线", time_tip)
  end
  online_txt.color = Util.get_unity_color_by_hex(color)
  state_bg_img.color = Util.get_unity_color_by_hex(color_img)
  player_quotation.text = "" ~= player_data.quotation and player_data.quotation or Util.get_i18n("请多多指教")
  local head_icon = Util.get_image("PlayerProfile", obj)
  Util.load_char_head_icon(head_icon, player_data.icon)
  local state = player_data.friend_status
  local is_can_apply = state == FRIEND_STATE.APPLY
  local applied = Util.get_child_gameobj("BtnHadAdd", obj)
  local apply = Util.get_button("BtnAdd", obj)
  apply.gameObject:SetActive(state == FRIEND_STATE.APPLY)
  applied:SetActive(state == FRIEND_STATE.APPLIED)
  self:set_button_listener(apply, function()
    self:on_apply_add_friend(player_data)
  end)
  local head_btn = Util.get_button("BtnFunction_", obj)
  if head_btn then
    self:set_button_listener(head_btn, function()
      UIMgr:get_ui("ui_player_new_info"):ui_show(player_data)
    end)
  end
  if self.v_parent_ui then
    local assistant_obj = Util.get_child("Assistant", obj)
    local aid_list = player_data.buddy_show_info.assist_buddys
    for i = 1, 3 do
      local char = Util.get_child("Char" .. i, assistant_obj)
      local is_show = 0 ~= aid_list[i].id
      char:SetActive(is_show)
      if is_show then
        self.v_parent_ui:set_assistant_roles(char, aid_list[i])
      end
    end
  end
end

function ui:on_apply_add_friend(player_data)
  local function apply_callback(uuid, type)
    Util.show_message_tip(2194)
    
    self:update_player_state(uuid, type)
  end
  
  local player_friend_num = player_data.friend_num
  local self_friend_num = FriendMgr:get_friend_num()
  if player_friend_num >= FRIEND_MAX_NUM then
    Util.show_message_tip(2334)
    return
  end
  if self_friend_num >= FRIEND_MAX_NUM then
    Util.show_message_tip(2335)
    return
  end
  FriendMgr:apply_add_friend(player_data.uuid, apply_callback)
end

function ui:update_player_state(uuid, new_state)
  local obj
  if not self.v_player_list then
    return
  end
  for key, player_data in pairs(self.v_player_list) do
    local data = player_data.data
    if data.uuid == uuid then
      data.friend_status = new_state
      obj = player_data.obj
      break
    end
  end
  if not obj then
    return
  end
  local apply = Util.get_button("BtnAdd", obj)
  apply.gameObject:SetActive(new_state == FRIEND_STATE.APPLY)
  local friend = Util.get_rect_transform("BtnHadAdd", obj)
  friend.gameObject:SetActive(new_state == FRIEND_STATE.APPLIED)
end

return ui
