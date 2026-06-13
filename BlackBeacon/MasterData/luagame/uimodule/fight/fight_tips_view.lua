local Base = require("ui.uiobject")
local CommonDefine = require("cs_share.common_define")
local Item_Helper = require("utils.item_helper")
local ui = Util.create_child_mt(Base)
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
local COUNT_TIPS = {TIMER = 4, CNT = 5}
local COUNT_TIPS_PARAM = {
  [COUNT_TIPS.TIMER] = {
    [1] = "total_time",
    [2] = "pass_time"
  },
  [COUNT_TIPS.CNT] = {
    [1] = "cur_cnt",
    [2] = "total_cnt"
  }
}

function ui:ui_finish_load()
  self.v_template_key = {
    fight_time_tips = "fight_time_tips",
    fight_cnt_tips = "fight_cnt_tips"
  }
  self.v_cnt_tips_tmp = {
    [COUNT_TIPS.TIMER] = self.v_template_key.fight_time_tips,
    [COUNT_TIPS.CNT] = self.v_template_key.fight_cnt_tips
  }
  self.v_cnt_tips = {}
  self:register_exist_auto_template(self.v_template_key.fight_time_tips, self.v_uiobjects.Tips4Tem, self.v_uiobjects.TipsFight4)
  self:register_exist_auto_template(self.v_template_key.fight_cnt_tips, self.v_uiobjects.Tips5Tem, self.v_uiobjects.TipsFight5)
  self.v_scene_tips_map = {}
  self:set_button("BtnCloseTips8", function()
    self:set_tipsfight_obj_active(8, false)
  end)
  self:set_button("BtnUnfoldTips8", function()
    self:set_tipsfight_obj_active(8, true)
  end)
  self.v_cnt_tips_info = {}
end

function ui:ui_on_show()
  self:_regist_client_event()
  self:update_counttips_rect_pos()
end

function ui:ui_on_update(delta_time)
  self:_update_scene_tips()
  self:_update_tips_time(delta_time)
end

function ui:_regist_client_event()
  self:bind_auto_mq(Const.MSG_UI_FIGHT_SCENE_TIPS, self.on_set_scene_tips, self)
  self:bind_auto_mq(Const.MSG_ON_SET_TIME_CUT_TIPS, self._start_time_cut_tips, self)
  self:bind_auto_mq(Const.MSG_ON_BATTLE_TASK_UPDATE, self.update_counttips_rect_pos, self)
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.update_counttips_rect_pos_byui, self)
end

function ui:ui_on_hide()
end

function ui:on_set_scene_tips(msg)
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  self.v_room_id = tower:get_room_num()
  local tips_id = msg.mm_x
  local visible = msg.mm_y
  local tip_cfg = ShareRes.create("scene.scene_tips", tips_id)
  if not tip_cfg then
    Log.Error("not find tips_id " .. tips_id)
    return
  end
  if tip_cfg.GuideID or not UtilTable.is_empty(tip_cfg.ComboIdList or E) then
    self.v_uiobjects.BtnRePlay8:SetActive(true)
    if visible then
      self:set_button("BtnRePlay8", function()
        if not UtilTable.is_empty(tip_cfg.ComboIdList) then
          UIMgr:get_ui("skill_teach_tips"):ui_show(tip_cfg.ComboIdList)
        elseif GraphicGuideMgr then
          GraphicGuideMgr:init(tip_cfg.GuideID)
        end
      end)
    end
  elseif 8 == tip_cfg.Type then
    self.v_uiobjects.BtnRePlay8:SetActive(false)
  end
  local fight_tips_type = CommonDefine.FIGHT_TIPS_TYPE
  if tip_cfg.Type == fight_tips_type.TIMER or tip_cfg.Type == fight_tips_type.COUNTER then
    self:_set_scene_cnt_tips(msg)
  else
    self:_set_common_tips(msg)
  end
end

function ui:_set_common_tips(msg)
  local tips_id = msg.mm_x
  local is_visible = msg.mm_y
  if not is_visible then
    local tip_info = self.v_scene_tips_map[tips_id]
    if not tip_info then
      return
    end
    self:set_tipsfight_obj_active(tip_info.type, false, true)
    self.v_scene_tips_map[tips_id] = nil
    return
  end
  local tip_cfg = ShareRes.create("scene.scene_tips", tips_id)
  if not tip_cfg then
    Log.Error("not find tips_id " .. tips_id)
    return
  end
  local type = tip_cfg.Type
  self:_remove_same_type(type)
  local tip_info = {
    end_time = Global.real_time + tip_cfg.Time,
    type = type,
    duration = tip_cfg.Time
  }
  self.v_scene_tips_map[tips_id] = tip_info
  local title_comp = "TipsTitle" .. type .. "_txt"
  if self.v_uicompents[title_comp] then
    self.v_uicompents[title_comp].text = tip_cfg.Title
  end
  local content_comp = "TipsContent" .. type .. "_txt"
  if self.v_uicompents[content_comp] then
    self.v_uicompents[content_comp].text = tip_cfg.Content
  end
  local player_comp = "TipsName" .. type .. "_txt"
  if self.v_uicompents[player_comp] then
    self.v_uicompents[player_comp].text = tip_cfg.Player
  end
  if tip_cfg.SoundId and tip_cfg.SoundId > 0 then
    local function callback(time)
      tip_info.end_time = Global.real_time + time / 1000
    end
    
    Global.sound_mgr:play_sound_by_id(tip_cfg.SoundId, nil, callback)
  end
  local RoleIcon = "RoleIcon" .. type .. "_img"
  if tip_cfg.RoleIcon and self.v_uicompents[RoleIcon] then
    ResMgr:load_set_icon(self.v_uicompents[RoleIcon], tip_cfg.RoleIcon)
  end
  if 3 == type then
    local rect = self.v_uicompents.TipsFight3_rect
    rect:SetSizeDeltaWidthA(0)
    LayoutRebuilder:ForceRebuildLayoutImmediate(rect)
  end
  local active = true
  if msg.mm_obj and msg.mm_obj.Flip then
    active = false
  end
  self:set_tipsfight_obj_active(type, active)
end

function ui:_update_scene_tips()
  if next(self.v_scene_tips_map) == nil then
    return
  end
  local time = Global.real_time
  for k, v in pairs(self.v_scene_tips_map) do
    if time > v.end_time and -1 ~= v.duration then
      self:set_tipsfight_obj_active(v.type, false, true)
      self.v_scene_tips_map[k] = nil
      break
    end
  end
end

function ui:_remove_same_type(type)
  for k, v in pairs(self.v_scene_tips_map) do
    if v.type == type then
      self:set_tipsfight_obj_active(v.type, false, true)
      self.v_scene_tips_map[k] = nil
    end
  end
end

function ui:_set_scene_cnt_tips(msg)
  local tips_id = msg.mm_x
  local is_visible = msg.mm_y
  local param = msg.mm_obj
  self:_set_cnt_tips(tips_id, param, is_visible)
  local tip_cfg = ShareRes.create("scene.scene_tips", tips_id)
  if msg.mm_obj and msg.mm_obj.Flip then
    is_visible = false
  end
  self:set_tipsfight_obj_active(tip_cfg.Type, is_visible)
  local list = self.v_cnt_tips[tips_id]
  if not is_visible then
    self:give_back_auto_cache_obj(nil, list.tips_obj, false)
    self.v_cnt_tips[tips_id] = nil
    local msg = MsgGame:mq_publish2(Const.MSG_FIGHT_CNT_TIPS_FINISH)
    msg.mm_x = tips_id
  else
    local obj
    if list and list.tips_obj then
      obj = list.tips_obj
      self:_convert_param(param, tip_cfg.Type, list.tips_data)
    else
      obj = self:get_auto_cache(self.v_cnt_tips_tmp[tip_cfg.Type])
      local tb = self:_convert_param(param, tip_cfg.Type)
      self.v_cnt_tips[tips_id] = {
        tips_type = tip_cfg.Type,
        tips_obj = obj,
        tips_data = tb,
        Content = tip_cfg.Content
      }
    end
    self:_set_tips_content(obj, tip_cfg, self.v_cnt_tips[tips_id].tips_data)
  end
  self:update_counttips_rect_pos()
end

function ui:update_counttips_rect_pos()
  if not BattleTaskMgr then
    return
  end
  local pos_y = -127
  local is_track_task = BattleTaskMgr:check_track_task()
  local is_show = self.v_parent_ui:is_show_map()
  if is_track_task and is_show then
    pos_y = -258
  end
  local counttips_obj = Util.get_child_gameobj("CountTipsList", self.v_object_transform)
  if not counttips_obj then
    return
  end
  local rect = Util.get_rect_transform(nil, counttips_obj)
  rect:SetAnchoredPositionA(49.6, pos_y)
end

function ui:_convert_param(param, type, data)
  data = data or {}
  for k, v in ipairs(COUNT_TIPS_PARAM[type]) do
    if param[v] then
      data[k] = param[v]
    end
  end
  return data
end

function ui:_set_tips_content(obj, cfg, param)
  if cfg.Type == COUNT_TIPS.TIMER then
    if not param[2] then
      self.v_cnt_tips[cfg.Id].start = false
    else
      param[1] = param[1] - param[2]
    end
  end
  local content = self:get_text("TipsText", obj)
  if content then
    content.text = string.gsub(cfg.Content, "{([%d]+)}", function(idx)
      return param[tonumber(idx)]
    end)
  end
  self.v_cnt_tips[cfg.Id].content = content
end

function ui:_update_tips_time(delta_time)
  if next(self.v_cnt_tips) == nil then
    return
  end
  if SceneMgr:get_game_pause() then
    return
  end
  for tips_id, v in pairs(self.v_cnt_tips) do
    if v.tips_type == COUNT_TIPS.TIMER and v.start then
      v.total_time = v.total_time + delta_time
      v.content.text = string.gsub(v.Content, "{([%d]+)}", function(idx)
        local time = math.floor((v.tips_data[tonumber(idx)] - v.total_time) * 100 + 0.5) / 100
        if time <= 0 then
          v.start = false
          self:on_set_scene_tips({mm_x = tips_id, mm_y = false})
        end
        return time
      end)
    end
  end
end

function ui:_start_time_cut_tips(msg)
  local tips_id = msg.mm_x
  local state = msg.mm_y
  local tips_info = self.v_cnt_tips[tips_id]
  if not tips_info then
    return
  end
  if tips_info.tips_type ~= COUNT_TIPS.TIMER then
    return
  end
  tips_info.start = state == CommonDefine.TIME_CUT_TIPS_ACTION.START or state == CommonDefine.TIME_CUT_TIPS_ACTION.CONTINUE
  if state == CommonDefine.TIME_CUT_TIPS_ACTION.START then
    tips_info.total_time = 0
  elseif state == CommonDefine.TIME_CUT_TIPS_ACTION.STOP then
    self:_abort_time_cut_tips(tips_id)
  end
end

function ui:_abort_time_cut_tips(tips_id)
  local list = self.v_cnt_tips[tips_id]
  self:give_back_auto_cache_obj(nil, list.tips_obj, false)
  self.v_cnt_tips[tips_id] = nil
  self:_set_cnt_tips(tips_id, nil, false)
  self:update_counttips_rect_pos()
end

function ui:_set_cnt_tips(tips_id, info, not_remove)
end

function ui:_restart_cnt_tips()
  if next(self.v_cnt_tips_info) == nil then
    return
  end
  local tower = TowerMgr:get_tower()
  if self.v_room_id == tower:get_room_num() then
    return
  end
  for k, v in pairs(self.v_cnt_tips_info) do
    local msg = MsgGame:mq_publish2(Const.MSG_UI_FIGHT_SCENE_TIPS)
    msg.mm_x = k
    msg.mm_y = true
    msg.mm_obj = v
  end
  self.v_cnt_tips_info = {}
end

function ui:set_tipsfight_obj_active(tip_type, active, is_all)
  self.v_uiobjects["TipsFight" .. tip_type]:SetActive(active)
  self:on_tip_type8_active_change(tip_type, active, is_all)
end

function ui:on_tip_type8_active_change(tip_type, active, is_all)
  if 8 == tip_type then
    local show_tips = active
    if not self.v_tip8_height then
      local _, height = self.v_uicompents.TipsFight8_rect:GetRectWH()
      self.v_tip8_height = height
      _, height = self.v_uicompents.TipsContent8_rect:GetRectWH()
      self.v_tip8_contnet_height = height
    end
    if not is_all then
      active = not active
    end
    self.v_uiobjects.TipsFightClose8:SetActive(active)
    if show_tips and self.v_tip8_height then
      Timer:add_timer(nil, Config.LOGIC_FRAME, self.update_tips_height, self)
    end
  end
end

function ui:update_tips_height()
  if not (not self:is_destroy() and self.v_parent_ui) or not self.v_parent_ui:visible() then
    return
  end
  if not self.v_uiobjects.TipsFight8.activeInHierarchy then
    return
  end
  local _, height = self.v_uicompents.TipsContent8_rect:GetRectWH()
  local dif_value = height - self.v_tip8_contnet_height
  local tip8_width = self.v_uicompents.TipsFight8_rect:GetRectWH()
  local max_height = 320
  self.v_uicompents.TipsFight8_rect:SetSizeDeltaA(tip8_width, math.min(self.v_tip8_height + dif_value, max_height))
end

function ui:update_counttips_rect_pos_byui(msg)
  local ui_name = msg.mm_obj
  if "fight" == ui_name then
    self:update_tips_height()
  end
end

function ui:get_uicompents()
  return self.v_uicompents
end

return ui
