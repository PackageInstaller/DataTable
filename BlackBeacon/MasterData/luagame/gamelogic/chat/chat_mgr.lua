local Base = require("gamelogic.base_system")
local ChatConfig = require("uimodule.chat.chat_config")
local Account = require("gamelogic.account.account")
local Json = require("utils.json")
local M = Util.create_child_mt(Base)
local CHAT_SYS_REDPOINT = 1
local FRIEND_LIST_REDPOINT = 7
local CHAT_SYS_ID = 11
local CHANNEL_TYPE = ChatConfig.CHANNEL_TYPE
local CommonDefine = require("cs_share.common_define")
local Json = require("utils.json")
local SYSTEM_NOTIFY_TYPE = CommonDefine.SYSTEM_NOTIFY_TYPE
local MULTILINGUAL_REVOLVE_DEVICE = CommonDefine.MULTILINGUAL_REVOLVE_DEVICE

function M:init_sys()
  Base.init_sys(self)
  self.v_friend_info = {}
  self.v_friend_msgs = {}
  self.v_record_idx = {}
  self.v_start_record_idx = {}
  self.v_player_info = nil
  self.v_last_frend_chat_side = nil
  self.v_sys_msg = {}
  self.v_world_msgs = {}
  self.v_world_channel = 0
  self.v_union_msgs = {}
  self.v_latest_msg = nil
  self.v_need_sync = {}
  self.v_pull_num = ShareRes.get_game_const("FriendChatRecordPullNum") or 50
  self:sys_mq_bind(Const.MSG_ON_PLAYER_INFO_UPDATE, self.response_player_info_update, self)
end

function M:on_reconnect()
  self.v_friend_info = {}
  self.v_friend_msgs = {}
  self.v_record_idx = {}
  self.v_start_record_idx = {}
  self.v_player_info = nil
  self.v_last_frend_chat_side = nil
  self.v_sys_msg = {}
  self.v_world_msgs = {}
  self.v_latest_msg = nil
end

function M:response_player_info_update()
  self.v_player_info = nil
end

function M:on_chat_status_info(data)
  self.v_can_chat = data.chat_status == CommonDefine.ROLE_CHAT_STATUS.NORMAL
end

function M:sync_friend_chat_info(data)
  local chatInfo = data.chat_info
  local friend_id = chatInfo.uuid
  if not self.v_friend_msgs[friend_id] then
    self.v_friend_msgs[friend_id] = {}
  end
  if self.v_friend_info[friend_id] then
    local chat_msg = self:_build_friend_chat_info(friend_id, chatInfo)
    table.insert(self.v_friend_msgs[friend_id], chat_msg)
    if not self.v_record_idx[friend_id] then
      self.v_record_idx[friend_id] = chat_msg.idx
    end
  end
  self.v_last_frend_chat_side = friend_id
  local msg = MsgGame:mq_publish2(Const.MSG_FRIEND_CHAT_MSG_UPDATE)
  msg.mm_obj = friend_id
  RedPointMgr:enable_dynamic_redpoint(friend_id, FRIEND_LIST_REDPOINT, true)
end

function M:sync_word_chat_info(data)
  data.chat_info.chat_type = ChatConfig.CHAT_TYPE.WORLD
  table.insert(self.v_world_msgs, data.chat_info)
  local channel = CHANNEL_TYPE.WORLD
  self.v_latest_msg = {
    channel = channel,
    chatInfo = data.chat_info
  }
  MsgGame:mq_publish2(Const.MSG_WORLD_CHAT_MSG_UPDATE)
  if data.chat_info.speaker.uuid ~= Global.player_uuid then
    RedPointMgr:enable_redpoint(ChatConfig.Channnel_red_point[channel], true)
  end
end

function correcting_multilingual_notify(data)
  local notify_data = data.notify_msg
  if notify_data.type ~= SYSTEM_NOTIFY_TYPE.MULTILINGUAL_REVOLVE_LANTERN then
    return
  end
  local device = Account:get_device_type()
  local notify_device = notify_data.device_type
  if notify_device ~= MULTILINGUAL_REVOLVE_DEVICE.ALL and 0 ~= device and (notify_device == MULTILINGUAL_REVOLVE_DEVICE.AOS and 1 == device_type or notify_device == MULTILINGUAL_REVOLVE_DEVICE.IOS and 2 == device_type) then
    return
  end
  local other_language_msg = notify_data.other_language
  if other_language_msg then
    local client_language = Global.curr_text_language
    local other_language_map = Json.decode(other_language_msg)
    if other_language_map then
      for _, info in pairs(other_language_map) do
        if info.language_type == client_language then
          notify_data.msg = info.content
          break
        end
      end
    end
  end
end

function M:sync_system_notify(data)
  data.chat_type = ChatConfig.CHAT_TYPE.SYSTEM
  correcting_multilingual_notify(data)
  table.insert(self.v_sys_msg, data)
  MsgGame:mq_publish2(Const.MSG_SYS_MSG_UPDATE)
  local channel = CHANNEL_TYPE.SYSTEM
  self.v_latest_msg = {channel = channel, chatInfo = data}
  MarqueeMgr:add_msg(data.notify_msg.msg, data.notify_msg.loop_seconds or -1, data.notify_msg.msg_index)
end

function M:sync_union_chat_info(data)
  data.chat_info.chat_type = ChatConfig.CHAT_TYPE.GUILD
  table.insert(self.v_union_msgs, data.chat_info)
  local channel = CHANNEL_TYPE.GUILD
  self.v_latest_msg = {
    channel = channel,
    chatInfo = data.chat_info
  }
  MsgGame:mq_publish2(Const.MSG_UNION_CHAT_MSG_UPDATE)
  if data.chat_info.speaker and data.chat_info.speaker ~= Global.player_uuid then
    RedPointMgr:enable_redpoint(ChatConfig.Channnel_red_point[channel], true)
  end
end

function M:request_friend_chat_record(send_data)
  Network:call("c2gs_get_friend_chat_record", send_data, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      self:_sync_friend_chat_record(send_data.target_uuid, resp.chat_record)
      local msg = MsgGame:mq_publish2(Const.MSG_PULL_FRIEND_CHAT_MSG_SUCCESS)
      msg.mm_obj = send_data.target_uuid
      self.v_cur_pull_friend = nil
      self.v_pull_all = nil
    end
  end)
end

function M:_sync_friend_chat_record(friend_id, data)
  if not self.v_friend_msgs[friend_id] then
    self.v_friend_msgs[friend_id] = {}
  end
  local list = self.v_friend_msgs[friend_id]
  for _, v in pairs(data) do
    local chat_msg = self:_build_friend_chat_info(friend_id, v)
    table.insert(list, chat_msg)
  end
  table.sort(list, function(a, b)
    return a.idx < b.idx
  end)
  if #list > 0 then
    if self.v_record_idx[friend_id] and self.v_record_idx[friend_id] == list[1].idx then
      self.v_start_record_idx[friend_id] = list[1].idx
    end
    self.v_record_idx[friend_id] = list[1].idx
  end
end

function M:_build_friend_chat_info(friend_id, chatInfo)
  local speaker
  if friend_id == chatInfo.uuid then
    speaker = self.v_friend_info[friend_id]
  else
    speaker = self:_build_my_info()
  end
  return {
    speaker = speaker,
    msg = chatInfo.msg,
    send_time = chatInfo.send_time,
    idx = chatInfo.idx,
    chat_type = ChatConfig.CHAT_TYPE.FRIEND
  }
end

function M:request_send_friend_chat_msg(friend_data, msg)
  if not self:can_chat() then
    return
  end
  local friend_id = friend_data.uuid
  self.v_friend_info[friend_id] = friend_data
  local chat_msg = {type = 0, msg = msg}
  local send_msg = {target_uuid = friend_id, chat_msg = chat_msg}
  Network:call("c2gs_friend_chat_msg", send_msg, function(ok, resp)
    if true == ok and 0 == resp.errcode then
      if not self.v_friend_msgs[friend_id] then
        self.v_friend_msgs[friend_id] = {}
      end
      local list = self.v_friend_msgs[friend_id]
      self:_insert_my_chat_msg(list, resp.msg_idx, chat_msg)
      if not self.v_record_idx[friend_id] then
        self.v_record_idx[friend_id] = resp.msg_idx
      end
      local param = MsgGame:mq_publish2(Const.MSG_FRIEND_CHAT_MSG_UPDATE)
      param.mm_obj = friend_id
    end
  end)
end

function M:_insert_my_chat_msg(list, idx, msg)
  local chat_msg = {
    speaker = self:_build_my_info(),
    msg = msg,
    send_time = Date.server_time(),
    idx = idx,
    chat_type = ChatConfig.CHAT_TYPE.FRIEND
  }
  self.v_last_frend_chat_side = Global.player_uuid
  table.insert(list, chat_msg)
end

function M:_build_my_info()
  if not self.v_player_info then
    self.v_player_info = {
      uuid = Global.player_uuid,
      icon = PlayerMgr:get_player_head_id(),
      lv = PlayerMgr:get_role_lv(),
      name = PlayerMgr:get_player_name()
    }
  end
  return self.v_player_info
end

function M:request_join_world_chat(channel_id)
  Network:call("c2gs_join_word_channel", {channel_id = channel_id}, function(ok, resp)
    if true == ok then
      if 0 == resp.errcode then
        self.v_world_channel = resp.channel_id
        Log.Info("request_join_world_chat", self.v_world_channel)
        self.v_world_msgs = {}
        local sys_msg = {
          msg = {
            type = -1,
            msg = Util.format_str("已进入<color=#ec7f00>世界频道{1}</color>，在线人数：<color=#ec7f00>{2}</color>", resp.channel_id, resp.role_num)
          },
          send_time = Date.server_time(),
          chat_type = ChatConfig.CHAT_TYPE.WORLD
        }
        table.insert(self.v_world_msgs, sys_msg)
        self.v_latest_msg = {
          channel = CHANNEL_TYPE.WORLD,
          chatInfo = sys_msg
        }
        MsgGame:mq_publish2(Const.MSG_WORLD_CHAT_CHANNEL_UPDATE)
      else
        Util.show_message_tip(2078)
      end
      self.v_has_join_default = true
    end
  end)
end

function M:request_send_world_chat_msg(msg)
  if not self:can_chat() then
    return
  end
  local chat_msg = {type = 0, msg = msg}
  Network:call("c2gs_word_chat_msg", {chat_msg = chat_msg})
end

function M:request_get_role_snapinfo(uuid, callback)
  Network:call("c2gs_get_role_snapinfo", {target_uuid = uuid}, function(ok, resp)
    if ok and callback then
      callback(resp.role_info)
    end
  end)
end

function M:request_send_union_chat_msg(msg)
  local chat_msg = {type = 0, msg = msg}
  Network:call("c2gs_guild_chat_msg", {chat_msg = chat_msg})
end

function M:request_send_msg(channel_type, msg)
  if channel_type == CHANNEL_TYPE.WORLD then
    self:request_send_world_chat_msg(msg)
  else
    if channel_type == CHANNEL_TYPE.GUILD then
      self:request_send_union_chat_msg(msg)
    else
    end
  end
end

function M:get_friend_chat_list(friend_data)
  local friend_id = friend_data.uuid
  self.v_friend_info[friend_id] = friend_data
  local list = self.v_friend_msgs[friend_id]
  return list or {}
end

function M:get_all_friends_chat_record(friends)
  if self.v_pull_all then
    return
  end
  for _, v in pairs(friends) do
    if not self.v_record_idx[v.uuid] then
      self.v_friend_info[v.uuid] = v
      local send_data = {
        target_uuid = v.uuid,
        limit_num = self.v_pull_num
      }
      self:request_friend_chat_record(send_data)
      self.v_pull_all = true
    end
  end
end

function M:get_record_idx(friend_id)
  return self.v_record_idx[friend_id] or 0
end

function M:pull_friend_chat_record(friend_data)
  local uuid = friend_data.uuid
  local cur_idx = self.v_record_idx[uuid]
  if not cur_idx or cur_idx == self.v_start_record_idx[uuid] then
    return
  end
  if self.v_cur_pull_friend then
    return
  end
  local send_data = {
    target_uuid = uuid,
    start_idx = cur_idx - 1,
    limit_num = self.v_pull_num
  }
  self:request_friend_chat_record(send_data)
  self.v_cur_pull_friend = uuid
end

function M:join_default_channel()
  if not SysOpenMgr:get_sys_is_open(CHAT_SYS_ID) then
    return
  end
  if 0 == self.v_world_channel then
    Log.Info("join_default_channel")
    self:request_join_world_chat()
  end
end

function M:get_world_chat_list()
  return self.v_world_msgs
end

function M:get_sys_list()
  return self.v_sys_msg
end

function M:get_my_last_speak(channel)
  local msgs
  if channel == CHANNEL_TYPE.WORLD then
    msgs = self.v_world_msgs
  elseif channel == CHANNEL_TYPE.GUILD then
    msgs = self.v_union_msgs
  end
  if not msgs then
    return
  end
  local length = #msgs
  for i = length, 1, -1 do
    local chat_data = msgs[i]
    if chat_data.speaker and chat_data.speaker.uuid == Global.player_uuid then
      return chat_data
    end
  end
end

function M:get_world_channel_id()
  return self.v_world_channel
end

function M:get_latest_msg()
  return self.v_latest_msg
end

function M:get_latest_friend_chat_side()
  return self.v_last_frend_chat_side
end

function M:get_guild_chat_list()
  return self.v_union_msgs
end

function M:clear_guild_msg()
  self.v_union_msgs = {}
end

function M:can_chat()
  return self.v_can_chat
end

return M
