local M = Util.create_class()
local floor = math.floor
local CSShadow = CS.Game.Shadow
local TypeMeshRenderer = typeof(UnityEngine.MeshRenderer)
local UnitySkinnedMeshRenderer = typeof(UnityEngine.SkinnedMeshRenderer)
local Math = require("base.mathx")
local CUSTOM_ROLE_LIGHT = "_CUSTOM_ROLE_LIGHT"
local CSAddMaterial = CS.Game.AddMaterial
local CSUnityMaterial = UnityEngine.Material
local CSResLoader = CS.ResLoader
local UnityRenderTexture = UnityEngine.RenderTexture
local UnityCamera = UnityEngine.Camera
local UnityRawImage = UnityEngine.UI.RawImage
local TypeModelRtView = typeof(CS.ModelRtView)
local CSGameMgr = CS.Game.GameMgr
local Timer = Global.timer
local UnityQualitySetting = UnityEngine.QualitySettings
local CriAtomSource = CS.CriWare.CriAtomSource
local TypeCriAtomSource = typeof(CriAtomSource)
local CSChangeLayer = CSHelper.ChangeLayerRecursively
local UnityShader = UnityEngine.Shader
local UnityColor = UnityEngine.Color
local SHADERID_CHARACTER_LIGHT_OFFSET = "_CharacterLightOffset"
local SHADERID_CHARACTER_LIGHT_POS = "_MainSceneLightPos"
local MAIN_SCENE_LIGHTON = UnityShader.PropertyToID("_MainSceneLightOn")
local MAIN_SCENE_SHOW_ATTEN = UnityShader.PropertyToID("_MAIN_SCENE_SHOW_ATTEN")
local MAIN_SCENE_SHOW_ID = UnityShader.PropertyToID("_MAIN_SCENE_SHOW")
local EDGE_LIGHT_MODE = UnityShader.PropertyToID("_EDGE_LIGHT_MODE")
local MAIN_SCENE_GRADIENT = UnityShader.PropertyToID("_MainSceneGradientBaseGlobal")
local LightColor = UnityColor(1, 1, 1, 1)
local AmbientColor = UnityColor(1, 1, 1, 1)
local LightIntensity = 1
local LightDirX = 30
local LightDirY = -30
local OutlineShaderLOD = 100
local OutlineShaderMaxLOD = 500
local CSUnityEngine = UnityEngine
local Gyro = CSUnityEngine.Input.gyro
local TypeCharacterUtil = typeof(CS.Game.CharacterUtil)
local TypeDynamicBoneController = typeof(CS.Game.DynamicBoneController)
local _slower = string.lower
local _ssub = string.sub
local _tonumber = tonumber
local Layer = require("utils.layer")
local ResPool = Global.res_pool_mgr
local ACT_DEFINE = Config.ACT_DEFINE
local MAX_MODEL_VIEW_COUNT = 20
local content_update_speed = 0.09
local COUNT = 0
local _lerp = require("base.mathx").lerp_number
local _abs = math.abs
local SCENE_EFFECT_NAME = "SceneEffect"
local ANTIALIASING = 0
local bird_id = 10010011
local BG_LIST = {
  MainBg = "MainBg",
  FashionBg = "FashionBg",
  CharacterBg = "CharacterBg",
  CharacterEnterBg = "CharacterEnterBg",
  TeamBg = "TeamBg",
  SelectHeroBg = "SelectHeroBg",
  EnemyInfoBg = "EnemyInfoBg",
  BossChallengeBg = "BossChallengeBg"
}
local SceneIlluminationInfo = CS.SceneIlluminationInfo
local SceneIllumination = CS.SceneIllumination
local NormalDistZ = 0.61
local ShortDistZ = 0.2
local USE_GYRO_NUM = 0
local Char_Helper = require("uimodule.character.char_helper")
local ColorPropID = UnityShader.PropertyToID("_AlbedoColor")
local Color = require("base.color")

function M:_init(bg_name, need_shadow, callback, play_idle_anim, use_gyro, fixed_rt_name)
  self.v_npc_load_list = {}
  self.v_npc_loaded_map = {}
  self.v_npc_delete_list = {}
  self.v_npc_lie_timer = {}
  self.v_content_rot_y = 0
  self.v_use_gyro = use_gyro
  if use_gyro then
    USE_GYRO_NUM = USE_GYRO_NUM + 1
  end
  self.v_play_idle_anim = play_idle_anim
  self.v_is_visible = true
  local res_name = fixed_rt_name or "UIModelRtView2"
  local path = CSResLoader.GetFullPath(res_name)
  self.v_model_root = ResMgr:load_gameobj(path, nil, true)
  if callback then
    callback()
  end
  local trans = self.v_model_root.transform
  self.v_cid = self.v_model_root:GetInstanceID()
  trans:SetParent(Global.ui_mgr:get_wcanvas_transform(), false)
  trans:SetPositionA(0, 0, 0)
  self.v_content_root = Util.get_child_gameobj("ContentRoot", self.v_model_root)
  self.v_effect_root = Util.get_child_gameobj("EffectRoot", self.v_model_root)
  self.v_content_root_transform = self.v_content_root.transform
  self.v_camera_root = Util.get_child_gameobj("CameraRoot", self.v_model_root)
  self.v_camera_root_transform = self.v_camera_root.transform
  self.v_canvas_root = Util.get_child_gameobj("CameraRoot/Canvas", self.v_model_root)
  self.v_camera = Util.get_component("CameraRoot", self.v_model_root, UnityCamera)
  self.v_init_layer = self.v_camera.cullingMask
  self.v_camera_transform = self.v_camera.transform
  CSShadow.Init()
  CSShadow.ShadowLayer = Layer.LayerMask.Character
  CSShadow.RenderOrder = 0
  self.v_need_shadow = need_shadow
  self:refresh_light_info()
  self:set_bg(bg_name)
  self:register_event()
  CSGameMgr.SetCameraObj(self.v_camera_root.gameObject)
  SceneIlluminationInfo.Apply(self.v_light_info)
  self.v_bloom_target = nil
  self.v_bloom_current = nil
  Global.render_mgr:set_post_process_param(ShareRes.get_post_process_cfg_by_ui_name(UIMgr:get_cur_show_ui_name()))
  CSShadow.RenderShadowMap(trans, true, 1, true, 3)
end

function M:refresh_light_info()
  local obj = UnityFind(SCENE_EFFECT_NAME) or ResMgr:load_gameobj(Path.get_res_path(SCENE_EFFECT_NAME))
  obj.name = SCENE_EFFECT_NAME
  local info = obj:GetComponent(typeof(SceneIllumination))
  self.v_light_info = info.IlluminationInfo
end

function M:set_post_process_bloom_param(threshold, filterScaler, isFast)
  if isFast then
    Global.render_mgr:set_post_process_bloom_param(threshold, filterScaler)
    return
  end
  self.v_bloom_duration = 1
  if not self.v_bloom_current then
    local cur_post_process_cfg = ShareRes.get_post_process_cfg_by_ui_name(UIMgr:get_cur_show_ui_name())
    self.v_bloom_current = {
      threshold = cur_post_process_cfg.Threshold,
      filterScaler = cur_post_process_cfg.FilterScaler
    }
  end
  self.v_bloom_target = {threshold = threshold, filterScaler = filterScaler}
end

function M:bloom_update()
  if not self.v_bloom_target then
    return
  end
  self.v_bloom_duration = self.v_bloom_duration - Global.delta_time * 0.5
  if self.v_bloom_duration < 0 then
    if self.v_bloom_target.threshold then
      self.v_bloom_current.threshold = self.v_bloom_target.threshold
    end
    if self.v_bloom_target.filterScaler then
      self.v_bloom_current.filterScaler = self.v_bloom_target.filterScaler
    end
    self.v_bloom_target = nil
    return
  end
  local cur_threshold, cur_filterScaler = self.v_bloom_current.threshold, self.v_bloom_current.filterScaler
  if self.v_bloom_target.threshold then
    cur_threshold = Math.lerp_number(self.v_bloom_target.threshold, self.v_bloom_current.threshold, self.v_bloom_duration)
  end
  if self.v_bloom_target.filterScaler then
    cur_filterScaler = Math.lerp_number(self.v_bloom_target.filterScaler, self.v_bloom_current.filterScaler, self.v_bloom_duration)
  end
  Global.render_mgr:set_post_process_bloom_param(cur_threshold, cur_filterScaler)
end

function M:get_camera()
  return self.v_camera
end

function M:set_bg(bg_name)
  if bg_name then
    self.v_canvas_root:SetActive(true)
    for _, now_bg_name in pairs(BG_LIST) do
      local is_now_bg = bg_name == now_bg_name
      local bg_obj = Util.get_child_gameobj(now_bg_name, self.v_canvas_root)
      if bg_obj then
        bg_obj:SetActive(is_now_bg)
        if is_now_bg then
          self.v_bg_go = bg_obj
          local trans = Util.get_rect_transform(nil, self.v_bg_go)
          self.v_bg_x = trans.anchoredPosition.x
          self.v_bg_y = trans.anchoredPosition.y
          self.v_bg_target_y = trans.anchoredPosition.y
          self.v_bg_target_x = trans.anchoredPosition.x
        end
      end
    end
  end
end

function M:register_event()
  Util.bind_msg(self, Const.MSG_ON_WEAPON_LOADED, self._on_weapon_loaded, self)
  Util.bind_msg(self, Const.MSG_ON_SET_LIGHT_INFO, self._set_light_info, self)
  Util.bind_msg(self, Const.MSG_ON_SHOW_UI, self.mat_set_ui_on_show, self)
  Util.bind_msg(self, Const.MSG_ON_HIDE_UI, self.mat_set_ui_on_hide, self)
  Util.bind_msg(self, Const.MSG_ON_LIGHT_DATA_INDEX_UPDATE, self.refresh_light_info, self)
  Util.bind_msg(self, Const.MSG_ON_LIGHT_DATA_INDEX_UPDATE, self.set_model_color_msg, self)
end

function M:update()
  if not self.v_is_visible then
    return
  end
  local list = self.v_npc_loaded_map
  for _, npc in pairs(list) do
    npc.act_ctrl:update()
  end
  local custom_rot = 0
  local custom_height = 0
  for _, npc in pairs(list) do
    local trans = npc.transform
    local _, angle_y = trans:GetEulerAnglesA3()
    self:update_light(angle_y)
    local npc_id = npc.character_cfg.NpcId
    local shadow_cfg = ShareRes.get_role_shadow_cfg(npc.model_cfg.ModelId)
    if ShareRes.get_grandshadow_cfg(npc.model_cfg.ModelId) then
      custom_rot, custom_height = ShareRes.get_grandshadow_cfg(npc.model_cfg.ModelId)
    end
    CSShadow.RenderShadowMap(trans, true, 1, false, 0, custom_rot, custom_height)
    if shadow_cfg then
      if shadow_cfg.FollowFace then
        if self.v_face_shadow_npc_id ~= npc_id then
          local follow_node
          follow_node = follow_node or Util.get_child_gameobj("lod0/" .. shadow_cfg.FollowFace .. "_lod0", trans)
          follow_node = follow_node or Util.get_child_gameobj(shadow_cfg.FollowFace, trans)
          if nil ~= follow_node then
            local follow_node_mesh = follow_node:GetComponent(UnitySkinnedMeshRenderer)
            self.v_face_shadow_follow = follow_node_mesh.rootBone
          else
            self.v_face_shadow_follow = nil
          end
          self.v_face_shadow_npc_id = npc_id
        end
        CSShadow.RenderShadowMap2(trans, true, 1, true, shadow_cfg.CameraHeight, shadow_cfg.LookAtHeight, self.v_face_shadow_follow)
      else
        CSShadow.RenderShadowMap2(trans, true, 1, true, shadow_cfg.CameraHeight, shadow_cfg.LookAtHeight)
      end
    else
      CSShadow.RenderShadowMap2(trans, true)
    end
  end
  if self.v_load_test_model then
    local trans = self.v_load_test_model.transform
    local _, angle_y = trans:GetEulerAnglesA3()
    self:update_light(angle_y)
    CSShadow.RenderShadowMap(trans, true)
    local npc_id = _tonumber(_ssub(self.v_load_test_model.name, 2, -8))
    local npc_modelId = _ssub(self.v_load_test_model.name, 1, -8)
    local shadow_cfg = ShareRes.get_role_shadow_cfg(npc_modelId)
    if shadow_cfg then
      CSShadow.RenderShadowMap2(trans, true, 1, true, shadow_cfg.CameraHeight, shadow_cfg.LookAtHeight)
    else
      CSShadow.RenderShadowMap2(trans, true)
    end
    self:set_all_character_mat(self.v_load_test_model, true)
    UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ATTEN, 0)
  end
  if self.v_cur_npc_luaobj then
    self.v_cur_npc_luaobj.act_effect_ctrl:low_update()
  end
  self:content_update()
end

function M:click_model(msg)
  if nil == msg then
    return
  end
end

function M:load_test_model(model_id)
  self:release_test_model_info()
  self.v_content_root_transform:ResetAttr()
  ResPool:get_model_async(model_id, function(gameobj)
    local trans = gameobj.transform
    CSChangeLayer(trans, Layer.Layer.Character)
    trans:SetParent(self.v_content_root_transform)
    trans:ResetAttr()
    trans:SetEulerY(180)
    self.v_load_test_model = gameobj
    self.v_test_add_material = CSAddMaterial.Bind(gameobj.gameObject)
    self:enable_effect()
    self:set_trans_mat(trans)
    self:set_all_character_mat(gameobj, true)
    CSHelper.ForceLODGroup(trans, 0)
  end)
end

function M:enable_effect()
  local mat = ResMgr:load_res(Path.get_res_path("ShadowCaster.mat"), CSUnityMaterial)
  if not mat then
    return
  end
  self.v_test_add_material.Enable = true
  self.v_test_mat = mat
  local FILTERATE_EYE = "eye"
  local FILTERATE_FACE = "face"
  self.v_test_add_material:ClearFilterate()
  self.v_test_add_material:Filterate(FILTERATE_EYE, mat)
  self.v_test_add_material:Filterate(FILTERATE_FACE, mat)
  self.v_test_add_material:AddMat(mat)
end

function M:release_test_model_info()
  if self.v_load_test_model then
    self.v_load_test_model.transform:SetKeyWordAll("_SHADOW_RECEIVE", false)
    self:set_all_character_mat(self.v_load_test_model, false)
    ResMgr:destroy_gameobj(self.v_load_test_model)
    self.v_load_test_model = nil
  end
  if self.v_test_add_material then
    self.v_test_add_material:RemoveAll()
  end
  if self.v_test_mat then
    ResMgr:unload_res(Path.get_res_path("ShadowCaster.mat"))
    self.v_test_mat = nil
  end
end

function M:load_npc(params)
  local model_id = params.model_id
  local npc_id = params.npc_id
  local is_reload = params.is_reload
  local npc_param = params.npc_param
  local hide_weapon = params.hide_weapon
  local cb = params.cb
  local team_pos = params.team_pos
  local fixed_id = params.fixed_id
  local do_preload_attach_model = params.do_preload_attach_model
  local use_weapon_id = params.use_weapon_id
  local init_anim = params.init_anim
  if is_reload then
    self:remove_all_npc()
  end
  self.v_model_id = model_id
  self.v_is_child = "H1001007" == model_id
  local count = COUNT
  local npc = require("obj.hero"):new()
  npc:set_is_ui_hero()
  if team_pos then
    npc:set_team_pos(team_pos)
  end
  local character_cfg = ShareRes.get_character_cfg(npc_id)
  npc.character_cfg = character_cfg
  local model_cfg = ShareRes.create("character.character_model", model_id .. "_UI")
  model_cfg = model_cfg or ShareRes.create("character.character_model", model_id)
  if not model_cfg then
    Log.Error("获取模型配置失败, model_id:", model_id)
    return
  end
  npc.model_cfg = model_cfg
  local npc_info = {
    index = count + 1,
    npc = npc,
    init_param = npc_param
  }
  COUNT = (COUNT + 1) % 100
  local idx = npc_info.index
  npc.cid = self.v_cid
  npc.effect_owner = self.v_model_root
  self.v_npc_load_list[npc_info.index] = npc_info
  self.v_is_loading = true
  self:load_model_animator(npc, npc_info, params)
  return idx
end

function M:load_model_animator(npc, npc_info, params)
  npc:before_load_gameobj()
  ResPool:get_animator_async(npc.model_cfg.ControllerPath, function(_, animator_info)
    if not (not npc:is_destroy() and self.v_npc_load_list[npc_info.index]) or self.v_npc_delete_list[npc_info.index] then
      ResPool:release_res(animator_info)
      return
    end
    npc.runtime_animator = animator_info.res
    npc.animator_info = animator_info
    self:load_gameobj_async(npc, npc_info, params)
  end)
end

function M:set_trans_mat(trans)
  Util.set_all_mat(trans, function(mat)
    local name = _slower(mat.name)
    local not_need_shadow = string.match(name, "eye")
    mat:SetKeyword("_SHADOW_RECEIVE", not not_need_shadow)
  end)
end

function M:set_all_character_mat(gameobj, enable)
  if Util.is_nil(gameobj) then
    return
  end
  self.v_gameobj = gameobj
  local character_util = gameobj:TryAddComponent(TypeCharacterUtil)
  character_util:ChangeAllCharacterMat(enable)
end

function M:set_dynamic_bone_enable(gameobj, enable)
  if Util.is_nil(gameobj) then
    return
  end
  local dynamic_bone_controller = gameobj:TryAddComponent(TypeDynamicBoneController)
  if enable then
    dynamic_bone_controller:RestoreOriginalBlendWeights()
  else
    dynamic_bone_controller:SetBlendWeightZero()
  end
end

function M:load_gameobj_async(npc, npc_info, params)
  local hide_weapon = params.hide_weapon
  local cb = params.cb
  local fixed_id = params.fixed_id
  local do_preload_attach_model = params.do_preload_attach_model
  local use_weapon_id = params.use_weapon_id
  local use_weapon_res = params.use_weapon_res
  local ignore_fashion = params.ignore_fashion
  local init_anim = params.init_anim
  local init_anim_cb = params.init_anim_cb
  local is_loop = params.is_loop
  npc.is_journey_event = params.is_journey_event
  local model_id = npc.model_cfg.ModelPath
  ResPool:get_model_async(model_id, function(gameobj)
    gameobj:SetActive(false)
    local npc_info = self.v_npc_load_list[npc_info.index]
    if not (not npc:is_destroy() and npc_info) or self.v_npc_delete_list[npc_info.index] then
      ResPool:release(gameobj)
      if npc.animator_info then
        ResPool:release_res(npc.animator_info)
      end
      return
    end
    local trans = gameobj.transform
    local _params = {
      hide_weapon = hide_weapon,
      fixed_char_id = fixed_id,
      use_attach_model = true,
      use_weapon_id = use_weapon_id,
      use_weapon_res = use_weapon_res,
      ignore_fashion = ignore_fashion,
      is_out_battle = true
    }
    npc:init_ui_model_gameobj(gameobj, trans, self.v_content_root.transform, _params)
    if gameobj.name == "H1001001_1(Clone)" then
      CSChangeLayer(trans, Layer.Layer.NPCCollider)
    end
    local init_param = npc_info.init_param
    local pos_x = 0
    local pos_y = 0
    local pos_z = 0
    local rot_x = 0
    local rot_y = 180
    local rot_z = 0
    if init_param then
      pos_x = init_param.pos_x or pos_x
      pos_y = init_param.pos_y or pos_y
      pos_z = init_param.pos_z or pos_z
      rot_x = init_param.rot_x or rot_x
      rot_y = init_param.rot_y or rot_y
      rot_z = init_param.rot_z or rot_z
    end
    local scale = npc.model_cfg.Scale_UI_Model or 1
    trans:SetLocalPositionA(pos_x, pos_y, pos_z)
    trans:SetLocalEuler(rot_x, rot_y, rot_z)
    trans:SetLocalScaleA(scale, scale, scale)
    npc.char_renderers:enable_effect(Config.CHAR_EFFECT.SHADOW, true)
    self:set_trans_mat(trans)
    self:set_all_character_mat(gameobj, true)
    self:set_dynamic_bone_enable(gameobj, false)
    if self.v_is_set_light then
      npc.char_renderers:enable_effect(Config.CHAR_EFFECT.PLANE_SHADOW, true)
    end
    self.v_cur_npc = gameobj
    self.v_cur_npc_luaobj = npc_info.npc
    self.v_is_enlarge = false
    self:on_loaded_npc(npc_info)
    self:remove_npc_lie_data(npc_info.index)
    self:add_lie_timer(npc_info)
    self.v_is_loading = false
    if self.v_scene_model_cfg and not self.v_look_at_camera then
      local model_rot = self.v_scene_model_cfg.ModelRotation
      trans:SetEuler(model_rot[1], model_rot[2], model_rot[3])
    end
    
    local function attach_model_loaded_cb()
      if self.v_is_show_effect then
        local effect_param = npc_info.npc.act_effect_ctrl.create_effect_param()
        effect_param.prefab_name = self.v_effect_name
        effect_param.parent = self.v_effect_root and self.v_effect_root.transform or self.v_content_root.transform
        self.v_show_effct_id = npc_info.npc.act_effect_ctrl:play_effect(effect_param)
        self.v_is_show_effect = false
      end
      gameobj:SetActive(true)
      local act_name = init_anim or ACT_DEFINE.UIMainIdle
      if npc.act_ctrl:can_npc_play_act(act_name) then
        local anim_cb_data
        if init_anim_cb then
          anim_cb_data = npc_info.index
        end
        Util.try_action(npc, act_name, 0, init_anim_cb, anim_cb_data, is_loop)
        self.v_init_anim = act_name
      end
      if cb then
        cb(npc_info.index)
      end
      local msg = MsgGame:mq_publish2(Const.MSG_ON_MODEL_VIEW_NPC_LOADED)
      msg.mm_x = npc.character_cfg.NpcId
      if self:get_is_signboard() then
        self:set_model_color(trans)
      end
    end
    
    if do_preload_attach_model then
      local approach_anim = CharacterMgr:get_hero_approach_anim_by_type(npc:get_npc_id(), 1)
      if approach_anim then
        npc:try_load_attach_model_by_act(approach_anim, attach_model_loaded_cb)
        return
      end
    end
    attach_model_loaded_cb()
  end)
end

function M:on_loaded_npc(npc_info)
  local index = npc_info.index
  self.v_npc_load_list[index] = nil
  self.v_npc_loaded_map[index] = npc_info.npc
  self:light_mat_set()
  self:point_light_mat_set()
end

function M:reset_init_anim(npc_index)
  local npc = self.v_npc_loaded_map[npc_index]
  if npc then
    Util.try_action(npc, self.v_init_anim, 0)
  end
end

function M:add_lie_timer(npc_info)
  local index = npc_info.index
  local npc = npc_info.npc
  local cfg = npc.character_cfg
  local npc_id = cfg.NpcId
  local lie_cfg = ShareRes.get_buddy_lie_cfg(npc_id)
  if lie_cfg then
    self.v_npc_lie_timer[index] = {cd = 0, lie_cfg = lie_cfg}
  end
end

function M:_on_weapon_loaded(msg)
  local tbl = msg.mm_obj
  local weapon = msg.mm_x
  for _, npc in pairs(self.v_npc_loaded_map) do
    if npc == tbl then
      if self.v_is_set_light then
        npc.char_renderers:update_effect()
      end
      break
    end
  end
  self:reset_weapon_local_pos(weapon.go, weapon.res_id)
  self:light_mat_set()
  self:point_light_mat_set()
end

function M:remove_all_npc()
  self.v_npc_load_list = {}
  for _, v in pairs(self.v_npc_loaded_map) do
    self:remove_npc(v)
  end
  self.v_npc_loaded_map = {}
end

function M:remove_npc_by_index(model_idx)
  if self.v_npc_load_list[model_idx] then
    self.v_npc_delete_list[model_idx] = true
    return
  end
  local npc = self.v_npc_loaded_map[model_idx]
  self:remove_npc_lie_data(model_idx)
  self:remove_npc(npc)
  self.v_npc_loaded_map[model_idx] = nil
end

function M:remove_npc(npc)
  if not npc then
    return
  end
  npc.act_ctrl:stop_action_sound()
  if npc.animator_info then
    ResPool:release_res(npc.animator_info)
  end
  local gameobj = npc.gameobj
  self:set_all_character_mat(gameobj, false)
  gameobj.transform:SetKeyWordAll("_SHADOW_RECEIVE", false)
  npc:on_destroy_luaobj()
  npc:on_destroy_gameobj()
  if npc == self.v_cur_npc_luaobj then
    self.v_cur_npc_luaobj = nil
  end
  ResPool:release(gameobj)
end

function M:remove_npc_lie_data(index)
  self.v_npc_lie_timer[index] = nil
end

function M:get_model_root()
  if not Util.is_nil(self.v_model_root) then
    return self.v_model_root.transform
  end
end

function M:on_destroy()
  if self.v_hide_node_go_list then
    for key, go in pairs(self.v_hide_node_go_list) do
      if not go:IsNull() then
        go:SetActive(true)
      end
    end
  end
  self.v_hide_node_go_list = {}
  if self.v_model_root then
    ResMgr:destroy_gameobj(self.v_model_root)
    self.v_model_root = nil
  end
  self:release_test_model_info()
  self:remove_all_npc()
  self.v_cur_npc_luaobj = nil
  self.v_npc_delete_list = {}
  Util.unbind_all_msg(self)
  local info = SceneIllumination:GetInfo()
  if info then
    SceneIlluminationInfo.ApplyCharacterLightDir(info.GlobalCharacterLightDir)
    SceneIlluminationInfo.ApplyCharacterLightColor(info.GlobalCharacterLightColor, info.GlobalCharacterLightIntensity)
    local env_char_ambient_id = UnityShader.PropertyToID("_EnvCharacterAmbientColor")
    UnityShader.SetGlobalColor(env_char_ambient_id, info.GlobalCharacterAmbientColor)
  end
  self.v_bg_go = nil
  self.v_job_bg = nil
  if self.v_use_gyro then
    USE_GYRO_NUM = USE_GYRO_NUM - 1
    if 0 == USE_GYRO_NUM then
      Gyro.enabled = false
    end
  end
  CSShadow.CloseRenderShadowMap2()
  if self.v_mat_tween then
    for _, mat_sequence in pairs(self.v_mat_tween) do
      mat_sequence:Kill(false)
    end
    self.v_mat_tween = nil
  end
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ATTEN, 0)
  self.v_light_info = nil
end

function M:set_gyro_pause(is_pause)
  self.v_gyro_pause = is_pause
end

function M:set_visible(is_on)
  self.v_is_visible = is_on
  self.v_content_root:SetActive(is_on)
  self.v_camera_root:SetActive(is_on)
  if is_on then
    CSGameMgr.SetCameraObj(self.v_camera_root.gameObject)
    Global.render_mgr:set_post_process_param(ShareRes.get_post_process_cfg_by_ui_name(UIMgr:get_cur_show_ui_name()))
    self:reset_camera_culling_mask()
    if TaskMgr then
      TaskMgr:play_mascot_idle_anim()
    end
  end
  if is_on and self.v_gameobj then
    self:set_all_character_mat(self.v_gameobj, true)
    if self:get_is_signboard() then
      MsgGame:mq_publish2(Const.MSG_ON_LIGHT_DATA_INDEX_UPDATE)
    end
  end
  if not is_on and self.v_mat_tween then
    for _, mat_sequence in pairs(self.v_mat_tween) do
      mat_sequence:Kill(false)
    end
    self.v_mat_tween = nil
  end
end

function M:set_camera_culling_mask_zero()
  self.v_is_visible = false
  self:stop_change_space_time_effect()
  self.v_content_root:SetActive(false)
  if not Util.is_nil(self.v_camera) then
    self.v_camera.cullingMask = 0
    self.v_camera.transform:SetActive(false)
  end
end

function M:reset_camera_culling_mask()
  if not Util.is_nil(self.v_camera) then
    self.v_camera.cullingMask = self.v_init_layer
    self.v_camera.transform:SetActive(true)
  end
end

function M:is_play_show_effect(is_show, effect_name)
  if self.v_show_effct_id and self.v_cur_npc_luaobj then
    self.v_cur_npc_luaobj.act_effect_ctrl:stop_effect(self.v_show_effct_id)
  end
  self.v_is_show_effect = is_show
  self.v_effect_name = effect_name
end

function M:set_content_pos(param)
  local trans = self.v_content_root.transform
  local local_pos = trans.localPosition
  local euler = trans:GetEulerAnglesA()
  local pos_x = param.pos_x or local_pos.x
  local pos_y = param.pos_y or local_pos.y
  local pos_z = param.pos_z or local_pos.z
  local rot_x = param.rot_x or euler.x
  local rot_y = param.rot_y or euler.y
  local rot_z = param.rot_z or euler.z
  trans:SetLocalPositionA(pos_x, pos_y, pos_z)
  trans:SetEuler(rot_x, rot_y, rot_z)
end

function M:set_camera_y(value)
  local trans = self.v_camera_root.transform
  local x = trans.localPosition.x
  local z = trans.localPosition.z
  trans:SetLocalPositionA(x, value, z)
end

function M:change_content_angle_y(change_val)
  self.v_content_rot_y = self.v_content_rot_y - change_val
end

function M:change_content_pos_y(change_val)
  local trans = self.v_content_root.transform
  local x = trans.position.x
  local z = trans.position.z
  self.v_content_root.transform:SetLocalPositionA(x, change_val, z)
end

function M:change_effect_root_pos_y(change_val)
  if not self.v_effect_root then
    return
  end
  local trans = self.v_effect_root.transform
  local x = trans.position.x
  local z = trans.position.z
  self.v_effect_root.transform:SetLocalPositionA(x, change_val, z)
end

function M:content_update()
  local temp = self.v_content_rot_y
  self.v_content_rot_y = Math.lerp_number(self.v_content_rot_y, 0, content_update_speed)
  self.v_content_root_transform:Rotate(0, temp - self.v_content_rot_y, 0)
end

function M:update_light(char_dir)
  char_dir = (char_dir - 180) % 360
  self.v_tar_light_dir = 0
  if char_dir > 30 and char_dir < 150 then
    self.v_tar_light_dir = 10
  elseif char_dir > 210 and char_dir < 315 then
    self.v_tar_light_dir = -10
  end
  local dir = self.v_light_info.GlobalCharacterLightDir
  if _abs(self.v_tar_light_dir - dir) > 175 then
    dir = self.v_tar_light_dir
  end
  self.v_light_info.GlobalCharacterLightDir = _lerp(dir, self.v_tar_light_dir, 0.01)
  SceneIlluminationInfo.Apply(self.v_light_info)
end

function M:_set_light_info(msg)
  if msg and self.v_light_info then
    self.v_light_info.GlobalCharacterLightDir = msg.mm_x
    SceneIlluminationInfo.Apply(self.v_light_info)
  end
end

function M:set_light_dir(x, y, z, w)
  self.v_is_set_light = true
  SceneIlluminationInfo.ApplyCharacterLightDir(LightDirY, LightDirX)
  SceneIlluminationInfo.ApplyCharacterLightColor(LightColor, LightIntensity)
  local plane_shadow_id = UnityShader.PropertyToID("_PlaneShadowLightDir")
  local env_char_ambient_id = UnityShader.PropertyToID("_EnvCharacterAmbientColor")
  CompExtensions.SetShaderGlobalVector(plane_shadow_id, x, y, z, w)
  CompExtensions.SetShaderGlobalVector(env_char_ambient_id, AmbientColor)
end

function M:set_camera_param(camera_param)
  local trans = self.v_camera.transform
  trans:SetLocalPositionA(camera_param.pos_x, camera_param.pos_y, camera_param.pos_z)
  trans:SetEuler(camera_param.rot_x, camera_param.rot_y, camera_param.rot_z)
end

function M:hide_model_node(is_hide_weapon)
  if not self.v_cur_npc_luaobj or self.v_cur_npc_luaobj.character_cfg.NpcId ~= 1001015 then
    if self.v_hide_node_go_list and is_hide_weapon then
      for _, go in pairs(self.v_hide_node_go_list) do
        if not go:IsNull() then
          go:SetActive(true)
        end
      end
    end
    return
  end
  local body_node_list = {}
  local weapon_node_list = {}
  if is_hide_weapon then
    body_node_list = {
      "lod0/body5_lod0",
      "lod0/body6_lod0"
    }
  else
    body_node_list = {
      "lod0/body5_lod0"
    }
  end
  self.v_hide_node_go_list = {}
  for key, body_node_name in pairs(body_node_list) do
    local body_node = Util.get_child_gameobj(body_node_name, self.v_cur_npc.transform)
    if body_node then
      body_node:SetActive(false)
      table.insert(self.v_hide_node_go_list, body_node)
    end
  end
end

function M:hide_weapon_node(go, res_id)
  if string.find(go.name, "H1001015_Weapon") then
    local animator = go:GetComponent(TypeUnityAnimator)
    animator.enabled = false
    go:ResetAttr()
  else
    return
  end
  if not self.v_hide_node_go_list then
    self.v_hide_node_go_list = {}
  end
  local weapon_node_list = {
    "H1001015_Weapon_3"
  }
  local weapon_go = go
  for index, weapon_node_name in pairs(weapon_node_list) do
    local weapon_node = Util.get_child_gameobj(weapon_node_name, weapon_go.transform)
    if weapon_node then
      weapon_node:SetActive(false)
      table.insert(self.v_hide_node_go_list, weapon_node)
    end
  end
end

function M:change_weapon_by_res(weapon_res)
  if self.v_cur_npc_luaobj then
    self.v_cur_npc_luaobj.weapon_mgr:change_weapon_by_res(weapon_res, true)
  end
end

function M:get_current_weapon_res()
  if self.v_cur_npc_luaobj then
    return self.v_cur_npc_luaobj.weapon_mgr:get_current_weapon_res()
  end
end

function M:reset_weapon_local_pos(go, res_id)
  if string.find(go.name, "H1001004_Weapon") then
    local animator = go:GetComponent(TypeUnityAnimator)
    animator.enabled = false
    go:ResetAttr()
  else
    return
  end
end

function M:is_visible()
  return self.v_is_visible
end

function M:get_npc_head_trans(model_idx)
  local npc = self.v_npc_loaded_map[model_idx]
  if not npc then
    return
  end
  return npc.v_head_bone
end

function M:get_npc_head_trans_with_npc_id(npc_id)
  local npc = self:get_npc_with_npc_id(npc_id)
  if not npc then
    return
  end
  return npc.v_head_bone
end

function M:get_npc_head_trans_with_npc_index(index)
  local npc = self.v_npc_loaded_map[index]
  if not npc then
    return
  end
  return npc.v_head_bone
end

function M:get_npc_with_npc_id(npc_id)
  for idx, npc in pairs(self.v_npc_loaded_map) do
    if npc:get_npc_id() == npc_id then
      return npc
    end
  end
  return nil
end

function M:get_npc_index_with_npc_id(npc_id)
  for idx, npc in pairs(self.v_npc_loaded_map) do
    if npc:get_npc_id() == npc_id then
      return idx
    end
  end
  return nil
end

function M:get_npc_index_with_npc_id_and_active_state(npc_id)
  for idx, npc in pairs(self.v_npc_loaded_map) do
    if npc:get_npc_id() == npc_id and npc:get_gameobj().activeSelf == true and true == self.v_content_root.activeSelf then
      return idx
    end
  end
  return nil
end

function M:get_npc_info_with_obj(obj)
  local obj_instance_id = obj:GetInstanceID()
  for index, npc in pairs(self.v_npc_loaded_map) do
    local npc_instance_id = npc:get_gameobj():GetInstanceID()
    if obj_instance_id == npc_instance_id then
      return index, npc
    end
  end
  return nil
end

function M:hide_other_model(npc_id, is_click_board)
  for idx, npc in pairs(self.v_npc_loaded_map) do
    if npc then
      if npc_id ~= npc:get_npc_id() then
        npc:get_gameobj():SetActive(false)
      elseif is_click_board and npc.is_journey_event then
        npc:get_gameobj():SetActive(false)
      end
    end
  end
end

function M:set_model_visible_with_index(model_index, visible)
  local npc = self.v_npc_loaded_map[model_index]
  if not npc then
    return
  end
  npc:get_gameobj():SetActive(visible)
end

function M:get_model_with_index(model_index)
  return self.v_npc_loaded_map[model_index]
end

function M:show_other_model(npc_id)
  for idx, npc in pairs(self.v_npc_loaded_map) do
    if npc and (npc_id ~= npc:get_npc_id() or npc.is_journey_event) then
      npc:get_gameobj():SetActive(true)
      self:play_ui_main_idle_anim(npc)
    end
  end
end

function M:set_model_visible(visible)
  for idx, npc in pairs(self.v_npc_loaded_map) do
    if npc then
      npc:get_gameobj():SetActive(visible)
    end
  end
end

function M:play_ui_main_idle_anim(npc)
  if npc:get_npc_id() == bird_id then
    return
  end
  if self.play_anim then
    local model_index = self:get_model_index(npc:get_npc_id())
    self:play_anim(ACT_DEFINE.UIMainIdle, model_index, nil, true)
  end
end

function M:delete_model(npc_id)
  local need_remove_index = self:get_model_index(npc_id)
  if need_remove_index and need_remove_index > 0 then
    self:remove_npc_by_index(need_remove_index)
  end
end

function M:refresh_model_pos(npc_id, model_pos)
  local npc = self:get_npc_with_npc_id(npc_id)
  if not npc then
    return
  end
  npc:set_pos(model_pos[1], model_pos[2], model_pos[3])
end

function M:get_npc_loaded_map()
  return self.v_npc_loaded_map
end

function M:get_model_index(npc_id)
  local index
  for idx, npc in pairs(self.v_npc_loaded_map) do
    if npc:get_npc_id() == npc_id then
      index = idx
      break
    end
  end
  return index
end

function M:get_npc_obj_with_npc_id(npc_id)
  for idx, npc in pairs(self.v_npc_loaded_map) do
    if npc and npc_id == npc:get_npc_id() then
      return npc:get_gameobj()
    end
  end
  return nil
end

function M:get_board_model_index()
  local board_npc_id = PlayerMgr:get_signboard_girl_id()
  return self:get_model_index(board_npc_id)
end

function M:show_char_advance_bg(is_show)
  if not self.v_bg_go then
    return
  end
  if not self.v_advance_bg then
    self.v_advance_bg = Util.get_image("AdvanceBg", self.v_bg_go)
  end
  self.v_advance_bg.gameObject:SetActive(is_show)
end

function M:show_char_job_bg(is_show, buddy_id)
  if not self.v_bg_go then
    return
  end
  if not self.v_job_bg then
    self.v_job_bg = Util.get_image("JobBg", self.v_bg_go)
  end
  if buddy_id and is_show then
    local job_icon_texture = Char_Helper.get_char_job_icon(buddy_id, true)
    ResMgr:load_set_icon(self.v_job_bg, job_icon_texture, nil, true)
  end
  self.v_job_bg.gameObject:SetActive(is_show)
end

function M:show_char_weapon_bg(is_show)
  if not self.v_bg_go then
    return
  end
  if not self.v_weapon_bg then
    self.v_weapon_bg = Util.get_child_gameobj("ShowWeapon_Bg", self.v_bg_go)
  end
  self.v_weapon_bg:SetActive(is_show)
end

function M:mat_set_ui_on_show()
  local cur_ui_name = UIMgr:get_cur_show_ui_name()
  if self.v_cur_mat_set_ui == cur_ui_name then
    return
  end
  self:light_mat_set(cur_ui_name)
  self:point_light_mat_set(cur_ui_name)
  self.v_cur_mat_set_ui = UIMgr:get_cur_show_ui_name()
end

function M:mat_set_ui_on_hide()
  local cur_ui_name = UIMgr:get_cur_show_ui_name()
  if self.v_cur_mat_set_ui == cur_ui_name then
    return
  end
  self:light_mat_set(cur_ui_name)
  self:point_light_mat_set(cur_ui_name)
  self.v_cur_mat_set_ui = UIMgr:get_cur_show_ui_name()
end

function M:light_mat_set(ui_name)
  ui_name = ui_name or UIMgr:get_cur_show_ui_name()
  local npc_list = self.v_npc_loaded_map
  UnityShader.SetGlobalFloat(CUSTOM_ROLE_LIGHT, 1)
  for _, npc in pairs(npc_list) do
    local trans = npc.transform
    local npc_id = npc.character_cfg.NpcId
    local light_cfg = ShareRes.get_character_light_by_id(npc.model_cfg.ModelId)
    if light_cfg then
      local light_offset = light_cfg[ui_name]
      if light_offset then
        Util.set_all_mat(trans, function(mat)
          local Ind = light_offset[4]
          local x = light_offset[1] * Ind
          local y = light_offset[2] * Ind
          local z = light_offset[3] * Ind
          mat:SetMatVector(SHADERID_CHARACTER_LIGHT_OFFSET, x, y, z)
        end)
      end
    end
  end
end

function M:point_light_mat_set(ui_name, is_kb)
  if not self.v_is_visible then
    return
  end
  ui_name = ui_name or UIMgr:get_cur_show_ui_name()
  if "char_map" == ui_name then
    ui_name = "character"
  end
  self.v_cur_inui = ui_name
  if "uimain" == ui_name then
    UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ATTEN, 1)
    return
  end
  local npc_list = self.v_npc_loaded_map
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 0)
  UnityShader.SetGlobalFloat(MAIN_SCENE_GRADIENT, 0)
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ATTEN, 0)
  if self.v_mat_tween then
    for _, mat_sequence in pairs(self.v_mat_tween) do
      mat_sequence:Kill(false)
    end
    self.v_mat_tween = nil
  end
  CSShadow.SetShadowCamOffset(0, 0, 0, 0, 0, 0)
  self.v_mat_tween = {}
  for _, npc in pairs(npc_list) do
    local trans = npc.transform
    local npc_id = npc.character_cfg.NpcId
    local shadow_cfg
    if trans.gameObject.activeSelf then
      shadow_cfg = ShareRes.get_shadow_offset_cfg(npc.model_cfg.ModelId, ui_name)
      if shadow_cfg then
        local shadow_cam_offset = shadow_cfg.ShadowCamOffset
        local shadow_cam_taroffset = shadow_cfg.ShadowCamTarOffset
        CSShadow.SetShadowCamOffset(shadow_cam_offset[1], shadow_cam_offset[2], shadow_cam_offset[3], shadow_cam_taroffset[1], shadow_cam_taroffset[2], shadow_cam_taroffset[3])
      end
    end
    local light_cfg = ShareRes.get_character_edge_light_by_id(npc.model_cfg.ModelId)
    if light_cfg then
      local light_pos = light_cfg[ui_name]
      if light_pos then
        local spec_logic_light = self.v_pre_ui_name == "KB4" or self.v_pre_ui_name == "KB3"
        if "KB1" == ui_name then
          UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ATTEN, 1)
        end
        if "KB1" == ui_name and spec_logic_light and nil == shadow_cfg and self.v_pre_shadow then
          local function value_func_pos(value)
            UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ATTEN, value)
          end
          
          local mat_tween_pos = CSHelper.WrapTweenTo(0, 1, 2, value_func_pos)
          table.insert(self.v_mat_tween, mat_tween_pos)
        end
        self.v_pre_shadow = nil == shadow_cfg
        self.v_pre_ui_name = ui_name
        Util.set_all_mat(trans, function(mat)
          local mat_name = _slower(mat.name)
          local is_body = string.match(mat_name, "body(%d+)")
          local is_face = string.match(mat_name, "face") ~= nil
          local is_eye = nil ~= string.match(mat_name, "eye")
          local is_hair = nil ~= string.match(mat_name, "hair")
          local is_weapon = nil ~= string.match(mat_name, "weapon")
          local set_cfg
          if is_body then
            set_cfg = light_pos["body" .. is_body]
          elseif is_face then
            set_cfg = light_pos.face
          elseif is_eye then
            set_cfg = light_pos.eye
          elseif is_hair then
            set_cfg = light_pos.hair
          elseif is_weapon then
            set_cfg = light_pos.weapon
          end
          if not set_cfg or not next(set_cfg) then
            set_cfg = light_pos.defaultLightInfo
          end
          if set_cfg and next(set_cfg) then
            local char_pos = trans.position
            mat:SetMatVector(SHADERID_CHARACTER_LIGHT_POS, set_cfg[1] + char_pos.x, set_cfg[2] + char_pos.y, set_cfg[3] + char_pos.z, set_cfg[4])
            if is_kb then
              local function value_func(value)
                mat:SetFloat(MAIN_SCENE_LIGHTON, value)
                
                UnityShader.SetGlobalFloat(MAIN_SCENE_GRADIENT, 1 - value)
              end
              
              local mat_tween = CSHelper.WrapTweenTo(0, 1, 1.5, value_func)
              table.insert(self.v_mat_tween, mat_tween)
            else
              mat:SetFloat(MAIN_SCENE_LIGHTON, 1)
              
              local function value_func_pos(value)
                mat:SetMatVector(SHADERID_CHARACTER_LIGHT_POS, set_cfg[1] + trans.position.x, set_cfg[2] + trans.position.y, set_cfg[3] + trans.position.z, set_cfg[4])
              end
              
              local mat_tween_pos = CSHelper.WrapTweenTo(0, 1, 1.5, value_func_pos)
              table.insert(self.v_mat_tween, mat_tween_pos)
            end
            if light_pos.OpenDepthEdge and "team" ~= ui_name then
              mat:SetFloat(EDGE_LIGHT_MODE, 1)
            else
              mat:SetFloat(EDGE_LIGHT_MODE, 0)
            end
            UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 1)
          elseif is_kb then
            local function value_func(value)
              mat:SetFloat(MAIN_SCENE_LIGHTON, value)
              
              UnityShader.SetGlobalFloat(MAIN_SCENE_GRADIENT, 1 - value)
              if value < 0.1 then
                UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 0)
                UnityShader.SetGlobalFloat(MAIN_SCENE_GRADIENT, 0)
              end
            end
            
            local mat_tween = CSHelper.WrapTweenTo(1, 0, 1.5, value_func)
            table.insert(self.v_mat_tween, mat_tween)
            UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 1)
          else
            mat:SetFloat(MAIN_SCENE_LIGHTON, 0)
          end
        end)
      else
        Util.set_all_mat(trans, function(mat)
          mat:SetFloat(MAIN_SCENE_LIGHTON, 0)
        end)
      end
    end
  end
end

function M:play_change_space_time_effect()
  local effect = Util.get_child_gameobj("FX_glitch_screen_2", self.v_camera_root_transform.gameObject)
  if not Util.is_nil(effect) then
    effect:SetActive(false)
    effect:SetActive(true)
  end
end

function M:stop_change_space_time_effect()
  local effect = Util.get_child_gameobj("FX_glitch_screen_2", self.v_camera_root_transform.gameObject)
  if not Util.is_nil(effect) then
    effect:SetActive(false)
  end
end

function M:refresh_camera_root_visible(visible)
  self.v_camera_root:SetActive(visible)
end

function M:get_content_root_trans()
  return self.v_content_root_transform
end

function M:stop_all_model_sound()
  if not self.v_npc_loaded_map or not next(self.v_npc_loaded_map) then
    return
  end
  for _, npc in pairs(self.v_npc_loaded_map) do
    Global.sound_mgr:stop_sound_by_obj(npc:get_gameobj())
  end
end

function M:get_signboard_model_sound_source_modelview()
  if not self.v_npc_loaded_map or not next(self.v_npc_loaded_map) then
    return
  end
  local board_npc_id = PlayerMgr:get_signboard_girl_id()
  for _, npc in pairs(self.v_npc_loaded_map) do
    if npc:get_npc_id() == board_npc_id then
      local cri_atom_source = npc:get_gameobj():GetComponent(TypeCriAtomSource)
      if not Util.is_nil(cri_atom_source) then
        return cri_atom_source
      end
    end
  end
end

function M:get_is_signboard()
  return false
end

local TYPE_RD = typeof(UnityEngine.Renderer)

function M:set_all_mat_instance(set_trans, func)
  local rds = set_trans:GetComponentsInChildren(TYPE_RD, true)
  for i = 0, rds.Length - 1 do
    local mats = rds[i].materials
    local mat
    for j = 0, mats.Length - 1 do
      mat = mats[j]
      if mat and not mat:IsNull() then
        func(mat)
      end
    end
  end
end

function M:set_model_color_msg()
  local list = self.v_npc_loaded_map
  for _, npc in pairs(list) do
    local trans = npc.transform
    if not Util.is_nil(trans) then
      self:set_model_color(trans)
    end
  end
end

function M:set_model_color(trans_param)
  if self:get_is_signboard() then
    local idx = FashionMgr:get_scene_illumination_index()
    local trans = trans_param
    if 3 == idx then
      local blue_color = Color.New(0.8, 0.9, 1, 1)
      self:set_all_mat_instance(trans, function(mat)
        mat:SetColor(ColorPropID, blue_color)
      end)
    else
      local white_color = Color.New(1, 1, 1, 1)
      self:set_all_mat_instance(trans, function(mat)
        mat:SetColor(ColorPropID, white_color)
      end)
    end
  end
end

return M
