local M = Global.util.create_class()
local UnityFindObjectsOfType = CS.UnityGameObject.FindObjectsOfType
local UnityFindObjectOfType = CS.UnityGameObject.FindObjectOfType
local INNER_DISTANCE = 10
local MAIN_SCENE_ID = 100
local _slower = string.lower

function M:_init(is_additive)
  self.v_addtive_scene_loaders = {}
  self.v_is_additive = is_additive
end

function M:before_load_scene(scene_cfg)
  self.v_is_main_scene = scene_cfg.SceneID == MAIN_SCENE_ID
  if self.v_is_main_scene then
    CS.EffectStatus.ClearStaticCache()
  end
end

function M:load_scene(scene_cfg)
  assert(nil, "override me please")
end

function M:get_additive_scene_loader()
  assert(nil, "override me please")
end

function M:unload_current_scene()
  for _, additive_scene_loader in pairs(self.v_addtive_scene_loaders) do
    additive_scene_loader:unload_current_scene()
  end
end

function M:update()
  if self.v_scene_loading and self.v_loadsceneop and self.v_loadsceneop.isDone then
    self.v_loadsceneop.allowSceneActivation = true
    self.v_scene_loading = nil
    self.v_loadsceneop = nil
    self.v_scene_loaded = true
    if not self.v_need_load then
      self:unload_current_scene()
    end
  end
  if not Global.hero then
    return
  end
  if self.v_is_additive then
    return
  end
end

function M:is_scene_loading()
  return self.v_scene_loading
end

function M:has_loading_addtive_scene()
  for _, scene_loader in pairs(self.v_addtive_scene_loaders) do
    if scene_loader:is_scene_loading() then
      return true
    end
  end
  return false
end

function M:clear()
  if not self.v_is_additive then
    self.v_addtive_scenes = {}
    self.v_loading_addtive_scenes = {}
    self.v_need_loading_scenes = {}
    self.v_need_unload_scenes = {}
    self.v_scene_count = 0
  end
  for _, scene_loader in pairs(self.v_addtive_scene_loaders) do
    scene_loader:unload_current_scene()
  end
  self.v_addtive_scene_loaders = {}
end

return M
