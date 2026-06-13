local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local PARAM = ShareRes.get_comm_string_value("BBQGuideParam")
local GUIDE_STAGE_ID = PARAM and PARAM[2]

function ui:on_click_confirm()
  local music_game_battle_panel = UIMgr:try_get_visible_ui("music_game_battle_panel")
  if music_game_battle_panel then
    music_game_battle_panel:ui_hide()
  end
  self:ui_hide()
end

function ui:on_click_BtnReStart()
  local music_game_battle_panel = UIMgr:try_get_visible_ui("music_game_battle_panel")
  if music_game_battle_panel then
    music_game_battle_panel:on_click_restart()
  end
  self:ui_hide()
end

function ui:on_click_lock()
  if self.v_lock_tips then
    Util.show_message_tip(self.v_lock_tips)
  end
end

function ui:ui_finish_load()
  self:set_button("BtnExit", function()
    UIMgr:try_get_visible_ui("barbecue_game_main_panel"):show_main_view()
    self:ui_hide()
  end)
  self:set_button("BtnContinue", function()
    UIMgr:try_get_visible_ui("barbecue_game_main_panel"):enter_stage(self.v_next_stage_id)
    self:ui_hide()
  end)
  self:set_button("BtnLock", function()
    self:on_click_lock()
  end)
  self:set_button("BtnRestart", function()
    UIMgr:try_get_visible_ui("barbecue_game_main_panel"):enter_stage(self.v_stage_id)
    self:ui_hide()
  end)
end

function ui:ui_on_show(stage_cfg, is_success)
  self.v_stage_id = stage_cfg.Id
  self.v_next_stage_id = nil
  self.v_activity_id = BarbecueGameMgr:get_activity_id()
  local stage_list = BarbecueGameMgr:get_stage_list(self.v_activity_id)
  local cur_stage_idx
  for i, cfg in ipairs(stage_list) do
    if cfg.Id == self.v_stage_id then
      cur_stage_idx = i
      break
    end
  end
  if self.v_stage_id == GUIDE_STAGE_ID then
    cur_stage_idx = 0
  end
  if cur_stage_idx and stage_list[cur_stage_idx + 1] then
    self.v_next_stage_id = stage_list[cur_stage_idx + 1].Id
  end
  local next_stage_data = BarbecueGameMgr:get_stage_data(self.v_next_stage_id)
  local is_unlock = next_stage_data and next_stage_data.is_challenge and not next_stage_data.is_lock
  self.v_uicompents.StageName_txt.text = stage_cfg.Name
  self.v_uiobjects.BtnRestart:SetActiveEx(not is_success)
  self.v_uiobjects.Success:SetActiveEx(is_success)
  self.v_uiobjects.Fail:SetActiveEx(not is_success)
  self.v_uiobjects.BtnContinue:SetActiveEx(is_success and is_unlock)
  self.v_uiobjects.BtnLock:SetActiveEx(is_success and next_stage_data and not is_unlock)
  local tips
  if is_success and next_stage_data then
    if next_stage_data.is_lock then
      local next_stage_cfg = ShareRes.create("activity.barbecue_stall_episode", self.v_next_stage_id)
      local start_time = next_stage_cfg.StartTime and Date.get_time_stamp_by_scheme_id(next_stage_cfg.StartTime) or 0
      local now_time = Date.server_time()
      local remain_time = start_time - now_time
      if remain_time > 86400 then
        tips = string.format("%s天后解锁", math.ceil(remain_time / 86400))
      elseif remain_time > 3600 then
        tips = string.format("%s时后解锁", math.ceil(remain_time / 3600))
      else
        remain_time = remain_time > 0 and remain_time or 1
        tips = string.format("%s分后解锁", math.ceil(remain_time / 60))
      end
    elseif not next_stage_data.is_challenge then
      tips = "通关前置关卡后解锁"
    end
  end
  self.v_lock_tips = tips
end

return ui
