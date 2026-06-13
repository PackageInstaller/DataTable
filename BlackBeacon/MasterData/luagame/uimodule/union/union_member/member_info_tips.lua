local Base = require("ui.uiobject")
local UnionHelper = require("uimodule.union.union_helper")
local UnionCfg = require("uimodule.union.union_config")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_apply_friend = {
    "BtnApplyFriend",
    BIND_TYPE.BUTTON
  },
  v_btn_check_message = {
    "BtnCheckMessage",
    BIND_TYPE.BUTTON
  },
  v_btn_content = {
    "BtnContent",
    BIND_TYPE.OBJECT
  },
  v_btn_kick_out = {
    "BtnKickOut",
    BIND_TYPE.BUTTON
  },
  v_btn_leader_transfer = {
    "BtnLeaderTransfer",
    BIND_TYPE.BUTTON
  },
  v_btn_manager_content = {
    "BtnManagerContent",
    BIND_TYPE.OBJECT
  },
  v_close_btn = {
    "CloseBtn",
    BIND_TYPE.BUTTON
  },
  v_icon = {
    "Icon",
    BIND_TYPE.IMAGE
  },
  v_player_name = {
    "PlayerName",
    BIND_TYPE.TEXT
  }
}
local FRIEND_MAX_NUM = ShareRes.get_system_comm_value("FriendNumLimit")

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnApplyFriend", function()
    self:_onclick_friend_btn()
  end)
  self:set_button("BtnCheckMessage", function()
    self:_onclick_check_btn()
  end)
  self:set_button("BtnKickOut", function()
    self:_onclick_kickout_btn()
  end)
  self:set_button("BtnLeaderTransfer", function()
    self:_onclick_transfer_leader_btn()
  end)
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(member_info, ...)
  self.v_member_info = member_info
  if not self.v_member_info then
    return
  end
  ResMgr:load_set_icon(self.v_icon, UnionHelper.get_player_icon_path(self.v_member_info.icon))
  self.v_player_name.text = self.v_member_info.name
  local title = UnionMgr:get_my_union_title()
  self.v_btn_manager_content:SetActive(title & UnionCfg.GUILD_AUTH_LIST.KICK_OUT_ROLE > 0)
end

function ui:ui_on_hide()
end

function ui:_onclick_kickout_btn()
  local desc = Util.format_str("是否请离该玩家？")
  
  local function conform_callback()
    UnionMgr:request_kickout_member(self.v_member_info.uuid, function()
      Util.show_message_tip(2306)
    end)
    self:ui_hide()
  end
  
  Util.show_conform_tip(desc, nil, nil, nil, conform_callback)
end

function ui:_onclick_transfer_leader_btn()
  local desc = Util.format_str("是否确认转让会长？")
  
  local function conform_callback()
    UnionMgr:request_transfer_leader(self.v_member_info.uuid, function()
      Util.show_message_tip(2307)
    end)
    self:ui_hide()
  end
  
  Util.show_conform_tip(desc, nil, nil, nil, conform_callback)
end

function ui:_onclick_check_btn()
  UnionMgr:request_check_member(self.v_member_info.uuid, function(ok)
    if ok then
      ChatMgr:request_get_role_snapinfo(self.v_member_info.uuid, function(player_data)
        UIMgr:get_ui("ui_player_info"):ui_show(player_data)
      end)
    else
      Util.show_message_tip(2308)
    end
  end)
end

function ui:_onclick_friend_btn()
  local function callback(ok)
    if not ok then
      Util.show_message_tip(2308)
      
      return
    end
    local is_friend = FriendMgr:is_in_friend(self.v_member_info.uuid)
    if is_friend then
      Util.show_message_tip(2309)
      return
    end
    local is_applying = FriendMgr:check_applied_by_uuid(self.v_member_info.uuid)
    if is_applying then
      Util.show_message_tip(2310)
      return
    end
    local cur_friend_num = FriendMgr:get_friend_num()
    if cur_friend_num >= FRIEND_MAX_NUM then
      Util.show_message_tip(1403)
      return
    end
    FriendMgr:apply_add_friend(self.v_member_info.uuid, function()
      Util.show_message_tip(2310)
    end)
  end
  
  UnionMgr:request_check_member(self.v_member_info.uuid, callback)
end

return ui
