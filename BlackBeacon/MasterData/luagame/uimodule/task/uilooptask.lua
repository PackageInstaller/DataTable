local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CHAPTER_CONFIG = require("uimodule.chapter.chapter_config")
local ToggleTab = require("ui.widget.widget_toggle_tab")
local AssetBarView = require("ui.asset_bar.asset_bar")
local BIND_TYPE = Config.BIND_TYPE
local LOOP_TASK_REWARD_ITEM_KEY = "LOOP_TASK_REWARD_ITEM"
local LOOP_TASK_ITEM_KEY = "LOOP_TASK_ITEM"
local _tinsert = table.insert
local Timer = Global.timer
local string_format = string.format
local Math = require("base.mathx")
local _clamp = Math.Clamp
local TASK_CONFIG = require("gamelogic.task.task_config")
local TASK_STATE = TASK_CONFIG.TASK_STATE
local util_get_color = Util.get_unity_color_by_hex
local toggle_select_color = util_get_color(tonumber("fff0d5", 16))
local toggle_unselect_color = util_get_color(tonumber("bcb4a5", 16))
local TASK_TYPE = {
  NEW_TASK = 1,
  DAILY_TASK = 2,
  WEEKLY_TASK = 3,
  MAIN_LINE_TASK = 4
}
local TASK_TYPE_TEXT = {
  [1] = Util.format_str("新手任务"),
  [2] = Util.format_str("每日任务"),
  [3] = Util.format_str("每周任务"),
  [4] = Util.format_str("主线任务")
}
local MODEL = {
  v_reward_content_obj = {
    "Reward_Content",
    BIND_TYPE.OBJECT
  },
  v_reward_item_obj = {
    "Reward_template",
    BIND_TYPE.OBJECT
  },
  v_item_content_obj = {
    "Task_Item_Content",
    BIND_TYPE.OBJECT
  },
  v_item_obj = {
    "Task_template",
    BIND_TYPE.OBJECT
  },
  v_xinshou_toggle = {
    "Xinshou",
    BIND_TYPE.TOGGLE
  },
  v_meiri_toggle = {
    "Meiri",
    BIND_TYPE.TOGGLE
  },
  v_meizhou_toggle = {
    "Meizhou",
    BIND_TYPE.TOGGLE
  },
  v_zhuxian_toggle = {
    "Zhuxian",
    BIND_TYPE.TOGGLE
  },
  v_active_now = {
    "ActiveNow",
    BIND_TYPE.TEXT
  },
  v_active_total = {
    "ActiceNeed",
    BIND_TYPE.TEXT
  },
  v_interval = {
    "Actice/",
    BIND_TYPE.TEXT
  },
  v_all_complete_obj = {
    "AllCompleteObj",
    BIND_TYPE.OBJECT
  },
  v_ani_vx_all_complete = {
    "Ani_VX_AllComplete",
    BIND_TYPE.OBJECT
  },
  v_award_obj = {
    "AwardObj",
    BIND_TYPE.OBJECT
  },
  v_award1 = {
    "Award1",
    BIND_TYPE.OBJECT
  },
  v_award2 = {
    "Award2",
    BIND_TYPE.OBJECT
  }
}
local TOGGLE_LIST = {
  [1] = {
    tog_name = "Xinshou",
    tog_show_name = "N E W",
    sys_id = 100
  },
  [2] = {
    tog_name = "Meiri",
    tog_show_name = "D A I L I E S",
    sys_id = 2,
    redpoint_id = 10
  },
  [3] = {
    tog_name = "Meizhou",
    tog_show_name = "W E E K L Y",
    sys_id = 3,
    redpoint_id = 11
  },
  [4] = {
    tog_name = "Zhuxian",
    tog_show_name = "M A I N",
    sys_id = 101
  }
}
local ITEM_QUALITY_PATH = "UICommon/pz_0%d"
local TASK_RED_ID = 9

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnReturn", function()
    self:ui_hide()
  end)
  self.v_all_btn = self:get_button(nil, self.v_uiobjects.GetAll)
  self:set_button("GetAll", function()
    self:do_submit_all()
  end)
  self:set_button("BtnAward", function()
    local daily_task_reward_list = ShareRes.create("task.daily_task_reward")
    local weekly_task_reward_list = ShareRes.create("task.weekly_task_reward")
    local data
    if self.v_tag_select == TASK_TYPE.DAILY_TASK then
      data = daily_task_reward_list
    elseif self.v_tag_select == TASK_TYPE.WEEKLY_TASK then
      data = weekly_task_reward_list
    end
    UIMgr:get_ui("task_reward_tips"):ui_show(data)
  end)
  self:register_exist_auto_template(LOOP_TASK_REWARD_ITEM_KEY, self.v_reward_item_obj, self.v_reward_content_obj)
  self:register_exist_auto_template(LOOP_TASK_ITEM_KEY, self.v_item_obj, self.v_item_content_obj)
  self:init_toggle()
  self.v_asset_bar = AssetBarView:new(self, self.v_uiobjects.AssetBar)
  self.v_player_active = 0
end

function ui:cache_ui()
  return true
end

function ui:get_cache_data()
  return self.v_last_tag_select
end

function ui:init_toggle()
  self.v_tag_toggles = {}
  self.v_tog_list = {}
  for i, v in ipairs(TOGGLE_LIST) do
    local tog = self:get_toggle(nil, self.v_uiobjects[v.tog_name])
    table.insert(self.v_tag_toggles, tog)
    self.v_tog_list[v.sys_id] = {
      lock = self:get_child_gameobj("Lock", tog.gameObject)
    }
    if v.redpoint_id then
      RedPointMgr:bind_redpoint(self, self:get_child_gameobj("Red", tog.gameObject), v.redpoint_id, TASK_RED_ID)
    end
  end
  for index, toggle in ipairs(self.v_tag_toggles) do
    local text = Util.get_text("TagName", toggle.transform)
    text.text = TASK_TYPE_TEXT[index]
  end
  self.v_toggle_tab = ToggleTab:new(self)
  self.v_toggle_tab:init_by_toggles(self.v_tag_toggles, function(select, last_select, select_toggle, last_select_toggle)
    self:select_tag_toggle(select, last_select, select_toggle, last_select_toggle)
  end, 2, false)
end

function ui:ui_on_show(init_idx)
  self:bind_auto_mq(Const.MSG_ON_TASK_UPDATE, self.refresh_task_view, self)
  self:bind_auto_mq(Const.MSG_NEW_SYS_OPEN, self.refresh_sys_open, self)
  self.v_receive_id_list = {}
  self.v_receive_item_list = {}
  local toggle_idx = init_idx or TASK_TYPE.DAILY_TASK
  self:select_tag_toggle(toggle_idx)
  self.v_toggle_tab:set_toggle_by_index(toggle_idx)
  self:refresh_tag_lock()
  self.v_asset_bar:reset_by_id_list({
    Config.PLAYER_SP_ITEMID
  })
  self.v_asset_bar:on_create()
  self:clear_Seq()
end

function ui:ui_on_hide()
  self.v_receive_id_list = nil
  self.v_receive_item_list = nil
  self.v_tag_select = nil
  self.v_complete_task_id = {}
  self.v_daily_task_list = nil
  self.v_weekly_task_list = nil
  if self.v_timer_index then
    Timer:remove_timer(self.v_timer_index)
    self.v_timer_index = nil
  end
  self.v_toggle_tab:set_toggle_by_index(-1)
  self.v_asset_bar:on_hide()
  self:clear_Seq()
end

function ui:ui_on_destroy()
  self.v_tag_toggles = nil
  self.v_toggle_tab = nil
  self.v_asset_bar:on_destory()
  self:clear_Seq()
end

function ui:refresh_sys_open(msg)
  if not msg or not msg.mm_obj then
    return
  end
  local sys_id = msg.mm_obj
  local lock = self.v_tog_list[sys_id].lock
  if lock then
    lock:SetActive(not SysOpenMgr:get_sys_is_open(sys_id))
  end
end

function ui:refresh_tag_lock()
  for sys_id, v in pairs(self.v_tog_list) do
    local open = SysOpenMgr:get_sys_is_open(sys_id)
    v.lock:SetActive(not open)
  end
end

function ui:refresh_view(idx)
  self:clear_Seq()
  self.v_tag_select = idx
  self:refresh_reward_view(idx)
  self:refresh_task_view(idx)
end

function ui:refresh_reward_view(idx)
  if idx == TASK_TYPE.DAILY_TASK then
    local daily_task_reward_list = ShareRes.create("task.daily_task_reward")
    self:_refresh_reward_item(daily_task_reward_list)
  elseif idx == TASK_TYPE.WEEKLY_TASK then
    local weekly_task_reward_list = ShareRes.create("task.weekly_task_reward")
    self:_refresh_reward_item(weekly_task_reward_list)
  end
end

function ui:_refresh_reward_item(reward_list_config)
  local condition_config = ShareRes.create("condition.condition")
  local task_config = ShareRes.create("condition.task")
  local award_group_config = ShareRes.create("award.award_group")
  local award_config = ShareRes.create("award.award")
  local item_config = ShareRes.create("item.item")
  local new_reward = {}
  local is_all_complete = 0
  for _, data in pairs(reward_list_config) do
    local task_info = TaskMgr:get_task_by_id(data.TaskId)
    local sort_index = 1
    if task_info.state == TASK_STATE.receive then
      sort_index = 2
      is_all_complete = is_all_complete + 1
    elseif task_info.state == TASK_STATE.received then
      sort_index = 0
      is_all_complete = is_all_complete + 1
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
  local cur_active = task_config[new_reward[1].TaskId]
  local cur_need_active = condition_config[cur_active.Condition[1]].Value
  self.v_active_total.text = cur_need_active
  self.v_interval.text = "/"
  if is_all_complete == #new_reward then
    self.v_active_total.text = ""
    self.v_interval.text = ""
  end
  self:release_items_by_template_key(LOOP_TASK_REWARD_ITEM_KEY)
  self:give_back_auto_cache(LOOP_TASK_REWARD_ITEM_KEY)
  self.v_complete_task_id = {}
  local complete_num = 0
  local award_id_list
  for i, config in ipairs(new_reward) do
    local reward_item = self:get_auto_cache(LOOP_TASK_REWARD_ITEM_KEY)
    local task_id = config.TaskId
    local task_item_config = task_config[task_id]
    local task_info = TaskMgr:get_task_by_id(task_id)
    local condition_id = task_item_config.Condition[1]
    local condition = condition_config[condition_id].Value
    if task_info.state == TASK_STATE.received then
      complete_num = complete_num + 1
      Util.get_child_gameobj("Bg_finish", reward_item):SetActive(true)
      Util.get_child_gameobj("Bg_normal", reward_item):SetActive(false)
      Util.get_child_gameobj("Active_list", reward_item):SetActive(false)
    else
      award_id_list = award_id_list or award_group_config[task_config[task_id].Award]
      Util.get_child_gameobj("Bg_finish", reward_item):SetActive(false)
      Util.get_child_gameobj("Bg_normal", reward_item):SetActive(true)
      Util.get_child_gameobj("Active_list", reward_item):SetActive(true)
      local last_need_num = self:get_last_task_need_num(config.Id, reward_list_config)
      local show_condition = condition - last_need_num
      for i = 1, 3 do
        local need_img = Util.get_image("Active_list/Need" .. i, reward_item)
        local complete_img = Util.get_image("Complete", need_img.transform)
        complete_img.gameObject:SetActive(false)
        need_img.gameObject:SetActive(false)
        if i <= show_condition then
          local progress = task_info and task_info.progress and #task_info.progress > 0 and task_info.progress[1].progress or 0
          if progress >= last_need_num + i then
            complete_img.gameObject:SetActive(true)
          end
          need_img.gameObject:SetActive(true)
        end
      end
      if task_info.state == TASK_STATE.receive then
        table.insert(self.v_complete_task_id, task_id)
      end
    end
    local award_group_id = task_item_config.Award
    for i = 1, 2 do
      local award_id = award_group_config[award_group_id][i]
      local item_key = "Item_template" .. i
      local item_obj = Util.get_child_gameobj("Item_list/" .. item_key, reward_item)
      if award_id and 0 ~= award_id then
        local award_item_config = award_config[award_id]
        local quality_img_path = string_format("Item_list/Item_template%s/ItemPz01", i)
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
        local txt_path = string_format("Item_list/Item_template%s/ItemAmount", i)
        Util.get_text(txt_path, reward_item).text = award_item_config.Num
        item_obj:SetActive(true)
      else
        item_obj:SetActive(false)
      end
    end
  end
  self.v_ani_vx_all_complete:SetActive(false)
  if complete_num == #new_reward then
    self.v_all_complete_obj:SetActive(true)
    self.v_ani_vx_all_complete:SetActive(true)
    self.v_award_obj:SetActive(false)
  else
    self.v_all_complete_obj:SetActive(false)
    self.v_award_obj:SetActive(true)
    local award_max = 2
    for i = 1, 2 do
      local award_obj = self["v_award" .. i]
      if 0 ~= award_id_list[i] then
        award_obj:SetActive(true)
        local award_item_config = award_config[award_id_list[i]]
        local quality_img = Util.get_image("ItemQuality_", award_obj)
        
        local function callback()
          UIMgr:get_ui("itemTip"):ui_show({
            item_id = award_item_config.ItemId
          })
        end
        
        self:create_item_obj(nil, quality_img.gameObject, LOOP_TASK_ITEM_KEY, {
          item_id = award_item_config.ItemId,
          click_cb = callback
        })
        Util.get_text("ItemAmount_/Bg/ItemNum_", award_obj).text = award_item_config.Num
      else
        award_obj:SetActive(false)
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

function ui:get_last_task_need_num(Id, all_cfg)
  if Id <= 1 then
    return 0
  end
  local task_data = all_cfg[Id - 1]
  if task_data then
    local task_config = ShareRes.create("condition.task", task_data.TaskId)
    local condition_id = task_config.Condition[1]
    local condition_config = ShareRes.create("condition.condition", condition_id)
    return condition_config.Value
  end
  return 0
end

function ui:decide_request_reward(task_id)
  TaskMgr:submit_task(task_id, function()
    self:refresh_reward_view(self.v_tag_select)
  end)
end

function ui:refresh_task_view()
  if self.v_tag_select == TASK_TYPE.DAILY_TASK then
    if not self.v_daily_task_list then
      self.v_daily_task_list = ShareRes.create("task.daily_task")
    end
    self:_refresh_task_item(self.v_daily_task_list)
  elseif self.v_tag_select == TASK_TYPE.WEEKLY_TASK then
    if not self.v_weekly_task_list then
      self.v_weekly_task_list = ShareRes.create("task.weekly_task")
    end
    self:_refresh_task_item(self.v_weekly_task_list)
  end
end

function ui:_refresh_task_item(task_list_config)
  local condition_config = ShareRes.create("condition.condition")
  local task_config = ShareRes.create("condition.task")
  local award_group = ShareRes.create("award.award_group")
  local award_config = ShareRes.create("award.award")
  local new_data = {}
  self.v_receive_id_list = {}
  self.v_receive_item_list = {}
  self.v_player_active = 0
  local complete_active = 0
  for _, config in ipairs(task_list_config) do
    local task_id = config.TaskId
    local task_item_config = task_config[task_id]
    local task_info = TaskMgr:get_task_by_id(task_id)
    local state = task_info.state
    local sort_index = 1
    if state == TASK_STATE.receive then
      sort_index = 2
    elseif state == TASK_STATE.received then
      sort_index = 0
    end
    config.sort_index = sort_index
    _tinsert(new_data, config)
  end
  table.sort(new_data, function(a, b)
    if a.sort_index == b.sort_index then
      return a.Id < b.Id
    end
    return a.sort_index > b.sort_index
  end)
  for idx = 1, 5 do
    self.v_uiobjects["FX_UI_Move" .. idx]:SetActive(false)
  end
  self.v_uiobjects.FX_UI_Bloom:SetActive(false)
  self:give_back_auto_cache(LOOP_TASK_ITEM_KEY)
  for i, config in ipairs(new_data) do
    local task_item = self:get_auto_cache(LOOP_TASK_ITEM_KEY)
    local task_id = config.TaskId
    local task_item_config = task_config[task_id]
    Util.get_text("TItle", task_item).text = task_item_config.Name
    Util.get_text("Detil", task_item).text = ""
    local task_info = TaskMgr:get_task_by_id(task_id)
    local task_state = task_info.state
    Util.get_child_gameobj("Panel/NotFinish", task_item):SetActive(task_state == TASK_STATE.none)
    Util.get_child_gameobj("Panel/HasFinish", task_item):SetActive(task_state == TASK_STATE.received)
    Util.get_child_gameobj("Panel/Finish", task_item):SetActive(task_state == TASK_STATE.receive)
    Util.get_child_gameobj("Panel/Finish/FX_UI_Particle", task_item):SetActive(false)
    Util.get_child_gameobj("Animation/Ani_VX_Finsh", task_item):SetActive(false)
    local award_id = award_group[task_item_config.Award][1]
    local award_num = award_config[award_id].Num
    local canvas_bg = Util.get_child_gameobj("Bg", task_item):GetComponent("CanvasGroup")
    local canvas_tit = Util.get_child_gameobj("TItle", task_item):GetComponent("CanvasGroup")
    local canvas_pbg = Util.get_child_gameobj("Panel/PointBg", task_item):GetComponent("CanvasGroup")
    local canvas_pro = Util.get_child_gameobj("ProgressNow", task_item):GetComponent("CanvasGroup")
    local canvas_probar = Util.get_child_gameobj("ProgressBar", task_item):GetComponent("CanvasGroup")
    local canvas_fin = Util.get_child_gameobj("Panel/Finish", task_item):GetComponent("CanvasGroup")
    canvas_bg.alpha = 1
    canvas_tit.alpha = 1
    canvas_pbg.alpha = 1
    canvas_pro.alpha = 1
    canvas_probar.alpha = 1
    canvas_fin.alpha = 1
    local progress = task_info and task_info.progress and #task_info.progress > 0 and task_info.progress[1].progress or 0
    local condition_id = task_item_config.Condition[1]
    local condition = condition_config[condition_id].Value
    Util.get_text("ProgressNow/interval/ProgressMax", task_item).text = condition
    Util.get_text("ProgressNow", task_item).text = progress
    Util.get_slider("ProgressBar", task_item).value = progress / condition
    if task_state == TASK_STATE.none then
      Util.get_text("Panel/NotFinish/Amount", task_item).text = award_num
    elseif task_state == TASK_STATE.receive then
      Util.get_child_gameobj("Panel/Finish/Mask", task_item):SetActive(false)
      Util.get_text("Panel/Finish/Amount", task_item).text = award_num
      local recive_btn = Util.get_button("Panel/Finish/GetBtn", task_item)
      self:set_button_listener(recive_btn, function()
        self:do_submit_single(task_item, task_id)
      end)
      _tinsert(self.v_receive_id_list, task_id)
      _tinsert(self.v_receive_item_list, {id = task_id, item = task_item})
      self.v_player_active = self.v_player_active + award_num
    elseif task_state == TASK_STATE.received then
      Util.get_text("Panel/HasFinish/Amount", task_item).text = award_num
      canvas_bg.alpha = 0.6
      self.v_player_active = self.v_player_active + award_num
      complete_active = complete_active + award_num
    end
    Util.get_child_gameobj("Animation/Ani_VX_HasFinsh", task_item):SetActive(task_state == TASK_STATE.received)
  end
  self.v_all_btn.interactable = next(self.v_receive_id_list) ~= nil
  self.v_active_now.text = complete_active
  self:update_btn_img()
  self:clear_Seq()
end

function ui:do_submit_single(task_item, task_id)
  if self.v_sequence then
    return
  end
  Util.get_child_gameobj("Animation/Ani_VX_Finsh", task_item):SetActive(true)
  self.v_uiobjects.FX_UI_Move1:SetActive(true)
  self:clear_Seq()
  self.v_sequence = Util.create_sequence()
  self.v_sequence:InsertCallback(0.3, function()
    self.v_uiobjects.FX_UI_Bloom:SetActive(true)
  end)
  self.v_sequence:InsertCallback(0.5, function()
    TaskMgr:submit_task(task_id, function()
      self:refresh_view(self.v_tag_select)
    end)
    self:clear_Seq()
  end)
end

function ui:do_submit_all()
  if not self.v_receive_id_list or not next(self.v_receive_id_list) then
    return
  end
  if not self.v_receive_item_list or not next(self.v_receive_item_list) then
    return
  end
  self:clear_Seq()
  self.v_sequence = Util.create_sequence()
  for idx, task_item in pairs(self.v_receive_item_list) do
    if UtilTable.contains(self.v_receive_id_list, task_item.id) then
      task_item = task_item.item
      Util.get_child_gameobj("Animation/Ani_VX_Finsh", task_item):SetActive(true)
    end
  end
  self.v_sequence:InsertCallback(0.3, function()
    self.v_uiobjects.FX_UI_Bloom:SetActive(true)
  end)
  self.v_sequence:InsertCallback(0.5, function()
    TaskMgr:submit_task_list(self.v_receive_id_list, function()
      self:refresh_view(self.v_tag_select)
    end)
    self:clear_Seq()
    self.v_receive_id_list = {}
  end)
  self.v_receive_item_list = {}
end

function ui:clear_Seq()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
end

function ui:select_tag_toggle(select, last_select, select_toggle, last_select_toggle)
  if select == self.v_tag_select then
    return
  end
  local sys_id = TOGGLE_LIST[select].sys_id
  local open = SysOpenMgr:get_sys_is_open(sys_id, true)
  if not open then
    self.v_toggle_tab:set_toggle_by_index(self.v_tag_select)
    return
  end
  self:refresh_view(select)
  self.v_tag_select = select
  self.v_last_tag_select = select
  for idx, toggle in pairs(self.v_tag_toggles) do
    local en_name = Util.get_text("TagEnName", toggle.gameObject)
    en_name.text = TOGGLE_LIST[idx].tog_show_name
  end
  local en_name = Util.get_text("TagEnName", self.v_toggle_tab:get_toggle_by_index(select).gameObject)
  en_name.text = "-" .. TOGGLE_LIST[select].tog_show_name .. "-"
end

function ui:refresh_red()
  local daily_task_list = ShareRes.create("task.daily_task")
  local weekly_task_list = ShareRes.create("task.weekly_task")
  local show_red = false
  for key, cfg in pairs(daily_task_list) do
    local task_id = cfg.TaskId
    local task_info = TaskMgr:get_task_by_id(task_id)
    local state = task_info.state
    if state == TASK_STATE.receive then
      show_red = true
      break
    end
  end
  self.v_tog_list[TASK_TYPE.DAILY_TASK].red:SetActive(show_red)
  show_red = false
  for key, cfg in pairs(weekly_task_list) do
    local task_id = cfg.TaskId
    local task_info = TaskMgr:get_task_by_id(task_id)
    local state = task_info.state
    if state == TASK_STATE.receive then
      show_red = true
      break
    end
  end
  self.v_tog_list[TASK_TYPE.WEEKLY_TASK].red:SetActive(show_red)
end

function ui:_get_all_reward()
  if next(self.v_receive_id_list) == nil then
    return
  end
  TaskMgr:submit_task_list(self.v_receive_id_list, function()
    self:refresh_view(self.v_tag_select)
  end)
  self.v_receive_id_list = {}
end

function ui:update_btn_img()
  local btn = Util.get_button(nil, self.v_uiobjects.Bottom)
  if next(self.v_receive_id_list) == nil then
    Util.disable_btn(btn, true)
  else
    Util.enable_btn(btn)
  end
end

return ui
