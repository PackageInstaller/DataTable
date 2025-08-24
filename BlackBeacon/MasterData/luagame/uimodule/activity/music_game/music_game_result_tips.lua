local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

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

function ui:ui_finish_load()
  self:set_button("BtnConfirm", function()
    self:on_click_confirm()
  end)
  self:set_button("ReStart", function()
    self:on_click_BtnReStart()
  end)
end

function ui:ui_on_show(stage_id, score, cur_star, max_combo)
  local is_success = 0 ~= cur_star
  self.v_stage_cfg = ShareRes.get_puzzle_game_stage_cfg(stage_id)
  self.v_uiobjects.Success:SetActiveEx(is_success)
  self.v_uiobjects.Fail:SetActiveEx(not is_success)
  if is_success then
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.music_game_suc_UI_SOUND)
  else
    Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.music_game_fail_UI_SOUND)
  end
  self.v_uicompents.ScoreNum_txt.text = score
  self.v_uicompents.ComboNum_txt.text = max_combo or 0
  for i = 1, 4 do
    local is_active = i <= cur_star
    self.v_uiobjects["StarLight" .. i]:SetActive(is_active)
    local txt = self.v_uicompents["StarConditionTxt" .. i .. "_txt"]
    txt.text = string.format("积分达到%s", self.v_stage_cfg.StarScore[i])
    Util.set_color(txt, is_active and "EFC66E" or "909090")
  end
end

return ui
