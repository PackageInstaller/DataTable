local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local SaticSv = require("ui.widget.static_scroll_view")
local WaterPipeItem = require("uimodule.mini_game.water_pipe.water_pipe_item")
local WaterPipeItemKey = "WATER_PIPE_ITEM_KEY"
local CT_Timer = Global.ct_timer
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_blur = {
    "Blur",
    BIND_TYPE.RAW_IMAGE
  },
  v_btn_introduce = {
    "BtnIntroduce",
    BIND_TYPE.BUTTON
  },
  v_btn_reset = {
    "BtnReset",
    BIND_TYPE.BUTTON
  },
  v_btn_ret1 = {
    "BtnRet1",
    BIND_TYPE.BUTTON
  },
  v_content = {
    "Content",
    BIND_TYPE.OBJECT
  },
  v_node = {
    "Node",
    BIND_TYPE.OBJECT
  },
  v_tips_desc = {
    "TipsDesc",
    BIND_TYPE.TEXT
  },
  v_tips_name = {
    "TipsName",
    BIND_TYPE.TEXT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self.v_static_sv = SaticSv:new(self, self.v_content, WaterPipeItem, WaterPipeItemKey)
  self:set_button("BtnRet1", function()
    self:ui_hide()
  end)
  self:set_button("BtnReset", function()
    self:reset_info()
  end)
  self.v_timer_dict = {}
  self.v_timers = {}
  self.v_timeline_in = self:get_child_gameobj("Animation/Ani_UIBattleGame1_In", self.v_object)
  self.v_timeline_out = self:get_child_gameobj("Animation/Ani_UIBattleGame1_Out", self.v_object)
end

function ui:ui_on_show(id, finish_cb, special_arg, game_id_list)
  self.v_timeline_out:SetActive(false)
  self.v_uiobjects.Timer:SetActive(false)
  self.v_cur_game_idx = 0
  if special_arg then
    self.v_target_num = tonumber(special_arg[1])
    self.v_target_time = tonumber(special_arg[2])
    self.v_fail_story_id = tonumber(special_arg[3])
    self.v_game_id_list = game_id_list
    if self.v_target_time > 0 then
      self.v_uiobjects.Timer:SetActive(true)
      local time_txt = self.v_uicompents.TimeNum_txt
      self.v_ct_timer = CT_Timer:add_timer("minigame_timer", self.v_target_time, function(sec)
        if sec > 0 then
          time_txt.text = Date.get_print_count_down(sec)
        else
          self:clear_ct_timer()
          self:do_out()
          if self.v_fail_story_id then
            StoryMgr:on_start(self.v_fail_story_id)
          end
        end
      end)
    end
  else
    self.v_game_id_list = {id}
  end
  self:change_canvas_raycaster(true)
  Global.sound_mgr:play_sound_by_id("Sound_pipewater_loop")
  self.v_finish_cb = finish_cb
  self:play_next()
end

function ui:play_next()
  self.v_cur_game_idx = self.v_cur_game_idx + 1
  local id = self.v_game_id_list[self.v_cur_game_idx]
  if not id then
    self:do_out()
    if self.v_finish_cb then
      self.v_finish_cb()
    end
    return
  end
  self.v_map_id = id
  self.v_map_cfg = ShareRes.create("minigame.waterpipe." .. id)
  if not self.v_map_cfg then
    Log.Error("接水管游戏 关卡配置不存在 id:", id)
    return
  end
  self.v_pipe_list = UtilTable.copy_table(self.v_map_cfg.waterPipes)
  if not self.v_pipe_list then
    Log.Error("接水管游戏 水管配置为空 id:", id)
    return
  end
  self.v_all_cnt = #self.v_pipe_list
  self.v_static_sv.v_content_cpt.constraintCount = self.v_map_cfg.colCnt
  self:set_special_point()
  self:reset_info()
end

function ui:set_special_point()
  local data = self.v_map_cfg.waterPipes
  self.v_start_point = nil
  self.v_end_points = {}
  self.v_pollute_points = {}
  for i = 1, #data do
    if 2 == data[i].centerType then
      self.v_start_point = i
    elseif 3 == data[i].centerType then
      table.insert(self.v_end_points, i)
    elseif 4 == data[i].centerType then
      table.insert(self.v_pollute_points, i)
    end
  end
end

function ui:reset_info()
  if self.v_map_cfg then
    self.v_pipe_list = UtilTable.copy_table(self.v_map_cfg.waterPipes)
    self.v_static_sv:update_list(self.v_pipe_list)
    self:check_is_pass()
    self.v_timeline_in:SetActiveEx(false)
    self.v_timeline_in:SetActive(true)
  end
end

function ui:check_is_pass()
  self:change_canvas_raycaster(true)
  if self.v_start_point < 1 then
    return false
  end
  if #self.v_end_points < 1 then
    return true
  end
  self.v_connect_end = 0
  self.v_connect_pollute = 0
  local connect_start_list = {}
  local connect_pollute_list = {}
  local is_pollute = false
  self:dfs(self.v_start_point, connect_start_list)
  for k, v in ipairs(self.v_pollute_points) do
    if connect_start_list[v] then
      is_pollute = true
    elseif not connect_pollute_list[v] then
      self:dfs(v, connect_pollute_list)
    end
  end
  for i = 1, self.v_all_cnt do
    if connect_pollute_list[i] then
      self.v_static_sv:get_item_by_idx(i):set_pipe_state(3)
    elseif connect_start_list[i] then
      self.v_static_sv:get_item_by_idx(i):set_pipe_state(is_pollute and 3 or 2)
    else
      self.v_static_sv:get_item_by_idx(i):set_pipe_state(1)
    end
  end
  if not is_pollute then
    local is_connected_all_end = true
    for k, v in ipairs(self.v_end_points) do
      if not connect_start_list[v] then
        is_connected_all_end = false
      end
    end
    if is_connected_all_end then
      self:change_canvas_raycaster(false)
      for k, v in ipairs(self.v_end_points) do
        self.v_static_sv:get_item_by_idx(v):set_node_icon(2)
      end
      for i = 1, self.v_all_cnt do
        self.v_static_sv:get_item_by_idx(i):set_glow(true)
      end
      Global.sound_mgr:play_sound_by_id("Sound_pipe_connect_finish")
      self:add_timer("ani_out", 0.3, function()
        self:play_next()
      end)
    end
  end
end

function ui:dfs(start, connect_list)
  connect_list[start] = true
  local pipe_data = self.v_pipe_list[start]
  
  local function check_can_connect(direction)
    local index
    if 0 == direction then
      index = start - self.v_map_cfg.colCnt
    elseif 1 == direction then
      index = (start - 1) % self.v_map_cfg.colCnt < self.v_map_cfg.colCnt - 1 and start + 1 or -1
    elseif 2 == direction then
      index = start + self.v_map_cfg.colCnt
    else
      index = (start - 1) % self.v_map_cfg.colCnt > 0 and start - 1 or -1
    end
    if index > 0 and index <= self.v_all_cnt and not connect_list[index] and UtilTable.contains(self.v_pipe_list[index].directions, (direction + 2) % 4) then
      return true, index
    end
    return false, nil
  end
  
  for k, v in ipairs(pipe_data.directions) do
    local result, index = check_can_connect(v)
    if result then
      self:dfs(index, connect_list)
    end
  end
end

function ui:add_timer(key, duration, cb)
  self:remove_timer(key)
  self.v_timer_dict[key] = Timer:add_timer("water_pipe", duration, cb)
  table.insert(self.v_timers, self.v_timer_dict[key])
end

function ui:remove_timer(key)
  if self.v_timer_dict[key] then
    Timer:remove_timer(self.v_timer_dict[key])
    self.v_timer_dict[key] = nil
  end
end

function ui:remove_all_timer()
  self:clear_ct_timer()
  for key, timer in pairs(self.v_timers) do
    Timer:remove_timer(timer)
  end
  self.v_timers = {}
end

function ui:ui_on_hide()
  self.v_static_sv:clear()
  self:remove_all_timer()
  Global.sound_mgr:stop_sound_by_id_ex("Sound_pipewater_loop")
end

function ui:ui_on_destroy()
  self.v_static_sv = nil
  self:remove_all_timer()
end

function ui:clear_ct_timer()
  if self.v_ct_timer then
    CT_Timer:remove_timer(self.v_ct_timer)
    self.v_ct_timer = nil
  end
end

function ui:do_out()
  self.v_timeline_out:SetActive(true)
  self:add_timer("ani_out", 1, function()
    Global.sound_mgr:stop_sound_by_id_ex("Sound_pipewater_loop")
    self:ui_hide()
  end)
end

return ui
