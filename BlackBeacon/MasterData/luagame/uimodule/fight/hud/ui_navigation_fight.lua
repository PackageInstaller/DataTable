local M = Util.create_class()
local Vec3 = require("base.vec3")
local Vec2 = require("base.vec2")
local mathX = require("base.mathx")
local prefab_name = "UI_Hud_Navigation"
local NAVIGATION_WIDTH_RATIO = 0.7
local NAVIGATION_HEIGHT_RATIO = 0.6
local FIX_HUD_NUM = 4
local LEFT_UP = 1
local RIGHT_UP = 2
local LEFT_DOWN = 3
local RIGHT_DOWN = 4
local CAMPS = Global.config.CAMPS
local top_left = Vec2.New()
local top_right = Vec2.New()
local bottom_left = Vec2.New()
local bottom_right = Vec2.New()
local center = Vec2.New()
local rect_vec_list = {}
local lerp_factor = 10
local WARNING_DURATION = 1.0

function M:_init(dynamic_ui)
  self.v_is_destroy = false
  self.v_dynamic_ui = dynamic_ui
  self.v_is_visible = false
  self.v_is_loading_complete = false
  local width = self.v_dynamic_ui:get_rect_size_delta_x() * NAVIGATION_WIDTH_RATIO
  local height = self.v_dynamic_ui:get_rect_size_delta_y() * NAVIGATION_HEIGHT_RATIO
  bottom_left:Set((self.v_dynamic_ui:get_rect_size_delta_x() - width) / 2, (self.v_dynamic_ui:get_rect_size_delta_y() - height) / 2)
  bottom_right:Set(bottom_left.x + width, bottom_left.y)
  top_left:Set(bottom_left.x, bottom_left.y + height)
  top_right:Set(top_left.x + width, top_left.y)
  center:Set(self.v_dynamic_ui:get_rect_size_delta_x() / 2, self.v_dynamic_ui:get_rect_size_delta_y() / 2)
  table.insert(rect_vec_list, bottom_left)
  table.insert(rect_vec_list, top_left)
  table.insert(rect_vec_list, top_right)
  table.insert(rect_vec_list, bottom_right)
  ResPoolMgr:get_ui_effect_async(prefab_name, function(go)
    self:finish_load(go)
  end)
end

function M:finish_load(go)
  self.v_gameobject = go
  local navigation_root_trans = self.v_dynamic_ui:get_navigation_root_trans()
  self.v_gameobject.transform:SetParent(navigation_root_trans, false)
  self.v_rect_transform = Util.get_rect_transform(nil, self.v_gameobject)
  self.v_rect_transform:SetAnchoredPositionA(0, 0)
  self.v_gameobject:SetActive(false)
  self:clear_clone()
  self.v_fight_hud_list = {}
  for i = 1, FIX_HUD_NUM do
    local clone_obj = ResMgr:instantiate(self.v_gameobject)
    clone_obj.transform:SetParent(navigation_root_trans, false)
    local clone_trans = Util.get_rect_transform(nil, clone_obj)
    self.v_fight_hud_list[i] = clone_trans
    clone_trans:SetAnchoredPositionA(rect_vec_list[i].x, rect_vec_list[i].y)
    clone_trans:SetLocalScaleA(3, 3, 3)
  end
  self.v_is_loading_complete = true
  self.v_results = {
    distance = {},
    viewpos = {},
    count_index = 0
  }
  self.v_cur_use_hud = 0
end

local temp_target_vec3 = Vec3.New()
local screen_pos = Vec2.New()
local screen_pos_dir = Vec2.New()
local target_screen_pos = Vec2.New()
local center_to_screen_vec = Vec2.New()

function M:update(hud_num, char_pos, target_pos_list)
  if self.v_is_loading_complete then
    hud_num = hud_num or 1
    char_pos = char_pos or Global.hero:get_pos_vec3()
    if not target_pos_list then
      target_pos_list = {}
      local npc_map = SceneMgr:get_all_npc()
      for _, npc in pairs(npc_map) do
        if npc:is_monster_with_kind() then
          table.insert(target_pos_list, npc:get_pos_vec3())
        end
      end
    end
    hud_num = hud_num or 0
    if hud_num < 0 then
      hud_num = 0
    end
    if hud_num > FIX_HUD_NUM then
      hud_num = FIX_HUD_NUM
    end
    local count_index = 0
    local cur_dist = 0
    local cur_index = 1
    local is_in_rectangle = false
    local open_fx = false
    for _, target_pos in pairs(target_pos_list) do
      open_fx = true
      count_index = count_index + 1
      self.v_results.distance[count_index] = Vec3.Distance(target_pos, char_pos)
      temp_target_vec3:Set(target_pos.x, target_pos.y, target_pos.z)
      local viewport_point = Global.camera:get_camera():WorldToViewportPoint(temp_target_vec3)
      local viewport_z = viewport_point.z
      screen_pos:Set(viewport_point.x, viewport_point.y)
      local sign_x, sign_y = self:judge_screen_pos(screen_pos)
      screen_pos.x = self.v_dynamic_ui:get_rect_size_delta_x() * screen_pos.x
      screen_pos.y = self.v_dynamic_ui:get_rect_size_delta_y() * screen_pos.y
      if not self:is_in_rectangle(screen_pos) then
        for i = 1, 4 do
          local begin_point = rect_vec_list[i]
          local end_point = 4 == i and rect_vec_list[1] or rect_vec_list[i + 1]
          if mathX.get_line_intersection(begin_point, end_point, center, screen_pos, screen_pos) then
            break
          end
        end
        is_in_rectangle = false
      else
        is_in_rectangle = true
      end
      if viewport_z < 0 then
        screen_pos.x = self.v_dynamic_ui:get_rect_size_delta_x() - screen_pos.x
        screen_pos.y = bottom_left.y
      elseif is_in_rectangle then
        screen_pos.y = top_left.y
      end
      if self.v_results.viewpos[count_index] ~= nil then
        self.v_results.viewpos[count_index]:Set(screen_pos.x, screen_pos.y)
      else
        self.v_results.viewpos[count_index] = Vec2.New()
        self.v_results.viewpos[count_index]:Set(screen_pos.x, screen_pos.y)
      end
      self.v_results.count_index = count_index
      cur_dist = cur_dist or self.v_results.distance[count_index]
      if cur_dist >= self.v_results.distance[count_index] then
        cur_dist = self.v_results.distance[count_index]
        cur_index = count_index
      end
    end
    if open_fx then
      screen_pos:Set(self.v_results.viewpos[cur_index].x, self.v_results.viewpos[cur_index].y)
      if not is_in_rectangle then
        if not self.v_last_screen_pos then
          self.v_last_screen_pos = Vec2.New(screen_pos.x, screen_pos.y)
        end
        screen_pos.x = mathX.lerp_number(self.v_last_screen_pos.x, screen_pos.x, lerp_factor * GlobalTimeMgr:get_dt_time())
        screen_pos.y = mathX.lerp_number(self.v_last_screen_pos.y, screen_pos.y, lerp_factor * GlobalTimeMgr:get_dt_time())
      end
      self.v_fight_hud_list[1]:SetActive(true)
      self.v_fight_hud_list[1]:SetAnchoredPosition3DA(screen_pos.x, screen_pos.y, 0)
      if self.v_last_screen_pos then
        self.v_last_screen_pos:Set(screen_pos.x, screen_pos.y)
      end
    else
      self.v_fight_hud_list[1]:SetActive(false)
    end
  end
end

function M:set_visible(is_visible)
  if self.v_is_visible ~= is_visible then
    self.v_is_visible = is_visible
    if self.v_gameobject then
      self.v_gameobject:SetActive(is_visible)
      if not is_visible then
        self.v_last_screen_pos = nil
      end
    end
  end
end

function M:judge_screen_pos(pos)
  if pos.x <= 0.5 and pos.y >= 0.5 then
    return -1, 1
  elseif pos.x >= 0.5 and pos.y >= 0.5 then
    return 1, 1
  elseif pos.x <= 0.5 and pos.y <= 0.5 then
    return -1, -1
  elseif pos.x >= 0.5 and pos.y <= 0.5 then
    return 1, -1
  end
end

function M:set_point_to_edge(screen_pos, viewport_z, x1, x2, y1, y2, sign_x, sign_y)
  if viewport_z > 0 and x1 < screen_pos.x and x2 > screen_pos.x and y1 < screen_pos.y and y2 > screen_pos.y then
    local x_left_side = screen_pos.x - x1
    local x_right_side = x2 - screen_pos.x
    local y_up_side = y2 - screen_pos.y
    local y_down_side = screen_pos.y - y1
    local x_min_side = x_left_side < x_right_side and x_left_side or x_right_side
    local y_min_side = y_up_side > y_down_side and y_down_side or y_up_side
    local min_side = x_min_side < y_min_side and x_min_side or y_min_side
    screen_pos.x = screen_pos.x + min_side * sign_x
    screen_pos.y = screen_pos.y + min_side * sign_y
  end
end

function M:is_in_rectangle(screen_pos)
  local result = screen_pos.x > bottom_left.x and screen_pos.x < bottom_right.x and screen_pos.y > bottom_left.y and screen_pos.y < top_left.y and true or false
  return result
end

function M:on_destroy()
  if self.v_gameobject then
    ResPoolMgr:release(self.v_gameobject)
  end
  self:clear_clone()
  self.v_gameobject = nil
end

function M:clear_clone()
  if self.v_fight_hud_list then
    for _, obj in pairs(self.v_fight_hud_list) do
      ResMgr:destroy_gameobj(obj.gameObject)
    end
  end
  self.v_fight_hud_list = nil
end

return M
