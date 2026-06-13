local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local _insert = table.insert
local CURSE_OBJ_CALSS = require("uimodule.stage_activity.challenge_ring_plus.curse_obj")
local TASK_OBJ = require("uimodule.stage_activity.challenge_ring_plus.curse_task_room_tem")
local Card_Destory_Help = require("uimodule.stage_activity.challenge_ring_plus.curse_card_destory_helper")
local AssetBarView = require("ui.asset_bar.asset_bar")
local TASK_OBJ_KEY = "TASK_OBJ_KEY"
local CommonDefine = Config.CommonDefine
local BIND_TYPE = Config.BIND_TYPE
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local MODEL = {
  v_task_tem = {
    "TaskTem",
    BIND_TYPE.OBJECT
  }
}
local asset_bar_config = {
  {
    item_id = Config.CURSE_GOLD,
    const_event = Const.MSG_ON_FIGHT_DIAMOND_UPDATE,
    is_fight_bag = true,
    not_show_max = true,
    bg_click = false
  }
}

function ui:on_click_finish_task_btn()
  local task_id = self.v_cur_select_task_id
  if not task_id or not ChallengeRingPlusMgr:is_complete_curse_task(task_id) then
    return
  end
  local task_data = ChallengeRingPlusMgr:get_curse_task(task_id)
  local copy_data
  if task_data.ability_drop_data or task_data.ornaments_drop_data then
    copy_data = UtilTable.copy_table(task_data)
    if task_data.task_reward.reward_type == CommonDefine.CURSE_TASK_REWARD_TYPE.SECT then
      copy_data.data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.TASK_ABILITY_AWARD
    elseif task_data.task_reward.reward_type == CommonDefine.CURSE_TASK_REWARD_TYPE.ORNAMENT_POOL then
      copy_data.data_type = curse_com_def.CURSE_CHOOSE_ITEM_TYPE.TASK_ORNAMENT_AWARD
    end
    ChallengeRingPlusMgr:drop_award_data_enqueue(copy_data)
    ChallengeRingPlusMgr:try_choose_drop_award()
    return
  end
  local actino_type, ornament_pos
  if task_data.task_reward.reward_type == CommonDefine.CURSE_TASK_REWARD_TYPE.ORNAMENTS then
    ornament_pos = BattleOrnamentMgr:get_null_pos()
    actino_type = ornament_pos and CommonDefine.ORNAMENTS_ACTION.EQUIT or CommonDefine.ORNAMENTS_ACTION.SELL
  else
    ornament_pos, actino_type = nil, nil
  end
  ChallengeRingPlusMgr:get_curse_task_award(task_id, actino_type, ornament_pos)
end

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnRet1", function()
    if self.v_show_only then
      self:ui_hide()
      return
    end
    Card_Destory_Help.confirm_quit_ui(self)
  end)
  self:set_button("BtnReceiveTask", function()
    local function sure_cb()
      self:confirm_task()
    end
    
    local tip = Util.format_str("仅能接取一个目标，是否接取？")
    UIMgr:get_ui("uinotice_tips"):ui_show(sure_cb, nil, tip, Util.format_str("确定"), Util.format_str("取消"))
  end)
  self:set_button("BtnFinishTask", function()
    self:on_click_finish_task_btn()
  end)
  self.v_task_obj_list = {}
  self:register_exist_auto_template(TASK_OBJ_KEY, self.v_task_tem, self.v_uiobjects.TaskList)
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar, asset_bar_config)
end

function ui:ui_on_show(card_index, group_id, show_only)
  self.v_show_only = show_only
  self.v_card_index = card_index
  self.v_curse_view = CURSE_OBJ_CALSS:ui_wrap(self, self.v_uiobjects.CurseObj, false)
  self.v_curse_view:set_enable(true)
  self:bind_auto_mq(Const.MSG_ON_CONFIRM_TASK, self.on_confirm_task, self)
  self:bind_auto_mq(Const.MSG_ON_GET_CURSE_TASK_AWARD, self.refresh_view, self)
  self:bind_auto_mq(Const.MSG_ON_GM_RESPONSE_SUC, self.refresh_view, self)
  self.v_asset_bar:on_create()
  self:refresh_view()
end

function ui:refresh_view()
  self:init_tasks()
  self:refresh_show_only()
end

function ui:ui_on_hide()
  self:remove_wrap_list()
  self.v_curse_view:ui_destroy()
  self.v_asset_bar:on_hide()
end

function ui:ui_on_destroy()
  self.v_asset_bar:on_destory()
end

function ui:refresh_show_only()
  if self.v_show_only then
    local is_have = self.v_cur_select_task_id and ChallengeRingPlusMgr:is_complete_curse_task(self.v_cur_select_task_id)
    Util.apply_grey_ex(self.v_uiobjects.BtnFinishTask, not is_have)
    self.v_uicompents.BtnFinishTask_btn.enabled = is_have
  end
  local is_in_fight = ChallengeRingPlusMgr:is_in_curse_fighting()
  self.v_uiobjects.BtnReceiveTask:SetActive(not self.v_show_only and not is_in_fight)
  self.v_uiobjects.BtnFinishTask:SetActive(self.v_show_only and not is_in_fight)
  self.v_uiobjects.ReceiveTaskTitle:SetActive(not self.v_show_only and not is_in_fight)
  self.v_uiobjects.TaskListTitle:SetActive(self.v_show_only and not is_in_fight)
end

function ui:set_select_task(task_id)
  self.v_cur_select_task_id = task_id
  self:refresh_show_only()
end

function ui:confirm_task()
  ChallengeRingPlusMgr:confirm_select_curse_task(self.v_card_index, self.v_cur_select_task_id)
end

function ui:on_confirm_task()
  self:ui_hide()
end

function ui:init_tasks()
  self:remove_wrap_list()
  self:give_back_auto_cache(TASK_OBJ_KEY)
  local task_list
  if self.v_show_only then
    task_list = ChallengeRingPlusMgr:get_curse_task_map()
  else
    local select_card_info = ChallengeRingPlusMgr:get_card_info(self.v_card_index)
    task_list = select_card_info.task_list
    if not task_list then
      Log.Error("获取任务牌数据失败  牌索引", self.v_card_index, " 牌id ", select_card_info.id, debug.traceback())
      return
    end
  end
  local has_task = true
  for _, task in pairs(task_list) do
    local item = self:get_auto_cache(TASK_OBJ_KEY)
    local task_obj = TASK_OBJ:ui_wrap_ex(self, item, true)
    task_obj:set_data(task, self.v_show_only)
    _insert(self.v_task_obj_list, task_obj)
    has_task = false
  end
  self.v_uiobjects.NoTask:SetActive(has_task)
end

function ui:remove_wrap_list()
  for k, item in pairs(self.v_task_obj_list) do
    item:ui_hide()
    item:ui_destroy()
    self.v_task_obj_list[k] = nil
  end
end

return ui
