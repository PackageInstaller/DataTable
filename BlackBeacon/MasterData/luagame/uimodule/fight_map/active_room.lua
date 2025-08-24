local Base = require("ui.uiobject")
local SceneDefine = require("cs_share.scene_define")
local Vec3 = require("base.vec3")
local Vec2 = require("base.vec2")
local MAP_HELPER = require("uimodule.fight_map.fight_map_helper")
local M = Util.create_child_mt(Base)
local MAP_ICON_PATH = "UIMap/%s"
local TREAT_ROOM_TYPE = 15

function M:ui_finish_load()
  self.v_room_type_cfg = ShareRes.create("tower.tower_room_type")
  self.v_rect = self:get_rect_transform(nil, nil)
  self.v_active_lines = {}
  self.v_no_active_lines = {}
  self.v_point_list = {}
  local str = ""
  for i = 1, 4 do
    str = "LineActiveTemp" .. i
    table.insert(self.v_active_lines, self.v_uiobjects[str])
    str = "LineNotTemp" .. i .. "_img"
    table.insert(self.v_no_active_lines, self.v_uicompents[str])
    str = "WayPoint" .. i .. "_img"
    table.insert(self.v_point_list, self.v_uicompents[str])
  end
  self.v_is_here = false
  self.v_is_small = false
  self.v_active_lines_height = self.v_uicompents.LineActiveTemp1_rect.rect.height
  self:set_button("RoomNotBg", function()
    self:_onclick_room()
  end)
end

function M:ui_on_show()
  self:register_event()
end

function M:register_event()
  self:bind_auto_mq(Const.MSG_ON_INTERACT_NPC_SUCCESS, self.update_npc_map, self)
  self:bind_auto_mq(Const.MSG_ON_CREATE_NPC_FINISH, self.update_npc_map, self)
  self:bind_auto_mq(Const.MSG_ON_UPDATE_ACTIVE_ROOM, self.update_room_map, self)
  self:bind_auto_mq(Const.MSG_ON_BATTLE_TASK_UPDATE, self._on_battle_task_update, self)
end

function M:_reset_obj()
  local components = self.v_uicompents
  components.Here_img.gameObject:SetActive(false)
  components.Small_Here_img.gameObject:SetActive(false)
  components.RoomType_img.gameObject:SetActive(false)
  for i = 1, 4 do
    self.v_active_lines[i]:SetActive(false)
    self.v_no_active_lines[i]:SetActive(false)
    self.v_point_list[i].gameObject:SetActive(false)
  end
end

function M:set_data(data, is_small)
  self:_reset_obj()
  self.roomData = data
  self.v_hero_arrow = false
  if is_small then
    self.v_is_small = is_small
  end
  if self.roomData == nil then
    return
  end
  local components = self.v_uicompents
  local uobj = self.v_uiobjects
  local tower = TowerMgr:get_tower()
  local isIn = tower:get_room_num() == self.roomData.RoomNum
  components.Here_img.gameObject:SetActive(not self.v_is_small and isIn)
  components.Small_Here_img.gameObject:SetActive(self.v_is_small and isIn)
  self.v_is_here = isIn
  if not self.v_is_small and isIn then
    self:_set_npc_dir()
  end
  local typeData = self.v_room_type_cfg[self.roomData.RoomType]
  components.RoomType_img.gameObject:SetActive(false)
  if nil ~= typeData then
    if nil ~= typeData.icon and typeData.icon ~= "" then
      local custom_info = tower:get_room_custom_info(self.roomData.RoomNum)
      local show = self.roomData.RoomType == TREAT_ROOM_TYPE and nil ~= custom_info and 1 == custom_info[SceneDefine.ROOM_CUSTOM_STATUS.BLOOD_REC] or 0 == typeData.hide_after_pass
      components.RoomType_img.gameObject:SetActive(show)
      ResMgr:load_set_icon(components.RoomType_img, string.format(MAP_ICON_PATH, typeData.icon))
    end
    local is_restore_hp = tower:get_tower_floor_room_info(self.roomData.RoomNum).is_restore_hp
    if is_restore_hp then
      self.v_origin_activeSelf = false
      uobj.RoomType:SetActive(false)
    end
    local is_obtained = tower:get_tower_floor_room_info(self.roomData.RoomNum).is_obtained
    if is_obtained then
      self.v_origin_activeSelf = false
      uobj.RoomType:SetActive(false)
    end
  else
    Log.Error("获取房间类型配置失败，请检查配置， roomType = ", self.roomData.RoomType)
  end
  self.v_origin_activeSelf = components.RoomType_img.gameObject.activeSelf
  local npc_list = tower:get_room_npc_list(self.roomData.RoomNum)
  if not self.v_origin_activeSelf and nil ~= npc_list then
    local is_interact = false
    for _, npc_data in pairs(npc_list) do
      self:update_npc_image(npc_data.npc_id)
      if not npc_data.is_get then
        is_interact = true
      end
    end
    uobj.IsNpc:SetActive(is_interact)
  else
    uobj.IsNpc:SetActive(false)
  end
  for i = 1, 4 do
    self.v_active_lines[i]:SetActive(false)
    self.v_no_active_lines[i]:SetActive(false)
    self.v_point_list[i].gameObject:SetActive(false)
  end
  local connectDic = self.roomData.RoomConnectDic
  for _, connect in pairs(connectDic) do
    if false == tower:is_pass_room(connect.TargetRoomNum) then
      self.v_no_active_lines[connect.SrcDir]:SetActive(true)
    else
      self.v_active_lines[connect.SrcDir]:SetActive(true)
      self.v_point_list[connect.SrcDir].gameObject:SetActive(false == self.v_is_small and true)
    end
  end
  if false == self.v_is_small then
    self:_set_point()
  end
  local width = 0
  local height = 0
  if false == self.v_is_small then
    width = 4736.0
    height = -2664.0
  else
    width = 2208.0
    height = -1242.0
  end
  local position = self.roomData.WindowPos
  if self.v_is_small then
    self.v_rect:SetAnchoredPositionA(position[1] * width, position[2] * height)
  else
    self.v_rect:SetAnchoredPositionA(position[1] * width + 800, position[2] * height - 500)
  end
  self:_set_task_data()
end

function M:_set_npc_dir()
  local map_angle = MAP_HELPER.get_map_angle()
  local cur_dir = Global.hero:get_dir()
  if map_angle then
    cur_dir = cur_dir - map_angle
  end
  CSHelper.SetEuler(self.v_uicompents.Here_rect, 0, 0, -cur_dir)
end

function M:_set_point()
  for _, img in pairs(self.v_point_list) do
    img.color = UnityEngine.Color(1, 1, 1)
  end
  local img = self.v_point_list[self.roomData.StartDir]
  if nil ~= img then
    img.gameObject:SetActive(true)
    img.color = UnityEngine.Color(0.9450980392156862, 0.3607843137254902, 0.2549019607843137)
  end
  img = self.v_point_list[self.roomData.EndDir]
  if nil ~= img then
    img.gameObject:SetActive(true)
    img.color = UnityEngine.Color(0.34509803921568627, 0.9333333333333333, 0.3058823529411765)
  end
  local tower = TowerMgr:get_tower()
  for idx = 1, 4 do
    if self.v_no_active_lines[idx].gameObject.activeSelf then
      local locked = tower:get_tp_is_locked(self.roomData.RoomNum, idx)
      ResMgr:load_set_icon(self.v_no_active_lines[idx], string.format(MAP_ICON_PATH, "Battle_maps_bg_ljx01"))
      if locked then
        self.v_no_active_lines[idx].color = UnityEngine.Color(0.4470588235294118, 0.12156862745098039, 0.12156862745098039)
        ResMgr:load_set_icon(self.v_no_active_lines[idx], string.format(MAP_ICON_PATH, "Battle_maps_bg_ljx03"))
      else
        self.v_no_active_lines[idx].color = UnityEngine.Color(0.3843137254901961, 0.3843137254901961, 0.3843137254901961)
      end
    end
  end
end

function M:set_line(connect_data, target_room)
  local scrDir = connect_data.SrcDir
  local tower = TowerMgr:get_tower()
  local line_obj = (-1 == connect_data.TargetRoomNum or tower:is_pass_room(connect_data.TargetRoomNum) == true) and self.v_active_lines[scrDir] or self.v_no_active_lines[scrDir]
  line_obj:SetActive(true)
  local line_rect = self:get_rect_transform(nil, line_obj)
  line_rect.sizeDelta = Vec2.New(1, self.v_active_lines_height)
  local start_pos = line_obj.transform.position
  local end_pos = target_room:get_port_postion(connect_data.TargetDir)
  local dir = end_pos - start_pos
  local length = Vec3.Magnitude(dir)
  local factor = self.v_parent_ui.scale_factor
  line_rect.sizeDelta = Vec2.New(length / factor, self.v_active_lines_height)
end

function M:_get_start_dir(port)
  if 1 == port then
    return Vec3.New(0, 1, 0)
  elseif 2 == port then
    return Vec3.New(-1, 0, 0)
  elseif 3 == port then
    return Vec3.New(0, -1, 0)
  else
    return Vec3.New(1, 0, 0)
  end
end

function M:get_port_postion(port)
  return self.v_point_list[port].transform.position
end

function M:get_room_position()
  return Global.ui_mgr.root_camera:WorldToScreenPoint(self.v_rect.position)
end

function M:get_room_world_position()
  return self.v_rect.position
end

function M:get_room_anchored_position()
  return self.v_rect.anchoredPosition
end

function M:get_is_player_in()
  return self.v_is_here
end

function M:_onclick_room()
  if TowerMgr.v_is_cut_pnl then
    return
  end
  if self.v_is_here == true then
    return
  end
  if true == self.v_is_small then
    return
  end
  if self.roomData == nil then
    return
  end
  if not TowerMgr.v_is_can_transmit then
    Util.show_message_tip(2333)
    return
  end
  UIMgr:get_ui("fight"):change_button(false)
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local room = tower:get_room()
  if not room then
    return
  end
  if not room:is_fight_end() then
    Util.show_message_tip(2333)
    return
  end
  tower:enter_room(self.roomData.RoomNum, 0, nil, true, function(is_success)
    if is_success then
      UIMgr:get_ui("fight_pause_common"):ui_hide()
    end
  end)
end

function M:set_pos(pos, is_anchored)
  if is_anchored then
    self.v_rect:SetAnchoredPositionA(pos.x, pos.y)
  else
    self.v_rect:SetPositionA(pos.x, pos.y, pos.z)
  end
end

function M:force_hide_room_icon(hide)
  if not self.v_is_small then
    return
  end
  self.v_hero_arrow = hide
  if self.v_is_here then
    if false == hide then
      self.v_uiobjects.RoomType:SetActive(self.v_origin_activeSelf)
    else
      self.v_uiobjects.RoomType:SetActive(false)
      self.v_uiobjects.IsNpc:SetActive(false)
    end
  end
end

function M:update_npc_image(npc_id)
  local npc_cfg = ShareRes.create("npc.functional_npc", npc_id)
  assert(npc_cfg, "npc不存在")
  local npc_img = self.v_uicompents.IsNpc_img
  local img_path = string.format(MAP_ICON_PATH, npc_cfg.Icon)
  ResMgr:load_set_icon(npc_img, img_path)
end

function M:update_npc_map()
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local npc_list = tower:get_room_npc_list(self.roomData.RoomNum)
  if not self.v_origin_activeSelf and nil ~= npc_list and not self.v_hero_arrow then
    local is_interact = false
    for _, npc_data in pairs(npc_list) do
      self:update_npc_image(npc_data.npc_id)
      if not npc_data.is_get then
        is_interact = true
      end
    end
    self.v_uiobjects.IsNpc:SetActive(is_interact)
  else
    self.v_uiobjects.IsNpc:SetActive(false)
  end
end

function M:update_room_map()
  local tower = TowerMgr:get_tower()
  if not tower then
    return
  end
  local is_obtained = tower:get_tower_floor_room_info(self.roomData.RoomNum).is_obtained
  local is_restore_hp = tower:get_tower_floor_room_info(self.roomData.RoomNum).is_restore_hp
  if (is_obtained or is_restore_hp) and not self.v_hero_arrow then
    self.v_origin_activeSelf = false
    self.v_uiobjects.RoomType:SetActive(false)
  end
end

function M:_on_battle_task_update(msg)
  self:_set_task_data()
end

function M:_set_task_data()
  self.v_uiobjects.TaskIcon:SetActive(false)
  if not self.roomData then
    return
  end
  local relate_list = BattleTaskMgr:check_task_relation_room(self.roomData.LogicNum)
  local task_id = next(relate_list)
  if nil ~= task_id then
    local task_cfg = ShareRes.create("battle.battle_task", task_id)
    if not task_cfg then
      return
    end
    local type_cfg = ShareRes.get_battle_task_type_cfg(task_cfg.Type)
    self.v_uiobjects.TaskIcon:SetActive(true)
    ResMgr:load_set_icon(self.v_uicompents.TaskIcon_img, type_cfg.IconPath)
  end
end

return M
