local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local MathX = require("base.mathx")
local GOAL_STATE = {
  NOT = 0,
  CAN = 1,
  HAS = 2
}
local COLOR = {
  DARK = "000000",
  BRIGHT = "F5EDE2",
  BROWN = "ac9479"
}

function ui:set_data(data, template_key, ...)
  self.v_param = {
    ...
  }
  self.v_data = data
  self.v_template_key = template_key
  self:refresh()
end

function ui:refresh()
  self:refresh_novice_task_award()
end

function ui:ui_on_hide()
  self:release_items_by_template_key(self.v_template_key)
end

function ui:refresh_novice_task_award()
  local data = self.v_data
  local reward_list = ShareRes.get_award_item_data(data.AwardGoupId)
  local state = NoviceMgr:get_goal_task_state(data.Id)
  self.v_uiobjects.Got:SetActive(state == GOAL_STATE.HAS)
  local red_point = self.v_uiobjects.RedDot
  if state >= GOAL_STATE.CAN then
    self.v_uicompents.Slider_sld.value = 1
    if state == GOAL_STATE.CAN then
      self.v_uiobjects.Complete:SetActive(true)
      RedPointMgr:bind_redpoint(self, red_point, RedEnum.NOVICE_STEP_TASK, RedEnum.NOVICE_DAILY_TASK)
    else
      self.v_uiobjects.Complete:SetActive(false)
      red_point:SetActive(false)
      RedPointMgr:unbind_redpoint_by_id(self, RedEnum.NOVICE_STEP_TASK, RedEnum.NOVICE_DAILY_TASK)
    end
    Util.set_color(self.v_uicompents.TaskPoint_img, COLOR.BRIGHT)
    self.v_uiobjects.Fill:SetActive(true)
  else
    if not self.v_param[2] or self.v_param[2] <= 0 then
      self.v_uiobjects.Fill:SetActive(false)
    else
      self.v_uicompents.Slider_sld.value = MathX.Clamp(self.v_param[3] / self.v_param[4], 0, 1)
      self.v_uiobjects.Fill:SetActive(true)
    end
    Util.set_color(self.v_uicompents.TaskPoint_img, COLOR.DARK)
    Util.set_color(self.v_uicompents.TaskPointNeed_txt, COLOR.BROWN)
    self.v_uiobjects.Complete:SetActive(false)
    red_point:SetActive(false)
    RedPointMgr:unbind_redpoint_by_id(self, RedEnum.NOVICE_STEP_TASK, RedEnum.NOVICE_DAILY_TASK)
  end
  local itemobj = self.v_uiobjects.itemObj
  self:create_item_obj(nil, itemobj, self.v_template_key, {
    item_id = reward_list[1][1],
    click_cb = function()
      local task_state = NoviceMgr:get_goal_task_state(data.Id)
      if task_state == GOAL_STATE.CAN then
        local finished_task_award_list = self.v_parent_ui:get_finished_task_award_list()
        NoviceMgr:request_get_allTask_prog_award(finished_task_award_list)
      else
        UIMgr:get_ui("itemTip"):ui_show({
          item_id = reward_list[1][1]
        })
      end
    end
  })
  self.v_uicompents.TaskPointNeed_txt.text = data.Progress
  self.v_uiobjects.AmountBg:SetActive(nil ~= reward_list[1][2] and reward_list[1][2] > 1)
  self.v_uicompents.ItemAmount_txt.text = reward_list[1][2]
end

return ui
