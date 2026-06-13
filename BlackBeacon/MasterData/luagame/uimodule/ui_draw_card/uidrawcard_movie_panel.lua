local UnityShader = UnityEngine.Shader
local UnityFind = _ENV.UnityFind
local TypeSceneContainer = typeof(CS.Game.SceneContainer)
local UnitySkinnedMeshRenderer = typeof(UnityEngine.SkinnedMeshRenderer)
local TypeTimeLineRenderHelper = typeof(CS.Game.TimeLineRenderHelper)
local TypeCharacterUtil = typeof(CS.Game.CharacterUtil)
local CSShadow = CS.Game.Shadow
local ResPool = Global.res_pool_mgr
local CSAddMaterial = CS.Game.AddMaterial
local CSUnityMaterial = UnityEngine.Material
local Char_Helper = require("uimodule.character.char_helper")
local _slower = string.lower
local SHADERID_CHARACTER_LIGHT_POS = "_MainSceneLightPos"
local MAIN_SCENE_LIGHTON = UnityShader.PropertyToID("_MainSceneLightOn")
local CUSTOM_ROLE_LIGHT = "_CUSTOM_ROLE_LIGHT"
local SHADERID_CHARACTER_LIGHT_OFFSET = "_CharacterLightOffset"
local MAIN_SCENE_SHOW_ID = UnityShader.PropertyToID("_MAIN_SCENE_SHOW")
local Layer = require("utils.layer")
local CHARACTER_CONFIG = require("uimodule.character.character_config")
local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local _char_root = {
  [4] = {
    scene_root = "Drawcard_S",
    model_root = "Drawcard_S/Model",
    eff_root = "Drawcard_S/Fx_Draw_S_2"
  },
  [5] = {
    scene_root = "Drawcard_S",
    model_root = "Drawcard_S/Model",
    eff_root = "Drawcard_S/Fx_Draw_S_1"
  }
}
local _equip_root = {
  [3] = {
    scene_root = "Drawcard_C",
    model_root = "Drawcard_C/Model",
    eff_root = "Drawcard_C/Fx_Draw_B_3"
  },
  [4] = {
    scene_root = "Drawcard_B",
    model_root = "Drawcard_B/Model",
    eff_root = "Drawcard_B/Fx_Draw_B_2"
  },
  [5] = {
    scene_root = "Drawcard_A",
    model_root = "Drawcard_A/Model",
    eff_root = "Drawcard_A/Fx_Draw_A_1"
  }
}
local AWARD_TYPE_TO_OBJ = {
  [Config.AWARD_TYPE.CHARA] = _char_root,
  [Config.AWARD_TYPE.EQUIP] = _equip_root
}
local CD_TIME = 0.4

function ui:ui_finish_load()
  self:set_button("BtnSkip", function()
    if self.v_CD_ing then
      return
    end
    if self.v_char_id then
      CharacterMgr:stop_buddy_sound(CHARACTER_CONFIG.TRIGGER_SOUND_TYPE.GET_CHARACTER, self.v_char_id)
    end
    self:check_gold_or_skip()
  end)
  self:set_button("BtnNext", function()
    if self.v_CD_ing then
      return
    end
    if self.v_char_id then
      CharacterMgr:stop_buddy_sound(CHARACTER_CONFIG.TRIGGER_SOUND_TYPE.GET_CHARACTER, self.v_char_id)
    end
    if self.v_cur_idx >= #self.v_data_list then
      self:do_skip()
      return
    end
    if self.v_just_show_gold then
      self:check_gold_or_skip()
      return
    end
    self.v_cur_idx = self.v_cur_idx + 1
    self:do_load_next()
  end)
  self.v_info_show_pd = Util.get_playabledirector("Animation/Ani_UIDraw_movie", self.v_object)
  self.v_white_mask_cg = self:get_canvas_group(nil, self.v_uiobjects.WhiteMask)
end

function ui:check_gold_or_skip()
  if self.v_cur_idx >= #self.v_data_list then
    self:do_skip()
    return
  end
  for i = self.v_cur_idx + 1, #self.v_data_list do
    local data = self.v_data_list[i]
    local item_id = data.item_id
    local quality = UtilUI.get_item_qulity(item_id)
    local type_config = Util.get_item_type_cfg(item_id)
    local award_type = type_config.AwardType
    if quality > 4 or award_type == Config.AWARD_TYPE.CHARA and quality > 3 and data.is_new then
      self.v_cur_idx = i
      self.v_just_show_gold = true
      self:do_load_next()
      return
    end
  end
  self:do_skip()
end

function ui:do_skip()
  if #self.v_data_list > 1 then
    UIMgr:get_ui("uidrawcard_multi_rlt"):ui_show(self.v_data_list)
  else
    DrawCardMgr:try_show_extra_item_list(self.v_data_list)
    if self.v_show_extra_when_end then
      UIMgr:get_ui("award_show_panel"):ui_show(self.v_show_extra_when_end)
    end
    self.v_show_extra_when_end = nil
    self:ui_hide()
  end
end

function ui:reset_info_view()
  self.v_info_show_pd.time = 0
  self.v_info_show_pd:Evaluate()
  self.v_uiobjects.InfoView:SetActiveEx(false)
  self.v_uiobjects.CharInfo:SetActiveEx(false)
  self.v_uiobjects.EquipInfo:SetActiveEx(false)
end

function ui:ui_on_show(data_list, do_skip, show_extra_when_end, show_white_mask, hide_cb)
  FashionMgr:refresh_main_scene_fashion(0)
  self:reset_info_view()
  self.v_hide_cb = hide_cb
  self.v_uiobjects.WhiteMask:SetActive(true == show_white_mask)
  if show_white_mask then
    self.v_white_mask_cg.alpha = 0.8
    local dur_time = DrawCardMgr.fade_time or 0.5
    self.v_white_mask_cg:DOFade(0, dur_time):OnComplete(function()
      self.v_uiobjects.WhiteMask:SetActive(false)
    end)
  end
  self.v_show_extra_when_end = show_extra_when_end
  SignBoardGirlMgr:set_update(false)
  CSShadow.Init()
  CSShadow.ShadowLayer = Layer.LayerMask.Character
  CSShadow.RenderOrder = 0
  self.v_is_init = true
  self.v_just_show_gold = false
  Global.render_mgr:set_post_process_param(ShareRes.get_post_process_cfg_by_ui_name("character_enter"))
  self.v_data_list = data_list
  self:init_container()
  if do_skip then
    self.v_cur_idx = 0
    self:check_gold_or_skip()
  else
    self.v_cur_idx = 1
    self:do_load_next()
  end
end

function ui:ui_on_hide()
  if self.v_hide_cb then
    self.v_hide_cb()
  end
  SignBoardGirlMgr:set_update(true)
  Global.render_mgr:set_post_process_param(ShareRes.get_post_process_cfg_by_ui_name("uimain"))
  self:release_mat()
  self:release_model_obj()
  self:reset_to_invisiable()
  self:clear_timer()
  CSShadow.CloseRenderShadowMap2()
  if self.v_timer_CD then
    Timer:remove_timer(self.v_timer_CD)
    self.v_timer_CD = nil
  end
  FashionMgr:reset_main_scene_fashion()
end

function ui:ui_on_destroy()
end

function ui:clear_timer()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
  if self.v_timer_black then
    Timer:remove_timer(self.v_timer_black)
    self.v_timer_black = nil
  end
  if self.v_timer_light then
    Timer:remove_timer(self.v_timer_light)
    self.v_timer_light = nil
  end
  if self.v_timer_info_show then
    Timer:remove_timer(self.v_timer_info_show)
    self.v_timer_info_show = nil
  end
end

function ui:release_model_obj()
  if self.v_animator_res then
    ResPool:release_res(self.v_animator_res)
    self.v_animator_res = nil
  end
  if self.v_model_obj then
    ResMgr:destroy_gameobj(self.v_model_obj)
    ResPool:on_destroy_gameobj(self.v_model_obj)
    self.v_model_obj = nil
  end
end

function ui:init_container()
  local root_gameobj = UnityFind("Root")
  if not root_gameobj or root_gameobj:IsNull() then
    return
  end
  self.v_container = root_gameobj:GetComponent(TypeSceneContainer)
  self.v_draw_root = self.v_container:Get("Drawcard").transform
  self.v_draw_root:SetActive(true)
  self.v_obj_binds = {}
  for award_type, data in pairs(AWARD_TYPE_TO_OBJ) do
    self.v_obj_binds[award_type] = {}
    for quality, root_info in pairs(data) do
      self.v_obj_binds[award_type][quality] = {}
      for name, path in pairs(root_info) do
        local obj = Util.get_child_gameobj(path, self.v_draw_root)
        self.v_obj_binds[award_type][quality][name] = obj
        obj:SetActiveEx(false)
      end
    end
  end
end

function ui:reset_to_invisiable()
  for award_type, data in pairs(AWARD_TYPE_TO_OBJ) do
    for quality, root_info in pairs(data) do
      self:set_visiable(award_type, quality, false)
    end
  end
end

function ui:set_visiable(award_type, quality, visiable)
  if self.v_obj_binds and self.v_obj_binds[award_type] and self.v_obj_binds[award_type][quality] then
    for name, path in pairs(self.v_obj_binds[award_type][quality]) do
      local obj = self.v_obj_binds[award_type][quality][name]
      if obj then
        obj:SetActiveEx(visiable)
      end
    end
  end
  if visiable then
    self:do_CD()
  end
end

function ui:get_weapon_prefab_path(weapon_id)
  local weapon_cfg = ShareRes.create("equip.equip", weapon_id)
  if not weapon_cfg then
    Log.Error("抽卡 武器配置不存在,weapon_id:", weapon_id)
    return
  end
  local res_id = weapon_cfg.ResId[#weapon_cfg.ResId]
  local weapon_res_cfg = ShareRes.create("equip.equip_res", res_id)
  if not weapon_res_cfg then
    Log.Error("抽卡 武器资源配置不存在,weapon_id,res_id:", weapon_id, res_id)
    return
  end
  local model_name = weapon_res_cfg.ModelPath .. "_UI"
  local model_cfg = ShareRes.create("character.character_model", model_name)
  Util.assert(model_cfg, "模型表中没有模型配置：", model_name)
  local animator_path = model_cfg.ControllerPath
  return model_cfg.ModelPath, animator_path
end

function ui:do_load_next()
  self.v_info_show_pd.time = 0
  self.v_info_show_pd:Evaluate()
  self.v_info_show_pd:Stop()
  local black_time = 0
  self.v_is_init = false
  self.v_uiobjects.BlackMask:SetActive(true)
  self.v_uiobjects.BtnNext:SetActive(false)
  self:reset_to_invisiable()
  self:release_model_obj()
  self:release_mat()
  self:clear_timer()
  self.v_timer = Timer:add_timer("uidrawcard_movie_panel_timer", 0.5, function()
    self.v_uiobjects.BtnNext:SetActive(true)
  end)
  local item_id = self.v_data_list[self.v_cur_idx].item_id
  local quality = UtilUI.get_item_qulity(item_id)
  local type_config = Util.get_item_type_cfg(item_id)
  local award_type = type_config.AwardType
  local model_root = self.v_obj_binds[award_type][quality].model_root
  local eff_root = self.v_obj_binds[award_type][quality].eff_root
  if eff_root then
    self.v_timeline_helper = eff_root:GetComponent(TypeTimeLineRenderHelper)
    self.v_timeline_helper.enabled = true
  else
    self.v_timeline_helper = nil
  end
  self:set_info_view(award_type)
  if award_type == Config.AWARD_TYPE.CHARA then
    self.v_char_id = item_id
    ResPool:get_model_async("Draw_H" .. item_id, function(go)
      self.v_model_obj = go
      go.transform:SetParent(model_root.transform, false)
      self.v_uiobjects.BtnNext:SetActive(true)
      self.v_uiobjects.BlackMask:SetActive(false)
      self:set_visiable(award_type, quality, true)
      self:add_shadow_mat()
      self.v_timer_light = Timer:add_timer("uidrawcard_movie_panel_timer_light", 1.35, function()
        self.v_info_show_pd:Play()
        if self.v_timeline_helper then
          self.v_timeline_helper.enabled = false
          self:point_light_mat_set()
          self:set_trans_mat()
        end
        CharacterMgr:trigger_buddy_sound(CHARACTER_CONFIG.TRIGGER_SOUND_TYPE.GET_CHARACTER, self.v_char_id)
      end)
    end)
  else
    self.v_char_id = nil
    local model_res_name, animator_res_name = self:get_weapon_prefab_path(item_id)
    if not animator_res_name then
      Log.Error("武器无状态机配置", item_id, model_res_name)
      return
    end
    local info_delay_show_time = 3 == quality and 0 or 4 == quality and 0.5 or 0.9
    ResPool:get_animator_async(animator_res_name, function(_, animator_info)
      self.v_animator_res = animator_info
      ResPool:get_model_async(model_res_name, function(go)
        self.v_model_obj = go
        go.transform:SetParent(model_root.transform, false)
        go:ResetAttr()
        local animator = go:GetComponent(TypeUnityAnimator)
        animator.runtimeAnimatorController = self.v_animator_res.res
        animator.enabled = true
        self:set_visiable(award_type, quality, true)
        self.v_uiobjects.BtnNext:SetActive(true)
        self.v_uiobjects.BlackMask:SetActive(false)
        animator:CrossFadeInFixedTime(Config.ACT_DEFINE.WeaponIdle, 0.0)
        self.v_timer_info_show = Timer:add_timer("uidrawcard_movie_panel_timer_info_show", info_delay_show_time, function()
          self.v_info_show_pd:Play()
        end)
      end)
    end)
    return
  end
end

function ui:set_info_view(award_type)
  local uiobj = self.v_uiobjects
  local uicom = self.v_uicompents
  uiobj.CharInfo:SetActiveEx(award_type == Config.AWARD_TYPE.CHARA)
  uiobj.EquipInfo:SetActiveEx(award_type == Config.AWARD_TYPE.EQUIP)
  uiobj.InfoView:SetActiveEx(true)
  local data = self.v_data_list[self.v_cur_idx]
  local item_id = data.item_id
  local is_new = data.is_new
  local quality = 0
  if award_type == Config.AWARD_TYPE.CHARA then
    local buddy_config = ShareRes.get_buddy_cfg(item_id)
    local element_path = CharacterMgr:get_buddy_element_icon_path(item_id)
    local job_cfg = ShareRes.get_job_cfg(buddy_config.Job)
    uicom.CharName_txt.text = buddy_config.Name
    uicom.CharJobName_txt.text = job_cfg.Name
    Char_Helper.set_buddy_tag_txt(self.v_uicompents.Tag1_txt, self.v_uicompents.Tag2_txt, buddy_config)
    quality = buddy_config.Quality
    ResMgr:load_set_icon(uicom.CharElement_img, element_path)
    ResMgr:load_set_icon(uicom.CharJob_img, job_cfg.IconPath)
    uiobj.CharIsNew:SetActiveEx(true == is_new)
  else
    local equip_cfg = ShareRes.get_equip(item_id)
    local user = ShareRes.get_equip_user(item_id)
    local path = UtilUI.get_hero_images(user, 1)
    quality = equip_cfg.Quality
    uicom.EquipName_txt.text = equip_cfg.Name
    ResMgr:load_set_icon(uicom.EquipOwner_img, path)
    uiobj.EquipIsNew:SetActiveEx(true == is_new)
  end
  Char_Helper.set_buddy_quality_star(self.v_uiobjects, quality)
  self:_refresh_extra_info(data)
end

function ui:_refresh_extra_info(data)
  if not data.has_extra then
    self.v_uiobjects.ExtraReward:SetActive(false)
    return
  end
  local item_config = ShareRes.get_item_cfg(data.extra_id)
  if not item_config then
    Log.Error("额外获得道具配置错误,extra_id:", data.extra_id)
    self.v_uiobjects.ExtraReward:SetActive(false)
    return
  end
  local uicom = self.v_uicompents
  uicom.ExName_txt.text = item_config.Name
  uicom.ExNum_txt.text = "X" .. data.extra_num
  local path = ShareRes.get_item_icon_path(data.extra_id)
  ResMgr:load_set_icon(uicom.ExIcon_img, path)
  local qulity_config = ShareRes.get_drawcard_anim_res(item_config.Quality)
  path = string.format("UIDraw/%s", qulity_config.Bg[3])
  ResMgr:load_set_icon(uicom.ExQualityBG_img, path)
  self.v_uiobjects.ExtraReward:SetActive(true)
end

function ui:light_mat_set()
  local npc = self.v_model_obj
  if self.v_char_id and npc and not npc:IsNull() then
    local ui_name = "character_enter"
    UnityShader.SetGlobalFloat(CUSTOM_ROLE_LIGHT, 1)
    local trans = npc.transform
    local npc_id = self.v_char_id
    local light_cfg = ShareRes.get_character_light_by_id(self:get_role_light_cfg_id(npc_id))
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

function ui:point_light_mat_set()
  UnityShader.SetGlobalFloat(MAIN_SCENE_SHOW_ID, 1)
  local npc = self.v_model_obj
  if self.v_char_id and npc and not npc:IsNull() then
    local ui_name = "character_enter"
    local trans = npc.transform
    local npc_id = self.v_char_id
    local light_cfg = ShareRes.get_character_edge_light_by_id(self:get_role_light_cfg_id(npc_id))
    if light_cfg then
      local light_pos = light_cfg[ui_name]
      if light_pos then
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
            mat:SetFloat(MAIN_SCENE_LIGHTON, 1.0)
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

function ui:ui_on_update()
  local custom_rot = 0
  local custom_height = 0
  local npc = self.v_model_obj
  if self.v_char_id and npc and not npc:IsNull() then
    local trans = npc.transform
    local npc_id = self.v_char_id
    local shadow_cfg = ShareRes.get_role_shadow_cfg(self:get_role_light_cfg_id(npc_id))
    if ShareRes.get_grandshadow_cfg(npc_id) then
      custom_rot, custom_height = ShareRes.get_grandshadow_cfg(self:get_role_light_cfg_id(npc_id))
    end
    CSShadow.RenderShadowMap(trans, true, 1, false, 0, custom_rot, custom_height)
    if shadow_cfg then
      if shadow_cfg.FollowFace then
        if self.v_face_shadow_npc_id ~= npc_id then
          local follow_node = Util.get_child_gameobj(shadow_cfg.FollowFace, trans)
          if not follow_node then
            return
          end
          local follow_node_mesh = follow_node:GetComponent(UnitySkinnedMeshRenderer)
          self.v_face_shadow_follow = follow_node_mesh.rootBone
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
end

function ui:add_shadow_mat()
  local npc = self.v_model_obj
  if self.v_char_id and npc and not npc:IsNull() then
    self.v_test_add_material = CSAddMaterial.Bind(npc.gameObject)
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
end

function ui:release_mat()
  if self.v_test_add_material then
    self.v_test_add_material:RemoveAll()
    self.v_test_add_material = nil
  end
  if self.v_test_mat then
    ResMgr:unload_res(Path.get_res_path("ShadowCaster.mat"))
    self.v_test_mat = nil
  end
end

function ui:set_trans_mat()
  if self.v_model_obj and not self.v_model_obj:IsNull() then
    Util.set_all_mat(self.v_model_obj.transform, function(mat)
      local name = _slower(mat.name)
      local not_need_shadow = string.match(name, "eye")
      mat:SetKeyword("_SHADOW_RECEIVE", not not_need_shadow)
    end)
    self:set_all_character_mat(self.v_model_obj, true)
  end
end

function ui:set_all_character_mat(gameobj, enable)
  if Util.is_nil(gameobj) then
    return
  end
  local character_util = gameobj:TryAddComponent(TypeCharacterUtil)
  character_util:ChangeAllCharacterMat(enable)
end

function ui:do_CD()
  self.v_CD_ing = true
  if self.v_timer_CD then
    Timer:remove_timer(self.v_timer_CD)
    self.v_timer_CD = nil
  end
  self.v_timer_CD = Timer:add_timer("uidrawcard_movie_panel_timer_CD", CD_TIME, function()
    self.v_CD_ing = false
  end)
end

function ui:get_role_light_cfg_id(npc_id)
  npc_id = npc_id or ""
  return string.format("H%s_UI", tostring(npc_id))
end

return ui
