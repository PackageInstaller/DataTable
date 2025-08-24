local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load(...)
  self.v_template_key = "task_" .. self.v_cfg.name
  self.v_tog_list = {}
  self:register_exist_auto_template(self.v_template_key, self.v_uiobjects.Task, self.v_uiobjects.TaskList)
  self:set_button("BtnChoose", function()
    self:_onclick_choose_btn()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show(npc_data, group_id, ...)
  if not group_id then
    self:ui_hide()
    return
  end
  self.v_npc_data = npc_data
  self.v_group_id = group_id
  local cfg = ShareRes.create("battle.battle_task_by_group", self.v_group_id)
  if not cfg then
    self:ui_hide()
    return
  end
  self:_refresh_task_list(cfg)
  if 0 == #self.v_tog_list then
    return
  end
  self.v_tog_list[1].tog.isOn = true
  self:_onclick_task_tog(self.v_tog_list[1].task_data.Id, true)
end

function ui:ui_on_hide()
  UIMgr:get_ui("fight"):set_uiobject_visible("Main", true)
end

function ui:_refresh_task_list(task_list)
  self:give_back_auto_cache(self.v_template_key, false)
  local idx = 1
  for i, v in pairs(task_list) do
    local item = self:get_auto_cache(self.v_template_key)
    self.v_tog_list[idx] = self:_set_task_content(item, i, i)
    idx = idx + 1
  end
end

function ui:_set_task_content(obj, idx, task_id)
  local task_data = ShareRes.create("battle.battle_task", task_id)
  local content = self:get_text("TaskContent", obj)
  content.text = string.format([[
%s
%s]], task_data.Name, task_data.Desc)
  local checkBg = self:get_child_gameobj("Choose", obj)
  local tog = self:get_toggle(nil, obj)
  self:set_toggle_listener(tog, function(isOn)
    checkBg:SetActive(isOn)
    self:_onclick_task_tog(task_data.Id, isOn)
  end)
  return {tog = tog, task_data = task_data}
end

function ui:_onclick_task_tog(task_id, isOn)
  if self.v_cur_task_id == task_id then
    return
  end
  if isOn then
    self.v_cur_task_id = task_id
  end
end

function ui:_onclick_choose_btn()
  FunctionalNpcMgr:choose_battle_task_end(self.v_npc_data, self.v_cur_task_id)
  local scene_logic = SceneMgr:get_scene_logic()
  scene_logic:remove_functional_npc(self.v_npc_data.npc_id)
  self:ui_hide()
end

return ui
