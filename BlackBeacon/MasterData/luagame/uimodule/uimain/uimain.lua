local UnityTime = UnityEngine.Time
local UnityFind = _ENV.UnityFind
local TypeUnityCamera = typeof(UnityEngine.Camera)
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local UnityShader = UnityEngine.Shader
local CSScreen = UnityEngine.Screen
local MAIN_SCENE_SHOW_ID = UnityShader.PropertyToID("_MAIN_SCENE_SHOW")
local Base = require("ui.uibase")
local ChatConfig = require("uimodule.chat.chat_config")
local Vec2 = require("base.vec2")
local ui = Util.create_child_mt(Base)
local AssetBarView = require("ui.asset_bar.asset_bar")
local SyncListClass = require("ui.widget.sync_scroll_list")
local BannerPageItem = require("uimodule.uimain.banner_page")
local PLAYER_PROFILE = "Icon/Profile/%s"
local NewModelRtView = require("uimodule.uimain.signboard_rt_view_main")
local MODEL_CONFIG = require("ui.model_rt_view.model_config")
local UIMAIN_CONFIG = require("uimodule.uimain.uimain_config")
local TASK_HELPER = require("uimodule.task.task_helper")
local commonDef = require("cs_share.common_define")
local UI_SHOW_CONFIG = UIMAIN_CONFIG.UI_SHOW_CONFIG
local UI_SHOW_CONFIG_FUN = UIMAIN_CONFIG.UI_SHOW_CONFIG_FUN
local effect_id = "Fx_UI_Switch_Hero"
local BOOK_MODEL_NAME = "Book1"
local dotween = CS.DG.Tweening.DOTweenAnimation
local LocalStorage = require("utils.localstorage")
local _tinsert = table.insert
local SIGNBOARD_PARAM = Config.SIGNBOARD_PARAM
local CONDITION_ACTION = Config.CONDITION_ACTION
local QUESTION_SYS_ID = 38
local CSInput = UnityEngine.Input
local bird_level_need_add_vet3 = UnityVector3(0.3, 0.3, 0)
local BTN_LIST = {
  [1] = {
    btn_name = "Btn_character",
    ui_name = "character_enter",
    redpoint = 25
  },
  [2] = {
    btn_name = "BtnRenwu",
    ui_name = "ui_task_new",
    redpoint = 9
  },
  [3] = {btn_name = "BtnMail", ui_name = "uimail"},
  [4] = {
    btn_name = "BtnPlayer",
    ui_name = "uiplayer_new"
  },
  [5] = {
    btn_name = "BtnShangcheng",
    ui_name = "shop",
    redpoint = RedEnum.SHOP
  },
  [6] = {btn_name = "BtnChat", ui_name = "uichat"},
  [7] = {
    btn_name = "BtnChouka",
    ui_name = "uidrawcard",
    redpoint = 23
  },
  [8] = {
    btn_name = "Btn_Union",
    ui_name = "union_main",
    redpoint = RedEnum.UNION
  },
  [9] = {
    btn_name = "ActTem",
    ui_name = "uiactivity",
    close = true
  },
  [10] = {
    btn_name = "BtnBoxpot",
    ui_name = "card_pack",
    redpoint = 60
  },
  [11] = {btn_name = "BtnWebView", sys_id = QUESTION_SYS_ID},
  [12] = {
    btn_name = "BtnNovice",
    ui_name = "ui_activity",
    redpoint = 12
  },
  [13] = {
    btn_name = "Btn_Bag",
    ui_name = "uibag",
    redpoint = RedEnum.BAG
  },
  [14] = {
    btn_name = "BtnBuilding",
    sys_id = 59,
    ui_name = "building_main",
    redpoint = RedEnum.BUILDING
  },
  [15] = {
    btn_name = "BtnMonthTask",
    ui_name = "ui_monthtask",
    sys_id = 54,
    redpoint = RedEnum.PASSPORT
  },
  [16] = {
    btn_name = "BtnActMain",
    ui_name = "ui_time_limited_activity_main",
    sys_id = 0,
    redpoint = RedEnum.TIME_LIMITED_ACTIVITY
  },
  [17] = {
    btn_name = "BtnMainLine",
    ui_name = "ui_chapter_detail",
    sys_id = 0
  }
}
local SHOW_CHAR_UI = {
  signboard_change = "signboard_change",
  uichat = "uichat"
}
local COLOR_DIME = tonumber("969696", 16)
local COLOR_LIGHT = tonumber("FFFFFF", 16)
local CHAT_SYS_ID = 11
local SIGN_IN_SYS_ID = 7
local MODEL_PARAM = MODEL_CONFIG.UI_MAIN_MODEL_PARAM
local ACT_DEFINE = Config.ACT_DEFINE
local ACTBANNER_ITEM_KEY = "ACTBANNER_ITEM_KEY"
local ACTBANNER_SELECT_KEY = "ACTBANNER_SELECT_KEY"
local VIDEO_DELAY_MIN = 10
local VIDEO_DELAY_MAX = 20
local _randomseed = math.randomseed
local _random = math.random
local _time = os.time
local _date = os.date
local UnityApplication = UnityEngine.Application
local RuntimePackage = require("manager.res.runtime_package")
local TypeUnityVideoPlayer = typeof(UnityEngine.Video.VideoPlayer)
local TypeMeshRenderer = typeof(UnityEngine.MeshRenderer)
local TypeMaterailCollect = typeof(CS.Game.MaterailCollect)
local TypeTexCollect = typeof(CS.Game.TexCollect)
local bird_obj
local is_camera_playing = false

function ui:ui_finish_load(...)
  self.v_signboard_girl_panel = self:get_panel("signboard_girl")
  self.v_uiobjects.MainPanel:SetActive(false)
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 0)
  self:set_button("BtnFight", function()
    self:on_click_fight()
  end)
  self:set_button("BtnStrength", function()
    UIMgr:get_ui("uiforcerecharg"):ui_show()
  end)
  self:set_button("BtnSkip", function()
    self:reset_signboard_param_movie()
    self.v_uiobjects.BtnSkip:SetActive(false)
  end)
  local name2sys = ShareRes.create("sysopen.ui_to_sys")
  self.v_sys_list = {}
  self.v_btn2sys = {}
  self.v_btn2sys.BtnNovice = 14
  self.v_camera_track_state = {from = -1, to = -1}
  for k, v in pairs(BTN_LIST) do
    local btn_name = v.btn_name
    local sys_id = v.ui_name and name2sys[v.ui_name] or v.sys_id
    if sys_id and not self.v_sys_list[sys_id] then
      self.v_sys_list[sys_id] = btn_name
      self.v_btn2sys[btn_name] = sys_id
    end
    self:set_button(btn_name, function()
      if v.ui_name and SysOpenMgr:get_is_ui_open(v.ui_name, true) and not v.close then
        if v.ui_name == "uinotice" and NoticeMgr:get_is_no_notice() then
          Util.show_message_tip(2230)
          return
        elseif v.ui_name == "uidrawcard" then
          self:enter_draw()
          return
        elseif v.ui_name == "ui_monthtask" then
          if PassPortMgr:get_passport_change_trigger() then
            UIMgr:get_ui("ui_monthtask_enter"):ui_show()
            PassPortMgr:reset_passport_change_trigger()
            return
          end
          if RedPointMgr:get_redpoint_enable_by_id(RedEnum.PASSPORT_TASK) then
            UIMgr:get_ui(v.ui_name):ui_show(nil, 2)
          end
        elseif v.ui_name == "ui_time_limited_activity_main" then
          local version_activity_id = TimeLimitedActMgr:get_version_activity_id()
          TimeLimitedActMgr:open_version_activity_win(version_activity_id)
          return
        elseif v.ui_name == "ui_chapter_detail" then
          if not self.v_newest_chapter_cfg or not self.v_newest_node_cfg then
            return
          end
          if not ResMgr:check_is_can_fight_with_res(self.v_newest_chapter_cfg) then
            return
          end
          UIMgr:get_ui("ui_chapter_detail"):ui_show(self.v_newest_chapter_cfg.Id, nil, nil, nil, self.v_newest_node_cfg.Id)
          return
        end
        UIMgr:get_ui(v.ui_name):ui_show()
      end
    end)
    if v.redpoint then
      local red = self:get_child_gameobj("SysOpen/RedPoint", self.v_uiobjects[btn_name].gameObject)
      RedPointMgr:bind_redpoint(self, red, v.redpoint)
    end
  end
  self:set_button("BtnFile", function()
    PlayerMgr:on_player_upgrade({new_level = 10})
  end)
  self:register_exist_auto_template(ACTBANNER_ITEM_KEY, self.v_uiobjects.ActTem, self.v_uiobjects.ActBannerContent)
  local rect_ex = self.v_uiobjects.ActBanner:GetComponent(typeof(CS.Game.ScrollRectEx))
  self.synv_list = SyncListClass:new(self, rect_ex, self.v_uiobjects.BannerNow, BannerPageItem, ACTBANNER_SELECT_KEY)
  self:set_button("FarClickChar", function()
    self:far_click_char()
  end)
  self:set_button("FarClickCharBird", function()
    self:on_mascot_click()
  end)
  self:set_button("BtnTower", function()
    UIMgr:get_ui("ui_climbing_tower_main"):ui_show()
  end)
  self:set_button("BtnActivitySummer", function()
    UIMgr:get_ui("ui_activity_summer_main"):ui_show()
  end)
  self:set_button("BtnEntrance", function()
    SysOpenMgr:jump_to_sys(self.v_curr_quick_enter_cfg.JumpId)
  end)
  self:set_button("BtnChange", function()
    self:refresh_main_scene_quick_btn_state()
  end)
  
  local function sure_callback()
    UIMgr:RemoveCanvasBlur()
  end
  
  self:set_button("BtnOrnaments", function()
    UIMgr:get_ui("ui_ornaments"):ui_show()
  end)
  self:set_button("Btn_ButtonPanel", function()
    local sub_panel = self:get_panel("more_entry_panel")
    if sub_panel.v_enable == false then
      self:get_panel("more_entry_panel"):set_enable(true)
      self:enable_ui_show_gameobj(false, true)
      Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.uimain_setting_UI_SOUND)
    end
  end)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.ButtonPanelRed, RedEnum.UIMAIN_MORE_ENTRY)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
  self.v_asset_bar:reset_by_id_list({
    Config.COIN_ITEMID,
    Config.DIAMOND_ITEMID
  })
  self.v_light_color = Util.get_unity_color_by_hex(COLOR_LIGHT)
  self.v_dime_color = Util.get_unity_color_by_hex(COLOR_DIME)
  self.v_msg_lab = self:get_text(nil, self.v_uiobjects.ChatCont)
  self.v_timer = {}
  self.v_safe_area_obj = Util.get_child_gameobj("SafeArea", self.v_object)
  self.v_full_screen_background = Util.get_child_gameobj("FullScreenBackground", self.v_object)
  self.v_fade_dotween = self.v_safe_area_obj:GetComponent(typeof(dotween))
  self.v_cannot_touch_bg_is_first = true
  self.v_ani_fade_in = Util.get_playabledirector("Animation/FadeInAnim", self.v_object)
  self.v_ani_fade_in_delay = Util.get_playabledirector("Animation/FadeInAnimDelay", self.v_object)
  self.v_ani_fade_in_no_player = Util.get_playabledirector("Animation/FadeInAnimUnBtnPlayer", self.v_object)
  self.v_ani_ui_out = Util.get_playabledirector("Animation/Ani_UIMain1_Out", self.v_object)
  self.v_ani_ui_black = Util.get_playabledirector("Animation/Ani_Black_", self.v_object)
  self.v_ani_character_in = Util.get_playabledirector("Animation/Ani_character_In_", self.v_object)
  self.v_ani_character_out = Util.get_playabledirector("Animation/Ani_character_Out_", self.v_object)
  self.v_bird_red_rect = Util.get_rect_transform("", self.v_uiobjects.BirdRed)
  self.v_level_award_red_rect = Util.get_rect_transform("", self.v_uiobjects.LevelAwardRed)
  self.v_bird_red_icon = Util.get_image("Main/point01", self.v_uiobjects.BirdRed)
  self.v_download_text = Util.get_text("Text", self.v_uiobjects.BtnDownLoading)
end

function ui:on_click_main_line_btn()
  if not self.v_newest_chapter_cfg or not self.v_newest_node_cfg then
    return
  end
  if not ResMgr:check_is_can_fight_with_res(self.v_newest_chapter_cfg) then
    return
  end
  UIMgr:get_ui("ui_chapter_detail"):ui_show(self.v_newest_chapter_cfg.Id, nil, nil, nil, self.v_newest_node_cfg.Id)
end

function ui:on_click_fight()
  if DebugSetting:is_enter_chapter() then
    if TowerMgr:check_fight_progress() then
      return
    end
    self:change_black_bg_show(true)
    self:remove_delay_enter_chapter_timer()
    self.v_delay_enter_chapter_timer = Timer:add_timer("delay_enter_chapter_timer", 0.3, function()
      ChapterMgr:clear_record_select_chapter_id()
      UIMgr:get_ui("chapter"):ui_show()
    end)
  else
    local function confirm_cb()
      local tower_id = DebugSetting:get_tower_id()
      
      if tower_id and tower_id > 0 then
        TowerMgr:on_gm_enter_tower(tower_id)
      end
    end
    
    Util.show_notify_popup_message(confirm_cb, "GM进塔", "GM进塔")
  end
end

function ui:clear_csharp_ref()
  self.v_safe_area_obj = nil
  self.v_scene_root_obj = nil
  self.v_container = nil
  self.v_video_player = nil
  self.v_minute_hand = nil
  self.v_hour_hand = nil
  self.v_clock = nil
  self.v_video_player_plane = nil
  self.v_video_player_compenent = nil
  self.v_photo_frame_mat_collect = nil
  self.v_tex_info = nil
  self.v_video_player_mat = nil
  self.v_video_tex_info = nil
  self.v_video_show_anim = nil
  self.v_video_hide_anim = nil
  self.v_chou_ka_canvas_group = nil
  self.v_vcamera_control = nil
  self.v_photo_frame_pd = nil
  self.v_drawcard_enter_pd = nil
  self.v_drawcard_close_to_clock_pd = nil
  self.v_camera_track_obj = nil
  self.v_camera_track_manager = nil
  self.v_level_award_red_obj = nil
  self.v_scene_journey_effect_container = nil
  self.v_scene_journey_born_effect = nil
  self.v_scene_journey_idle_effect = nil
  self.v_scene_journey_interact_effect = nil
  self.v_ani_fade_in = nil
  self.v_ani_fade_in_delay = nil
  self.v_ani_fade_in_no_player = nil
  self.v_ani_ui_out = nil
  self.v_ani_ui_black = nil
  self.v_ani_character_in = nil
  self.v_ani_character_out = nil
  self.v_bird_red_rect = nil
  self.v_level_award_red_rect = nil
  self.v_bird_red_icon = nil
  self.v_download_text = nil
  self.v_full_screen_background = nil
  self.v_signboard_girl_panel = nil
end

function ui:init_scene_container()
  self.v_main_scene_init_done = true
  if not SceneMgr:check_main_scene_loaded() then
    self.v_main_scene_init_done = false
    return
  end
  local root = UnityFind("Root")
  if not root or root:IsNull() then
    Log.Error("can't find Root GameObject in main scene")
    return
  end
  local container = root:GetComponent(TypeSceneContainer)
  if nil == container then
    Log.Error("can't find scene container in main scene")
    return
  end
  self.v_scene_root_obj = root
  self.v_container = container
  local photo_frame = self.v_container:Get("Main_xiangkuang")
  self.v_video_player = self.v_container:Get("Video")
  self.v_minute_hand = self.v_container:Get("MinuteHand")
  self.v_hour_hand = self.v_container:Get("HourHand")
  self.v_clock = self.v_container:Get("Clock")
  self.v_video_player_plane = self.v_container:Get("VideoPlayerPlane")
  self.v_video_player_compenent = self.v_video_player_plane:GetComponent(TypeUnityVideoPlayer)
  self.v_photo_frame_mat_collect = photo_frame:GetComponent(TypeMaterailCollect)
  self.v_tex_info = self.v_uiobjects.TexCollectForPhotoFrame:GetComponent(TypeTexCollect).texInfo
  local video_player_mr = self.v_video_player_plane:GetComponent(TypeMeshRenderer)
  self.v_video_player_mat = video_player_mr.material
  self.v_video_player_mat:SetTextureOffset("_SoftTex", Vec2.New(-0.5, 0))
  self.v_video_tex_info = self.v_uiobjects.TexCollectForWindowVideo:GetComponent(TypeTexCollect).texInfo
  self.v_video_show_anim = Util.get_child_gameobj("WindowVideo/Animation/Show", self.v_video_player)
  self.v_video_hide_anim = Util.get_child_gameobj("WindowVideo/Animation/Hide", self.v_video_player)
  self.v_video_show_anim:SetActive(false)
  self.v_video_hide_anim:SetActive(false)
  self.v_video_entry_state = false
  self.v_chou_ka_canvas_group = Util.get_canvas_group(nil, self.v_uiobjects.BtnChouka)
  self.v_vcamera_control = self.v_container:Get("VirtualCamera_Control")
  self.v_vcamera_control:SetActive(false)
  self.v_photo_frame_pd = Util.get_playabledirector(nil, photo_frame)
  self:refresh_draw_card_info()
  self.v_container:Get("Drawcard").transform:SetActive(false)
  self.v_camera_track_obj = self.v_container:Get("CinemachineTrack")
  self.v_camera_track_manager = self.v_camera_track_obj:GetComponent(typeof(CS.Game.CameraTrackManager))
  self.v_level_award_red_obj = self.v_container:Get("LevelAwardRed")
  self.v_scene_journey_effect_container = self.v_container:Get("SceneJourneyEffect")
  self.v_scene_journey_born_effect = self.v_container:Get("FX_H10010012_born")
  self.v_scene_journey_idle_effect = self.v_container:Get("FX_H10010012_ui_idle")
  self.v_scene_journey_interact_effect = self.v_container:Get("FX_H10010012_uimain_interact")
  local change_trans = self.v_container:Get("Change").transform
  local change_names = {}
  local child_count = change_trans.childCount
  if child_count > 0 then
    for i = 0, child_count - 1 do
      local obj = change_trans:GetChild(i)
      change_names[obj.name] = i
    end
  end
  if FashionMgr then
    FashionMgr:refresh_main_scene_fashion_index(change_names)
    FashionMgr:refresh_main_scene_fashion(nil, true)
  end
  self:refresh_book_model()
  self:bind_uimain_to_signboard_view()
  self:check_guide_pause()
  if self.v_level_award_red_obj then
    self.v_level_award_red_obj_bubble_pos = self.v_level_award_red_obj.transform.position + bird_level_need_add_vet3
  end
end

function ui:refresh_draw_card_info()
  local draw_card_pd_name = FashionMgr:get_curr_fashion_draw_card_pd_name()
  FashionMgr:show_fashion_draw_card_pd(draw_card_pd_name, self.v_vcamera_control)
  local draw_card_pd_go = Util.get_child_gameobj(draw_card_pd_name, self.v_vcamera_control)
  self.v_drawcard_enter_pd = Util.get_playabledirector("Enter", draw_card_pd_go)
  self.v_drawcard_close_to_clock_pd = Util.get_playabledirector("CloseToClock", draw_card_pd_go)
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return
end

function ui:set_after_show_cb(after_show_callback)
  self.v_after_show_callback = after_show_callback
end

function ui:ui_on_show(after_show_callback)
  is_camera_playing = false
  if after_show_callback then
    self.v_after_show_callback = after_show_callback
  end
  UIMainBubbleMgr:init_bubble_list(self.v_safe_area_obj)
  self.v_canvas = self:get_canvas()
  UIMgr:get_ui("ui_click_effect"):ui_show()
  self.v_last_click_time = nil
  self.v_is_control_by_other = false
  self.v_continued_click_num = 0
  self.v_signboard_param_type = SIGNBOARD_PARAM.NORMAL
  self.v_asset_bar:on_create()
  self.v_safe_area_offset = 0
  self:register_event()
  self:_refresh_sys_btn()
  self:refresh_mail_red()
  self:refresh_passport_red()
  self:refresh_give_energy_value_red()
  self:refresh_player_info()
  self:refresh_chat_content()
  self:init_signboard_model()
  self:init_scene_container()
  self:refresh_activity_banner()
  self:refresh_character_red()
  self:refresh_stage_info()
  self:refresh_task_num()
  ChatMgr:join_default_channel()
  self:show_res_err()
  self:_first_set_cannot_touch_bg_open()
  self:refresh_treasure_chest_red()
  self:_refresh_union_redpoint()
  self:refresh_ornament_redpoint()
  self:refresh_player_journey_entry()
  self:refresh_strength()
  PlayerMgr:get_all_achievement_list_form_server()
  if UIMgr then
    UIMgr:open_default_ui(false)
  end
  self:main_scene_play_video()
  self:main_scene_set_tex()
  self:on_mascot_red_refresh()
  self:refresh_custom_photo_frame()
  self:check_hide_model()
  self.v_ani_ui_black.time = 0
  self.v_ani_ui_black:Play()
  Global.sound_mgr:set_bgm_volume(nil, 1, 1)
  Global.sound_mgr:sound_preload_by_soundid("Sound_H1001001_ui_idle")
  self:refresh_remain_time(Util.get_text("Text", self.v_uiobjects.BagTimeTag), Util.get_image(nil, self.v_uiobjects.BagTimeTag), self.v_uiobjects.BagTimeTag, Util.get_child_gameobj("SysOpen/RedPoint", self.v_uiobjects.Btn_Bag))
  DownloadMgr:refresh_ui_main_tips()
  self.v_uiobjects.Ani_BtnEntrance_Change:SetActive(true)
  self:refresh_quick_enter_cfg_list()
  self:refresh_main_scene_quick_btn_state()
end

function ui:refresh_summer_btn()
  local activity_cfg = TimeLimitedActMgr:get_activity_cfg_with_activity_type(TimeLimitedActMgr.Type.SummerActivity)
  if not activity_cfg then
    self.v_uiobjects.BtnActivitySummer:SetActive(false)
    return
  end
  local is_open = TimeLimitedActMgr:is_activity_open(activity_cfg.Id)
  self.v_uiobjects.BtnActivitySummer:SetActive(is_open)
end

function ui:show_res_err()
  if Global.res_err == true and (GAME_DEBUG or PUBLISH_GM) and not UNITY_EDITOR then
    Global.res_err = nil
    Util.show_notify_popup_message(nil, "注意前后台配置不一致, " .. Global.res_err_tip, "提示", "确定", "取消", nil, true)
  end
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_MAIL_UPDATE, self.refresh_mail_red, self)
  self:bind_auto_mq(Const.MSG_ON_PLAYER_INFO_UPDATE, self.refresh_player_info, self)
  self:bind_auto_mq(Const.MSG_NEW_SYS_OPEN, self.on_sys_open_event, self)
  self:bind_auto_mq(Const.MSG_WORLD_CHAT_MSG_UPDATE, self.refresh_chat_content, self)
  self:bind_auto_mq(Const.MSG_SYS_MSG_UPDATE, self.refresh_chat_content, self)
  self:bind_auto_mq(Const.MSG_UNION_CHAT_MSG_UPDATE, self.refresh_chat_content, self)
  self:bind_auto_mq(Const.MSG_WORLD_CHAT_CHANNEL_UPDATE, self.refresh_chat_content, self)
  self:bind_auto_mq(Const.MSG_ON_CHANGE_AVATAR_SUCCESS, self.refresh_player_icon, self)
  self:bind_auto_mq(Const.MSG_ON_FINISH_AUTO_SIGN, self.response_finish_auto_sign, self)
  self:bind_auto_mq(Const.MSG_NOVICE_ACTIVE_CLOSE, self.response_activity_close_event, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.response_hide_ui_event, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.response_show_ui_event, self)
  self:bind_auto_mq(Const.MSG_ON_SIGNBOARD_ACTIVE_ACTION, self.response_signboard_girl_action, self)
  self:bind_auto_mq(Const.MSG_ON_BROWSE_SIGNBOARD_GIRL, self.response_browse_signboard_girl, self)
  self:bind_auto_mq(Const.MSG_ON_HERO_UPDATE_FASHION, self.response_update_char_fashion, self)
  self:bind_auto_mq(Const.MSG_ON_BUDDY_TO_ADVANCE_ITEM, self.refresh_character_red, self)
  self:bind_auto_mq(Const.MSG_REFRESH_CHARACTER_ENTRY_RED, self.refresh_character_red, self)
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_task_num, self)
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self.refresh_treasure_chest_red, self)
  self:bind_auto_mq(Const.MSG_ROLE_RES_CHANGE, self.refresh_treasure_chest_red, self)
  self:bind_auto_mq(Const.MSG_ON_CHAPTER_UPDATE, self.refresh_stage_info, self)
  self:bind_auto_mq(Const.MSG_ON_POINT_UPDATE, self.refresh_stage_info, self)
  self:bind_auto_mq(Const.MSG_ON_PLAYER_INFO_UPDATE, self.refresh_activity_banner, self)
  self:bind_auto_mq(Const.MSG_ON_QUESTIONNAIRE_UPDATE, self.refresh_activity_banner, self)
  self:bind_auto_mq(Const.MSG_ON_ORNAMENT_RED_update, self.refresh_ornament_redpoint, self)
  self:bind_auto_mq(Const.MSG_ON_JOURNEY_UPDATE, self.refresh_player_journey_entry, self)
  self:bind_auto_mq(Const.MSG_ON_SIGNBOARD_SOUND_FINISH, self.response_signboar_sound_finish, self)
  self:bind_auto_mq(Const.MSG_ON_PLAYER_SP_UPDATE, self.refresh_strength, self)
  self:bind_auto_mq(Const.MSG_PLAYER_LVUP, self.main_scene_set_tex, self)
  self:bind_auto_mq(Const.MSG_ON_CHAPTER_UPDATE, self.main_scene_set_tex, self)
  self:bind_auto_mq(Const.MSG_CHANGE_MODEL_VIEW_PARAM, self.response_change_model_view_param, self)
  self:bind_auto_mq(Const.MSG_SCENE_LOAD_FINISH, self.init_scene_container, self)
  self:bind_auto_mq(Const.MSG_ON_MAIN_MASCOT_RED_UPDATE, self.on_mascot_red_refresh, self)
  self:bind_auto_mq(Const.ON_ALL_SERVER_WIN_POP_FINISH, self.on_all_server_win_pop_finish, self)
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self.refresh_remain_time_event, self)
  self:bind_auto_mq(Const.ON_VERSION_ACTIVITY_UPDATE, self.on_version_activity_update, self)
  self:bind_auto_mq(Const.MSG_UPDATE_PASSPORT_DATA, self.on_passport_data_update, self)
  self:bind_auto_mq(Const.MSG_ON_LIGHT_DATA_INDEX_UPDATE, self.on_main_scene_fashion_update, self)
end

function ui:ui_on_hide()
  UIMgr:get_ui("ui_click_effect"):ui_hide()
  self.v_board_id = nil
  self.v_use_fashion_id = nil
  self:remove_timer()
  self:release_model()
  self:clear_signboard_pos_seq()
  self.v_model_idx = nil
  self.v_signboard_param_type = nil
  self:remove_delay_enter_chapter_timer()
  self.v_actbanner_item_uis = nil
  self:give_back_auto_cache(ACTBANNER_ITEM_KEY)
  self.synv_list:clear()
  self:clear_main_scene_timer()
  self.v_asset_bar:on_hide()
  bird_obj = nil
  if self.v_act_signboard_timer then
    Timer:remove_timer(self.v_act_signboard_timer)
    self.v_act_signboard_timer = nil
  end
  if self.v_login_timer_id then
    Timer:remove_timer(self.v_login_timer_id)
  end
  self:clear_quick_enter_timer()
  self:clear_quick_btn_change_timer()
  Global.sound_mgr:stop_lipsync_data()
end

function ui:clear_main_scene_timer()
  if self.v_video_timer then
    Timer:remove_timer(self.v_video_timer)
    self.v_video_timer = nil
  end
  if self.v_video_end_timer then
    Timer:remove_timer(self.v_video_end_timer)
    self.v_video_end_timer = nil
  end
  if self.v_video_anim_timer then
    Timer:remove_timer(self.v_video_anim_timer)
    self.v_video_anim_timer = nil
  end
  if self.v_ui_fade_out_timer then
    Timer:remove_timer(self.v_ui_fade_out_timer)
    self.v_ui_fade_out_timer = nil
  end
  if self.v_video_show_anim and not self.v_video_show_anim:IsNull() then
    self.v_video_show_anim:SetActive(false)
  end
  if not self.v_video_hide_anim or not self.v_video_hide_anim:IsNull() then
  end
end

function ui:ui_update()
  if not self.v_model_view then
    return
  end
  self.v_model_view:update()
  self:refresh_banner_close()
  self:refresh_bubble_pos()
  if CSInput.GetMouseButtonDown(0) then
    local cur_pos = UtilUI.convert_to_resolution_pos(CSInput.mousePosition)
    local ray = self.v_model_view.v_camera:ScreenPointToRay(cur_pos)
    if UnityEngine.EventSystems.EventSystem.current:IsPointerOverGameObject() then
      return
    end
    local hits = CompExtensions.GetRaycastHitArray(10)
    local hit_num = UnityPhysics.RaycastNonAlloc(ray, hits, 1000, Util.get_main_role_or_bird_layer_mask())
    if hit_num > 0 then
      self:on_character_click(hits[0].collider.gameObject)
    else
      self:on_touch_no_character()
    end
  end
end

function ui:set_canvas_show()
  self:get_canvas().planeDistance = 100
end

function ui:set_canvas_hide()
  self:get_canvas().planeDistance = 0
end

function ui:on_character_click(character_obj)
  local index, npc = self.v_model_view:get_npc_info_with_obj(character_obj)
  if not npc then
    return
  end
  local npc_id = npc:get_npc_id()
  local journey_event_npc_id, journey_event_model_index = JourneyEventMgr:get_npc_id_and_index()
  if journey_event_npc_id == npc_id and journey_event_model_index == index then
    JourneyEventMgr:on_npc_click()
    return
  end
  local bird_npc_id = TaskMgr:get_bird_npc_id()
  if npc_id == bird_npc_id then
    TaskMgr:on_mascot_click()
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.click_npc_bird_UI_SOUND)
    return
  end
  local signboard_girl_id = PlayerMgr:get_signboard_girl_id()
  if npc_id == signboard_girl_id then
    self:click_char()
  end
  if not (self.v_signboard_param_type == SIGNBOARD_PARAM.NORMAL and self.v_model_view:get_camera_change_end()) or is_camera_playing then
    return
  end
  self:play_story_with_npc_id(npc_id, nil, nil, true)
end

function ui:on_touch_no_character()
  if self:check_is_login_performance() then
    return
  end
  self:reset_signboard_param_movie()
end

function ui:play_story_with_npc_id(npc_id, not_story_cb, delay_time, is_need_play_anim)
  if StoryMgr:is_playing_story() then
    return
  end
  local buddy_event_data = TaskMgr:get_buddy_data_with_npc_id(npc_id)
  if not buddy_event_data then
    return
  end
  delay_time = delay_time or 0.3
  local story_id = buddy_event_data.story_id
  local board_id = buddy_event_data.board_id
  if is_need_play_anim then
    local buddy_state = buddy_event_data.bubble_state
    local action_cfg = TaskMgr:get_buddy_action_with_param(npc_id, buddy_state)
    if action_cfg then
      local model_index = self.v_model_view:get_model_index(npc_id)
      if model_index then
        self.v_model_view:play_anim(action_cfg.Action, model_index, nil, false)
      end
    end
  end
  if story_id and story_id > 0 then
    self.v_model_view:hide_other_model(npc_id)
    if npc_id == PlayerMgr:get_signboard_girl_id() then
      self:change_model_view_param(SIGNBOARD_PARAM.CHANGE_ROLE)
    else
      self:change_center_event_model_view_param(board_id, false)
    end
    self:enable_ui_show_gameobj(false, true)
    
    local function cb(role_event_type)
      self:on_story_finish(role_event_type, buddy_event_data)
    end
    
    Log.Info("播放剧情,角色事件Id=", buddy_event_data.buddy_info.event_id, "剧情id:", story_id)
    self:play_story_delay(story_id, delay_time, cb)
  elseif not_story_cb then
    not_story_cb()
  end
end

function ui:play_story_delay(story_id, delay_play_time, cb)
  self:set_canvas_hide()
  if delay_play_time > 0 then
    Timer:add_timer("dealy_curse_ring_settlement", delay_play_time, function()
      self:play_story(story_id, cb)
    end)
  else
    self:play_story(story_id, cb)
  end
end

function ui:play_story(story_id, cb)
  StoryMgr:on_start(story_id, nil, nil, nil, nil, cb)
end

function ui:on_mascot_click()
  local jump_type = PlayerJourneyMgr:get_journey_red() and 2 or 1
  if 1 == jump_type and not self.v_uiobjects.BirdRed.activeSelf then
    local mascot_event_count = #TaskMgr:get_mascot_agency_list()
    if TaskMgr:get_is_first_open_bird_event() then
      jump_type = 2
      TaskMgr:on_bird_event_open()
    else
      jump_type = mascot_event_count > 0 and 1 or 2
    end
  end
  UIMgr:get_ui("uimain_close_new"):ui_show(jump_type)
  self:enable_ui_show_gameobj(false)
  self.v_uiobjects.BirdRed:SetActive(false)
end

function ui:on_story_finish(role_event_type, buddy_event_data)
  local uimain_close = UIMgr:try_get_visible_ui("uimain_close")
  local uimain_close_new = UIMgr:try_get_visible_ui("uimain_close_new")
  if not uimain_close and not uimain_close_new then
    self:set_canvas_show()
  end
  if uimain_close then
    uimain_close:get_canvas().planeDistance = 100
  end
  local npc_id = buddy_event_data.npc_id
  self:lerp_to_far_camera()
  if uimain_close then
    uimain_close:ui_hide()
  end
  self:enable_ui_show_gameobj(true)
  if self.v_model_view then
    self.v_model_view:show_other_model(npc_id)
  end
  local is_direct_trigger = TaskMgr:is_need_direct_trigger(buddy_event_data.buddy_cfg.EventType)
  if not is_direct_trigger and (not role_event_type or 0 == role_event_type) then
    if npc_id == PlayerMgr:get_signboard_girl_id() then
      self:open_ui_main_close_win_with_cb()
    end
    Log.Info("如果应该接取/交付,实际并没有 可能是跳过了事件步骤或者没有勾选接取/交付,或者剧情配置中未勾选必要选项导致导出的剧情lua文件中没有该步骤(注意是lua文件,不要看json文件)")
    return
  end
  local event_state = buddy_event_data.buddy_info.state
  local buddy_event_id = buddy_event_data.buddy_info.event_id
  if event_state ~= commonDef.BUDDY_EVENT_TYPE.Accept then
    TaskMgr:request_each_center_event(1, buddy_event_id)
  else
    local is_delivery, task_id = TaskMgr:is_need_show_delivery_with_buddy_event_id(buddy_event_id)
    if is_delivery then
      TaskMgr:request_get_event_reward(task_id, buddy_event_id)
    end
  end
  Log.Info("这里角色应该逐渐消失，消失后重置镜头")
end

function ui:open_ui_main_close_win_with_cb()
  local function cb(npc_id)
    self:play_story_with_npc_id(npc_id, nil, 0)
  end
  
  self:open_ui_main_close_win(cb)
  if UIMainBubbleMgr then
    UIMainBubbleMgr:try_set_board_girl_bubble_played()
  end
end

function ui:change_center_event_model_view_param(board_id, is_fast, speed)
  if not self.v_model_view then
    return
  end
  local total_buddy_param_cfg = ShareRes.create("signboard_girl.signboard_girl_param")
  local buddy_param_cfg = total_buddy_param_cfg[board_id]
  local camera_pos = buddy_param_cfg.CameraPos
  local camera_rot = buddy_param_cfg.CameraRot
  local camera_param
  camera_param = {
    pos_x = camera_pos[1],
    pos_y = camera_pos[2],
    pos_z = camera_pos[3],
    rot_x = camera_rot[1],
    rot_y = camera_rot[2],
    rot_z = camera_rot[3],
    fov = buddy_param_cfg.FOV,
    speed = speed
  }
  self:update_camera_state(board_id)
  local key = (self.v_camera_track_state.from or "-1") .. "_" .. (self.v_camera_track_state.to or "-1")
  local pathgroup_cfg = ShareRes.get_signboard_girl_track_table(key)
  if pathgroup_cfg then
    self:play_camera_track_animation(pathgroup_cfg)
  else
    self:change_camera_param(camera_param, is_fast)
    self.v_signboard_param_type = buddy_param_cfg.Event
  end
end

function ui:play_role_interaction_anim()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
  self.v_asset_bar = nil
  self.v_timer = nil
  self.v_sys_list = {}
  self.v_btn2sys = {}
  self.v_fade_dotween:DOKill()
  self.v_fade_dotween = nil
  if self.v_track_animator_controller_path then
    Global.res_mgr:unload_res(self.v_track_animator_controller_path, UnityAnimatorOverrideController)
  end
  self:clear_main_scene_timer()
  self:clear_csharp_ref()
end

function ui:release_model()
  if self.v_model_view then
    self.v_model_view:stop_effect(self.v_model_idx)
    self.v_model_view:on_destroy()
    self.v_model_view = nil
  end
end

function ui:reset_signboard_param()
  local board_id = PlayerMgr:get_signboard_girl_id()
  self:update_char_model(board_id, function()
    SignBoardGirlMgr:play_login_action()
    self:change_model_view_param_to_normal()
  end)
end

function ui:check_need_reset_char_model()
  local board_id = PlayerMgr:get_signboard_girl_id()
  local model_fashion_id = FashionMgr:get_fashion_model_id(board_id)
  local is_change_fashion = model_fashion_id ~= self.v_use_fashion_id
  if self.v_board_id ~= board_id or is_change_fashion then
    self:update_char_model(board_id)
  end
end

function ui:change_model_view_param_to_normal(is_fast, ignore_journey_event)
  self.v_uiobjects.BtnSkip:SetActive(false)
  local msg = SignBoardGirlMgr:send_change_model_view_param(SIGNBOARD_PARAM.NORMAL, is_fast, false, true)
  self:response_change_model_view_param(msg, ignore_journey_event)
end

function ui:init_signboard_model()
  local board_id = PlayerMgr:get_signboard_girl_id()
  local fashion_id = FashionMgr:get_fashion_model_id(board_id)
  self.v_board_id = board_id
  self.v_model_view = NewModelRtView:new(nil, true, nil, nil, true, "UIModelRtViewMain")
  self:load_npc(fashion_id, board_id)
  TaskMgr:init_model_to_main_ui()
end

function ui:update_char_model(npc_id, finish_cb)
  local uimain_close_win = UIMgr:try_get_visible_ui("uimain_close")
  if not uimain_close_win and self.v_model_view then
    self.v_model_view:show_other_model(npc_id)
    local is_need_run_journey_event = JourneyEventMgr:get_is_need_run_force_journey_event()
    if not is_need_run_journey_event then
      TaskMgr:refresh_role_model(self.v_model_idx)
    end
    JourneyEventMgr:refresh_journey_event_model()
  end
  local model_fashion_id = FashionMgr:get_fashion_model_id(npc_id)
  local is_change_fashion = model_fashion_id ~= self.v_use_fashion_id
  if self.v_board_id == npc_id and not is_change_fashion then
    if finish_cb then
      finish_cb()
    end
    return
  end
  self.v_board_id = npc_id
  if not self.v_model_view then
    self.v_model_view = NewModelRtView:new(nil, true, nil, nil, true, "UIModelRtViewMain", self)
  else
    self.v_model_view:stop_effect(self.v_model_idx)
  end
  if self.v_model_idx then
    self.v_model_view:remove_npc_by_index(self.v_model_idx)
    self.v_model_idx = nil
  end
  self.v_model_view:is_play_show_effect(true, effect_id)
  model_fashion_id = FashionMgr:get_fashion_model_id(npc_id)
  self:load_npc(model_fashion_id, npc_id, finish_cb)
end

function ui:response_update_char_fashion(msg)
  if nil == msg then
    return
  end
  if not self.v_model_view or not self.v_model_view:is_visible() then
    return
  end
  local buddy_id = msg.mm_obj
  if self.v_board_id == buddy_id then
    self:update_char_model(buddy_id)
  end
end

function ui:_refresh_sys_btn()
  local version
  for _, data in pairs(BTN_LIST) do
    local btn_name = data.btn_name
    local sys_id = self.v_btn2sys[btn_name]
    local open = false
    if sys_id then
      open = SysOpenMgr:get_sys_is_open(sys_id)
    end
    if data.ui_name == "ui_chapter_detail" then
      local version_activity_id = TimeLimitedActMgr:get_version_activity_id()
      open = not version_activity_id and true or false
    elseif data.ui_name == "ui_time_limited_activity_main" then
      local version_activity_id = TimeLimitedActMgr:get_version_activity_id()
      open = version_activity_id and true or false
    elseif data.ui_name == "ui_monthtask" then
      local id = PassPortMgr:get_passport_data().id
      open = open and 0 ~= id
    end
    self:check_ui_open_state(open, btn_name)
  end
end

function ui:check_ui_open_state(is_open, btn_name)
  local btn_obj = self.v_uiobjects[btn_name]
  if not btn_obj then
    Log.Error("btn is not exist, name = ", btn_name)
    return
  end
  local ui_fun_name = UI_SHOW_CONFIG[btn_name]
  if ui_fun_name then
    local fun = UI_SHOW_CONFIG_FUN[ui_fun_name]
    if fun then
      fun(is_open, btn_obj)
    end
  end
  local lock = self:get_child_gameobj("Lock", btn_obj)
  if lock then
    lock:SetActive(not is_open)
  end
  local red_parent = self:get_child_gameobj("SysOpen", btn_obj)
  if red_parent then
    red_parent:SetActive(is_open)
  end
end

function ui:refresh_mail_red()
  local show_mail_read = MailMgr:is_show_main_red()
  self.v_uicompents.MailRed_img.gameObject:SetActive(show_mail_read)
end

function ui:refresh_passport_red()
  local red_obj = Util.get_child_gameobj("SysOpen/RedPoint", self.v_uiobjects.BtnMonthTask)
  red_obj:SetActive(RedPointMgr:get_redpoint_enable_by_id(RedEnum.PASSPORT))
end

function ui:refresh_give_energy_value_red()
  NewbieTowerMgr:refresh_give_energy_value_red()
end

function ui:refresh_character_red()
  local is_show_red = CharacterMgr:is_show_character_main_red()
  self.v_uicompents.CharRed_img.gameObject:SetActive(is_show_red)
end

function ui:refresh_player_icon()
  local face_id = PlayerMgr:get_player_face_id()
  local player_icon_cfg = ShareRes.create("player.player_avatar", face_id)
  assert(player_icon_cfg, "player icon don't exist")
  local player_icon_img = self.v_uicompents.PlayerIcon_img
  local icon_name = player_icon_cfg.Icon
  local player_icon_path = string.format(PLAYER_PROFILE, icon_name)
  ResMgr:load_set_icon(player_icon_img, player_icon_path)
end

function ui:refresh_player_info()
  local base_info = PlayerMgr:get_player_base_info()
  local ucom = self.v_uicompents
  ucom.UserLevel_txt.text = base_info.lv
  ucom.UserName_txt.text = base_info.name
  ucom.UserId_txt.text = PlayerMgr:get_player_uid()
  local exp = base_info.exp or 0
  local need_exp = PlayerMgr:player_lv_need_exp() or 0
  ucom.PlayerExpFill_img.fillAmount = 0 ~= need_exp and exp / need_exp or 1
end

function ui:change_touch_bg_show(is_on)
  if self.v_uiobjects then
    self.v_uiobjects.touch_bg:SetActive(is_on)
  end
end

function ui:change_black_bg_show(is_show)
  self.v_uiobjects.Black_Bg:SetActive(is_show)
end

function ui:on_sys_open_event(msg)
  if not msg or not msg.mm_obj then
    return
  end
  local sys_id = msg.mm_obj
  local data = self.v_sys_list[sys_id]
  if data then
    self:_refresh_sys_btn()
  end
  if sys_id == CHAT_SYS_ID and SysOpenMgr:get_sys_is_open(sys_id) then
    ChatMgr:join_default_channel()
  end
  ArchiveMgr:update_red_state()
end

function ui:refresh_chat_content()
  local msg = ChatMgr:get_latest_msg()
  if msg and msg.chatInfo and msg.chatInfo.speaker and FriendMgr:is_in_friend_black(msg.chatInfo.speaker.uuid) then
    msg = nil
  end
  if nil == msg then
    self.v_msg_lab.text = Util.format_str("当前暂无聊天信息")
    return
  end
  local prefix = string.format("【%s】", ChatConfig.CHANNLE_LIST[msg.channel][1])
  if msg.channel == ChatConfig.CHANNEL_TYPE.SYSTEM then
    local content = msg.chatInfo.notify_msg.msg
    self.v_msg_lab.text = string.format("%s %s", prefix, content)
  else
    local speaker_name = msg.chatInfo.speaker and msg.chatInfo.speaker.name .. "：" or ""
    local content = msg.chatInfo.msg.msg
    local face_character = self:_get_is_face(content)
    if face_character then
      local cfg = ChatConfig.chat_face[face_character]
      content = string.format("[%s]", cfg.name)
    end
    self.v_msg_lab.text = string.format("%s %s%s", prefix, speaker_name, content)
  end
end

function ui:_get_is_face(msg)
  for v in string.gmatch(msg, "%[%d+%]") do
    return v
  end
end

function ui:response_finish_auto_sign()
  self:change_touch_bg_show(false)
end

function ui:response_activity_close_event(msg)
  if not msg or not msg.mm_x then
    return
  end
  self.v_uiobjects.BtnNovice:SetActive(NoviceMgr:get_sys_open_state())
end

function ui:remove_timer()
  for _, timer_idx in pairs(self.v_timer) do
    Timer:remove_timer(timer_idx)
  end
  UtilTable.clear_map(self.v_timer)
end

function ui:remove_delay_enter_chapter_timer()
  if self.v_delay_enter_chapter_timer then
    Timer:remove_timer(self.v_delay_enter_chapter_timer)
    self.v_delay_enter_chapter_timer = nil
  end
end

function ui:remove_delay_enter_draw_timer()
  if self.v_delay_enter_draw_timer then
    Timer:remove_timer(self.v_delay_enter_draw_timer)
    self.v_delay_enter_draw_timer = nil
  end
end

function ui:enable_ui_show_gameobj(is_enable, from_more_entry, from_signboard_show, pop_up_delay)
  if from_more_entry then
    if not is_enable then
      self.v_ani_fade_in_no_player.time = 0
      self.v_ani_fade_in_no_player:Play()
    end
  else
    local sub_panel = self:get_panel("more_entry_panel")
    if sub_panel.v_enable == true then
      return
    end
  end
  local should_pop_up = not self.v_uiobjects.MainPanel.activeSelf
  self.v_uiobjects.MainPanel:SetActive(is_enable)
  self.v_uiobjects.AttachBtns:SetActive(is_enable)
  if is_enable then
    self.v_safe_area_offset = UIMgr:get_safe_area_offset() * CSScreen.width
    self:refresh_player_journey_entry()
    self:check_fix_photo_frame_mat_show()
    if should_pop_up then
      PopUpWindowMgr:pop_up(pop_up_delay)
    end
  end
  if from_signboard_show then
    self.v_uiobjects.BtnPlayer:SetActive(is_enable)
  elseif is_enable then
    self.v_uiobjects.BtnPlayer:SetActive(true)
  end
  self.v_ui_visiable = is_enable
end

function ui:response_hide_ui_event(msg)
  if nil == msg then
    return
  end
  local ui_name = msg.mm_obj
  if "uimain" == ui_name then
    self:enable_ui_show_gameobj(false)
    if self.v_signboard_param_type then
      self.v_signboard_param_type_record = self.v_signboard_param_type
    end
    if not self.v_is_control_by_other then
      SignBoardGirlMgr:enable_check_stand_by(false)
      self:set_model_view_visible(false)
      self.v_signboard_param_type = nil
    end
    local alpha_target = self.v_safe_area_obj:GetComponent("CanvasGroup")
    alpha_target.alpha = 1
    self.v_fade_dotween:DORestartById(1)
    if self.v_hide_touch_bg then
      Timer:remove_timer(self.v_hide_touch_bg)
      self.v_hide_touch_bg = nil
    end
    self:change_black_bg_show(false)
    self:remove_delay_enter_chapter_timer()
    self:remove_delay_enter_draw_timer()
  elseif "ui_guide" == ui_name then
    self:set_guide_pause(false)
  end
end

function ui:check_pop_window()
  if self.v_login_act_trigger then
    self.v_login_act_trigger = false
  else
    self:enable_ui_show_gameobj(true)
  end
end

function ui:response_show_ui_event(msg)
  if nil == msg then
    return
  end
  local ui_name = msg.mm_obj
  if "uimain" == ui_name then
    Global.sound_mgr:set_bgm_volume(nil, 1, 1)
    self:clean_signboard_action_cache()
    self:set_model_view_visible(true)
    self:change_black_bg_show(false)
    ChapterMaterialMgr:try_clear_lack_item_cache()
    local alpha_target = self.v_safe_area_obj:GetComponent("CanvasGroup")
    alpha_target.alpha = 1
    self.v_fade_dotween:DOKill()
    local sub_panel = self:get_panel("more_entry_panel")
    if sub_panel.v_enable then
    elseif self.v_signboard_param_type ~= SIGNBOARD_PARAM.NORMAL then
      self.v_ani_fade_in_delay.time = 0
      self.v_ani_fade_in_delay:Play()
    else
      self.v_ani_fade_in.time = 0
      self.v_ani_fade_in:Play()
    end
    self:reset_signboard_param()
    if self.v_login_act_trigger then
      self.v_login_act_trigger = false
    else
      self:enable_ui_show_gameobj(true)
    end
    if SysOpenMgr:get_is_ui_open("uisign_in") and not SignInMgr:get_today_done() then
      self:change_touch_bg_show(true)
    end
    self.v_hide_touch_bg = Timer:add_timer("hide_touch_bg", 1, function()
      self:change_touch_bg_show(false)
    end)
    self:refresh_stage_info()
    self:refresh_strength()
    self:check_guide_pause()
    ArchiveMgr:update_red_state()
    self:check_hide_model()
    self:release_victual_camera()
    if self.v_after_show_callback then
      self.v_after_show_callback()
      self.v_after_show_callback = nil
    end
    if SDKManager and SDKManager.show_review and 1 == LocalStorage:load_int("SDK_SHOW_REVIEW", 0, true) then
      LocalStorage:save_int("SDK_SHOW_REVIEW", 0, true)
      SDKManager:show_review()
    end
  elseif "ui_guide" == ui_name then
    self:set_guide_pause(true)
  end
end

function ui:set_model_view_visible(is_on)
  if self.v_model_view then
    if is_on then
      self.v_model_view:set_visible(is_on)
      self:check_need_reset_char_model()
    else
      self.v_model_view:set_camera_culling_mask_zero()
    end
  end
end

function ui:clear_signboard_pos_seq()
  if self.v_signboard_pos_seq then
    self.v_signboard_pos_seq:Kill()
    self.v_signboard_pos_seq = nil
  end
end

function ui:is_use_pad_camera()
  local const_rate = 1.5
  local cur_rate = Global.screen_width / Global.screen_height
  return const_rate >= cur_rate
end

function ui:get_scene_pad_camera_param()
  if not self.v_scene_root_obj or self.v_scene_root_obj:IsNull() then
    self:init_scene_container()
  end
  local camera_obj = self.v_container:Get("PadFarCamera")
  local camera_trans = camera_obj.transform
  local camera = Util.get_component(nil, camera_obj, TypeUnityCamera)
  local x, y, z = camera_trans:GetPositionA()
  local rx, ry, rz = camera_trans:GetEulerAnglesA3()
  local camera_param = {
    pos_x = x,
    pos_y = y,
    pos_z = z,
    rot_x = rx,
    rot_y = ry,
    rot_z = rz,
    fov = camera.fieldOfView
  }
  return camera_param
end

function ui:response_change_model_view_param(msg, ignore_journey_event)
  if msg then
    self:change_model_view_param(msg.mm_x, msg.mm_y, msg.mm_obj, nil, ignore_journey_event)
  end
end

function ui:ui_fade_in_anim(ignore_journey_event)
  local is_need_run_journey_event = JourneyEventMgr:get_is_need_run_force_journey_event()
  if is_need_run_journey_event and not ignore_journey_event then
    return
  end
  self.v_ani_fade_in_delay.time = 0
  self.v_ani_fade_in_delay:Play()
  self:enable_ui_show_gameobj(true, true, true)
  self:check_hide_model()
end

function ui:ui_fade_out_anim()
  self.v_ani_ui_out.time = 0
  self.v_ani_ui_out:Play()
  self.v_ui_fade_out_timer = Timer:add_timer("ui_fade_out_timer", self.v_ani_ui_out.duration - 0.1, function()
    self:enable_ui_show_gameobj(false, true, true)
  end)
end

function ui:change_model_view_param(param_id, is_fast, ignore_same_act, ignore_all_act, ignore_journey_event)
  if not self.v_model_view or not self.v_model_idx then
    return
  end
  local is_need_run_journey_event = JourneyEventMgr:get_is_need_run_force_journey_event()
  if is_need_run_journey_event and not ignore_journey_event then
    return
  end
  if SignBoardGirlMgr.first_trigger and not self.v_is_guide_pause and not is_need_run_journey_event then
    SignBoardGirlMgr.first_trigger = false
    local player_setting = BattleSettingMgr:get_login_camera_movement_mode()
    local flag = false
    if player_setting == Config.SETTING.LOGIN_CAMERA_MOVEMENT_SETTING.DAILYLOGIN then
      if Global.is_first_login_today then
        param_id = SIGNBOARD_PARAM.LOGIN
        flag = true
      end
    elseif player_setting == Config.SETTING.LOGIN_CAMERA_MOVEMENT_SETTING.EVERYLOGIN then
      param_id = SIGNBOARD_PARAM.LOGIN
      flag = true
    end
    if flag then
      if GuideMgr:get_cur_guider() then
        return
      end
      self.v_login_act_trigger = true
      self.v_ani_ui_black.time = 0
      self.v_ani_ui_black:Play()
      self:enable_ui_show_gameobj(false, false, true)
    end
  end
  local event_param_cfg = ShareRes.get_signboard_girl_param(param_id, self.v_board_id)
  if not event_param_cfg then
    return
  end
  self:set_dof_eff(event_param_cfg)
  local npc_pos = event_param_cfg.ModelPos
  local npc_rot = event_param_cfg.ModelRot
  local scale = event_param_cfg.ModelScale
  local camera_pos = event_param_cfg.CameraPos
  local camera_rot = event_param_cfg.CameraRot
  local npc_param = {
    pos_x = npc_pos[1],
    pos_y = npc_pos[2],
    pos_z = npc_pos[3],
    rot_x = npc_rot[1],
    rot_y = npc_rot[2],
    rot_z = npc_rot[3],
    scale_x = scale[1],
    scale_y = scale[2],
    scale_z = scale[3]
  }
  local camera_param
  if self:is_use_pad_camera() and param_id == SIGNBOARD_PARAM.NORMAL then
    camera_param = self:get_scene_pad_camera_param()
  else
    camera_param = {
      pos_x = camera_pos[1],
      pos_y = camera_pos[2],
      pos_z = camera_pos[3],
      rot_x = camera_rot[1],
      rot_y = camera_rot[2],
      rot_z = camera_rot[3],
      fov = event_param_cfg.FOV
    }
  end
  if self.v_long_standby_trigger then
    self.v_long_standby_trigger = false
    self.v_ani_character_out.time = 0
    self.v_ani_character_out:Play()
  end
  if param_id == SIGNBOARD_PARAM.LOGIN or param_id == SIGNBOARD_PARAM.LONG_STANDBY then
    camera_param.speed = SignBoardGirlMgr.signboard_movie_speed
    local process_cfg = ShareRes.get_post_process_cfg_by_ui_name("close_range")
    self.v_model_view:set_post_process_bloom_param(process_cfg.Threshold, process_cfg.FilterScaler)
    if param_id == SIGNBOARD_PARAM.LONG_STANDBY then
      self.v_long_standby_trigger = true
      self.v_ani_character_in.time = 0
      self.v_ani_character_in:Play()
      self.v_ani_fade_in:Stop()
    end
  elseif self.v_signboard_param_type == SIGNBOARD_PARAM.LOGIN or self.v_signboard_param_type == SIGNBOARD_PARAM.LONG_STANDBY then
    local process_cfg = ShareRes.get_post_process_cfg_by_ui_name(UIMgr:get_cur_show_ui_name())
    self.v_model_view:set_post_process_bloom_param(process_cfg.Threshold, process_cfg.FilterScaler)
  end
  self.v_model_view:load_signboard_npc_param(npc_param, self.v_model_idx)
  self:set_signboard_param_type(param_id, ignore_same_act, ignore_all_act)
  self:update_camera_state(event_param_cfg.Id)
  if 3 == self.v_camera_track_state.from % 100 and 1 == self.v_camera_track_state.to % 100 then
    self.v_ani_character_out.time = 0
    self.v_ani_character_out:Play()
  end
  local key = (self.v_camera_track_state.from or "-1") .. "_" .. (self.v_camera_track_state.to or "-1")
  local pathgroup_cfg = ShareRes.get_signboard_girl_track_table(key)
  if pathgroup_cfg then
    self:play_camera_track_animation(pathgroup_cfg)
    self.v_model_view:point_light_mat_set("KB" .. event_param_cfg.Event, true)
  else
    self:change_camera_param(camera_param, is_fast)
    self.v_model_view:point_light_mat_set("KB" .. event_param_cfg.Event, false)
  end
  return true
end

function ui:set_signboard_param_type(param_id, ignore_same_act, ignore_all_act)
  self.v_model_view:on_signboard_param_type_change(param_id)
  SignBoardGirlMgr:record_signboard_param_type(param_id)
  self.v_signboard_param_type = param_id
  local event_param_cfg = ShareRes.get_signboard_girl_param(param_id, self.v_board_id)
  if not (event_param_cfg and event_param_cfg.Action) or event_param_cfg.Action == "" then
    self.v_signboard_param_act = nil
    return
  end
  if not (ignore_all_act or ignore_same_act) or self.v_signboard_param_act ~= event_param_cfg.Action then
    local board_index = self.v_model_view:get_model_index(self.v_board_id)
    if not board_index then
      return
    else
      local cur_action_cfg = SignBoardGirlMgr:get_cur_playing_action_cfg()
      if cur_action_cfg and cur_action_cfg.Action ~= Config.ACT_DEFINE.UIMainIdle and event_param_cfg.Action == Config.ACT_DEFINE.UIMainIdle then
        return
      end
      self.v_model_view:play_anim(event_param_cfg.Action, board_index)
    end
    self.v_signboard_param_act = event_param_cfg.Action
  end
end

function ui:change_camera_param(camera_param, is_fast, callback, slow_camera_y)
  self.v_model_view:set_vcamera_brain_enabled(false)
  self.v_model_view:change_camera_param(camera_param, is_fast, callback, slow_camera_y)
  self:check_is_login_performance(true)
end

function ui:check_is_login_performance(is_show_skip_btn)
  local cfg = ShareRes.create("signboard_girl.signboard_girl_param", self.v_cur_camera_state)
  if cfg and 3 == cfg.Event then
    if is_show_skip_btn then
      self.v_uiobjects.BtnSkip:SetActive(true)
    end
    return true
  end
  return false
end

function ui:set_dof_eff(event_param_cfg)
  if not Util.is_nil(self.v_camera_track_manager) then
    local DOF_OBJ = Util.get_child_gameobj("DOF_ALL", self.v_camera_track_manager.gameObject)
    if not Util.is_nil(DOF_OBJ) then
      local dof_count = DOF_OBJ.transform.childCount
      if dof_count > 0 then
        for i = 0, dof_count - 1 do
          local dof = DOF_OBJ.transform:GetChild(i)
          dof:SetActive(false)
        end
      end
      if event_param_cfg and event_param_cfg.DOF then
        local DOF_OBJ_TAR = Util.get_child_gameobj(event_param_cfg.DOF, DOF_OBJ.gameObject)
        if not Util.is_nil(DOF_OBJ_TAR) then
          DOF_OBJ_TAR:SetActive(true)
        end
      end
    end
  end
end

function ui:play_camera_track_animation(cfg)
  local pathgroupdata = ShareRes.get_camera_path_group_data(cfg.PathGroupName)
  local animator_controller_name = pathgroupdata.AnimatorControllerFileName
  local ac_path = CS.ResLoader.GetFullPath(animator_controller_name)
  if self.v_track_animator_controller_path ~= ac_path then
    self.v_track_animator_controller_path = ac_path
    local new_animator_controller
    new_animator_controller = Global.res_mgr:load_res(ac_path, UnityAnimatorController)
    self.v_camera_track_manager.animator.runtimeAnimatorController = new_animator_controller
  end
  local pathdata = pathgroupdata.pathDatas[cfg.PathId]
  local animation_state, cliplength
  animation_state = cfg.Reverse and pathdata.AnimationStateReverse or pathdata.AnimationState
  cliplength = cfg.Reverse and pathdata.ClipReverseLength or pathdata.ClipLength
  cliplength = math.ceil(cliplength)
  self.v_camera_track_manager:PlayTrackAnimation(animation_state, pathdata.Resolution, pathdata.WayPointList, cfg.StartPointOffset, cfg.EndPointOffset)
  self.v_model_view:set_vcamera_brain_enabled(true)
  self.v_camera_track_manager:EnableVirtualCamera(true)
  self.v_model_view:set_gyro_pause(true)
  is_camera_playing = true
  self.v_timer.track_timer = Timer:add_timer("track_timer", cliplength, function()
    self.v_model_view:set_vcamera_brain_enabled(false)
    self.v_model_view:cache_camera_rotate()
    self.v_timer.track_timer = nil
    self.v_model_view:set_gyro_pause(false)
    is_camera_playing = false
  end)
end

function ui:response_signboard_girl_action(msg)
  if self.v_is_guide_pause then
    return
  end
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local action_cfg = msg.mm_obj
  local is_need_run_journey_event = JourneyEventMgr:get_is_need_run_force_journey_event()
  if is_need_run_journey_event then
    return
  end
  self:play_signboard_action(action_cfg)
end

function ui:response_signboar_sound_finish()
  self:set_signboard_girl_panel_enable(false)
end

function ui:stop_signboard_model_sound_uimain()
  if not self.v_model_view then
    return
  end
  self.v_model_view:stop_all_model_sound()
end

function ui:get_signboard_model_sound_source_uimain()
  if not self.v_model_view then
    return
  end
  return self.v_model_view:get_signboard_model_sound_source_modelview()
end

function ui:clean_signboard_action_cache()
  if not self.v_model_view then
    return
  end
  self.v_model_view:clear_anim()
end

function ui:play_signboard_dialog_only(action_cfg, enable)
  if enable then
    local dialog = action_cfg.Text
    self.v_signboard_girl_panel:change_content(dialog)
  end
  self:set_signboard_girl_panel_enable(enable)
end

function ui:play_signboard_action(action_cfg)
  if not self.v_model_view then
    self:set_signboard_girl_panel_enable(true)
    local dialog = action_cfg.Text
    self.v_signboard_girl_panel:change_content(dialog)
    return
  end
  local dialog = action_cfg.Text
  local anim_name = action_cfg.Action
  local duration = SignBoardGirlMgr:get_act_duraction(action_cfg)
  local effect_name = action_cfg.Effect
  self.v_model_view:play_effect(effect_name, duration, self.v_model_idx)
  local is_need_ignore_signboard_sound = JourneyEventMgr:get_is_need_ignore_signboard_sound()
  if not is_need_ignore_signboard_sound then
    self:set_signboard_girl_panel_enable(true)
    self.v_signboard_girl_panel:change_content(dialog)
    self.v_model_view:play_anim(anim_name, self.v_model_idx)
    SignBoardGirlMgr:play_action_sound(action_cfg)
  end
  if not self.v_is_guide_pause and self.v_signboard_param_type == SIGNBOARD_PARAM.NORMAL or self.v_signboard_param_type == SIGNBOARD_PARAM.LOGIN then
    if self:get_panel("more_entry_panel").v_enable then
      return
    end
    local ui = UIMgr:get_top_ui_in_uis()
    if ui ~= self then
      return
    end
    local act_signboard_param_id, delay_time
    if action_cfg.ConditionId == CONDITION_ACTION.LOGIN_WEILCOME then
      local player_setting = BattleSettingMgr:get_login_camera_movement_mode()
      act_signboard_param_id = SIGNBOARD_PARAM.NORMAL
      if player_setting == Config.SETTING.LOGIN_CAMERA_MOVEMENT_SETTING.DAILYLOGIN then
        if Global.is_first_login_today then
          act_signboard_param_id = SIGNBOARD_PARAM.LOGIN
        end
      elseif player_setting == Config.SETTING.LOGIN_CAMERA_MOVEMENT_SETTING.EVERYLOGIN then
        act_signboard_param_id = SIGNBOARD_PARAM.LOGIN
      end
      delay_time = 0.5
      self.v_login_timer_id = Timer:add_timer("login_timer_id", duration + delay_time, function()
        if self.v_signboard_param_type == SIGNBOARD_PARAM.LOGIN then
          self:reset_signboard_param_movie()
        end
      end)
    elseif action_cfg.ConditionId == CONDITION_ACTION.PLAY_LONG_TIEM then
      act_signboard_param_id = SIGNBOARD_PARAM.LONG_STANDBY
      delay_time = 0
    end
    if act_signboard_param_id then
      self.v_act_signboard_timer = Timer:add_timer("act_signboard_timer", delay_time, function()
        local change_suc = self:change_model_view_param(act_signboard_param_id, false, false, true)
        if change_suc and not act_signboard_param_id == SIGNBOARD_PARAM.LONG_STANDBY then
          self:enable_ui_show_gameobj(false, false, true)
        end
      end)
    end
  end
end

function ui:reset_signboard_param_movie()
  if self.v_signboard_param_type == SIGNBOARD_PARAM.LOGIN or self.v_signboard_param_type == SIGNBOARD_PARAM.LONG_STANDBY then
    self:reset_signboard_param()
    self:enable_ui_show_gameobj(true, false, true, 1.85)
  end
end

function ui:response_browse_signboard_girl(msg)
  if nil == msg then
    return
  end
  local npc_id = msg.mm_x
  local signboard_param_id = msg.mm_y or SIGNBOARD_PARAM.CHANGE_ROLE
  local ignore_same_act = self.v_board_id == npc_id
  SignBoardGirlMgr:set_npc_loading(true)
  self:update_char_model(npc_id, function()
    SignBoardGirlMgr:send_change_model_view_param(signboard_param_id, false, ignore_same_act)
    SignBoardGirlMgr:set_npc_loading(false)
  end)
end

function ui:continued_click_char()
  local now_time = UnityTime.realtimeSinceStartup
  self.v_last_click_time = self.v_last_click_time or now_time
  self.v_continued_click_num = self.v_continued_click_num or 0
  local board_id = PlayerMgr:get_signboard_girl_id()
  local continued_cfg = ShareRes.create("signboard_girl.continued_signboard_girl_param", board_id)
  if not continued_cfg then
    return
  end
  local continued_num = continued_cfg.ContinuedNum
  local continued_cd = continued_cfg.ContinuedCD
  if continued_cd < now_time - self.v_last_click_time then
    self.v_last_click_time = nil
    self.v_continued_click_num = 0
    return
  end
  self.v_last_click_time = now_time
  self.v_continued_click_num = self.v_continued_click_num + 1
  if continued_num <= self.v_continued_click_num then
    return true
  end
end

function ui:click_char()
  local is_continued = self:continued_click_char()
  if SignBoardGirlMgr:is_playing() then
    return
  end
  if is_continued then
    SignBoardGirlMgr:continued_click_girl()
    return
  end
  SignBoardGirlMgr:click_signboard_girl()
end

function ui:far_click_char()
  local buddy_event_data = TaskMgr:get_buddy_event_data_with_player_board_npc_id()
  if not buddy_event_data then
    self:open_ui_main_close_win_with_cb()
    return
  end
  local is_played, is_in_progress = TaskMgr:get_npc_story_is_played(buddy_event_data)
  
  local function cb(npc_id)
    self:play_story_with_npc_id(npc_id, nil, 0)
  end
  
  if is_played and is_in_progress then
    self:open_ui_main_close_win_with_cb()
  elseif not is_played and is_in_progress then
    TaskMgr:set_npc_story_is_played(buddy_event_data)
    self:play_story_with_npc_id(buddy_event_data.npc_id, function()
      self:open_ui_main_close_win_with_cb()
    end)
  else
    self:play_story_with_npc_id(buddy_event_data.npc_id)
  end
end

function ui:open_ui_main_close_win(event_btn_cb)
  UIMgr:get_ui("uimain_close"):ui_show(event_btn_cb, function()
    SignBoardGirlMgr:click_signboard_girl()
  end)
  self:enable_ui_show_gameobj(false)
  local player_board_npc_id = PlayerMgr:get_signboard_girl_id()
  self.v_model_view:hide_other_model(player_board_npc_id, true)
end

function ui:lerp_to_far_camera()
  self:change_model_view_param(SIGNBOARD_PARAM.NORMAL, false)
  self:refresh_book_model()
end

function ui:refresh_can_enter_chapter(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  self.v_is_enter_chapter = msg.mm_obj
end

local image_x = -62.9
local image_y = 14.8

function ui:refresh_stage_info()
  local ucom = self.v_uicompents
  local uiobj = self.v_uiobjects
  local version_activity_id = TimeLimitedActMgr:get_version_activity_id()
  local stageinfo_img = Util.get_image("StageInfo", uiobj.BtnMainLine)
  local stageinfo = Util.get_child_gameobj("StageInfo", uiobj.BtnMainLine)
  if version_activity_id then
    uiobj.StageId:SetActiveEx(false)
    stageinfo:SetActiveEx(false)
  else
    stageinfo_img.enabled = true
    self.v_newest_node_cfg = ChapterMgr:get_newest_node_info()
    if not self.v_newest_node_cfg then
      return
    end
    uiobj.StageId:SetActiveEx(true)
    stageinfo:SetActiveEx(true)
    ucom.StageId_txt.text = self.v_newest_node_cfg.TagNumName
    ucom.StageName_txt.text = self.v_newest_node_cfg.MainName
    self.v_newest_chapter_cfg = ChapterMgr:get_chapter_by_node_id(self.v_newest_node_cfg.Id)
    if self.v_newest_chapter_cfg and self.v_newest_chapter_cfg.PicName then
      ResMgr:load_set_icon(ucom.StageIcon_img, self.v_newest_chapter_cfg.PicName, nil, true, self)
    end
  end
end

function ui:refresh_task_num()
  local task_num = TASK_HELPER.get_task_receive_num() or 0
  self.v_uicompents.TaskNum_txt.text = task_num
  local task_obj = self.v_uiobjects.TaskNum
  task_obj:SetActive(task_num > 0)
end

function ui:load_npc(model_fashion_id, npc_id, finish_cb)
  self.v_use_fashion_id = model_fashion_id
  local signboard_param_type = self.v_signboard_param_type or self.v_signboard_param_type_record
  local fashion_id = FashionMgr:get_fashion_wearing_id(self.v_board_id)
  local event_param_cfg = ShareRes.get_signboard_girl_param(signboard_param_type, self.v_board_id, fashion_id)
  local npc_pos = event_param_cfg.ModelPos
  local npc_rot = event_param_cfg.ModelRot
  local npc_param = {
    pos_x = npc_pos[1],
    pos_y = npc_pos[2],
    pos_z = npc_pos[3],
    rot_x = npc_rot[1],
    rot_y = npc_rot[2],
    rot_z = npc_rot[3]
  }
  local params = {
    model_id = model_fashion_id,
    npc_id = npc_id,
    npc_param = npc_param,
    hide_weapon = true,
    cb = function()
      if finish_cb then
        finish_cb()
      end
      self.v_model_view:hide_model_node(true)
      local normal_action_name = SignBoardGirlMgr:get_cur_view_stand_by_act()
      self.v_model_view:play_npc_anim(normal_action_name)
    end
  }
  self.v_model_idx = self.v_model_view:load_npc(params)
end

function ui:get_model_buddy_id()
  return self.v_board_id
end

function ui:_first_set_cannot_touch_bg_open()
  if not self.v_is_guide_pause and self.v_cannot_touch_bg_is_first or SysOpenMgr:get_sys_is_open(SIGN_IN_SYS_ID) and not SignInMgr:get_today_done() then
    self:change_touch_bg_show(true)
    self.v_cannot_touch_bg_is_first = false
  end
end

function ui:refresh_treasure_chest_red()
  TreasureChestMgr:refresh_treasure_chest_red()
end

function ui:_refresh_union_redpoint()
  if not SysOpenMgr:get_is_ui_open("union_main") then
    return
  end
  UnionMgr:refresh_redpoint()
end

function ui:refresh_banner_close()
  if not self.v_banner_refresh_time or self.v_banner_refresh_time > Date.server_time() then
    return
  end
  self:refresh_activity_banner()
end

function ui:refresh_activity_banner()
  self.v_actbanner_list = {}
  local banner_list = ShareRes.create("activity_banner.activity_banner")
  local banner_items = {}
  local target_tag = SDKManager:is_third_party_channel() and 2 or 1
  local cur_time = Date.server_time()
  self.v_banner_refresh_time = nil
  for _, v in pairs(banner_list) do
    local con_result_id = Condition:check_condition_list(v.Condition)
    if 0 ~= con_result_id then
    elseif v.TouchCount and LocalStorage:load_int(v.TouchCountRecordKey, 0, true) >= v.TouchCount then
    else
      local open_time = v.OpenTime and Date.get_time_stamp_by_scheme_id(v.OpenTime) or 0
      local end_time = v.EndTime and Date.get_time_stamp_by_scheme_id(v.EndTime) or 0
      local is_open = cur_time >= open_time and (0 == end_time or cur_time < end_time)
      if not is_open then
      else
        local q_id = v.QuestionnaireId[target_tag]
        if q_id and not PlayerSundryMgr:is_questionnaire_open(q_id) then
        else
          _tinsert(banner_items, UtilTable.copy_table(v))
          if 0 ~= end_time then
            self.v_banner_refresh_time = self.v_banner_refresh_time and (end_time > self.v_banner_refresh_time and self.v_banner_refresh_time or end_time) or end_time
          end
        end
      end
    end
  end
  table.sort(banner_items, function(a, b)
    return a.Priority > b.Priority
  end)
  self:give_back_auto_cache(ACTBANNER_ITEM_KEY)
  self.v_actbanner_item_uis = {}
  for _, data in ipairs(banner_items) do
    local item_ui = self:get_auto_cache(ACTBANNER_ITEM_KEY)
    local jump_id = UNITY_IOS and data.IOSJumpId and data.IOSJumpId or data.JumpId
    self:set_button_listener(Util.get_button(nil, item_ui), function()
      if data.TouchCount then
        local touch_count = LocalStorage:load_int(data.TouchCountRecordKey, 0, true) + 1
        LocalStorage:save_int(data.TouchCountRecordKey, touch_count, true)
        if touch_count >= data.TouchCount then
          self:refresh_activity_banner()
        end
      end
      if jump_id then
        SysOpenMgr:jump_to_sys(jump_id, true)
      end
    end)
    local dec_text = Util.get_text("Text", item_ui)
    dec_text.text = data.Title
    local BannerIcon = Util.get_image("BannerIcon", item_ui)
    ResMgr:load_set_icon(BannerIcon, data.JumpImage, nil, false)
    _tinsert(self.v_actbanner_item_uis, item_ui)
  end
  self.synv_list:update_list(banner_items)
  self.synv_list:on_select_change(self.synv_list.v_items[1])
end

function ui:refresh_ornament_redpoint()
  local tips_num = PlayerMgr:get_ornament_unread_num()
  self.v_uiobjects.OrnamentsRedPoint:SetActive(0 ~= tips_num)
  self.v_uicompents.OrnamentsNum_txt.text = tips_num
end

function ui:refresh_player_journey_entry()
  local red = PlayerJourneyMgr:get_journey_red()
  self.v_show_journey = red
end

function ui:world_to_screen_pos(x, y, z, ignore_canvas)
  local canvas
  if not ignore_canvas then
    canvas = self:get_canvas(nil, self.v_object)
  end
  return self.v_model_view:world_to_screen_pos(canvas, x, y, z)
end

function ui:screen_point_to_ray(vec2_pos)
  if not self.v_model_view then
    return nil
  end
  return self.v_model_view:screen_point_to_ray(vec2_pos)
end

function ui:set_signboard_girl_panel_enable(is_enable)
  self.v_signboard_girl_panel:set_enable(is_enable)
end

function ui:bind_uimain_to_signboard_view()
  self.v_model_view:bind_uimain(self)
end

function ui:check_guide_pause()
  self:set_guide_pause(GuideMgr:get_cur_guider() ~= nil)
end

function ui:set_guide_pause(is_pause)
  self.v_is_guide_pause = is_pause
  if not self.v_ui_visiable then
    return
  end
  if self.v_photo_frame_pd then
    if is_pause then
      self.v_photo_frame_pd:Pause()
    else
      self.v_photo_frame_pd:Resume()
    end
  end
end

function ui:get_model_view()
  return self.v_model_view
end

function ui:set_control_sign_board(is_enable)
  self.v_is_control_by_other = is_enable
end

function ui:refresh_archive_voice_pos(btn_archive, btn_voice)
  local camera_tarck_archive = self.v_container:Get("CameraTrack_Archive").transform
  local archive_rect = Util.get_rect_transform(nil, btn_archive.gameObject)
  local archive_outline = Util.get_rect_transform("OutLine", btn_archive.gameObject)
  local voice_rect = Util.get_rect_transform(nil, btn_voice.gameObject)
  local voice_outline = Util.get_rect_transform("OutLine", btn_voice.gameObject)
  local camera_component = self.v_model_view.v_camera.component
  local view_port_x, view_port_y = camera_component:WorldToViewPointB(camera_tarck_archive, 30, camera_component.aspect, camera_component.near, camera_component.far, -0.4666, 0.9, 0.992)
  local canvas_width, canvas_height = self.v_object.transform:GetRectWH()
  voice_rect:SetAnchoredPositionA(view_port_x * canvas_width, view_port_y * canvas_height)
  view_port_x, view_port_y = camera_component:WorldToViewPointB(camera_tarck_archive, 30, camera_component.aspect, camera_component.near, camera_component.far, 0.1, 0.9, 0.815)
  archive_rect:SetAnchoredPositionA(view_port_x * canvas_width, view_port_y * canvas_height)
  local scale_factor = canvas_height / 1080
  archive_outline:SetLocalScaleA(scale_factor)
  voice_outline:SetLocalScaleA(scale_factor)
end

function ui:refresh_bird_bubble_pos()
  if not self.v_model_view or not self.v_model_view.v_camera then
    return
  end
  if not self.v_uiobjects.BirdRed or self.v_uiobjects.BirdRed.activeSelf == false then
    return
  end
  if not bird_obj then
    bird_obj = self.v_model_view:get_npc_obj_with_npc_id(TaskMgr:get_bird_npc_id())
    if bird_obj then
      self.v_bird_bubble_pos = bird_obj.transform.position + bird_level_need_add_vet3
    end
  end
  if not bird_obj then
    return
  end
  if not self.v_bird_bubble_pos then
    return
  end
  local x, y, z = self.v_bird_bubble_pos:Get()
  local screen_pos_x, screen_pos_y = UtilUI.world_to_screen_pos(self.v_model_view.v_camera, self.v_canvas, x, y, z)
  self.v_bird_red_rect:SetAnchoredPositionA(screen_pos_x, screen_pos_y)
end

function ui:refresh_level_award_bubble_pos()
  if not self.v_model_view or not self.v_model_view.v_camera then
    return
  end
  if not self.v_uiobjects.LevelAwardRed or self.v_uiobjects.LevelAwardRed.activeSelf == false then
    return
  end
  if not self.v_level_award_red_obj_bubble_pos then
    return
  end
  local x, y, z = self.v_level_award_red_obj_bubble_pos:Get()
  local screen_pos_x, screen_pos_y = UtilUI.world_to_screen_pos(self.v_model_view.v_camera, self.v_canvas, x, y, z)
  self.v_level_award_red_rect:SetAnchoredPositionA(screen_pos_x, screen_pos_y)
end

function ui:refresh_bubble_pos()
  self:refresh_bird_bubble_pos()
  self:refresh_level_award_bubble_pos()
  if not self.v_ui_visiable and not JourneyEventMgr:get_is_need_run_force_journey_event() then
    return
  end
  if UIMainBubbleMgr then
    UIMainBubbleMgr:refresh_all_buddy_event_bubble(self.v_model_view, self.v_model_view.v_camera, self.v_safe_area_offset, self.v_canvas)
  end
end

function ui:refresh_strength()
  local item_maxnum = CharacterMgr:get_res_force_max_val()
  local item_num = BagMgr:get_item_num(Config.PLAYER_SP_ITEMID)
  self.v_uicompents.StrengthNum_txt.text = string.format("/%s", item_maxnum)
  self.v_uicompents.StrengthNumNow_txt.text = item_num
end

function ui:main_scene_play_video()
  if not self.v_main_scene_init_done then
    return
  end
  if self.v_video_player then
    if self.v_video_timer then
      Timer:remove_timer(self.v_video_timer)
      self.v_video_timer = nil
    end
    _randomseed(_time())
    self.v_video_cfg = self:get_video_info()
    local delay_min = VIDEO_DELAY_MIN
    local delay_max = VIDEO_DELAY_MAX
    if self.v_video_cfg then
      delay_min = self.v_video_cfg.DelayMin or VIDEO_DELAY_MIN
      delay_max = self.v_video_cfg.DelayMax or VIDEO_DELAY_MAX
    end
    local begin_time = _random(delay_min, delay_max)
    self.v_video_timer = Timer:add_timer("video_timer", begin_time, function()
      local cfg = self.v_video_cfg
      if cfg then
        self:set_video_info(cfg)
        self.v_video_player:SetActive(true)
        self:video_anim(cfg.EntryStyle, true)
      else
        self.v_video_player:SetActive(false)
      end
      self:video_end(cfg)
    end)
  end
end

function ui:get_video_info()
  local current_time_str = _date("!%H")
  local current_time_num = tonumber(current_time_str)
  local cfg = ShareRes.get_main_scene_video_cfg(current_time_num)
  if cfg then
    _randomseed(_time())
    local wight = _random(1, 99)
    local cur_wight = 0
    local res
    for _, video_info in pairs(cfg) do
      cur_wight = cur_wight + video_info.Wight
      if wight <= cur_wight then
        return video_info
      end
      res = video_info
    end
    return res
  end
end

function ui:get_path(file)
  file = string.lower(file)
  if not Game_AssetBundle then
    return Path.get_editor_sound_path(file)
  else
    return RuntimePackage.get_bundle_path(file)
  end
end

function ui:set_video_info(cfg)
  if not self.v_video_player_compenent then
    return
  end
  self.v_cur_video_url = self:get_path(cfg.VedioName)
  self.v_video_player_compenent.url = self.v_cur_video_url
end

function ui:play_journey_event_video(cfg, cb)
  if not cfg then
    self.v_video_entry_state = false
    self.v_video_show_anim:SetActive(false)
    self.v_video_hide_anim:SetActive(true)
    self:main_scene_play_video()
    if cb then
      cb()
    end
    return
  end
  self:clear_main_scene_timer()
  self:set_video_info(cfg)
  self.v_video_player:SetActive(true)
  self:video_anim(cfg.EntryStyle, true)
  self.v_video_player_compenent:AddVideoPlayerPrepareEvent(function()
    Timer:add_timer("delay_hide_journey_event_video", 0.5, function()
      self.v_video_player_compenent:Pause()
      cb()
    end)
    self.v_video_player_compenent:RemoveVideoPlayerPrepareEvent()
  end)
end

function ui:set_video_player_state(is_play)
  if is_play then
    self.v_video_player_compenent:Play()
  else
    self.v_video_player_compenent:Pause()
  end
end

function ui:refresh_video_time(time)
  if not self.v_video_player_compenent then
    return
  end
  self.v_video_player_compenent.time = time
end

function ui:video_anim(style, entry)
  if self.v_video_style ~= style then
    self.v_video_player_mat:SetTexture("_SoftTex", self.v_video_tex_info[style - 1])
    self.v_video_style = style
  end
  if entry and self.v_video_entry_state == false then
    self.v_video_show_anim:SetActive(true)
    self.v_video_hide_anim:SetActive(false)
    self.v_video_entry_state = true
  elseif not entry and self.v_video_entry_state == true then
    self.v_video_entry_state = false
    self.v_video_show_anim:SetActive(false)
    self.v_video_hide_anim:SetActive(true)
  end
  if not entry then
    if self.v_video_anim_timer then
      Timer:remove_timer(self.v_video_anim_timer)
      self.v_video_anim_timer = nil
    end
    self.v_video_anim_timer = Timer:add_timer("video_anim_timer", 10, function()
      self.v_video_player:SetActive(false)
      self:main_scene_play_video()
    end)
  end
end

function ui:video_end(cfg)
  cfg = cfg or {VedioLength = 50}
  if self.v_video_end_timer then
    Timer:remove_timer(self.v_video_end_timer)
    self.v_video_end_timer = nil
  end
  self.v_video_end_timer = Timer:add_timer("video_end_timer", cfg.VedioLength or 50, function()
    self:video_anim(cfg.LevelStyle, false)
  end)
end

function ui:video_exit()
  if not self.v_video_entry_state then
    return
  end
  self.v_video_entry_state = false
  self.v_video_show_anim:SetActive(false)
  if not self.v_video_hide_anim.activeSelf then
    self.v_video_hide_anim:SetActive(true)
  end
end

function ui:main_scene_set_tex()
  if not self.v_photo_frame_mat_collect or self.v_photo_frame_mat_collect:IsNull() then
    return
  end
  local MR = self.v_photo_frame_mat_collect.meshRenderers
  local cfg = ShareRes.get_main_scene_tex_cfg()
  for pos_type, info in pairs(cfg) do
    local cur_tex_set = {Priority = -10000}
    for _, tex_set in pairs(info) do
      if Condition:check_condition(tex_set.Condition) and tex_set.Priority > cur_tex_set.Priority then
        cur_tex_set = tex_set
      end
    end
    if cur_tex_set.Priority > 0 then
      local target = MR[pos_type - 1]
      target.material:SetTexture("_MainTex", self.v_tex_info[cur_tex_set.TexTarget - 1])
    end
  end
  local version_activity_id = TimeLimitedActMgr:get_version_activity_id()
  if version_activity_id then
    local target = MR[0]
    local time_limited_activity_cfg = ShareRes.create("activity.time_limited_activity")[version_activity_id]
    ResMgr:load_set_mat_texture(target, time_limited_activity_cfg.TexturePath)
    self.v_uicompents.ActName_txt.text = time_limited_activity_cfg.Name
  end
end

function ui:refresh_custom_photo_frame()
  self.v_mat_collect = self.v_photo_frame_mat_collect
  if not self.v_mat_collect or self.v_mat_collect:IsNull() then
    return
  end
  local MR = self.v_mat_collect.meshRenderers
  local MF = self.v_mat_collect.meshFilters
  self.v_3d_frame_list = {}
  local cfg = ShareRes.create("main_scene_video.chartlet_frame")
  for _, v in pairs(cfg) do
    if 1 == v.Show and 0 ~= v.Index then
      local target = MR[v.PosType - 1]
      if not target then
        Log.Error("主场景Main_xiangkuang未收集对应MeshRender，PosType：", PosType)
      else
        local frame_id = v.Id
        local mesh_render = target
        local mesh_filter = MF[v.PosType - 1]
        PhotoMgr:update_frame_mat(mesh_render, mesh_filter, frame_id)
      end
    end
  end
end

function ui:check_hide_model()
  local need_hide = not Condition:check_condition(920)
  if need_hide then
    self:set_fix_photo_frame_mat_visiable(false)
    self.v_uiobjects.AttachBtns:SetActive(false)
  end
end

function ui:check_fix_photo_frame_mat_show()
  if not self.v_fix_photo_frame_mat_visiable and Condition:check_condition(920) then
    self:set_fix_photo_frame_mat_visiable(true)
    if self.v_model_view then
      self.v_model_view:set_model_visible(true)
    end
  end
end

function ui:set_fix_photo_frame_mat_visiable(boolval)
  if self.v_mat_collect and not self.v_mat_collect:IsNull() then
    local MR = self.v_mat_collect.meshRenderers
    local cfg = ShareRes.create("main_scene_video.chartlet_frame")
    for _, v in pairs(cfg) do
      if 0 == v.Index then
        local target = MR[v.PosType - 1]
        if target then
          target:SetActive(boolval)
        end
      end
    end
    self.v_fix_photo_frame_mat_visiable = boolval
  end
end

function ui:enter_photo()
  if not self.v_main_scene_init_done then
    return
  end
  self:clear_main_scene_timer()
  if self.v_video_hide_anim and not self.v_video_hide_anim:IsNull() and not self.v_video_hide_anim.activeSelf then
    self:video_exit()
  end
  self:set_control_sign_board(true)
  self:set_model_view_visible(true)
  self.v_photo_frame_pd:Stop()
  self.v_photo_frame_pd.time = 0
  self.v_photo_frame_pd:Evaluate()
end

function ui:release_enter_photo()
  if not self.v_main_scene_init_done then
    return
  end
  self:main_scene_play_video()
  self:set_control_sign_board(false)
  self.v_photo_frame_pd:Play()
  self.v_uiobjects.ButtonPanel:SetActive(false)
  self.v_uiobjects.ButtonPanel:SetActive(true)
end

function ui:release_victual_camera()
  if not self.v_main_scene_init_done then
    return
  end
  if not self.v_vcamera_control or not self.v_vcamera_control.activeSelf then
    return
  end
  if self.v_drawcard_enter_pd then
    self.v_drawcard_enter_pd.time = 0
    self.v_drawcard_enter_pd:Evaluate()
  end
  self.v_model_view:set_gyro_pause(false)
  self:main_scene_play_video()
  self:set_control_sign_board(false)
  self.v_vcamera_control:SetActive(false)
  if self.v_model_view then
    self.v_model_view:set_camera_change_end(false)
    self.v_model_view:set_vcamera_brain_enabled(false)
    self.v_model_view:set_model_visible(true)
  end
  if self.v_photo_frame_pd then
    self.v_photo_frame_pd:Play()
  end
  SignBoardGirlMgr:set_clock_update(true)
end

function ui:delay_enter_draw(pool_id)
  self:change_touch_bg_show(true)
  self:remove_delay_enter_draw_timer()
  self.v_delay_enter_draw_timer = Timer:add_timer("delay_enter_draw_timer", 0.7, function()
    self:enter_draw(pool_id)
    self:change_touch_bg_show(false)
  end)
end

function ui:enter_draw(pool_id)
  if not self.v_main_scene_init_done then
    return
  end
  self.v_ani_ui_out.time = 0
  self.v_ani_ui_out:Play()
  self:clear_main_scene_timer()
  if self.v_video_hide_anim and not self.v_video_hide_anim:IsNull() and not self.v_video_hide_anim.activeSelf then
    self:video_exit()
  end
  self:set_control_sign_board(true)
  self:set_model_view_visible(true)
  self.v_signboard_param_type = nil
  SignBoardGirlMgr:record_signboard_param_type(nil)
  self.v_model_view:set_model_visible(false)
  self.v_uiobjects.AttachBtns:SetActive(false)
  self.v_model_view:set_gyro_pause(true)
  self.v_vcamera_control:SetActive(true)
  self.v_model_view:set_camera_change_end(true)
  self.v_model_view:set_vcamera_brain_enabled(true)
  self.v_photo_frame_pd:Stop()
  self.v_camera_track_manager:EnableVirtualCamera(false)
  self.v_drawcard_enter_pd:Play()
  self:change_touch_bg_show(true)
  self:remove_delay_enter_draw_timer()
  self.v_delay_enter_draw_timer = Timer:add_timer("delay_enter_draw_timer", 0.3, function()
    self:change_touch_bg_show(false)
    self.v_uiobjects.MainPanel:SetActive(false)
    UIMgr:get_ui("uidrawcard"):ui_show(pool_id)
  end)
end

function ui:prepare_fo_draw_movie_panel()
  if not self.v_main_scene_init_done then
    return
  end
  self:set_control_sign_board(true)
  self:set_model_view_visible(true)
  self.v_model_view:set_vcamera_brain_enabled(true)
  self.v_camera_track_manager:EnableVirtualCamera(false)
  return true
end

function ui:reset_after_draw_movie_panel()
  if not self.v_main_scene_init_done then
    return
  end
  local cur_signboard_param_type = SignBoardGirlMgr.v_cur_signboard_param_type
  if (not cur_signboard_param_type or cur_signboard_param_type == SIGNBOARD_PARAM.NORMAL) and not self.v_vcamera_control.activeSelf then
    self:set_control_sign_board(false)
    self.v_model_view:set_vcamera_brain_enabled(false)
    self.v_camera_track_manager:EnableVirtualCamera(false)
    self:change_model_view_param_to_normal(true)
  end
end

function ui:close_to_clock(stopped_func)
  if not self.v_main_scene_init_done then
    return
  end
  self.v_drawcard_close_to_clock_pd:Play()
  self.v_drawcard_close_to_clock_pd.transform:SetTimelineSeqEndCB(stopped_func)
end

function ui:refresh_book_model()
  if not self.v_main_scene_init_done then
    return
  end
  local board_buddy_id = PlayerMgr:get_signboard_girl_id()
  local style = 1
  local cfg = ShareRes.get_buddy_archive_overview(board_buddy_id)
  if cfg and cfg.Style then
    style = cfg.Style
  end
  local rotate = cfg.Rotate
  local pos = cfg.Pos
  local attach_trans = self.v_container:Get(BOOK_MODEL_NAME).transform
  attach_trans:SetActive(true)
  local obj_tans = Util.active_child_but(attach_trans, cfg.Style - 1, true)
  obj_tans:SetEuler(rotate[1], rotate[2], rotate[3])
  obj_tans:SetLocalPositionA(pos[1], pos[2], pos[3])
end

function ui:on_mascot_red_refresh()
  local red = PlayerJourneyMgr:get_journey_red()
  self.v_uiobjects.LevelAwardRed:SetActive(red)
  if red then
    self.v_uiobjects.BirdRed:SetActive(false)
    TaskMgr.is_need_check_bird_red = false
    return
  else
    TaskMgr.is_need_check_bird_red = true
  end
  if not TaskMgr.is_need_check_bird_red then
    return
  end
  local path = TaskMgr:get_bird_icon_path()
  self.v_uiobjects.BirdRed:SetActive(nil ~= path)
  if not path then
    return
  end
  ResMgr:load_set_icon(self.v_bird_red_icon, path)
end

function ui:update_camera_state(new_state)
  self.v_cur_camera_state = new_state
  self.v_camera_track_state.from = self.v_camera_track_state.to
  self.v_camera_track_state.to = new_state
  if self.v_timer.track_timer then
    Timer:remove_timer(self.v_timer.track_timer)
  end
  self.v_model_view:set_gyro_param_by_config(self.v_cur_camera_state)
end

function ui:get_camera_state()
  return self.v_camera_track_state
end

function ui:on_all_server_win_pop_finish()
  if BagMgr then
    BagMgr:on_all_server_win_pop_finish()
  end
end

function ui:set_ui_function_visible(visible)
  self.v_safe_area_obj:SetActive(visible)
  self.v_full_screen_background:SetActive(visible)
end

function ui:refresh_ui_function_visible(visible)
  self.v_uiobjects.MainPanel:SetActive(visible)
  self.v_full_screen_background:SetActive(visible)
  self.v_uiobjects.BtnPlayer:SetActive(visible)
  self.v_uiobjects.LowerLeft:SetActive(visible)
  self.v_uiobjects.Content:SetActive(visible)
  self.v_uiobjects.LowerRight:SetActive(visible)
  self.v_uiobjects.UpperRight:SetActive(visible)
  self.v_uiobjects.FarClickChar:SetActive(visible)
  self.v_uiobjects.FarClickCharBird:SetActive(visible)
  self.v_uiobjects.FarClickCharLevel:SetActive(visible)
  if visible then
    self.v_chou_ka_canvas_group.alpha = 1
  end
end

function ui:set_clock_state(visible)
  if not visible then
    self:clear_main_scene_timer()
    self.v_video_player.gameObject:SetActive(false)
  else
    self:main_scene_play_video()
  end
end

function ui:get_hour_minute_hand()
  return self.v_hour_hand.transform, self.v_minute_hand.transform
end

function ui:get_long_press_btn()
  return self.v_uicompents.BtnLongPress_btn
end

function ui:set_long_press_tips_visible(visible)
  self.v_uiobjects.LongPressTips:SetActive(visible)
end

function ui:get_photo_frame_pd()
  return self.v_photo_frame_pd
end

function ui:get_clock()
  return self.v_clock
end

function ui:refresh_long_press_btn_pos(obj)
  local x, y, z = obj.transform:GetPositionA()
  local screen_pos_x, screen_pos_y = UtilUI.world_to_screen_pos(self.v_model_view.v_camera, self.v_canvas, x, y, z)
  self.v_uicompents.BtnLongPress_btn.transform:SetAnchoredPositionA(screen_pos_x - self.v_safe_area_offset, screen_pos_y)
end

function ui:play_change_space_time_effect()
  self.v_model_view:play_change_space_time_effect()
end

function ui:stop_change_space_time_effect()
  self.v_model_view:stop_change_space_time_effect()
end

function ui:get_camera_track_obj()
  return self.v_camera_track_obj
end

function ui:get_scene_journey_effect()
  return self.v_scene_journey_effect_container, self.v_scene_journey_born_effect, self.v_scene_journey_idle_effect, self.v_scene_journey_interact_effect
end

function ui:set_main_scene_chapter_mat_tex(index)
  if not self.v_photo_frame_mat_collect or self.v_photo_frame_mat_collect:IsNull() then
    return
  end
  local MR = self.v_photo_frame_mat_collect.meshRenderers
  local target = MR[0]
  target.material:SetTexture("_MainTex", self.v_tex_info[index])
end

function ui:refresh_remain_time_event()
  self:refresh_remain_time(Util.get_text("Text", self.v_uiobjects.BagTimeTag), Util.get_image(nil, self.v_uiobjects.BagTimeTag), self.v_uiobjects.BagTimeTag, Util.get_child_gameobj("SysOpen/RedPoint", self.v_uiobjects.Btn_Bag))
end

function ui:refresh_remain_time(ui_txt, ui_img, remain_obj, red_obj)
  local remain_time = BagMgr:get_min_remain_time_item()
  local TIME_UNIT = Config.TIME_UNIT
  local TIMEUNIT2STR = {
    [TIME_UNIT.DAY] = "天",
    [TIME_UNIT.HOUR] = "小时",
    [TIME_UNIT.MINUTE] = "分钟"
  }
  if remain_time then
    local num, time_unit = Util.sec2time(remain_time)
    if time_unit == TIME_UNIT.DAY and num >= 7 then
      ui_txt.text = Util.format_str(string.format("%d周", math.floor(num / 7)))
    else
      if 0 == num and time_unit == TIME_UNIT.MINUTE then
        num = 1
      end
      ui_txt.text = Util.format_str(string.format("%d%s", num, TIMEUNIT2STR[time_unit]))
    end
    ui_img.color = Util.get_unity_color_by_hex(tonumber("f5ede2", 16))
    if remain_obj then
      remain_obj:SetActive(true)
    end
    if red_obj then
      red_obj:SetActive(false)
    end
  elseif remain_obj then
    remain_obj:SetActive(false)
  end
end

function ui:refresh_res_download(visible, tips)
  self.v_uiobjects.BtnDownLoading:SetActive(visible)
  if visible then
    self.v_download_text.text = tips
  end
end

function ui:on_version_activity_update()
  self:main_scene_set_tex()
  self:refresh_stage_info()
  self:_refresh_sys_btn()
  self:refresh_quick_enter_cfg_list()
  self:refresh_main_scene_quick_btn_state()
end

function ui:on_passport_data_update()
  local id = PassPortMgr:get_passport_data().id
  if 0 == id then
    self:check_ui_open_state(false, "BtnMonthTask")
  end
end

function ui:on_main_scene_fashion_update()
  self:refresh_draw_card_info()
end

function ui:refresh_quick_enter_cfg_list()
  self.v_quick_btn_not_can_click = nil
  local cfg_list = ShareRes.create("main_scene_video.main_scene_quick_entrance")
  self.v_quick_enter_cfg_opened_list = {}
  for _, cfg in ipairs(cfg_list) do
    local is_open = self:check_quick_enter_info_is_open(cfg)
    if is_open then
      table.insert(self.v_quick_enter_cfg_opened_list, cfg)
    end
  end
  self.v_quick_enter_cfg_opened_count = #self.v_quick_enter_cfg_opened_list
  table.sort(self.v_quick_enter_cfg_opened_list, function(a, b)
    return a.Priority < b.Priority
  end)
end

function ui:check_quick_enter_info_is_open(cfg)
  local jump_cfg = ShareRes.create("sysopen.sys_jump")[cfg.JumpId]
  local is_sys_open = jump_cfg and SysOpenMgr:get_sys_is_open(jump_cfg.sys_id) or false
  if not is_sys_open then
    return false
  end
  local open_time = cfg.OpenTime and Date.get_time_stamp_by_scheme_id(cfg.OpenTime) or 0
  local end_time = cfg.StopTime and Date.get_time_stamp_by_scheme_id(cfg.StopTime) or 0
  local cur_time = Date.server_time()
  local is_time_open = open_time <= cur_time and (0 == end_time or end_time > cur_time)
  if not is_time_open then
    return false
  end
  local condition_id = Condition:check_condition_list(cfg.Condition)
  if 0 ~= condition_id then
    return false
  end
  if cfg.CloseCondition and cfg.CloseCondition > 0 then
    local is_close = Condition:check_condition(cfg.CloseCondition)
    if is_close then
      return false
    end
  end
  return true
end

function ui:refresh_main_scene_quick_btn_state()
  if self.v_quick_btn_not_can_click then
    return
  end
  self.v_quick_btn_not_can_click = true
  self.v_uicompents.Ani_BtnEntrance_Change_pd:Play()
  self:clear_quick_btn_change_timer()
  self.v_quick_btn_change_timer = Timer:add_timer("Ani_BtnEntrance_Change_Timer", 0.2, function()
    self.v_quick_btn_not_can_click = nil
    self.v_uiobjects.BtnTower:SetActive(false)
    self.v_uiobjects.BtnActivitySummer:SetActive(false)
    self:refresh_quick_enter_cfg()
    if not self.v_curr_quick_enter_cfg then
      self.v_uiobjects.BtnEntrance:SetActive(false)
      return
    end
    self.v_uiobjects.BtnEntrance:SetActive(true)
    self:refresh_quick_enter_info()
  end)
end

function ui:refresh_quick_enter_cfg()
  if 0 == self.v_quick_enter_cfg_opened_count then
    self.v_curr_quick_enter_index = nil
    self.v_next_quick_enter_index = nil
    self.v_curr_quick_enter_cfg = nil
    self.v_next_quick_enter_cfg = nil
    return
  end
  if not self.v_curr_quick_enter_index then
    self.v_curr_quick_enter_index = 1
  else
    self.v_curr_quick_enter_index = self.v_curr_quick_enter_index + 1
  end
  if self.v_curr_quick_enter_index > self.v_quick_enter_cfg_opened_count then
    self.v_curr_quick_enter_index = 1
  end
  self.v_next_quick_enter_index = self.v_curr_quick_enter_index + 1
  if self.v_next_quick_enter_index > self.v_quick_enter_cfg_opened_count then
    self.v_next_quick_enter_index = 1
  end
  if self.v_next_quick_enter_index == self.v_curr_quick_enter_index then
    self.v_next_quick_enter_index = nil
    self.v_next_quick_enter_cfg = nil
  end
  self.v_curr_quick_enter_cfg = self.v_quick_enter_cfg_opened_list[self.v_curr_quick_enter_index]
  if self.v_next_quick_enter_index then
    self.v_next_quick_enter_cfg = self.v_quick_enter_cfg_opened_list[self.v_next_quick_enter_index]
  end
end

function ui:refresh_quick_enter_info()
  self.v_uiobjects.BtnChange:SetActive(self.v_next_quick_enter_cfg ~= nil)
  self.v_uiobjects.ActivityEntrance2:SetActive(self.v_next_quick_enter_cfg ~= nil)
  ResMgr:load_set_icon(self.v_uicompents.ActivityEntrance1_img, self.v_curr_quick_enter_cfg.ImagePath)
  self.v_uicompents.EntranceText_txt.text = self.v_curr_quick_enter_cfg.Title
  if self.v_next_quick_enter_cfg then
    ResMgr:load_set_icon(self.v_uicompents.ActivityEntrance2_img, self.v_next_quick_enter_cfg.ImagePath)
    self:add_quick_enter_timer()
  end
  if not self.v_curr_quick_enter_cfg.IsNeedShowStar or 0 == self.v_curr_quick_enter_cfg.IsNeedShowStar then
    self.v_uiobjects.Star:SetActive(false)
    self.v_uiobjects.StarNum:SetActive(false)
    return
  end
  self.v_uiobjects.Star:SetActive(true)
  self.v_uiobjects.StarNum:SetActive(true)
  if self.v_curr_quick_enter_cfg.FightType == Config.CommonDefine.CHALLENGE_TYPE.CLIMBING_TOWER then
    local _, curr, max = ClimbingTowerMgr:get_main_btn_info()
    self.v_uicompents.StarNum_txt.text = curr .. "/" .. max
  end
end

function ui:add_quick_enter_timer()
  self:clear_quick_enter_timer()
  if not self.v_curr_quick_enter_cfg then
    return
  end
  local time = self.v_curr_quick_enter_cfg.ShowTime
  if not time or time <= 0 then
    return
  end
  self.v_quick_enter_timer = Timer:add_timer("quick_enter_timer", time, function()
    self:refresh_main_scene_quick_btn_state()
  end)
end

function ui:clear_quick_enter_timer()
  if self.v_quick_enter_timer then
    Timer:remove_timer(self.v_quick_enter_timer)
    self.v_quick_enter_timer = nil
  end
end

function ui:clear_quick_btn_change_timer()
  if self.v_quick_btn_change_timer then
    Timer:remove_timer(self.v_quick_btn_change_timer)
    self.v_quick_btn_change_timer = nil
  end
end

return ui
