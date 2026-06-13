local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local LOOP_TASK_REWARD_ITEM_KEY = "LOOP_TASK_REWARD"
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local string_format = string.format
local MODEL = {
  v_active_need_num = {
    "ActiveNeedNum",
    BIND_TYPE.TEXT
  },
  v_bg_btn = {
    "BgBtn",
    BIND_TYPE.BUTTON
  },
  v_close_btn = {
    "CloseBtn",
    BIND_TYPE.BUTTON
  },
  v_task_reward_tem = {
    "TaskRewardTem",
    BIND_TYPE.OBJECT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BgBtn", function()
  end)
  self:set_button("CloseBtn", function()
    self:ui_hide()
  end)
  self:set_button("Reward1", function()
  end)
  self:set_button("Reward2", function()
  end)
  self:register_exist_auto_template(LOOP_TASK_REWARD_ITEM_KEY, self.v_task_reward_tem, self.v_task_reward_tem.transform.parent, 20)
end

function ui:ui_on_show(data)
  self:_refresh_reward_item(data)
end

function ui:_refresh_reward_item(reward_list_config)
  local condition_config = ShareRes.create("condition.condition")
  local task_config = ShareRes.create("condition.task")
  local award_group_config = ShareRes.create("award.award_group")
  local award_config = ShareRes.create("award.award")
  local item_config = ShareRes.create("item.item")
  local new_reward = {}
  for _, data in pairs(reward_list_config) do
    local task_info = TaskMgr:get_task_by_id(data.TaskId)
    local sort_index = 1
    if task_info.state == TASK_STATE.receive then
      sort_index = 2
    elseif task_info.state == TASK_STATE.received then
      sort_index = 0
    end
    data.sort_index = sort_index
    table.insert(new_reward, data)
  end
  table.sort(new_reward, function(a, b)
    if a.sort_index == b.sort_index then
      return a.TaskId < b.TaskId
    end
    return a.sort_index > b.sort_index
  end)
  self:release_items_by_template_key(LOOP_TASK_REWARD_ITEM_KEY)
  self:give_back_auto_cache(LOOP_TASK_REWARD_ITEM_KEY)
  self.v_complete_task_id = {}
  for i, config in ipairs(new_reward) do
    local reward_item = self:get_auto_cache(LOOP_TASK_REWARD_ITEM_KEY)
    local task_id = config.TaskId
    local task_item_config = task_config[task_id]
    local task_info = TaskMgr:get_task_by_id(task_id)
    local condition_id = task_item_config.Condition[1]
    local condition = condition_config[condition_id].Value
    Util.get_text("AmountBg/ActiveNeedNum_", reward_item).text = condition
    if task_info.state == TASK_STATE.received then
      Util.get_child_gameobj("Complete_", reward_item):SetActive(true)
      Util.get_child_gameobj("Mask", reward_item):SetActive(true)
      Util.get_child_gameobj("UnComplete_", reward_item):SetActive(false)
    else
      Util.get_child_gameobj("Complete_", reward_item):SetActive(false)
      Util.get_child_gameobj("Mask", reward_item):SetActive(false)
      Util.get_child_gameobj("UnComplete_", reward_item):SetActive(true)
      if task_info.state == TASK_STATE.receive then
        table.insert(self.v_complete_task_id, task_id)
      end
    end
    local award_group_id = task_item_config.Award
    for i = 1, 2 do
      local award_id = award_group_config[award_group_id][i]
      local item_key = "Reward" .. i .. "_"
      local item_obj = Util.get_child_gameobj("Award/" .. item_key, reward_item)
      if award_id and 0 ~= award_id then
        local award_item_config = award_config[award_id]
        local quality_img_path = string_format("Award/Reward%s_/ItemQuality_", i)
        local quality_img = Util.get_image(quality_img_path, reward_item)
        
        local function callback()
          UIMgr:get_ui("itemTip"):ui_show({
            item_id = award_item_config.ItemId
          })
        end
        
        self:create_item_obj(nil, quality_img.gameObject, LOOP_TASK_REWARD_ITEM_KEY, {
          item_id = award_item_config.ItemId,
          click_cb = callback
        })
        local txt_path = string_format("Award/Reward%s_/ItemAmount_/Bg/ItemNum_", i)
        Util.get_text(txt_path, reward_item).text = award_item_config.Num
        item_obj:SetActive(true)
      else
        item_obj:SetActive(false)
      end
    end
  end
  if self.v_complete_task_id and #self.v_complete_task_id > 0 and not self.v_timer_index then
    self.v_timer_index = Timer:add_timer("uilooptask.decide_request_reward", 0.5, function()
      TaskMgr:submit_task_list(self.v_complete_task_id, function()
        self:refresh_view(self.v_tag_select)
      end)
      self.v_complete_task_id = {}
      if self.v_timer_index then
        Timer:remove_timer(self.v_timer_index)
        self.v_timer_index = nil
      end
    end)
  end
end

return ui
