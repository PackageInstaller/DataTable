local Base = require("ui.uiobject")
local ChatConfig = require("uimodule.chat.chat_config")
local CHAT_PLAYER_TITLE = require("uimodule.chat.chat_player_title")
local UnionCfg = require("uimodule.union.union_config")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local CSUnityUI = UnityEngine.UI
local Vec2 = require("base.vec2")
local SPEAK_SIDE = {
  OTHER = 1,
  SELF = 2,
  SYS = 3
}
local ZERO = Vec2.zero
local FRIEND_WORLD_WIDTH = 500
local DEFAULT_WORLD_WIDTH = 672
local PLAYER_ICON_PATH = "Icon/Profile/%s"
local FACE_ICON_PATH = "UIChat/Face/%s"
local UNION_TITLE = UnionCfg.UNION_TITLE
local UNION_TITLE_LAB = {
  [UNION_TITLE.CHAIRMAN] = Util.format_str("会长")
}
local MODEL = {
  v_time_panel = {
    "TimePoint",
    BIND_TYPE.OBJECT
  },
  v_time_lab = {
    "TimeTxt",
    BIND_TYPE.TEXT
  },
  v_self_panel = {
    "SelfPanel",
    BIND_TYPE.TRANSFORM
  },
  v_other_panel = {
    "OtherPanel",
    BIND_TYPE.TRANSFORM
  },
  v_sys_panel = {
    "SysMessage",
    BIND_TYPE.OBJECT
  },
  v_notice_panel = {
    "NoticeMessage",
    BIND_TYPE.OBJECT
  },
  v_title_obj_self = {
    "TitleObjSelf",
    BIND_TYPE.OBJECT
  },
  v_title_obj_other = {
    "TitleObjOther",
    BIND_TYPE.OBJECT
  }
}
local LIST = {
  {
    name = "icon",
    path = "PlayerHead/PlayerIcon",
    type = TypeUnityUIImage
  },
  {
    name = "name",
    path = "PlayerName/NameTxt",
    type = typeof(CSUnityUI.Text)
  },
  {
    name = "guide_name",
    path = "PlayerName/GuildNameTxt",
    type = typeof(CSUnityUI.Text)
  },
  {
    name = "guide_title",
    path = "PlayerName/GuildTitleTxt",
    type = typeof(CSUnityUI.Text)
  },
  {
    name = "short_msg_bg",
    path = "Message/ShortMsgBg",
    type = TypeUnityGameObject
  },
  {
    name = "short_msg_fit",
    path = "Message/ShortMsgBg",
    type = typeof(CS.Game.ContentSizeFitterByRect)
  },
  {
    name = "short_msg_lab",
    path = "Message/ShortMsgBg/Content",
    type = typeof(CSUnityUI.Text)
  },
  {
    name = "long_msg_bg",
    path = "Message/LongMsgBg",
    type = TypeUnityGameObject
  },
  {
    name = "long_bg_fit",
    path = "Message/LongMsgBg",
    type = typeof(CS.Game.ContentSizeFitterByRect)
  },
  {
    name = "long_msg_lab",
    path = "Message/LongMsgBg/Content",
    type = typeof(CSUnityUI.Text)
  },
  {
    name = "face_bg",
    path = "Message/FaceMsgBg",
    type = TypeUnityGameObject
  },
  {
    name = "face_img",
    path = "Message/FaceMsgBg/Content",
    type = TypeUnityUIImage
  },
  {
    name = "head_btn",
    path = "PlayerHead",
    type = typeof(CSUnityUI.Button)
  }
}
local TIME_STEP = {
  [1] = {0, 86400},
  [2] = {86400, 172800},
  [3] = {172800, 604800}
}
local WEEK_DATE = {
  [1] = Util.format_str("星期日"),
  [2] = Util.format_str("星期一"),
  [3] = Util.format_str("星期二"),
  [4] = Util.format_str("星期三"),
  [5] = Util.format_str("星期四"),
  [6] = Util.format_str("星期五"),
  [7] = Util.format_str("星期六")
}
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_sys_msg_lab = self:get_text("MsgContent", self.v_sys_panel)
  self.v_notice_msg_lab = self:get_text("MsgContent", self.v_notice_panel)
  self.v_ui_controls = {
    [SPEAK_SIDE.OTHER] = {
      panel = self.v_other_panel,
      panel_fit = self.v_other_panel:GetComponent(typeof(CS.Game.ContentSizeFitterByRect))
    },
    [SPEAK_SIDE.SELF] = {
      panel = self.v_self_panel,
      panel_fit = self.v_self_panel:GetComponent(typeof(CS.Game.ContentSizeFitterByRect))
    },
    [SPEAK_SIDE.SYS] = {
      panel = self.v_notice_panel
    }
  }
  for side, v in ipairs(self.v_ui_controls) do
    if side < SPEAK_SIDE.SYS then
      for _, t in ipairs(LIST) do
        if t.type == TypeUnityGameObject then
          v[t.name] = self:get_child_gameobj(t.path, v.panel)
        else
          v[t.name] = self:get_component(t.path, v.panel, t.type)
        end
      end
      v.logn_msg_rect = self:get_rect_transform(nil, v.long_msg_lab.gameObject)
      v.long_msg_fit = v.long_msg_lab.gameObject:GetComponent(typeof(CSUnityUI.ContentSizeFitter))
    end
  end
  for i, v in ipairs(self.v_ui_controls) do
    if v.head_btn then
      Global.listener_mgr:add_listener(self.v_object, v.head_btn.onClick, function()
        self:_on_click_player_head()
      end)
    end
  end
  self.v_item_rect = self:get_rect_transform(nil, self.v_object)
  self.v_item_fit = self.v_object:GetComponent(typeof(CS.Game.ContentSizeFitterByRect))
  self.v_time_interval = ShareRes.get_game_const("ChatShowTimeTTL") or 300
  self.v_world_width = DEFAULT_WORLD_WIDTH
end

function ui:ui_on_hide()
end

function ui:set_data(go, data_list, index)
  self.v_msg_list = data_list
  self.v_msg_data = data_list[index]
  self.v_msg_obj = go
  self.v_index = index
  local chat_type = self.v_msg_data.chat_type
  if chat_type == ChatConfig.CHAT_TYPE.SYSTEM then
    self:_set_sys_msg()
  elseif chat_type == ChatConfig.CHAT_TYPE.WORLD or chat_type == ChatConfig.CHAT_TYPE.FRIEND then
    self:_set_friend_or_world_msg()
  elseif chat_type == ChatConfig.CHAT_TYPE.GUILD then
    self:_set_union_msg()
  end
  if self.v_title_self then
    self.v_title_self:ui_hide()
    self:remove_wrap_ui(self.v_title_self)
    self.v_title_self = nil
  end
  if self.v_title_other then
    self.v_title_other:ui_hide()
    self:remove_wrap_ui(self.v_title_other)
    self.v_title_other = nil
  end
  local speaker_side = self:get_speak_side()
  local speaker = self.v_msg_data.speaker
  if speaker_side == SPEAK_SIDE.SELF then
    self.v_title_self = CHAT_PLAYER_TITLE:ui_wrap_ex(self, self.v_title_obj_self, true)
    self.v_title_self:set_data(speaker.title)
  elseif speaker_side == SPEAK_SIDE.OTHER then
    self.v_title_other = CHAT_PLAYER_TITLE:ui_wrap_ex(self, self.v_title_obj_other, true)
    self.v_title_other:set_data(speaker.title)
  end
  local show_time = self:_calc_interval()
  self.v_time_panel:SetActive(nil ~= show_time)
  if show_time then
    self.v_time_lab.text = show_time
  end
  self:force_fit_size()
end

function ui:_set_sys_msg()
  for i, v in ipairs(self.v_ui_controls) do
    v.panel:SetActive(i == SPEAK_SIDE.SYS)
  end
  self.v_sys_panel:SetActive(false)
  self.v_notice_msg_lab.text = self.v_msg_data.notify_msg.msg
end

function ui:_set_friend_or_world_msg()
  self.v_speaker = self.v_msg_data.speaker
  self.v_chat_msg = self.v_msg_data.msg
  local speak_side = self:get_speak_side()
  for i, v in ipairs(self.v_ui_controls) do
    v.panel:SetActive(i == speak_side)
  end
  self.v_notice_panel:SetActive(false)
  self.v_sys_panel:SetActive(speak_side == SPEAK_SIDE.SYS)
  local is_friend_chat = self.v_msg_data.chat_type == ChatConfig.CHAT_TYPE.FRIEND
  self.v_world_width = is_friend_chat and FRIEND_WORLD_WIDTH or DEFAULT_WORLD_WIDTH
  if speak_side == SPEAK_SIDE.SYS then
    local msg_lab
    if self.v_chat_msg.role_name then
      msg_lab = string.format("%s%s%s", Util.format_str("玩家"), self.v_chat_msg.role_name, self.v_chat_msg.msg)
    else
      msg_lab = self.v_chat_msg.msg
    end
    self.v_sys_msg_lab.text = msg_lab
  else
    local controls = self.v_ui_controls[speak_side]
    local avatar_cfg = ShareRes.create("player.player_avatar", self.v_speaker.icon)
    ResMgr:load_set_icon(controls.icon, string.format(PLAYER_ICON_PATH, avatar_cfg.Icon))
    controls.name.text = self.v_speaker.name
    controls.guide_name:SetActive(self.v_speaker.guild_name ~= "")
    controls.guide_title:SetActive(false)
    if self.v_speaker.guild_name ~= "" then
      controls.guide_name.text = string.format("[%s]", self.v_speaker.guild_name)
    end
    local face_character = self:_get_is_face(self.v_chat_msg.msg)
    controls.short_msg_bg:SetActive(not face_character)
    controls.long_msg_bg:SetActive(not face_character)
    controls.face_bg:SetActive(face_character)
    if face_character then
      local cfg = ChatConfig.chat_face[face_character]
      if cfg then
        ResMgr:load_set_icon(controls.face_img, string.format(FACE_ICON_PATH, cfg.icon))
      end
    else
      controls.short_msg_lab.text = self.v_chat_msg.msg
      local len = self:calc_text_width(controls.short_msg_lab)
      controls.short_msg_bg:SetActive(len <= self.v_world_width)
      controls.long_msg_bg:SetActive(len > self.v_world_width)
      if len > self.v_world_width then
        controls.long_msg_lab.text = self.v_chat_msg.msg
      end
    end
  end
end

function ui:_set_union_msg()
  self.v_speaker = self.v_msg_data.speaker
  self.v_chat_msg = self.v_msg_data.msg
  local speak_side = self:get_speak_side()
  for i, v in ipairs(self.v_ui_controls) do
    v.panel:SetActive(i == speak_side)
  end
  self.v_notice_panel:SetActive(false)
  self.v_sys_panel:SetActive(speak_side == SPEAK_SIDE.SYS)
  self.v_world_width = DEFAULT_WORLD_WIDTH
  if speak_side == SPEAK_SIDE.SYS then
    local msg_lab
    if self.v_chat_msg.role_name then
      msg_lab = string.format("%s<color=#ec7f00>%s</color>%s", Util.format_str("玩家"), self.v_chat_msg.role_name, self.v_chat_msg.msg)
    else
      msg_lab = self.v_chat_msg.msg
    end
    self.v_sys_msg_lab.text = msg_lab
  else
    local controls = self.v_ui_controls[speak_side]
    local avatar_cfg = ShareRes.create("player.player_avatar", self.v_speaker.icon)
    ResMgr:load_set_icon(controls.icon, string.format(PLAYER_ICON_PATH, avatar_cfg.Icon))
    controls.name.text = self.v_speaker.name
    controls.guide_name:SetActive(false)
    local title = UNION_TITLE_LAB[self.v_speaker.position]
    controls.guide_title:SetActive(nil ~= title)
    if title then
      controls.guide_title.text = string.format("<color=#ec7f00>[%s]</color>", title)
    end
    local face_character = self:_get_is_face(self.v_chat_msg.msg)
    controls.short_msg_bg:SetActive(not face_character)
    controls.long_msg_bg:SetActive(not face_character)
    controls.face_bg:SetActive(face_character)
    if face_character then
      local cfg = ChatConfig.chat_face[face_character]
      if cfg then
        ResMgr:load_set_icon(controls.face_img, string.format(FACE_ICON_PATH, cfg.icon))
      end
    else
      controls.short_msg_lab.text = self.v_chat_msg.msg
      local len = self:calc_text_width(controls.short_msg_lab)
      controls.short_msg_bg.gameObject:SetActive(len <= self.v_world_width)
      controls.long_msg_bg.gameObject:SetActive(len > self.v_world_width)
      if len <= self.v_world_width then
      else
        controls.long_msg_lab.text = self.v_chat_msg.msg
      end
    end
  end
end

function ui:calc_text_width(text)
  if not text then
    return 0
  end
  local tg = text.cachedTextGeneratorForLayout
  local setting = text:GetGenerationSettings(ZERO)
  return tg:GetPreferredWidth(text.text, setting) / text.pixelsPerUnit
end

function ui:get_speak_side()
  if self.v_speaker and self.v_speaker.uuid == Global.player_uuid then
    return SPEAK_SIDE.SELF
  elseif self.v_speaker and self.v_speaker.uuid > 0 then
    return SPEAK_SIDE.OTHER
  else
    return SPEAK_SIDE.SYS
  end
end

function ui:_get_is_face(msg)
  for v in string.gmatch(msg, "%[%d+%]") do
    return v
  end
end

local function callback(player_data)
  UIMgr:get_ui("ui_player_info"):ui_show(player_data)
end

function ui:_on_click_player_head()
  local speak_side = self:get_speak_side()
  if speak_side ~= SPEAK_SIDE.OTHER then
    return
  end
  ChatMgr:request_get_role_snapinfo(self.v_speaker.uuid, callback)
end

function ui:_calc_interval()
  if self.v_index <= 1 then
    return
  end
  local cur_time = self.v_msg_data.send_time
  local last_data = self.v_msg_list[self.v_index - 1]
  local last_time = last_data.send_time
  if self.v_time_interval and cur_time - last_time >= self.v_time_interval then
    local diff = Date.server_time() - cur_time
    return self:_get_time_str(diff, cur_time)
  end
end

function ui:_get_time_str(time, cur_time)
  for i, v in ipairs(TIME_STEP) do
    if time >= v[1] and time < v[2] then
      return self:_formate_time(cur_time, i)
    end
  end
  return self:_formate_time(cur_time, 4)
end

function ui:_formate_time(timeStamp, idx)
  local date = os.date("!*t", timeStamp)
  local time = string.format("%02d:%02d", date.hour, date.min)
  if 1 == idx then
    return time
  elseif 2 == idx then
    return Util.format_str("昨天 {1}", time)
  elseif 3 == idx then
    return string.format("%s %s", WEEK_DATE[date.wday], time)
  else
    local str = Util.format_str("{1}月{2}日", date.month, date.day)
    return string.format("%s %s", str, time)
  end
end

function ui:force_fit_size()
  local speak_side = self:get_speak_side()
  if speak_side == SPEAK_SIDE.SYS then
    self.v_item_fit:ResetSize()
    return
  end
  local controls = self.v_ui_controls[speak_side]
  if controls then
    controls.long_msg_fit:SetLayoutVertical()
    LayoutRebuilder.ForceRebuildLayoutImmediate(controls.logn_msg_rect)
    controls.long_bg_fit:ResetSize()
    LayoutRebuilder.ForceRebuildLayoutImmediate(controls.panel)
    controls.panel_fit:ResetSize()
  end
  local rects = self.v_item_fit.targetRect
  for i = 0, rects.Length - 1 do
    LayoutRebuilder.ForceRebuildLayoutImmediate(rects[i])
  end
  self.v_item_fit:ResetSize()
end

return ui
