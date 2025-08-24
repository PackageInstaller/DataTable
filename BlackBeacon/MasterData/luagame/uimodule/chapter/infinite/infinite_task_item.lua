local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local RELEASE_INFINITE_TASK_ITEM_KEY = "RELEASE_INFINITE_TASK_ITEM_KEY"
local util_get_color = Util.get_unity_color_by_hex
local task_name_normal_color = util_get_color(tonumber("A19A8D", 16))
local task_name_get_color = util_get_color(tonumber("B19F89", 16))
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local MODEL = {
  v_bg = {
    "Bg",
    BIND_TYPE.OBJECT
  },
  v_item_obj = {
    "ItemObj",
    BIND_TYPE.OBJECT
  },
  v_task_info_obj = {
    "TaskInfo",
    BIND_TYPE.OBJECT
  },
  v_have_get = {
    "HaveGet",
    BIND_TYPE.OBJECT
  },
  v_btn_get = {
    "BtnGet",
    BIND_TYPE.OBJECT
  },
  v_process_now = {
    "ProcessNow",
    BIND_TYPE.TEXT
  },
  v_process_max = {
    "ProcessMax",
    BIND_TYPE.TEXT
  },
  v_progress_bar = {
    "ProgressBar",
    BIND_TYPE.SLIDER
  },
  v_task_desc = {
    "TaskDesc",
    BIND_TYPE.TEXT
  },
  v_task_name = {
    "TaskName",
    BIND_TYPE.TEXT
  },
  v_item_quality = {
    "ItemQuality",
    BIND_TYPE.OBJECT
  },
  v_item_num = {
    "ItemNum",
    BIND_TYPE.TEXT
  }
}

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnGet", function()
    TaskMgr:submit_task(self.v_task_cfg.Id, function()
      self:refresh_task_state(self.v_task_cfg)
    end)
  end)
end

function ui:ui_on_show(task_cfg)
  if type(task_cfg) ~= "table" then
    return
  end
  self.v_task_cfg = task_cfg
  self:init_task_item_info(task_cfg)
  self:refresh_task_state(task_cfg)
end

function ui:ui_on_hide()
end

function ui:init_task_item_info(task_cfg)
  self.v_task_name.text = task_cfg.Name
  self.v_task_desc.text = task_cfg.Desc
  self:release_items_by_template_key(RELEASE_INFINITE_TASK_ITEM_KEY)
  local reward_list = ShareRes.get_award_item_data(task_cfg.Award)
  local reward_data = reward_list[1]
  self:create_item_obj(nil, self.v_item_quality, RELEASE_INFINITE_TASK_ITEM_KEY, {
    item_id = reward_data[1],
    click_cb = function()
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = reward_data[1]
      })
    end
  })
  self.v_item_num.text = reward_data[2]
end

function ui:refresh_task_state(task_cfg)
  local task_info = TaskMgr:get_task_by_id(task_cfg.Id)
  local condition_cfg = ShareRes.create("condition.condition", task_cfg.Condition[1])
  local now_progress_value = task_info and task_info.progress and #task_info.progress > 0 and task_info.progress[1].progress or 0
  self.v_process_now.text = now_progress_value
  self.v_process_max.text = condition_cfg.Value
  self.v_progress_bar.maxValue = condition_cfg.Value
  self.v_progress_bar.value = now_progress_value
  local bg = self:get_canvas_group(nil, self.v_bg)
  local item_canvas = self:get_canvas_group(nil, self.v_item_obj)
  local task_info_canvas = self:get_canvas_group(nil, self.v_task_info_obj)
  local task_state = TaskMgr:get_task_state(task_cfg.Id)
  if task_state == TASK_STATE.receive or task_state == TASK_STATE.received then
    bg.alpha = 1
    item_canvas.alpha = 1
    task_info_canvas.alpha = 1
    self.v_task_name.color = task_name_get_color
  else
    bg.alpha = 0.6
    item_canvas.alpha = 0.9
    task_info_canvas.alpha = 0.6
    self.v_task_name.color = task_name_normal_color
  end
  self.v_have_get:SetActive(task_state == TASK_STATE.received)
  self.v_btn_get:SetActive(task_state == TASK_STATE.receive)
  self.v_task_state = task_state
end

function ui:get_item_state()
  return self.v_task_state
end

return ui
