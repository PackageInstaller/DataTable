local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local LocalStorage = require("utils.localstorage")
local ACHIEVEMENT_SYS_ID = 41
local NOTICE_SYS_ID = 24
local icon_color = Util.get_unity_color_by_hex(tonumber("FFF3DE", 16))
local lock_color = Util.get_unity_color_by_hex(tonumber("7A7A78", 16))
local unlock_color = Util.get_unity_color_by_hex(tonumber("FFFFFF", 16))
local CSTSISDKManager = CS.Game.TSISDKManager
local BTN_SYS_LIST = {
  [1] = {
    btn_name = "Btn_Achievement",
    sys_id = ACHIEVEMENT_SYS_ID,
    redpoint = RedEnum.ACHIEVEMENT
  },
  [2] = {
    btn_name = "Btn_Archive",
    ui_name = "archive_enter",
    redpoint = RedEnum.ARCHIVES
  },
  [3] = {
    btn_name = "BtnNotice",
    sys_id = NOTICE_SYS_ID,
    redpoint = RedEnum.NOTICE
  },
  [4] = {
    btn_name = "BtnSign",
    ui_name = "uisign_in",
    sys_id = 7,
    redpoint = RedEnum.SIGN_IN
  },
  [5] = {
    btn_name = "BtnFriend",
    ui_name = "uifriend",
    sys_id = 12,
    redpoint = RedEnum.FRIEND
  },
  [6] = {
    btn_name = "BtnPhoto",
    ui_name = "uimain_photo",
    sys_id = 62,
    redpoint = RedEnum.SCENE_PHOTO_FASHION
  },
  [7] = {
    btn_name = "Btn_Synthesis",
    ui_name = "new_ui_item_synthesis",
    sys_id = 40
  }
}

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self.v_parent_ui:enable_ui_show_gameobj(true, true)
    self:do_hide_anim()
  end)
  self.v_uiobjects.BtnCommunity:SetActive(SDKManager:is_show_community_btn_in_more_entry())
  self:set_button("BtnCommunity", function()
    SDKManager:open_community()
  end)
  self.v_uiobjects.BtnAgreement:SetActive(SDKManager:is_show_privacy_policy_btn_in_more_entry())
  self:set_button("BtnAgreement", function()
    SDKManager:open_privacy_policy()
  end)
  self.v_uiobjects.BtnFeedback:SetActive(SDKManager:is_show_help_center_btn_in_more_entry())
  self:set_button("BtnFeedback", function()
    SDKManager:open_help_center()
  end)
  self.v_uiobjects.BtnJoinQQ:SetActive(SDKManager:is_show_join_qq_btn_in_more_entry())
  self:set_button("BtnJoinQQ", function()
    SDKManager:qq_join_group()
  end)
  self.v_uiobjects.BtnUserCenter:SetActive(SDKManager:is_show_user_center_btn_in_more_entry())
  self:set_button("BtnUserCenter", function()
    SDKManager:open_user_center()
  end)
  self.v_uiobjects.BtnExchange:SetActive(SDKManager:is_show_exchange_code_btn_in_more_entry())
  self:set_button("BtnExchange", function()
    SDKManager:open_exchange_code()
  end)
  self.v_uiobjects.BtnCancelLation:SetActive(SDKManager:is_show_delete_account_in_more_entry())
  self:set_button("BtnCancelLation", function()
    SDKManager:show_delete_account_popup()
  end)
  self.v_uiobjects.BtnScanQRCode:SetActive(SDKManager:is_enable_qrcode_login() and not Util.is_windows_plat() and not SDKManager:is_google_play_games() and not SDKManager:is_simulator())
  self:set_button_listener(self.v_uicompents.BtnScanQRCode_btn, function()
    CSTSISDKManager.ScanOrCode()
  end)
  self:set_button("Btn_Achievement", function()
    if SysOpenMgr:get_sys_is_open(ACHIEVEMENT_SYS_ID) then
      if PlayerMgr:whether_get_achievement_list() then
        UIMgr:get_ui("achievement_group"):ui_show()
      else
        self.v_uicompents.Btn_Achievement_btn.enabled = false
        PlayerMgr:get_all_achievement_list_form_server()
      end
    else
      local condition_id = ShareRes.get_sys_open_cfg(ACHIEVEMENT_SYS_ID).Condition[1]
      local unlock_desc = ShareRes.get_condition_desc(condition_id)
      if nil == unlock_desc or "" == unlock_desc then
        Util.show_message_tip(2346)
      else
        Util.show_message_tip(unlock_desc)
      end
    end
  end)
  self:set_button("BtnNotice", function()
    if not SysOpenMgr:get_sys_is_open(NOTICE_SYS_ID, true) then
      return
    end
    if SDKType == Config.SDK_TYPE.HIVE_SDK then
      UIMgr:get_ui("ui_notice_login"):ui_show()
      return
    end
    if NoticeMgr:get_is_no_notice() then
      Util.show_message_tip(2230)
      return
    end
    UIMgr:get_ui("uinotice"):ui_show()
  end)
  self:set_button("BtnLogout", function()
    UIMgr:get_ui("battle_setting"):ui_show()
  end)
  for k, v in pairs(BTN_SYS_LIST) do
    if v.ui_name then
      self:set_button(v.btn_name, function()
        if not v.sys_id or SysOpenMgr:get_sys_is_open(v.sys_id, true) then
          UIMgr:get_ui(v.ui_name):ui_show()
        end
      end)
    end
    if v.redpoint then
      local red = self:get_child_gameobj("RedPoint", self.v_uiobjects[v.btn_name].gameObject)
      RedPointMgr:bind_redpoint(self, red, v.redpoint)
    end
  end
end

function ui:ui_on_show()
  self.v_uiobjects.ButtonPanel_Out:SetActive(false)
  self.v_uiobjects.ButtonPanel_IN:SetActive(true)
  self.v_uiobjects.BtnClose:SetActive(true)
  self:register_event()
  self:refresh_sys_open()
  PlayerMgr:refresh_achievement_red_point()
  FriendMgr:update_red()
  FashionMgr:refresh_main_scene_red()
end

function ui:ui_on_hide()
  self.v_uiobjects.BtnClose:SetActive(true)
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:do_hide_anim()
  self.v_uiobjects.BtnClose:SetActive(false)
  self.v_uiobjects.ButtonPanel_Out:SetActive(true)
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  self.v_sequence = Util.create_sequence()
  self.v_sequence:AppendInterval(0.5)
  self.v_sequence:AppendCallback(function()
    self:set_enable(false)
  end)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_GET_ACHIEVEMENT_GROUP, self.refresh_achievement_sys, self)
end

function ui:check_read_unlock_anim(sys_id, is_open)
  local sys_cfg = ShareRes.get_sys_open_cfg(sys_id)
  if not sys_cfg or 0 == sys_cfg.Condition[1] then
    return true
  end
  local storage_key = string.format("more_entry_panel_read_unlock_anim_%s", sys_id)
  local read = 1 == LocalStorage:load_int(storage_key, 0, true)
  if is_open and not read then
    LocalStorage:save_int(storage_key, 1, true)
    return false
  end
  return true
end

function ui:refresh_sys_open()
  for k, v in pairs(BTN_SYS_LIST) do
    if v.sys_id then
      local is_open = SysOpenMgr:get_sys_is_open(v.sys_id)
      local is_read = is_open and self:check_read_unlock_anim(v.sys_id, is_open)
      local obj = self.v_uiobjects[v.btn_name]
      local lock = Util.get_child_gameobj("Lock", obj)
      local bg = Util.get_child_gameobj("Bg", obj)
      local icon = Util.get_image("Icon", obj)
      local txt = Util.get_text("Text", obj)
      lock:SetActive(not is_open or not is_read)
      if bg then
        Util.apply_grey_ex(bg, not is_open)
      end
      icon.gameObject:SetActive(is_open)
      icon.color = icon_color
      txt.color = is_read and unlock_color or lock_color
      if not is_open then
        local red = Util.get_child_gameobj("RedPoint", obj)
        if red then
          red:SetActive(false)
        end
      end
      if is_open and not is_read then
        local unLock_anim = Util.get_playabledirector("Ani_UnLock", obj)
        if unLock_anim then
          Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.ui_main_entry_panel_unlock_UI_SOUND)
          unLock_anim:Play()
        end
      end
    end
  end
end

function ui:refresh_achievement_sys()
  local is_open = SysOpenMgr:get_sys_is_open(ACHIEVEMENT_SYS_ID)
  local ready_data = PlayerMgr:whether_get_achievement_list()
  if is_open and not ready_data then
    PlayerMgr:get_all_achievement_list_form_server()
  end
  self.v_uicompents.Btn_Achievement_btn.enabled = is_open and ready_data
end

return ui
