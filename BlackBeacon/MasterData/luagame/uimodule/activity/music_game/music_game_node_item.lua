local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local PosCfg = ShareRes.create("activity.music_mini_game_node_pos")
local TypeCfg = ShareRes.create("activity.music_mini_game_node_type")

function ui:ui_finish_load()
  self:set_button("TouchBtn", function()
    self:on_click()
  end)
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:on_click()
  if not self.v_watting_click then
    return
  end
  if self.v_ct_time >= self.v_start_sec and self.v_ct_time < self.v_end_sec then
    self:do_suc()
  else
    self:do_fail()
  end
end

function ui:set_idx(idx)
  self.v_idx = idx
  self.v_watting_click = false
end

function ui:show_node(pos_id, node_type)
  self.v_pos_id = pos_id
  self.v_node_type = node_type
  local pos_cfg = PosCfg[pos_id]
  local pos = pos_cfg.Pos
  self.v_object_transform:SetLocalPositionA(pos[1], pos[2], 0)
  self.v_type_cfg = TypeCfg[node_type]
  self.v_start_sec = self.v_type_cfg.JudgeStart
  self.v_end_sec = self.v_type_cfg.JudgeEnd
  self.v_circle_end_sec = self.v_type_cfg.CircleEnd
  self.v_tips_duraction = self.v_type_cfg.TipsDuration
  self.v_uiobjects.ResultObj:SetActiveEx(false)
  self.v_uiobjects.TouchBtn:SetActiveEx(true)
  self.v_uiobjects.Bg:SetActiveEx(true)
  self:show_anim(self.v_type_cfg.AnimSuffix)
  self.v_ct_time = 0
  self.v_watting_click = true
  self.v_showing_tips = false
  self:set_enable(true)
end

function ui:show_anim(anim_suffix)
  self.v_uiobjects.ExpendCircle:SetActiveEx(false)
  local trans = self.v_uicompents.ExpendCircle_rect
  local child_count = trans.childCount
  for idx = 0, child_count - 1 do
    local is_show = idx + 1 == anim_suffix
    local effect_trans = trans:GetChild(idx)
    effect_trans.gameObject:SetActive(is_show)
    if is_show then
      self.v_eff_ui_particle = Util.get_ui_particle(nil, effect_trans)
    end
  end
  self.v_uiobjects.ExpendCircle:SetActive(true)
end

function ui:do_pause(is_pause)
  if self.v_eff_ui_particle then
    if is_pause then
      self.v_eff_ui_particle:Pause()
    else
      self.v_eff_ui_particle:Play()
    end
  end
end

function ui:do_ct(detla_time)
  if self.v_watting_click then
    self.v_ct_time = self.v_ct_time + detla_time
    if self.v_ct_time > self.v_end_sec then
      self:do_fail()
    end
  elseif self.v_showing_tips then
    self.v_ct_time = self.v_ct_time + detla_time
    if self.v_ct_time >= self.v_tips_end then
      self:do_end()
    end
  end
end

function ui:do_suc()
  self.v_uiobjects.TouchBtn:SetActiveEx(false)
  self.v_uiobjects.Bg:SetActive(false)
  self.v_uiobjects.Success:SetActiveEx(true)
  self.v_uiobjects.Miss:SetActiveEx(false)
  self.v_uiobjects.ResultObj:SetActive(true)
  self.v_watting_click = false
  self.v_showing_tips = true
  self.v_tips_end = self.v_ct_time + self.v_tips_duraction
  self.v_parent_ui:hit_node(self.v_idx)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.music_game_node_suc_UI_SOUND)
end

function ui:do_fail()
  self.v_uiobjects.TouchBtn:SetActiveEx(false)
  self.v_uiobjects.Bg:SetActive(false)
  self.v_uiobjects.Success:SetActiveEx(false)
  self.v_uiobjects.Miss:SetActiveEx(true)
  self.v_uiobjects.ResultObj:SetActive(true)
  self.v_watting_click = false
  self.v_showing_tips = true
  self.v_tips_end = self.v_ct_time + self.v_tips_duraction
  self.v_parent_ui:miss_node(self.v_idx)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.music_game_node_fail_UI_SOUND)
end

function ui:do_end()
  self.v_showing_tips = false
  self:set_enable(false)
  self.v_parent_ui:release_node(self.v_idx)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.music_game_node_end_UI_SOUND)
end

function ui:expend_circle()
end

return ui
