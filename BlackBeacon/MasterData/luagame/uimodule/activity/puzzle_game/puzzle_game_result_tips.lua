local Base = require("ui.uibase")
local CommDefine = require("cs_share.common_define")
local ui = Util.create_child_mt(Base)

function ui:on_click_BtnNext()
  if self.v_lock_str then
    Util.show_message_tip(self.v_lock_str)
    return
  end
  local puzzle_game_battle_panel = UIMgr:try_get_visible_ui("puzzle_game_battle_panel")
  if puzzle_game_battle_panel then
    puzzle_game_battle_panel:start_new(self.v_next_stage_cfg.Id)
  end
  self:ui_hide()
end

function ui:on_click_BtnQuit()
  local puzzle_game_battle_panel = UIMgr:try_get_visible_ui("puzzle_game_battle_panel")
  if puzzle_game_battle_panel then
    puzzle_game_battle_panel:ui_hide()
  end
  self:ui_hide()
end

function ui:on_click_BtnReStart()
  local puzzle_game_battle_panel = UIMgr:try_get_visible_ui("puzzle_game_battle_panel")
  if puzzle_game_battle_panel then
    puzzle_game_battle_panel:show_tage_info()
    puzzle_game_battle_panel:reset_all()
  end
  self:ui_hide()
end

function ui:ui_finish_load()
  self:set_button("BtnNext", function()
    self:on_click_BtnNext()
  end)
  self:set_button("BtnQuit", function()
    self:on_click_BtnQuit()
  end)
  self:set_button("BtnReStart", function()
    self:on_click_BtnReStart()
  end)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:ui_on_show(stage_id, is_success, score_grade)
  local data = PuzzleGameMgr:get_stage_data(stage_id)
  self.v_stage_cfg = ShareRes.get_puzzle_game_cfg(stage_id)
  self.v_is_success = is_success
  self.v_grade = score_grade or data.grade
  if self.v_is_success then
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.puzzle_game_suc_SOUND)
  else
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.puzzle_game_fal_SOUND)
  end
  self:refresh_view()
end

function ui:refresh_view()
  self.v_uiobjects.Success:SetActive(self.v_is_success)
  self.v_uiobjects.Fail:SetActive(not self.v_is_success)
  self.v_uiobjects.BtnNext:SetActive(self.v_is_success)
  self.v_uiobjects.BtnReStart:SetActive(not self.v_is_success)
  self.v_uicompents.StageNum_txt.text = string.format("%02d", self.v_stage_cfg.SortId)
  if self.v_is_success then
    self.v_uiobjects.S_Rating:SetActive(self.v_grade == CommDefine.PUZZLE_GAME_SCORE_GRADE.S)
    self.v_uiobjects.A_Rating:SetActive(self.v_grade == CommDefine.PUZZLE_GAME_SCORE_GRADE.A)
    self.v_uicompents.SucRatingTips_txt.text = string.format("成功在%s秒内完成关卡", self.v_grade == CommDefine.PUZZLE_GAME_SCORE_GRADE.S and self.v_stage_cfg.EpicPassTime or self.v_stage_cfg.PassTime)
  else
    self.v_uicompents.FailRatingTips_txt.text = string.format("未能在%s秒内完成关卡", self.v_stage_cfg.PassTime)
    return
  end
  local next_stage_cfg = PuzzleGameMgr:get_next_stage_cfg(self.v_stage_cfg)
  self.v_next_stage_cfg = next_stage_cfg
  if not next_stage_cfg then
    self.v_uiobjects.BtnNext:SetActive(false)
    return
  end
  local data = PuzzleGameMgr:get_stage_data(next_stage_cfg.Id)
  local open_time = data.start_time or 0
  local str
  if open_time > Date:server_time() then
    local remain_time = open_time - Date:server_time()
    if remain_time > 86400 then
      str = string.format("%s天后解锁", math.ceil(remain_time / 86400))
    else
      str = string.format("%s小时后解锁", math.ceil(remain_time / 3600))
    end
    self.v_lock_str = str
    self.v_uicompents.NextStageUnlock_txt.text = str
    self.v_uiobjects.NextStageUnlock:SetActive(true)
  else
    self.v_lock_str = nil
    self.v_uiobjects.NextStageUnlock:SetActive(false)
  end
  Util.apply_grey_ex(self.v_uiobjects.BtnNext, self.v_lock_str ~= nil)
end

return ui
