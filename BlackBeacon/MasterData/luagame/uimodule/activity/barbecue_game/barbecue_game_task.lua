local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
local TASK_ITEM_KEY = "MUSIC_GAME_TASK_ITEM_KEY"
local TASK_AWARD_ITEM_KEY = "MUSIC_GAME_TASK_AWARD_ITEM_KEY"
local _insert = table.insert
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local STATE_TO_COLOR = {
  [true] = "FFFFFF",
  [false] = "001532"
}
local TASK_ITEM = require("uimodule.activity.barbecue_game.barbecue_game_task_item")

function ui:click_get_all_btn()
  self.v_get_task_id_list = {}
  for task_id, _ in pairs(self.v_task_data) do
    local task_data = TaskMgr:get_task_by_id(task_id)
    if task_data and task_data.state == TASK_STATE.receive then
      _insert(self.v_get_task_id_list, task_id)
    end
  end
  TaskMgr:submit_task_list(self.v_get_task_id_list, function()
    self:refresh_task_list()
  end)
end

function ui:ui_finish_load()
  self:set_button("BtnRetX", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnAllGet", function()
    self:click_get_all_btn()
  end)
  self.v_task_data = {}
  self:register_exist_auto_template(TASK_ITEM_KEY, self.v_uiobjects.CtTem, self.v_uiobjects.TaskContent)
  self:register_exist_auto_template(TASK_AWARD_ITEM_KEY, self.v_uiobjects.AwardItem, self.v_uiobjects.AwardContent)
end

function ui:ui_on_show(group_id)
  self.v_group_id = group_id
  self:refresh_normal_task()
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_task_list, self)
  self:bind_auto_mq(Const.MSG_ON_CLICK_CHAPTER_TASK_ITEM, self.response_click_task_item, self)
end

function ui:ui_on_hide()
  self:clear_task_item()
  self.v_not_show_progress = nil
  self.v_group_id = nil
end

function ui:ui_on_destroy()
end

function ui:refresh_normal_task()
  self.v_task_list = self:get_task_list()
  self:refresh_task_list()
end

function ui:refresh_weekly_pre_task()
  local all_cfg = ShareRes.get_weekly_prepare_war()
  local temp_list = {}
  for key, cfg in pairs(all_cfg) do
    table.insert(temp_list, cfg)
  end
  table.sort(temp_list, function(a, b)
    if a.Id ~= b.Id then
      return a.Id < b.id
    else
      return false
    end
  end)
  self:clear_task_item()
  for index, cfg in ipairs(temp_list) do
    local task_ui = self:get_auto_cache(TASK_ITEM_KEY)
    local item = TASK_ITEM:ui_wrap_ex(self, task_ui, true)
    self.v_task_data[cfg.Id] = item
  end
end

function ui:get_task_list()
  local task_list = ShareRes.get_task_group(self.v_group_id)
  return task_list
end

function ui:refresh_task_list()
  if not self.v_task_list then
    return
  end
  local new_task_data = {}
  local is_have_task_receive, no_task_node = false, true
  for _, task in pairs(self.v_task_list) do
    local task_data = TaskMgr:get_task_by_id(task.Id)
    if task_data then
      if task_data.state == TASK_STATE.receive then
        no_task_node = false
        is_have_task_receive = true
        task_data.sort_index = 0
      elseif task_data.state == TASK_STATE.received then
        task_data.sort_index = 2
      else
        no_task_node = false
        task_data.sort_index = 1
      end
      task_data.task_group_cfg = task
      _tinsert(new_task_data, task_data)
    end
  end
  self.v_uiobjects.BtnAllGet:SetActive(is_have_task_receive)
  self.v_uiobjects.AllGot:SetActive(no_task_node)
  table.sort(new_task_data, function(a, b)
    local a_priority = a.task_cfg.Priority
    local b_priority = b.task_cfg.Priority
    if a.sort_index == b.sort_index then
      if a_priority == b_priority then
        return a.id < b.id
      else
        return a_priority < b_priority
      end
    end
    return a.sort_index < b.sort_index
  end)
  self:clear_task_item()
  for _, task in pairs(new_task_data) do
    local task_id = task.id
    local task_data = TaskMgr:get_task_by_id(task_id)
    if task_data then
      local task_ui = self:get_auto_cache(TASK_ITEM_KEY)
      local item = TASK_ITEM:ui_wrap_ex(self, task_ui, true)
      item:set_data(task_id, function()
        self:ui_hide()
      end, self.v_show_jump_btn)
      item:refresh_task_item()
      item:refresh_task_get_state()
      self.v_task_data[task_id] = item
    end
  end
  local task_content_obj = Util.get_rect_transform(nil, self.v_uiobjects.TaskContent)
  local x = task_content_obj.anchoredPosition.x
  task_content_obj.transform:SetAnchoredPositionA(x, 0)
end

function ui:click_get_award_btn(task_id)
  local task_data = TaskMgr:get_task_by_id(task_id)
  if task_data.state ~= TASK_STATE.receive then
    return
  end
  TaskMgr:submit_task(task_id, function()
    self:refresh_task_list()
  end)
end

function ui:refresh_task_view()
  if not self.v_task_data then
    return
  end
  for task_id, item in pairs(self.v_task_data) do
    item:refresh_task_get_state(task_id)
  end
end

function ui:response_click_task_item(msg)
  if not msg then
    return
  end
  local data = msg.mm_obj
  local dp_group_id = data.dp_group_id
  local dp_id = data.dp_id
  local can_get_state = TaskMgr:can_get_dp_award(dp_group_id, dp_id, self.v_chapter_id)
  if can_get_state == TASK_STATE.received then
    return
  end
  if can_get_state ~= TASK_STATE.receive then
    Util.show_message_tip(2140)
    return
  end
end

function ui:click_get_all_btn()
  self.v_get_task_id_list = {}
  for task_id, _ in pairs(self.v_task_data) do
    local task_data = TaskMgr:get_task_by_id(task_id)
    if task_data and task_data.state == TASK_STATE.receive then
      _insert(self.v_get_task_id_list, task_id)
    end
  end
  TaskMgr:submit_task_list(self.v_get_task_id_list, function()
    self:refresh_task_list()
  end)
end

function ui:get_color(is_receive)
  return STATE_TO_COLOR[is_receive]
end

function ui:clear_task_item()
  self:give_back_auto_cache(TASK_ITEM_KEY)
  self:give_back_auto_cache(TASK_AWARD_ITEM_KEY)
  for key, item in pairs(self.v_task_data) do
    item:ui_hide()
    item:ui_destroy()
    self.v_task_data[key] = nil
  end
end

function ui:get_award_item()
  return self:get_auto_cache(TASK_AWARD_ITEM_KEY)
end

return ui
