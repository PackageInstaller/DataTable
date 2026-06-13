local Layer = require("utils.layer")
local QualityCfg = require("manager.render.quality_cfg")
local LEVEL_NOT_INIT = -1
local SAVE_LEVEL_KEY = "quality_level_key"
local LocalStorage = require("utils.localstorage")
local CSShadow = CS.Game.Shadow
local CSResLoader = CS.ResLoader
local CSGameMgr = CS.Game.GameMgr
local CSUnityEngine = UnityEngine
local CSSystemInfo = CSUnityEngine.SystemInfo
local CSScreen = CSUnityEngine.Screen
local Color = CSUnityEngine.Color
local SETTING = Config.SETTING
local UnityQualitySetting = UnityEngine.QualitySettings
local UnityShadowQuality = UnityEngine.ShadowQuality
local CSSceneIllumination = CS.SceneIllumination
local CSSceneIlluminationInfo = CS.SceneIlluminationInfo
local CSPostProcessBehavior = typeof(UnityEngine.PostProcessing.PostProcessingBehaviour)
local CSOnDemandRendering = UnityEngine.Rendering.OnDemandRendering
local QUALITY = QualityCfg.QUALITY
local QualityDetailCfg = QualityCfg.CFG
local QualityShadow = QualityCfg.SHADOW
local CAM_CLIP_DIST = QualityCfg.CLIP_CFG
local RENDER_FRAME = QualityCfg.RENDER_FRAME
local RESOLUTION = QualityCfg.RESOLUTION
local MAX_MOBILE_UNITY_QUALITY = QUALITY.VERY_HIGH
local UnityFind = _ENV.UnityFind
local MAX_FPS = 60
local TextureStreamingReduction = 3
local TextureStremingBudget = 200
local WINDOS_SUPPORT_RESOLUTION_KEY = "WINDOS_SUPPORT_RESOLUTION_KEY"
local WINDOS_FRAME = {
  FRAME60 = 0,
  FRAME_NO_LIMIT = 1,
  FRAME_VSYNC = 2
}
local M = Util.create_class()

function M:_init()
  MsgGame:mq_bind(Const.MSG_SCENE_LOAD, self._on_load_scene, self)
  MsgGame:mq_bind(Const.MSG_CREATE_CAMERA, self._on_create_camera, self)
  self:load_graphic_settings()
  self:load_default_scene_effect()
  self.v_cam_created_cbs = {}
  local quality_level
  if UNITY_ANDROID then
    quality_level = self:get_android_quality_level()
  elseif UNITY_IOS then
    quality_level = self:get_ios_quality_level()
  elseif UNITY_STANDALONE_WIN then
    quality_level = self:get_quality_level_from_gpu() or QUALITY.HIGH
  else
    quality_level = QUALITY.MIDDLE
  end
  Log.Info("current quality level: ", quality_level)
  self.v_initial_quality_level = quality_level
  self.v_hardware_quality_level = self:try_get_quality_level_from_config()
  self:set_quality_level(quality_level)
  self.v_disable_shadow = false
  MsgGame:mq_bind(Const.MSG_QUALIY_CHANGE, self._on_quality_change, self)
  self:set_texture_streaming()
  self:set_lod_bias()
  self:get_suport_resolution_list()
  self:set_cur_resolution()
  if not UNITY_EDITOR then
    self:set_optimize_particle_system_sorting(true)
  end
  self:set_frame_for_pc()
end

function M:set_frame_for_pc()
  if not self:get_is_windos() then
    return
  end
  local frame_set = self:get_save_frame()
  if frame_set == WINDOS_FRAME.FRAME60 then
    self:set_frame_60()
  elseif frame_set == WINDOS_FRAME.FRAME_VSYNC then
    self:set_vsynccount()
  elseif frame_set == WINDOS_FRAME.FRAME_NO_LIMIT then
    self:set_frame_nolimit()
  end
end

function M:_on_load_scene()
  CSShadow.Init()
  CSShadow.ShadowLayer = Layer.LayerMask.Character
  CSShadow.RenderOrder = 0
end

function M:_on_create_camera()
  self.v_postprocessing = Global.camera:get_camera_obj():GetComponent(CSPostProcessBehavior)
  self:check_post_process()
  for cb, _ in pairs(self.v_cam_created_cbs) do
    cb()
  end
  UtilTable.clear_map(self.v_cam_created_cbs)
end

function M:on_destroy_camera()
  self.v_postprocessing = nil
end

local function enable_shadow_camera(enable)
  local shadow_camera = CSShadow.ShadowCamera
  if shadow_camera and not shadow_camera:IsNull() then
    shadow_camera:SetActive(enable)
  end
end

function M:enter_game_mode()
  enable_shadow_camera(BattleSettingMgr:is_enable_shadow_camera())
end

function M:leave_game_mode()
  enable_shadow_camera(false)
end

function M:load_graphic_settings()
  local full_path = CSResLoader.GetFullPath("GraphicSettings.asset")
  self.v_graphic_settings = ResMgr:load_res(full_path, CS.Game.GraphicSettings)
  CSGameMgr.SetGraphicSettings(self.v_graphic_settings)
end

function M:load_default_scene_effect()
  local path = CSResLoader.GetFullPath("CommonSceneEffect.asset")
  local asset = ResMgr:load_res(path, CSSceneIlluminationInfo)
  CSSceneIlluminationInfo.Apply(asset)
end

function M:enable_post_processing(enable)
  if not self.v_postprocessing or self.v_postprocessing:IsNull() then
    return
  end
  self.v_postprocessing.enabled = true == enable
end

function M:check_info_is_null()
  if not self.v_graphic_info then
    self:set_graphic_info(0)
  end
end

function M:enable_depth_of_field(enable)
  self:check_info_is_null()
  self.v_graphic_info.DepthOfField = true == enable
end

function M:enable_bloom(enable)
  Log.Error("enable_bloom", enable, debug.traceback())
  self:check_info_is_null()
  self.v_graphic_info.Bloom = true == enable
end

function M:enable_fxaa(enable)
  self:check_info_is_null()
  self.v_graphic_info.FXAA = true == enable
end

function M:enable_lut(enable)
  self:check_info_is_null()
  self.v_graphic_info.Lut = true == enable
end

function M:enable_distortion(enable)
  self:check_info_is_null()
  self.v_graphic_info.Distortion = true == enable
end

function M:enable_hdr(enable)
  self:check_info_is_null()
  self.v_graphic_info.HDR = true == enable
  CS.CustomResolveCamera.HDR = enable
end

function M:is_hdr_enabled()
  return self.v_graphic_info.HDR
end

function M:enable_guassian_blur(enable)
  self:check_info_is_null()
  self.v_graphic_info.GaussianBlur = true == enable
end

function M:enable_shadow(enable)
  self.v_disable_shadow = not enable
  CSShadow.DisableShadow = not enable
end

function M:set_quality_level(quality_level)
  Global.quality_cfg = UtilTable.copy_table(QualityDetailCfg[quality_level])
  local msg = MsgGame:mq_publish2(Const.MSG_QUALIY_CHANGE)
  msg.mm_obj = quality_level
end

function M:set_unity_quality_setting(quality_level)
  local unity_quality = quality_level
  if not UNITY_EDITOR then
    unity_quality = math.min(quality_level, MAX_MOBILE_UNITY_QUALITY)
  end
  CSGameMgr.SetCurQuality(unity_quality)
  self.v_cs_unity_quality = unity_quality
  UnityQualitySetting.SetQualityLevel(unity_quality)
  UnityQualitySetting.streamingMipmapsActive = false
end

function M:set_graphic_info(level)
  if not self.v_graphic_settings then
    self:load_graphic_settings()
  end
  self.v_graphic_info = self.v_graphic_settings.graphicsSettings[level]
  CSGameMgr.SetGraphicInfo(self.v_graphic_info)
  local enable_depth_of_field = UNITY_EDITOR or UNITY_STANDALONE_WIN or SDKManager:is_google_play_games()
  self:enable_depth_of_field(enable_depth_of_field)
end

function M:_on_quality_change(msg)
  local quality_level = msg.mm_obj
  Global.quality_cfg = UtilTable.copy_table(QualityDetailCfg[quality_level])
  if self.v_quality_level == quality_level then
    return
  end
  self.v_quality_level = quality_level
  self:set_unity_quality_setting(quality_level)
  self:set_graphic_info(quality_level - 1)
  self:set_shadow(Global.quality_cfg.shadow)
  self.v_quality_fps = Global.quality_cfg.fps
  
  local function set_cam_clip_dist()
    local cur_clip_factor = Global.quality_cfg.cam_dist
    local clip_dist_component = Global.camera.clip_dist
    for layer, dist in pairs(CAM_CLIP_DIST) do
      clip_dist_component:SetDistance(layer, dist * cur_clip_factor)
    end
  end
  
  if Global.camera then
    set_cam_clip_dist()
  else
    self.v_cam_created_cbs[set_cam_clip_dist] = true
  end
  self:set_render_frame(Global.quality_cfg.render_frame)
  self:check_post_process()
  self:set_resolution(Global.quality_cfg.resolution)
end

function M:set_fps(fps)
end

function M:set_render_frame(render_frame)
  if self:get_is_windos() then
    return
  end
  self.v_render_frame = render_frame
  if render_frame == RENDER_FRAME.LOW then
    CSOnDemandRendering.renderFrameInterval = 2
  else
    CSOnDemandRendering.renderFrameInterval = 1
  end
end

function M:get_render_frame()
  return self.v_render_frame
end

function M:check_post_process()
  if self.v_postprocessing and not self.v_postprocessing:IsNull() then
    self.v_postprocessing.enabled = Global.quality_cfg.postprocess == true
  else
    self.v_postprocessing = nil
  end
end

function M:set_resolution(resolution_level)
  ScreenMgr:set_graphic_resolution(resolution_level)
end

function M:get_cur_resolution()
  return ScreenMgr:get_cur_graphic_resolution()
end

function M:set_shadow(quality)
  quality = quality or QualityShadow.MIDDLE
  if quality > QualityShadow.LOW then
    local cs_shadow_quality = CSShadow.ShadowQuality.Middle
    if quality == QualityShadow.HIGH then
      cs_shadow_quality = CSShadow.ShadowQuality.Middle
    end
    CSShadow.UseShadowMap(cs_shadow_quality)
  else
    CSShadow.DisableShadowMap()
    CSShadow.ReleaseShadowCamera()
  end
end

local MSAA_DISABLE = 1
local MSAA_X2 = 2
local MSAA_X4 = 4
local MSAA_X8 = 8

function M:set_anti_aliasing(is_on)
  local anti_aliasing = MSAA_DISABLE
  local cur_quality_level = self:get_cur_quality_level()
  if is_on then
    if UNITY_IOS then
      anti_aliasing = cur_quality_level > QUALITY.HIGH and SDKManager:is_tablet() and MSAA_X4 or MSAA_X2
    elseif UNITY_ANDROID then
      local is_arm_gpu = string.find(CSSystemInfo.graphicsDeviceVendor, "ARM")
      if is_arm_gpu then
        anti_aliasing = MSAA_X4
      else
        anti_aliasing = cur_quality_level > QUALITY.HIGH and MSAA_X4 or MSAA_X2
      end
    else
      anti_aliasing = MSAA_X8
    end
  end
  if UNITY_IOS then
    anti_aliasing = math.max(anti_aliasing, MSAA_X2)
  end
  CS.CustomResolveCamera.MSAA = anti_aliasing
  UnityQualitySetting.antiAliasing = MSAA_DISABLE
end

function M:get_initial_quality_level()
  return self.v_initial_quality_level
end

function M:get_cur_quality_level()
  return self.v_cs_unity_quality or 1
end

function M:set_unity_antiAliasing(val)
  UnityEngine.QualitySettings.antiAliasing = val
end

local function find_longest_prefix_match(tb, target)
  local longest_match = ""
  local quality
  for k, v in pairs(tb) do
    if target:sub(1, #k) == k and #k > #longest_match then
      longest_match = k
      quality = v
    end
  end
  return longest_match, quality
end

function M:get_quality_level_from_gpu()
  local gpu_name = CSSystemInfo.graphicsDeviceName
  Log.Info("gpu hardware: ", gpu_name)
  if not gpu_name then
    return
  end
  local gpu_cfg
  if UNITY_STANDALONE_WIN then
    gpu_cfg = ShareRes.create("common.pc_gpu")
  else
    gpu_cfg = ShareRes.create("common.gpu")
  end
  if gpu_cfg[gpu_name] then
    Log.Info("find gpu cfg: ", gpu_name, "quality: ", gpu_cfg[gpu_name])
    return gpu_cfg[gpu_name]
  end
  local gpu, quality = find_longest_prefix_match(gpu_cfg, gpu_name)
  Log.Info("find gpu cfg: ", gpu, "quality: ", quality)
  return quality
end

function M:get_quality_level_from_cpu()
  local cpu_hardware = Util.get_android_cpuhardware()
  cpu_hardware = cpu_hardware and string.lower(cpu_hardware)
  Log.Info("cpu hardware: ", cpu_hardware)
  if not cpu_hardware then
    return
  end
  Log.Info("find cpu cfg: ", cpu, quality)
  local cpu_cfg = ShareRes.create("common.cpu")
  local cpu, quality = find_longest_prefix_match(cpu_cfg, cpu_hardware)
  return quality
end

function M:try_get_quality_level_from_config()
  local cpu_quality_level = self:get_quality_level_from_cpu()
  local gpu_quality_level = self:get_quality_level_from_gpu()
  return cpu_quality_level or gpu_quality_level
end

function M:get_android_quality_level()
  if SDKManager:is_simulator() then
    return QUALITY.HIGH
  end
  if SDKManager:is_google_play_games() then
    return QUALITY.VERY_HIGH
  end
  local quality_level = self:try_get_quality_level_from_config()
  return quality_level or QUALITY.MIDDLE
end

function M:get_ios_quality_level()
  local quality_level
  local generation = CompExtensions.GetiOSDeviceGeneration()
  local iOSDeviceGeneration = Config.iOSDeviceGeneration
  Log.Info("ios device generation: ", iOSDeviceGeneration)
  if generation >= iOSDeviceGeneration.iPhone14Pro then
    quality_level = QUALITY.VERY_HIGH
  elseif generation >= iOSDeviceGeneration.iPhone12 then
    quality_level = QUALITY.HIGH
  elseif generation >= iOSDeviceGeneration.iPhoneXR then
    quality_level = QUALITY.MIDDLE
  else
    quality_level = QUALITY.LOW
  end
  return quality_level
end

function M:is_low_memory_device()
  local device_memory = CSSystemInfo.systemMemorySize
  return device_memory <= 4096
end

function M:is_low_performance_device()
  return self.v_hardware_quality_level and self.v_hardware_quality_level <= QUALITY.MIDDLE
end

function M:on_destroy()
  local shadow_camera = CSShadow.ShadowCamera
  if shadow_camera and not shadow_camera:IsNull() then
    UnityDestroy(shadow_camera)
    CSShadow.ShadowCamera = nil
  end
  CSShadow.ReleaseShadowCamera()
end

function M:try_get_hard_ware_quality()
  return self.v_hardware_quality_level
end

function M:set_post_process_param(param)
  if not param or not CSGameMgr.PostProfile then
    return
  end
  CSGameMgr.PostProfile.bloomModel.enabled = 1 == param.BloomModelEnable
  CSGameMgr.PostProfile.drakCornerModel.enabled = 1 == param.DarkCornerModelEnable
  CSGameMgr.PostProfile.lutModel.enabled = 1 == param.LutEnable
  CSGameMgr.PostProfile.rgbSplit.enabled = 1 == param.RGBSplitEnable
  local settings
  if 1 == param.BloomModelEnable then
    settings = CSGameMgr.PostProfile.bloomModel.settings
    settings.Threshold = param.Threshold
    settings.FilterScaler = param.FilterScaler
    CSGameMgr.PostProfile.bloomModel.settings = settings
  end
  if 1 == param.DarkCornerModelEnable then
    settings = CSGameMgr.PostProfile.drakCornerModel.settings
    settings.Color = Util.get_unity_color_by_hex(tonumber(param.Color, 16))
    settings.Inner = param.Inner
    settings.Bound = param.Bound
    settings.centerX = param.CenterX
    settings.centerY = param.CenterY
    CSGameMgr.PostProfile.drakCornerModel.settings = settings
  end
  if 1 == param.LutEnable then
    settings = CSGameMgr.PostProfile.lutModel.settings
    local lut = settings.lut
    lut.LutContribute = param.LutContribute
    settings.lut = lut
    CSGameMgr.PostProfile.lutModel.settings = settings
  end
  if 1 == param.RGBSplitEnable then
    local offset = param.ChanelOffset
    settings = CSGameMgr.PostProfile.rgbSplit.settings
    local rgbSplit = settings.rgbSplit
    rgbSplit.chanelOffset = UnityVector3(offset[1], offset[2], offset[3])
    settings.rgbSplit = rgbSplit
    CSGameMgr.PostProfile.rgbSplit.settings = settings
  end
end

function M:set_post_process_bloom_param(threshold, filterScaler)
  local settings = CSGameMgr.PostProfile.bloomModel.settings
  settings.Threshold = threshold
  settings.FilterScaler = filterScaler
  CSGameMgr.PostProfile.bloomModel.settings = settings
end

function M:set_texture_streaming()
  if UNITY_IOS then
    UnityQualitySetting.streamingMipmapsActive = false
    CSUnityEngine.Texture.streamingTextureDiscardUnusedMips = false
    return
  end
  if self:is_low_memory_device() or self:is_low_performance_device() then
    UnityQualitySetting.streamingMipmapsMemoryBudget = 150
    UnityQualitySetting.asyncUploadBufferSize = 8
    UnityQualitySetting.masterTextureLimit = 1
    UnityQualitySetting.streamingMipmapsMaxLevelReduction = 2
  else
    UnityQualitySetting.streamingMipmapsMemoryBudget = 300
    UnityQualitySetting.asyncUploadBufferSize = 32
    UnityQualitySetting.masterTextureLimit = 0
    UnityQualitySetting.streamingMipmapsMaxLevelReduction = 1
  end
  UnityQualitySetting.streamingMipmapsActive = true
  CSUnityEngine.Texture.streamingTextureDiscardUnusedMips = true
  UnityQualitySetting.streamingMipmapsAddAllCameras = false
end

function M:set_vsynccount()
  if UNITY_STANDALONE_WIN then
    UnityEngine.Application.targetFrameRate = -1
    CSUnityEngine.QualitySettings.vSyncCount = 1
    self:set_save_frame(WINDOS_FRAME.FRAME_VSYNC)
  end
end

function M:set_frame_nolimit()
  if UNITY_STANDALONE_WIN then
    UnityEngine.Application.targetFrameRate = -1
    CSUnityEngine.QualitySettings.vSyncCount = 0
    self:set_save_frame(WINDOS_FRAME.FRAME_NO_LIMIT)
  end
end

function M:set_frame_60()
  if UNITY_STANDALONE_WIN then
    UnityEngine.Application.targetFrameRate = 60
    CSUnityEngine.QualitySettings.vSyncCount = 0
    self:set_save_frame(WINDOS_FRAME.FRAME60)
  end
end

function M:get_save_frame()
  if not self:get_is_windos() then
    return
  end
  return LocalStorage:load_int("WINDOS_SUPPORT_FRAME_KEY", WINDOS_FRAME.FRAME_NO_LIMIT, false)
end

function M:set_save_frame(mode)
  if not self:get_is_windos() then
    return
  end
  LocalStorage:save_int("WINDOS_SUPPORT_FRAME_KEY", mode, false)
end

function M:set_lod_bias()
  if UNITY_STANDALONE_WIN then
    UnityQualitySetting.lodBias = 2
  end
end

function M:get_is_windos()
  if UNITY_STANDALONE_WIN then
    return true
  end
  return false
end

local RESOLUTION_MODE = {
  FullScreen = 0,
  Windowed = 1,
  Borderless = 2
}
local RESOLUTION_DEFAULT_SELECT = 1

function M:get_suport_resolution_list()
  if not self:get_is_windos() then
    return
  end
  local support_resolution = CS.Game.WindowsResolutionChangger.GetSupportedResolutionsArray()
  self.v_windos_support_resolution = {}
  for i = 0, support_resolution.Length - 1 do
    local cs_resolution = support_resolution[i]
    table.insert(self.v_windos_support_resolution, {
      width = cs_resolution.width,
      height = cs_resolution.height,
      refreshRate = cs_resolution.refreshRate,
      mode = RESOLUTION_MODE.Windowed
    })
  end
  if next(self.v_windos_support_resolution) == nil then
    return
  end
  table.sort(self.v_windos_support_resolution, function(a, b)
    return a.width > b.width
  end)
  local full_screen = {}
  full_screen.width = self.v_windos_support_resolution[1].width
  full_screen.height = self.v_windos_support_resolution[1].height
  full_screen.refreshRate = self.v_windos_support_resolution[1].refreshRate
  full_screen.mode = RESOLUTION_MODE.FullScreen
  self.v_windos_support_resolution[1].mode = RESOLUTION_MODE.Borderless
  table.insert(self.v_windos_support_resolution, 1, full_screen)
end

function M:get_resolution_use_index()
  local save_table = self:get_save_resolution()
  local support_table = self:get_resolution_by_windowssetting()
  if nil == save_table or nil == next(save_table) then
    return RESOLUTION_DEFAULT_SELECT
  end
  for idx, data in pairs(support_table) do
    if save_table.width == data.width and save_table.height == data.height and save_table.mode == data.mode then
      return idx
    end
  end
  return RESOLUTION_DEFAULT_SELECT
end

function M:get_save_resolution()
  if not self:get_is_windos() then
    return
  end
  return LocalStorage:load_table(WINDOS_SUPPORT_RESOLUTION_KEY, false)
end

function M:set_save_resolution(width, height, mode)
  if not self:get_is_windos() then
    return
  end
  local save_table = {
    width = width,
    height = height,
    mode = mode
  }
  LocalStorage:save_table(WINDOS_SUPPORT_RESOLUTION_KEY, save_table, false)
end

function M:set_cur_resolution()
  if not self:get_is_windos() then
    return
  end
  if self.v_windos_support_resolution == nil or nil == next(self.v_windos_support_resolution) then
    CS.Game.WindowsResolutionChangger.SetDefaultResolution()
    return
  end
  local save_table = self:get_save_resolution()
  if save_table then
    CS.Game.WindowsResolutionChangger.SetResolutionByLua(save_table.width, save_table.height, save_table.mode)
  else
    CS.Game.WindowsResolutionChangger.SetDefaultResolution()
  end
end

function M:set_resolution_by_windowssetting(width, height, mode)
  self:set_save_resolution(width, height, mode)
  self:set_cur_resolution()
  ScreenMgr:set_graphic_resolution_for_pc(width, height)
end

function M:get_resolution_by_windowssetting()
  return self.v_windos_support_resolution
end

function M:set_optimize_particle_system_sorting(enable)
end

return M
