local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local Math = require("base.mathx")

function ui:ui_finish_load()
  self:set_button("BtnJump", function()
    self.v_parent_ui:ui_hide()
  end)
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(task_id)
  self.v_task_id = task_id
  self:refresh_task_info()
  self:refresh_task_get_state()
end

function ui:refresh_task_info()
  local task_data = TaskMgr:get_task_by_id(self.v_task_id)
  local task_cfg = ShareRes.get_task_cfg(self.v_task_id)
  local condition_id = task_cfg.Condition[1]
  local condition_cfg = ShareRes.create("condition.condition", condition_id)
  local coms = self.v_uicompents
  local objs = self.v_uiobjects
  coms.TaskName_txt.text = task_cfg.Name
  local is_received = task_data.state == TASK_STATE.received
  local color = self.v_parent_ui:get_color(is_received)
  Util.set_color(coms.TaskName_txt, color)
  local progress_list = task_data.progress
  local progress = progress_list and #progress_list > 0 and progress_list[1].progress or 0
  local max = condition_cfg.Value
  local cur = Math.Clamp(progress or 0, 0, max)
  coms.TaskProgressNow_txt.text = cur
  coms.TaskProgressNeed_txt.text = max
  Util.set_color(coms.TaskProgressNow_txt, color)
  Util.set_color(coms.TaskProgressLine_txt, color)
  Util.set_color(coms.TaskProgressNeed_txt, color)
  objs.BgFinish:SetActive(is_received)
  objs.Bg:SetActive(not is_received)
  self:refresh_award(task_cfg.Award)
end

function ui:refresh_task_get_state()
  local coms = self.v_uicompents
  local objs = self.v_uiobjects
  local task_data = TaskMgr:get_task_by_id(self.v_task_id)
  local task_cfg = ShareRes.get_task_cfg(self.v_task_id)
  local condition_id = task_cfg.Condition[1]
  local condition_cfg = ShareRes.create("condition.condition", condition_id)
  local condition_progress
  if not task_data.condition then
    for _, data in pairs(task_data.progress) do
      if data.id == condition_id then
        condition_progress = data.progress
      end
    end
  else
    condition_progress = task_data.condition[condition_id]
  end
  coms.ProgressBarFill_img.fillAmount = condition_progress / condition_cfg.Value
  local get_state = task_data.state
  objs.BtnJump:SetActive(get_state == TASK_STATE.none)
  objs.BtnRecive:SetActive(get_state == TASK_STATE.receive)
  objs.Finish:SetActive(get_state == TASK_STATE.received)
  self:set_button_listener(self.v_uicompents.BtnRecive_btn, function()
    self.v_parent_ui:click_get_award_btn(self.v_task_id)
  end)
end

function ui:refresh_award(award_group_id)
  local item_parent = self.v_uiobjects.AwardContent
  local award_data = ShareRes.get_award_item_data(award_group_id)
  if not award_data then
    Log.Error("任务配置奖励为空， 奖励ID：", award_group_id or "空", debug.traceback())
    return
  end
  local task_data, state
  for _, data in ipairs(award_data) do
    task_data = TaskMgr:get_task_by_id(self.v_task_id) or WeeklyMgr:get_pvp_task_data(self.v_task_id)
    state = task_data.state
    local award_ui = self.v_parent_ui:get_award_item()
    local item_id = data[1]
    award_ui.transform:SetParent(item_parent.transform)
    local icon_path, quality_path = UtilUI.get_item_images(item_id)
    local quality_img = Util.get_image("ItemQuality_", award_ui)
    self:update_item_img(quality_img, quality_path)
    local icon = Util.get_image("ItemIcon_", award_ui.transform)
    self:update_item_img(icon, icon_path)
    local mask = self:get_child_gameobj("Mask_", award_ui)
    mask.gameObject:SetActive(state == TASK_STATE.received)
    local amount_txt = Util.get_text("ItemAmount_/Bg/ItemNum_", award_ui)
    amount_txt.text = data[2]
    self:set_button_listener(Util.get_button(nil, award_ui), function()
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = item_id,
        jump_cb = function()
          self.v_parent_ui:ui_hide()
        end
      })
    end)
  end
end

function ui:update_item_img(icon, path)
  icon.gameObject:SetActive(true)
  ResMgr:load_set_icon(icon, path)
end

return ui
