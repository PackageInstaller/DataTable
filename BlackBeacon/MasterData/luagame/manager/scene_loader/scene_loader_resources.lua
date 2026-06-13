local Base = require("manager.scene_loader.scene_loader")
local M = Global.util.create_child_mt(Base)
local UnitySceneManager = UnityEngine.SceneManagement.SceneManager
local UnityLoadSceneAsync = CS.UnitySceneManager.LoadSceneAsync
local UnityUnloadScene = CS.UnitySceneManager.UnloadScene
local UnityLoad = UnityEngine.Resources.Load
local UnityUnLoad = UnityEngine.Resources.UnloadAsset
local UnityDestroy = _ENV.UnityDestroy
local UnityFind = _ENV.UnityFind
local RuntimeMeshCombinener = CS.RuntimeMeshCombinener
local CSSceneIllumination = CS.SceneIllumination
local CSHelper = CS.Game.CSHelper

function M:load_scene(scene_cfg)
  if self.v_scene_loading then
    return
  end
  local new_scene_name = scene_cfg.SceneName and scene_cfg.SceneName or scene_cfg.MapName
  self:unload_current_scene()
  self.v_scene_name = new_scene_name
  local name = Util.check_load_scene_name(new_scene_name)
  local scene_path = "assets/product/world/" .. scene_cfg.MapName .. "/" .. name .. ".unity"
  Util.assert(CSHelper.IsFileExist(scene_path), scene_path, "not exist")
  self:before_load_scene(scene_cfg)
  self.v_loadsceneop = ResMgr:load_scene(scene_path)
  Util.assert(self.v_loadsceneop, "can't load scene ", name)
  self.v_loadsceneop.allowSceneActivation = true
  self.v_scene_loading = true
  self.v_need_load = true
end

local function _init_scene_diff_light()
  local scene_effect_obj = UnityFind("SceneEffect")
  if not scene_effect_obj then
    return
  end
  local scene_illumination = scene_effect_obj:GetComponent(typeof(CSSceneIllumination))
  local index = 0
  if TowerMgr then
    local tower = TowerMgr:get_tower()
    if tower then
      index = tower:get_diff_light_index()
    else
      local story_room = TowerMgr:get_story_room()
      index = story_room and story_room:get_diff_light_index() or 0
    end
  end
  scene_illumination.curLightDataIndex = index
  scene_illumination:ApplySceneEffect()
end

local function _init_static_batching()
  if Global.scene_mgr and Global.scene_mgr:check_main_scene() then
    return
  end
  local root_obj = UnityFind("Root")
  if not root_obj then
    return
  end
  local runtime_mesh_comb = root_obj:GetComponent(typeof(RuntimeMeshCombinener))
  if not runtime_mesh_comb then
    return
  end
  runtime_mesh_comb:StaticBatch()
end

function M:need_load_scene(scene_name)
  if self.v_scene_loading or self.v_scene_loaded then
    return false
  end
  return true
end

function M:get_additive_scene_loader()
  return M
end

function M:get_load_scene_progress()
  if not self.v_scene_loading then
    return 1
  end
  return self.v_loadsceneop.progress
end

function M:unload_current_scene()
  Base.unload_current_scene(self)
  if not self.v_scene_loaded then
    self.v_need_load = nil
    return
  end
  if self.v_scene_loaded and self.v_is_additive then
    local name = Util.check_load_scene_name(self.v_scene_name)
    UnityUnloadScene(name)
  end
  self.v_scene_loading = nil
  self.v_scene_name = nil
  self.v_scene_loaded = nil
  self.v_need_load = nil
end

function M:is_load_scene_done()
  if not self.v_scene_loading then
    return true
  end
  if self.v_loadsceneop.isDone then
    _init_scene_diff_light()
    _init_static_batching()
    self.v_loadsceneop = nil
    self.v_scene_loading = nil
    self.v_scene_loaded = true
  end
  return not self.v_scene_loading
end

return M
