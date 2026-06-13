local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)
local TypePOVInputProvider = typeof(CS.Game.POVInputProvider)
local Graphic = UnityEngine.Graphics
local MAX_POV_COUNT = 10
local Scale_ratio = 0.6

function M:init_sys()
  self.v_pov_go_list = {}
  self.v_input_provider_list = {}
  self.v_activated_pov_index = -1
  self.v_activated_npc_id = -1
  self.v_rt_map = {}
  Base.init_sys(self)
end

function M:on_destroy()
  self:release_manager()
  Base.on_destroy(self)
end

function M:release_manager()
  for _, rt in pairs(self.v_rt_map) do
    UnityEngine.RenderTexture.ReleaseTemporary(rt)
  end
  if self.v_screenshot_rt then
    UnityEngine.RenderTexture.ReleaseTemporary(self.v_screenshot_rt)
  end
  UtilTable.clear_list(self.v_pov_go_list)
  UtilTable.clear_list(self.v_input_provider_list)
  self.v_capture_system_data = nil
  self.v_activated_pov_index = -1
  self.v_activated_npc_id = -1
  UtilTable.clear_map(self.v_rt_map)
  self.v_screenshot_rt = nil
end

function M:open_capture_system(id)
  if self.v_capture_system_data then
    return
  end
  local scene_map = SceneMgr:get_scene_map()
  local scene_container = scene_map:get_scene_container()
  for i = 1, MAX_POV_COUNT do
    local pov_go = scene_container:Get(string.format("POV_%u", i))
    if not pov_go then
      break
    end
    local input_provider = pov_go:GetComponent(TypePOVInputProvider)
    table.insert(self.v_pov_go_list, pov_go)
    table.insert(self.v_input_provider_list, input_provider)
  end
  local cfg = ShareRes.get_quantum_camera_cfg(id)
  self.v_capture_system_data = cfg
  local msg = MsgGame:mq_publish2(Const.MSG_CAMERA_CAPTURE_SYSTEM)
  msg.mm_x = true
  self.v_interact_pov_hd = self:sys_mq_bind(Const.MSG_ON_INTERACT_QUANTUM_CAMERA_NPC, self._response_interact_succ_event, self)
end

function M:close_capture_system()
  self:release_manager()
  local msg = MsgGame:mq_publish2(Const.MSG_CAMERA_CAPTURE_SYSTEM)
  msg.mm_x = false
  self:sys_mq_unbind(self.v_interact_pov_hd)
  self.v_interact_pov_hd = nil
end

function M:get_capture_system_data()
  return self.v_capture_system_data
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
    local ui_pov = UIMgr:try_get_visible_ui("ui_capture_main")
    if not ui_pov then
      UIMgr:get_ui("ui_capture_main"):ui_show()
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
  local ui_pov = UIMgr:try_get_visible_ui("ui_capture_main")
  if ui_pov then
    ui_pov:ui_hide()
  end
  SceneMgr:set_player_control_on()
  BehaviorMgr:call_event_fun(BehaviorMgr.EVENTS.ON_DEACTIVATE_POV_CAMERA)
  if Global.camera then
    Global.camera:on_activate_pov_camera(false)
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
  self.v_rt_map[pov_index] = self.v_screenshot_rt
  local msg = MsgGame:mq_publish2(Const.MSG_CAMERA_CAPTURE)
  msg.mm_x = pov_index
  msg.mm_y = true
  BehaviorMgr:call_scene_logic_event_fun("on_func_npc_interact_end", self.v_activated_npc_id)
end

function M:remove_capture(pov_index)
  UnityEngine.RenderTexture.ReleaseTemporary(self.v_rt_map[pov_index])
  self.v_rt_map[pov_index] = nil
  local msg = MsgGame:mq_publish2(Const.MSG_CAMERA_CAPTURE)
  msg.mm_x = pov_index
  msg.mm_y = false
end

function M:enable_pov_input(enable)
  self.v_input_provider_list[self.v_activated_pov_index].Blocked = not enable
end

function M:get_activated_pov_index()
  return self.v_activated_pov_index
end

function M:is_initialized()
  return self.v_capture_system_data and true or false
end

function M:_response_interact_succ_event(msg)
  local pov_id = msg.mm_x
  local npc_id = msg.mm_y
  self:activate_pov_camera(pov_id, npc_id)
end

return M
