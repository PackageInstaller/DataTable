local M = Util.create_class()
local TypeUnityVideoPlayer = typeof(UnityEngine.Video.VideoPlayer)
local UnityApplication = UnityEngine.Application
local UnityCurve = UnityEngine.AnimationCurve
local UnityTime = UnityEngine.Time
local CriManaMovieControllerForUI = typeof(CS.CriWare.CriManaMovieControllerForUI)
local CriMoviePlayerStatus = CS.CriWare.CriMana.Player.Status
local RuntimePackage = require("manager.res.runtime_package")

function M:get_path(file)
  file = string.lower(file)
  if not Game_AssetBundle then
    return Path.get_editor_sound_path(file)
  else
    return RuntimePackage.get_video_path(file)
  end
end

function M:_init()
  self.v_video_player_obj = nil
  self.v_cur_video_url = nil
  self.v_playing = false
  self.v_cri_movie_player_status = CriMoviePlayerStatus.Stop
  self.v_cri_movie_canvas_group = nil
end

function M:on_play_video(video_info)
  if self.v_playing then
    Log.Error("当前正在播放视频，当前视频路径 = ", self.v_cur_video_url)
    return
  end
  local video_name = video_info.video_name
  local is_skip = video_info.is_skip
  local alpha_enter = video_info.alpha_enter
  local alpha_out = video_info.alpha_out
  local end_cb = video_info.end_cb
  local aspect_ratio = video_info.aspect_ratio
  local video_data = {}
  if alpha_enter and 0 ~= alpha_enter then
    local curve = UnityCurve.EaseInOut(0, 0, alpha_enter, 1)
    video_data.curve_enter = curve
    video_data.enter_start_time = UnityTime.realtimeSinceStartup
    video_data.enter_all_time = alpha_enter
  end
  if alpha_out and 0 ~= alpha_out then
    local curve_out = UnityCurve.EaseInOut(0, 1, alpha_out, 0)
    video_data.curve_out = curve_out
    video_data.out_all_time = alpha_out
  end
  video_data.end_cb = end_cb
  video_data.sound_name = video_info.sound_name
  video_name = video_name:gsub(".mp4", ".usm")
  self.v_video_name = video_name
  self.v_play_video_data = video_data
  self:play_with_cri_video(video_name, is_skip, aspect_ratio)
  self:check_and_play_sound(video_name)
end

function M:play_with_cri_video(video_name, is_skip, aspect_ratio)
  self.v_cur_video_url = self:get_path(video_name)
  UIMgr:get_ui("uivideo_skip"):ui_show(function(movie_image, movie_canvas_group, usm_mask_canvas_group)
    self.v_cri_movie_canvas_group = movie_canvas_group
    self.v_usm_mask_canvas_group = usm_mask_canvas_group
    if self.v_play_video_data.enter_all_time and self.v_play_video_data.enter_all_time > 0 then
      self.v_cri_movie_canvas_group.alpha = 0
      self.v_usm_mask_canvas_group.alpha = 0
      self.v_cri_movie_canvas_group.gameObject:SetActive(true)
      
      local function value_func(value)
        self.v_cri_movie_canvas_group.alpha = value
        self.v_usm_mask_canvas_group.alpha = value
        if value >= 1 then
          self:play_cri_video_callback(movie_image)
        end
      end
      
      CSHelper.WrapTweenTo(0, 1, self.v_play_video_data.enter_all_time, value_func)
    else
      self.v_cri_movie_canvas_group.gameObject:SetActive(true)
      self:play_cri_video_callback(movie_image)
    end
  end, is_skip, aspect_ratio)
end

function M:play_cri_video_callback(movie_image)
  if self.cri_movie_player then
    return
  end
  self.cri_movie_player = movie_image.gameObject:GetComponent(CriManaMovieControllerForUI)
  if Util.is_nil(self.cri_movie_player) then
    self.cri_movie_player = movie_image.gameObject:AddComponent(CriManaMovieControllerForUI)
    self.cri_movie_player.useOriginalMaterial = true
    self.cri_movie_player.applyTargetAlpha = true
  end
  self.cri_movie_player.player:SetFile(nil, self.v_cur_video_url)
  Util.set_cri_video_track(self.cri_movie_player, self.v_video_name)
  self.cri_movie_player.player:SetVolume(BattleSettingMgr:get_voice_main())
  self.cri_movie_player.maxFrameDrop = CS.CriWare.CriManaMovieMaterialBase.MaxFrameDrop.Five
  NextFrameMgr:add_next_update(function()
    self.cri_movie_player:Play()
    self.v_playing = true
  end)
end

function M:stop()
  self:stop_cri_movie_player()
end

function M:stop_cri_movie_player()
  if not self.cri_movie_player then
    return
  end
  if self.v_play_video_data.out_all_time and self.v_play_video_data.out_all_time > 0 then
    self.v_cri_movie_canvas_group.alpha = 1
    self.v_usm_mask_canvas_group.alpha = 1
    
    local function value_func(value)
      if not Util.is_nil(self.v_cri_movie_canvas_group) then
        self.v_cri_movie_canvas_group.alpha = value
      end
      if not Util.is_nil(self.v_usm_mask_canvas_group) then
        self.v_usm_mask_canvas_group.alpha = value
      end
      if value <= 0 then
        self:stop_cri_movie_player_callback()
      end
    end
    
    CSHelper.WrapTweenTo(1, 0, self.v_play_video_data.out_all_time, value_func)
  else
    self:stop_cri_movie_player_callback()
  end
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_VIDEO_PLAY_END)
end

function M:stop_cri_movie_player_callback()
  if not self.v_play_video_data then
    return
  end
  if not Util.is_empty(self.v_play_video_data.sound_name) and self.v_play_video_data.sound_type then
    Global.sound_mgr:stop_sound_by_type(self.v_play_video_data.sound_type)
  end
  Util.remove_cri_subtitle_event(self.cri_movie_player)
  self.cri_movie_player:Stop()
  self.cri_movie_player.gameObject:TryRemoveComponent(CriManaMovieControllerForUI)
  self.cri_movie_player = nil
  self.v_cur_video_url = nil
  self.v_cri_movie_canvas_group = nil
  self.v_playing = false
  UIMgr:try_hide_ui("uivideo_skip")
  if self.v_play_video_data.end_cb then
    self.v_play_video_data.end_cb()
    self.v_play_video_data = nil
  end
end

function M:update()
  self:on_cri_movie_player_update()
end

function M:on_cri_movie_player_update()
  if not self.cri_movie_player then
    return
  end
  if self.v_cri_movie_player_status ~= self.cri_movie_player.player.status then
    self.v_cri_movie_player_status = self.cri_movie_player.player.status
    if self.v_cri_movie_player_status == CriMoviePlayerStatus.PlayEnd then
      self:stop()
    end
  end
end

function M:check_and_play_sound(video_name)
  local split = Util.split_str(video_name, ".")
  local name = split[1]
  local cfg = ShareRes.get_usm_video_cfg(name)
  if not cfg then
    Log.Error("视频表中找不到配置:", video_name)
    return
  end
  if 1 == cfg.StopBgm then
    Global.sound_mgr:stop_play_bgm()
  end
  if cfg.SoundName and cfg.SoundName ~= "" then
    Global.sound_mgr:play_sound_by_id(cfg.SoundName)
  end
end

return M
