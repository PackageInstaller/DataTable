local Base = require("ui.uibase")
local SaticSv = require("ui.widget.static_scroll_view")
local ui = Util.create_child_mt(Base)
local AwardItemClass = Util.create_child_mt(require("ui.uiobject"))
local CtTemClass = Util.create_child_mt(require("ui.uiobject"))
local TASK_STATE = Config.TASK_STATE
local AWARD_ITEM_KEY = "ACT_BATTLE_GAME_AWARD"
local CtTemKey = "ACT_BATTLE_GAME_AWARD_CTTEM"
local Color = {black = 4735555, white = 16117218}

function AwardItemClass:ui_finish_load()
end

function AwardItemClass:set_data(data)
  local uicom = self.v_uicompents
  local uiobj = self.v_uiobjects
  uiobj.Mask:SetActiveEx(data.state == TASK_STATE.GET_REWARD)
  local item_icon_path = ShareRes.get_item_icon_path(data.ItemId)
  local item_quality_path = ShareRes.get_item_quality_path(data.ItemId)
  ResMgr:load_set_icon(uicom.CiItemIcon_img, item_icon_path)
  ResMgr:load_set_icon(uicom.CiPz_img, item_quality_path)
  uicom.CiItemAmount_txt.text = data.Num
  local btn = Util.get_button(nil, self.v_object)
  self:set_button_listener(btn, function()
    UIMgr:get_ui("itemTip"):ui_show({
      item_id = data.ItemId,
      is_exist_jump = false
    })
  end)
end

function AwardItemClass:on_clear()
end

function CtTemClass:ui_finish_load()
end

function CtTemClass:set_data(data)
  local uicom = self.v_uicompents
  local uiobj = self.v_uiobjects
  uicom.CtContent_txt.text = data.Desc
  local taskInfo = TaskMgr:get_task_by_id(data.Id)
  local task_process = taskInfo and taskInfo.progress and #taskInfo.progress > 0 and taskInfo.progress[1].progress or 0
  local condition_id = data.Condition[1]
  local total = ShareRes.create("condition.condition", condition_id)
  uicom.Progress_txt.text = string.format("(%d/%d)", task_process, total.Value)
  local state = TaskMgr:get_task_state(data.Id)
  uiobj.CtGet:SetActiveEx(state == TASK_STATE.COMPLETE)
  uiobj.NowText:SetActiveEx(state == TASK_STATE.RECEIVE and 0 == data.Jump)
  uiobj.CtJump:SetActiveEx(state == TASK_STATE.RECEIVE and 0 ~= data.Jump)
  uiobj.FinishText:SetActiveEx(state == TASK_STATE.GET_REWARD)
  uiobj.Bg:SetActiveEx(state ~= TASK_STATE.GET_REWARD)
  uiobj.BgComplete:SetActiveEx(state == TASK_STATE.GET_REWARD)
  uicom.CtContent_txt.color = Util.get_unity_color_by_hex(state == TASK_STATE.GET_REWARD and Color.white or Color.black)
  uicom.Progress_txt.color = Util.get_unity_color_by_hex(state == TASK_STATE.GET_REWARD and Color.white or Color.black)
  if uiobj.CtJump.activeSelf then
    self:set_button_listener(uicom.CtJump_btn, function()
      self.v_parent_ui:ui_hide()
      SysOpenMgr:jump_to_sys(data.Jump, true)
    end)
  end
  if uiobj.CtGet.activeSelf then
    self:set_button_listener(uicom.CtGet_btn, function()
      TaskMgr:submit_task(data.Id)
    end)
  end
  local award_list = ShareRes.get_awards(data.Award)
  for _, value in ipairs(award_list) do
    value.state = state
  end
  local condition_config = ShareRes.create("condition.condition")
  local now = (taskInfo or E).progress or E[1] or E.progress or 0
  local need = condition_config[data.Condition[1]].Value
  uicom.CtTaskDone_img.fillAmount = now / need
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.AwardContent, AwardItemClass, AWARD_ITEM_KEY .. data.idx)
  self.v_static_sv:update_list(award_list)
end

function CtTemClass:on_clear()
  self.v_static_sv:clear()
  self.v_static_sv = nil
end

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide(false)
  end)
  self:set_button("BtnRetX", function()
    self:ui_hide(false)
  end)
  self:set_button("BtnAllGet", function()
    local taskgroup_id = ShareRes.create("activity.activity_mini_game")[self.v_activity_id].TaskGroupId
    local tmp_list = ShareRes.get_task_group(taskgroup_id)
    local t = {}
    for task_id, _ in pairs(tmp_list) do
      local state = TaskMgr:get_task_state(task_id)
      if state == TASK_STATE.COMPLETE then
        table.insert(t, task_id)
      end
    end
    if next(t) then
      TaskMgr:submit_task_list(t)
    end
  end)
  self.v_static_sv = SaticSv:new(self, self.v_uiobjects.TaskContent, CtTemClass, CtTemKey)
end

function ui:ui_on_show(activity_id)
  self.v_activity_id = activity_id
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.on_task_update, self)
  self:refresh()
end

function ui:refresh()
  local taskgroup_id = ShareRes.create("activity.activity_mini_game")[self.v_activity_id].TaskGroupId
  local tmp_list = ShareRes.get_task_group(taskgroup_id)
  local task_list = {}
  local has_award = false
  for task_id, v in pairs(tmp_list) do
    table.insert(task_list, v)
    local state = TaskMgr:get_task_state(task_id)
    if state == TASK_STATE.COMPLETE then
      has_award = true
    end
  end
  
  local function get_sort_id(state)
    if state == TASK_STATE.COMPLETE then
      return 1
    elseif state == TASK_STATE.GET_REWARD then
      return 3
    else
      return 2
    end
  end
  
  table.sort(task_list, function(a, b)
    local a_state = TaskMgr:get_task_state(a.Id)
    local b_state = TaskMgr:get_task_state(b.Id)
    local a_sort = get_sort_id(a_state)
    local b_sort = get_sort_id(b_state)
    if a_sort == b_sort then
      if a.Priority == b.Priority then
        return a.Id < b.Id
      else
        return a.Priority > b.Priority
      end
    else
      return a_sort < b_sort
    end
  end)
  self.v_static_sv:update_list(task_list)
  Util.apply_grey_ex(self.v_uiobjects.BtnAllGet, not has_award)
end

function ui:on_task_update()
  self:refresh()
end

return ui
