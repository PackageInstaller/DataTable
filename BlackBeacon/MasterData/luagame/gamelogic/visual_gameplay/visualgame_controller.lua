local M = Util.create_class()
local VGC_PREFABNAME = "VisualGameController"
local TypeVisualGameProfile = typeof(CS.Game.VisualGameProfile)
local TypeVisualGameController = typeof(CS.Game.VisualGameController)

function M:_init()
  self.v_vgc_obj = ResMgr:load_gameobj(Path.get_res_path(VGC_PREFABNAME), nil, false)
  self.v_vgc_com = self.v_vgc_obj:GetComponent(TypeVisualGameController)
  VisualGameManager:register_vgc(self)
  
  function self.v_event_wrap_0(obj_index, is_visible)
    self:on_visibility_change(obj_index, is_visible)
  end
  
  function self.v_event_wrap_1(obj_index)
    self:on_obj_move(obj_index)
  end
  
  self.v_vgc_com:OnVisibilityChangeEvent("+", self.v_event_wrap_0)
  self.v_vgc_com:OnObjMoveEvent("+", self.v_event_wrap_1)
end

function M:destroy()
  self.v_vgc_com:OnVisibilityChangeEvent("-", self.v_event_wrap_0)
  self.v_vgc_com:OnObjMoveEvent("-", self.v_event_wrap_1)
  self.v_event_wrap_0 = nil
  self.v_event_wrap_1 = nil
  self.v_vgc_com = nil
  ResMgr:destroy_gameobj(self.v_vgc_obj)
  ResMgr:unload_res(self.v_profile_path, TypeVisualGameProfile)
  VisualGameManager:remove_vgc(self)
end

function M:initialize(profile_name)
  self.v_profile_path = Path.get_res_path(profile_name .. ".asset")
  local profile = ResMgr:load_res(self.v_profile_path, TypeVisualGameProfile)
  self:load_visual_profile_visible_prefab(profile)
  self.v_vgc_com:Initialize(profile)
  self.v_vgc_obj.name = profile_name
  self.v_visible_object_count = self.v_vgc_com.VisibleObjectCount
end

function M:load_visual_profile_visible_prefab(profile)
  local visual_prefab_paths = profile.VisiblePrefabPaths
  local visual_prefabs = profile.VisiblePrefab
  local len = visual_prefab_paths.Length
  for i = 0, len - 1 do
    local res_path = visual_prefab_paths[i]
    local prefab = ResMgr:load_gameobj(res_path)
    self:save_loaded_prefab(prefab.gameObject)
    visual_prefabs[i] = prefab.gameObject
  end
end

function M:save_loaded_prefab(visual_prefabs)
  VisualGameManager:save_loaded_prefab(visual_prefabs)
end

function M:apply_camera(camera)
  self.v_vgc_com:ApplyCamera(camera)
end

function M:start_game()
  self.v_vgc_com:StartGame()
end

function M:pause_game()
  self.v_vgc_com:PauseGame()
end

function M:resume_game()
  self.v_vgc_com:ResumeGame()
end

function M:end_game()
  self.v_vgc_com:EndGame()
end

function M:get_vgc_com()
  return self.v_vgc_com
end

function M:on_visibility_change(obj_index, is_visible)
end

function M:on_obj_move(obj_index)
end

function M:get_obj_location(obj_index)
  local x, y, z = self.v_vgc_com:GetObjectPosition(obj_index)
  return x, y, z
end

function M:get_obj_clue_location(obj_index)
  local x, y, z = self.v_vgc_com:GetCluePosition(obj_index)
  return x, y, z
end

function M:get_obj_activated_index(obj_index)
  return self.v_vgc_com.ActivatedIndex[obj_index]
end

function M:change_obj_location(obj_index, new_backuplocation_index)
  self.v_vgc_com:ChangeObjectLocation(obj_index, new_backuplocation_index)
end

return M
