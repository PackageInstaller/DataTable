local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local TypePOVInputProvider = typeof(CS.Game.POVInputProvider)
local Graphic = UnityEngine.Graphics
local Scale_ratio = 0.6

function M:init_sys()
  Base.init_sys(self)
  self.v_reference_count = 0
  self.v_loaded_prefabs = {}
  self.v_vgc_map = {}
  self.v_pov_go_list = {}
  self.v_input_provider_list = {}
  self.v_activated_pov_index = -1
  self.v_activated_npc_id = -1
  self.v_rt_map = {}
  self.v_screenshot_rt = nil
  self.v_pos_buffer = {}
  self.v_capture_system_data = nil
end

function M:on_destroy()
  self:release_manager()
  Base.on_destroy(self)
end

function M:init_manager()
  local scene_map = SceneMgr:get_scene_map()
  local scene_container = scene_map:get_scene_container()
  for i = 1, 10 do
    local pov_go = scene_container:Get(string.format("POV_%u", i))
    if not pov_go then
      break
    end
    local input_provider = pov_go:GetComponent(TypePOVInputProvider)
    table.insert(self.v_pov_go_list, pov_go)
    table.insert(self.v_input_provider_list, input_provider)
  end
  self.v_interact_pov_hd = self:sys_mq_bind(Const.MSG_ON_INTERACT_QUANTUM_CAMERA_NPC, self._response_interact_succ_event, self)
end

function M:release_manager()
  UtilTable.clear_map(self.v_vgc_map)
  UtilTable.clear_list(self.v_pov_go_list)
  UtilTable.clear_list(self.v_input_provider_list)
  for _, rt in pairs(self.v_rt_map) do
    UnityEngine.RenderTexture.ReleaseTemporary(rt)
  end
  UtilTable.clear_map(self.v_rt_map)
  if self.v_screenshot_rt then
    UnityEngine.RenderTexture.ReleaseTemporary(self.v_screenshot_rt)
  end
  self.v_screenshot_rt = nil
  self.v_activated_pov_index = -1
  self.v_activated_npc_id = -1
  self.v_reference_count = 0
  UtilTable.clear_map(self.v_pos_buffer)
  if self.v_capture_system_data then
    M:close_capture_system()
  end
  if self.v_interact_pov_hd then
    self:sys_mq_unbind(self.v_interact_pov_hd)
    self.v_interact_pov_hd = nil
  end
end

function M:register_vgc(vgc)
  if 0 == self.v_reference_count then
    self:init_manager()
  end
  self.v_vgc_map[vgc] = vgc
  self.v_reference_count = self.v_reference_count + 1
end

function M:remove_vgc(vgc)
  self.v_vgc_map[vgc] = nil
  self.v_reference_count = self.v_reference_count - 1
  if 0 == self.v_reference_count then
    self:release_manager()
  end
end

function M:open_capture_system(id)
  local cfg = ShareRes.get_quantum_camera_cfg(id)
  self.v_capture_system_data = cfg
  local msg = MsgGame:mq_publish2(Const.MSG_QUANTUM_CAPTURE_SYSTEM)
  msg.mm_x = true
end

function M:close_capture_system()
  self.v_capture_system_data = nil
  local msg = MsgGame:mq_publish2(Const.MSG_QUANTUM_CAPTURE_SYSTEM)
  msg.mm_x = false
end

function M:get_capture_system_data()
  return self.v_capture_system_data
end

function M:get_activated_pov_index()
  return self.v_activated_pov_index
end

function M:activate_pov_camera(index, npc_id)
  if not self.v_capture_system_data then
    return
  end
  if not self.v_pov_go_list[index] or self.v_activated_pov_index == index then
    return
  end
  if Global.camera then
    Global.camera:on_activate_pov_camera(true)
  end
  local pre_pov_go = self.v_pov_go_list[self.v_activated_pov_index]
  if pre_pov_go then
    pre_pov_go:SetActiveEx(false)
  end
  self.v_pov_go_list[index]:SetActiveEx(true)
  self.v_activated_pov_index = index
  self.v_activated_npc_id = npc_id
  NextFrameMgr:add_next_update(function()
    local ui_pov = UIMgr:try_get_visible_ui("ui_quantum_main")
    if not ui_pov then
      UIMgr:get_ui("ui_quantum_main"):ui_show()
    end
  end)
  SceneMgr:set_player_control_off()
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_ACTIVATE_POV_CAMERA, index)
end

function M:deactivate_pov_camera()
  if not self.v_capture_system_data then
    return
  end
  if -1 == self.v_activated_pov_index then
    return
  end
  self.v_pov_go_list[self.v_activated_pov_index]:SetActiveEx(false)
  self.v_activated_pov_index = -1
  self.v_activated_npc_id = -1
  local ui_pov = UIMgr:try_get_visible_ui("ui_quantum_main")
  if ui_pov then
    ui_pov:ui_hide()
  end
  SceneMgr:set_player_control_on()
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_DEACTIVATE_POV_CAMERA)
  if Global.camera then
    Global.camera:on_activate_pov_camera(false)
  end
end

function M:is_any_obj_visible()
  local count = 0
  for _, vgc in pairs(self.v_vgc_map) do
    local buffer = vgc:get_vgc_com().ObjIsVisibleInActivateCamera
    for i = 0, buffer.Length - 1 do
      if buffer[i] then
        local x, y, z = vgc:get_obj_clue_location(i)
        self.v_pos_buffer[count * 3 + 1] = x
        self.v_pos_buffer[count * 3 + 2] = y
        self.v_pos_buffer[count * 3 + 3] = z
        count = count + 1
      end
    end
  end
  if count > 0 then
    return true, count, self.v_pos_buffer
  else
    return false, 0
  end
end

function M:screenshot(callback)
  local pov_index = self.v_activated_pov_index
  local global_camera_rt = Global.camera.v_camera.targetTexture
  local width = math.floor(global_camera_rt.width * Scale_ratio)
  local height = math.floor(global_camera_rt.height * Scale_ratio)
  if self.v_screenshot_rt then
    UnityEngine.RenderTexture.ReleaseTemporary(self.v_screenshot_rt)
  end
  self.v_screenshot_rt = CompExtensions.GetUIRT(width, height, string.format("POV_CAPTURE_%u", pov_index))
  Graphic.Blit(global_camera_rt, self.v_screenshot_rt)
  if callback then
    callback(self.v_screenshot_rt)
  end
end

function M:get_capture_rt(pov_id)
  return self.v_rt_map[pov_id]
end

function M:capture()
  local pov_index = self.v_activated_pov_index
  for _, vgc in pairs(self.v_vgc_map) do
    vgc:get_vgc_com():Capture(pov_index)
  end
  self.v_rt_map[pov_index] = self.v_screenshot_rt
  local msg = MsgGame:mq_publish2(Const.MSG_QUANTUM_CAPTURE)
  msg.mm_x = pov_index
  msg.mm_y = true
  BehaviorMgr:call_scene_logic_event_fun("on_func_npc_interact_end", self.v_activated_npc_id)
end

function M:remove_capture(pov_index)
  for _, vgc in pairs(self.v_vgc_map) do
    vgc:get_vgc_com():RemoveCapture(pov_index)
  end
  UnityEngine.RenderTexture.ReleaseTemporary(self.v_rt_map[pov_index])
  self.v_rt_map[pov_index] = nil
  local msg = MsgGame:mq_publish2(Const.MSG_QUANTUM_CAPTURE)
  msg.mm_x = pov_index
  msg.mm_y = false
end

function M:enable_pov_input(enable)
  self.v_input_provider_list[self.v_activated_pov_index].Blocked = not enable
end

function M:update_visible_state()
  for _, vgc in pairs(self.v_vgc_map) do
    vgc:get_vgc_com():UpdateVisibleState()
  end
end

function M:set_visual_prefabs_visible(visible)
  if self.v_loaded_prefabs == nil or UtilTable.is_empty(self.v_loaded_prefabs) then
    return
  end
  for i, prefab in pairs(self.v_loaded_prefabs) do
    prefab:SetActive(visible)
  end
end

function M:save_loaded_prefab(prefab)
  self:cleanup_destroyed_prefabs()
  table.insert(self.v_loaded_prefabs, prefab)
end

function M:cleanup_destroyed_prefabs()
  if self.v_loaded_prefabs == nil then
    return
  end
  local valid_prefabs = {}
  for i, prefab in pairs(self.v_loaded_prefabs) do
    if not self:IsNil(prefab) then
      table.insert(valid_prefabs, prefab)
    end
  end
  self.v_loaded_prefabs = valid_prefabs
end

function M:IsNil(uobj)
  return nil == uobj or uobj:IsNull()
end

function M:clear_loaded_prefabs()
  UtilTable.clear_map(self.v_loaded_prefabs)
  self.v_loaded_prefabs = {}
end

function M:_response_interact_succ_event(msg)
  local pov_id = msg.mm_x
  local npc_id = msg.mm_y
  self:activate_pov_camera(pov_id, npc_id)
end

return M
