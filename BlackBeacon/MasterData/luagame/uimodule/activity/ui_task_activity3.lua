local Base = require("uimodule.activity.ui_task_activity_base")
local ui = Util.create_child_mt(Base)
local MAX_PUZZLE_COUNT = 2
local UI_TASK_ACTIVITY3_ITEM = require("uimodule.activity.ui_task_activity3_item")

function ui:on_click_BtnRecive()
  if TaskMgr:check_task_can_receive(self.v_task_id) then
    TaskMgr:submit_task(self.v_task_id)
  end
end

function ui:ui_finish_load()
  self.v_check_group_first = true
  Base.ui_finish_load(self)
  self:set_button("BtnRecive", function()
    self:on_click_BtnRecive()
  end)
  RedPointMgr:bind_redpoint(self, self.v_uiobjects.RedPoint, RedEnum.PUZZLE_ACT_TASK_AWARD)
  self.v_show_award_count = false
end

function ui:ui_on_show(task_activity_id)
  Base.ui_on_show(self, task_activity_id)
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_view, self)
end

local UNLOCK_STATE = {LOCK = 1, UNLOCK = 2}

function ui:refresh_view()
  Base.refresh_view(self)
  if not self.v_activity_task_cfg then
    return
  end
  local params = self.v_activity_task_cfg.Param
  if not params then
    return
  end
  local unlock_list = {}
  local puzzle_list = not Util.is_empty(params[1]) and Util.split_str(params[1], "|")
  local role_list = not Util.is_empty(params[2]) and Util.split_str(params[2], "|")
  local time_list = not Util.is_empty(params[3]) and Util.split_str(params[3], "|")
  if not puzzle_list then
    return
  end
  local puzzle_count = #puzzle_list
  local type_name = "Type"
  local enablt_type_name
  for i = 1, MAX_PUZZLE_COUNT do
    local type_obj = self.v_uiobjects[type_name .. i]
    if type_obj then
      type_obj:SetActive(puzzle_count == i)
      if puzzle_count == i then
        enablt_type_name = type_name .. i
      end
    end
  end
  if not enablt_type_name then
    return
  end
  for index, time_id in ipairs(time_list) do
    time_id = tonumber(time_id)
    local unlock_time = Date.get_time_stamp_by_scheme_id(time_id)
    unlock_list[index] = unlock_time
  end
  local puzzle_name = "Puzzle"
  local puzzle_obj
  for index, puzzle_id in ipairs(puzzle_list) do
    puzzle_id = tonumber(puzzle_id)
    local role_id = tonumber(role_list[index])
    puzzle_obj = self.v_uiobjects[enablt_type_name .. puzzle_name .. index]
    if puzzle_obj then
      local unlock_time = unlock_list[index]
      local item = UI_TASK_ACTIVITY3_ITEM:ui_wrap_ex(self, puzzle_obj, true)
      item:set_data(unlock_time, puzzle_id, role_id)
      self.v_item_list[#self.v_item_list + 1] = item
      self:try_add_refresh_check_timer(unlock_time)
    end
  end
  self:check_task_group_comp()
end

function ui:check_task_group_comp()
  local task_id_list = self.v_task_group and ShareRes.get_task_group_cfg(self.v_task_group)
  local task_id = task_id_list and next(task_id_list)
  self.v_task_group_comp = false
  self.v_task_group_received = false
  self.v_task_id = task_id
  if self.v_task_id then
    self.v_task_group_comp = TaskMgr:check_task_can_receive(self.v_task_id)
    self.v_task_group_received = TaskMgr:check_task_received(self.v_task_id)
  end
  self.v_uiobjects.Complete:SetActive(self.v_task_group_comp)
  self.v_uiobjects.Uncomplete:SetActive(not self.v_task_group_comp)
  for _, item in pairs(self.v_item_list) do
    local mask = item:get_uiobject("Mask")
    if mask then
      mask:SetActive(self.v_task_group_received)
    end
  end
end

function ui:try_add_refresh_check_timer(unlock_time)
  local cur_time = Date.server_time()
  if unlock_time and unlock_time > cur_time and unlock_time - cur_time <= 3600 then
    if not self.v_refresh_time or unlock_time < self.v_refresh_time then
      if self.v_refresh_check_timer then
        Timer:remove_timer(self.v_refresh_check_timer)
        self.v_refresh_check_timer = nil
      end
      self.v_refresh_check_timer = Timer:add_timer(nil, unlock_time - cur_time, function()
        if self:visible() then
          self:refresh_view()
        end
      end)
    end
    self.v_refresh_time = unlock_time
  end
end

function ui:ui_on_hide()
  Base.ui_on_hide(self)
  if self.v_item_list then
    for key, item in pairs(self.v_item_list) do
      item:ui_hide()
      item:ui_destroy()
      self.v_item_list[key] = nil
    end
  end
  if self.v_refresh_check_timer then
    Timer:remove_timer(self.v_refresh_check_timer)
    self.v_refresh_check_timer = nil
    self.v_refresh_time = nil
  end
end

function ui:ui_on_destroy()
  Base.ui_on_destroy(self)
end

function ui:ui_on_update()
  Base.ui_on_update(self)
end

return ui
