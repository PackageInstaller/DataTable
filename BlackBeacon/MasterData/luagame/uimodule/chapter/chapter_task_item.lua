local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local Math = require("base.mathx")

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:set_data(task_id, jump_callback, show_jump_btn)
  self.v_task_id = task_id
  self.jump_callback = jump_callback
  self.show_jump_btn = true == show_jump_btn
end

function ui:refresh_task_item()
  local task_data = TaskMgr:get_task_by_id(self.v_task_id) or WeeklyMgr:get_pvp_task_data(self.v_task_id)
  local task_cfg = ShareRes.get_task_cfg(self.v_task_id)
  local condition_id = task_cfg.Condition[1]
  local condition_cfg = ShareRes.create("condition.condition", condition_id)
  local coms = self.v_uicompents
  local objs = self.v_uiobjects
  local name_txt = coms.CtTitle_txt
  if not Util.is_nil(name_txt) then
    name_txt.text = task_cfg.Name
  end
  local is_receive = task_data.state == TASK_STATE.receive
  local desc_txt = coms.CtContent_txt
  desc_txt.text = task_cfg.Desc
  local color = self.v_parent_ui:get_color(is_receive)
  Util.set_color(desc_txt, color)
  local progress_list = task_data.progress
  local progress = progress_list and #progress_list > 0 and progress_list[1].progress or 0
  local max = condition_cfg.Value
  local cur = Math.Clamp(progress or 0, 0, max)
  if task_data and (task_data.state == Config.CommonDefine.TaskState.Complete or task_data.state == Config.CommonDefine.TaskState.GotAward) then
    cur = max
  end
  local now_progress_txt = coms.Now_txt
  now_progress_txt.text = cur
  Util.set_color(now_progress_txt, color)
  local need_progress_text = coms.Need_txt
  need_progress_text.text = max
  Util.set_color(need_progress_text, color)
  local BgComplete = objs.BgComplete
  BgComplete.gameObject:SetActive(is_receive)
  local split = coms.split_txt
  Util.set_color(split, color)
  self:refresh_award(task_cfg.Award)
  local show_jump = self.show_jump_btn and task_cfg.Jump and 0 ~= task_cfg.Jump
  if show_jump then
    self:set_button_listener(self.v_uicompents.CtJump_btn, function()
      if self.jump_callback then
        self.jump_callback()
      end
      SysOpenMgr:jump_to_sys(task_cfg.Jump, true)
    end)
  end
end

function ui:refresh_task_get_state()
  local coms = self.v_uicompents
  local objs = self.v_uiobjects
  local task_data = TaskMgr:get_task_by_id(self.v_task_id) or WeeklyMgr:get_pvp_task_data(self.v_task_id)
  local task_cfg = ShareRes.get_task_cfg(self.v_task_id)
  local show_jump = self.show_jump_btn and task_cfg.Jump and 0 ~= task_cfg.Jump
  local condition_id = task_cfg.Condition[1]
  local condition_cfg = ShareRes.create("condition.condition", condition_id)
  local slider_img = coms.CtTaskDone_img
  local condition_progress = 0
  if not task_data.condition then
    for key, data in pairs(task_data.progress) do
      if data.id == condition_id then
        condition_progress = data.progress
      end
    end
  else
    condition_progress = task_data.condition[condition_id]
  end
  slider_img.fillAmount = (condition_progress or 0) / condition_cfg.Value
  local get_state = task_data.state
  local btn_obj = objs.CtGet
  btn_obj:SetActive(get_state == TASK_STATE.receive)
  local now_obj = objs.NowText
  now_obj:SetActive(get_state == TASK_STATE.none and not show_jump)
  local jump_btn_obj = objs.CtJump
  if jump_btn_obj then
    jump_btn_obj:SetActive(get_state == TASK_STATE.none and show_jump)
  end
  local suc_obj = objs.FinishText
  suc_obj:SetActive(get_state == TASK_STATE.received)
  local bg = objs.Bg
  bg:SetActive(get_state == TASK_STATE.none or get_state == TASK_STATE.received)
  local complete_img = objs.TaskComplete
  if not Util.is_nil(complete_img) then
    complete_img:SetActive(get_state == TASK_STATE.received)
  end
  local finish = objs.FinishMask
  finish:SetActive(false)
  if get_state == TASK_STATE.received then
    finish:SetActive(true)
    btn_obj:SetActive(false)
  end
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
    award_ui.transform:SetLocalScaleA(1, 1, 1)
    local icon_path, quality_path = UtilUI.get_item_images(item_id)
    local quality_img = Util.get_image("CiPz", award_ui)
    self:update_item_img(quality_img, quality_path)
    local icon = Util.get_image("CiItemIcon", award_ui.transform)
    self:update_item_img(icon, icon_path)
    local mask = self:get_child_gameobj("Mask_", award_ui)
    mask.gameObject:SetActive(state == TASK_STATE.received)
    local amount_txt = Util.get_text("AmoBg/CiItemAmount", award_ui)
    amount_txt.text = data[2]
    self:set_button_listener(Util.get_button(nil, award_ui), function()
      UIMgr:get_ui("itemTip"):ui_show({
        item_id = item_id,
        jump_cb = self.jump_callback
      })
    end)
  end
  self:set_button_listener(self.v_uicompents.CtGet_btn, function()
    self.v_parent_ui:click_get_award_btn(self.v_task_id)
  end)
end

function ui:refresh_star_info(cfg)
  local data_list = {}
  for index, condition in ipairs(cfg.StarCondition) do
    if condition > 0 then
    end
    local award_data = ShareRes.get_award_item_data(condition)
  end
end

function ui:update_item_img(icon, path)
  icon.gameObject:SetActive(true)
  ResMgr:load_set_icon(icon, path)
end

return ui
