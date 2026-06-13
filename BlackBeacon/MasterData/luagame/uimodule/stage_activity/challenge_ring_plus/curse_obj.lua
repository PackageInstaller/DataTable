local EffectStatus = TypeEffectStatus
local Cs_color = UnityEngine.Color
local DEF_CURSE_COLOR = Cs_color(1, 1, 1, 1)
local ADD_CURSE_COLOR = Cs_color(0.8274509803921568, 0, 0, 1)
local SPECIAL_CURSE_INDEX = 5
local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self.v_curse_obj_list = {}
  for index = 1, 5 do
    self:set_button("CurseTem" .. index, function()
      self:click_curse_tem(index)
    end)
    table.insert(self.v_curse_obj_list, self.v_uiobjects["CurseTem" .. index])
  end
end

function ui:click_curse_tem(select_index)
  local debuff_cnt = #self.v_debuff_list
  if select_index > debuff_cnt then
    return
  end
  for index = 1, 5 do
    self.v_uiobjects["Select" .. index]:SetActive(index == select_index)
  end
  local debuff_cfg = ShareRes.create("activity.curse_effect", self.v_debuff_list[select_index])
  local pos_x, pos_y = 480 + select_index * 100, 170
  local content_pos = {pos_x = pos_x, pos_y = pos_y}
  
  local function callback()
    if self:is_destroy() then
      return
    end
    for index = 1, 5 do
      self.v_uiobjects["Select" .. index]:SetActive(false)
    end
  end
  
  local show_info = {
    name = debuff_cfg.Name,
    desc = debuff_cfg.WorldDesc,
    icon_path = debuff_cfg.Icon,
    effect_desc = debuff_cfg.Desc
  }
  UIMgr:get_ui("curse_ring_tips"):ui_show(content_pos, show_info, callback)
end

function ui:ui_on_show()
  self.v_init_show = true
  self.v_uiobjects.PreviewSld:SetActive(false)
  self.v_uiobjects.ChangeExpre:SetActive(false)
  self.v_change_expre_canvas = self.v_uiobjects.ChangeExpre:GetComponent("CanvasGroup")
  self.v_change_expre_canvas.alpha = 0
  self.v_is_play_set_curse_value_anima = false
  self:bind_auto_mq(Const.MSG_CURSE_UPDATE, self.update_view, self)
  self:update_view()
  self.v_init_show = false
end

function ui:ui_on_hide()
  self.v_last_curse_val = nil
  if self.v_change_sequence then
    self.v_change_sequence:Kill(false)
    self.v_change_sequence = nil
  end
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
  if self.v_add_curse_effect then
    ResMgr:destroy_gameobj(self.v_add_curse_effect)
    self.v_add_curse_effect = nil
  end
  if self.v_curse_sequence then
    self.v_curse_sequence:Kill(false)
    self.v_curse_sequence = nil
  end
end

function ui:update_view()
  if ChallengeRingPlusMgr:is_in_curse_fighting() then
    self.v_debuff_list = ChallengeRingPlusMgr:get_before_fight_debuff_list()
  else
    self.v_debuff_list = ChallengeRingPlusMgr:get_debuff()
  end
  if not self.v_is_play_set_curse_value_anima then
    self:set_curse_val()
  end
  local debuff_cnt = #self.v_debuff_list
  self.v_uiobjects.CurseTem5:SetActive(self.v_debuff_list[SPECIAL_CURSE_INDEX] ~= nil)
  for index = 1, 5 do
    self.v_uiobjects["Select" .. index]:SetActive(false)
    self.v_uiobjects["CurseIcon" .. index]:SetActive(debuff_cnt >= index)
    self.v_uiobjects["BgRed" .. index]:SetActive(debuff_cnt >= index)
    Util.apply_grey_ex(self.v_uiobjects["CurseTem" .. index], false)
    self:set_curse_icon(index)
  end
  local indexs = ChallengeRingPlusMgr:get_invalid_debuff_indexs()
  if indexs then
    for _, index in pairs(indexs) do
      Util.apply_grey_ex(self.v_uiobjects["CurseTem" .. index], true)
    end
  end
end

function ui:set_curse_icon(index)
  local curse_id = self.v_debuff_list[index]
  if curse_id then
    local curse_icon = self.v_uicompents["CurseIcon" .. index .. "_img"]
    local icon_path = ShareRes.get_curse_ring_curse_iocn(curse_id)
    ResMgr:load_set_icon(curse_icon, icon_path)
  end
end

function ui:set_curse_val(is_remove_card, anima_cb)
  local remove_data = ChallengeRingPlusMgr:get_remove_card_data()
  if ChallengeRingPlusMgr:is_achieve_total_limit() and not ChallengeRingPlusMgr:get_is_first_max_value() then
    remove_data = nil
    is_remove_card = false
  end
  if ChallengeRingPlusMgr:is_in_curse_fighting() then
    remove_data = nil
    is_remove_card = false
  end
  if not self.v_init_show and remove_data then
    return
  end
  local cur_curse_val
  local last_curse = ChallengeRingPlusMgr:get_before_fight_curse_value()
  if ChallengeRingPlusMgr:is_in_curse_fighting() then
    cur_curse_val = ChallengeRingPlusMgr:get_before_fight_curse_value()
  else
    cur_curse_val = ChallengeRingPlusMgr:get_curse_val()
  end
  local cur_curse_val_limit = ChallengeRingPlusMgr:get_curse_val_limit()
  local curse_bar_sld = self.v_uicompents.CurseBarFill_img
  if self.v_init_show then
    self.v_uicompents.CurseNow_txt.text = last_curse
    self.v_uicompents.CurseMax_txt.text = cur_curse_val_limit
    curse_bar_sld.fillAmount = #self.v_debuff_list >= 4 and 1 or last_curse / cur_curse_val_limit
    return
  end
  if 0 == cur_curse_val then
    self.v_last_curse_val = cur_curse_val
    self.v_change_expre_canvas.alpha = 0
  end
  if not self.v_last_curse_val then
    self.v_last_curse_val = last_curse
  end
  
  local function callback()
    self.v_uicompents.CurseNow_txt.text = cur_curse_val
    self.v_uicompents.CurseMax_txt.text = cur_curse_val_limit
    if anima_cb then
      anima_cb()
    end
    self.v_is_play_set_curse_value_anima = false
  end
  
  if self.v_change_sequence then
    self.v_change_sequence:Kill(false)
    self.v_change_sequence = nil
  end
  local parent = self.v_parent_ui
  local preview_sld = self.v_uicompents.PreviewSld_img
  local change_txt = self.v_uicompents.ChangeVal_txt
  local record_value = ChallengeRingPlusMgr:get_fight_add_curse_value() or 0
  if parent.v_cfg.name == "curse_blood_room" then
    record_value = parent.v_heal_card_cfg.CostCnt
  end
  local reduce = ChallengeRingPlusMgr:get_skip_card_add_curse_value()
  local desc = ChallengeRingPlusMgr.v_wait_skip_card and reduce or record_value
  if #self.v_debuff_list >= 4 then
    self.v_change_sequence = Util.create_sequence()
    self.v_change_expre_canvas.alpha = 0
    self.v_change_sequence:Append(self.v_change_expre_canvas:DOFade(1, 0.5))
    self.v_change_sequence:Append(self.v_change_expre_canvas:DOFade(0, 0.2))
    curse_bar_sld.fillAmount = 1
    self.v_uiobjects.ChangeExpre:SetActive(true)
    local color = Util.get_unity_color_by_hex(tonumber("721F1F", 16))
    local is_less = desc < 0
    if is_less then
      color = Util.get_unity_color_by_hex(tonumber("37721F", 16))
    else
      desc = "+" .. desc
      self:play_add_curse_effect()
    end
    change_txt.text = desc
    change_txt.color = color
    callback()
    if not ChallengeRingPlusMgr:is_in_curse_fighting() and parent.v_cfg.name == "challenge_ring_plus" then
      ChallengeRingPlusMgr:record_before_fight_view_info(cur_curse_val, self.v_debuff_list)
      ChallengeRingPlusMgr:reset_fight_add_curse_value()
    end
    self.v_last_curse_val = cur_curse_val
    return
  end
  if cur_curse_val ~= self.v_last_curse_val or is_remove_card and 0 ~= desc then
    self.v_is_play_set_curse_value_anima = true
    local value = last_curse / cur_curse_val_limit
    local is_less = desc < 0
    self.v_change_expre_canvas.alpha = value
    self.v_uiobjects.PreviewSld:SetActive(true)
    self.v_uiobjects.ChangeExpre:SetActive(true)
    local color = Util.get_unity_color_by_hex(tonumber("721F1F", 16))
    if is_less then
      color = Util.get_unity_color_by_hex(tonumber("37721F", 16))
    else
      desc = "+" .. desc
      self:play_add_curse_effect()
    end
    change_txt.text = desc
    change_txt.color = color
    preview_sld.fillAmount = 0
    self.v_change_sequence = Util.create_sequence()
    self.v_change_sequence:Append(preview_sld:DOFillAmount(cur_curse_val / cur_curse_val_limit, 0.5))
    self.v_change_sequence:Insert(self.v_change_expre_canvas:DOFade(1, 0.5))
    self.v_change_sequence:Append(curse_bar_sld:DOFillAmount(cur_curse_val / cur_curse_val_limit, 0.2))
    self.v_change_sequence:OnComplete(function()
      self.v_change_sequence:Insert(self.v_change_expre_canvas:DOFade(0, 0.2))
      self.v_uiobjects.PreviewSld:SetActive(false)
      callback()
    end)
  else
    self.v_uiobjects.PreviewSld:SetActive(false)
    self.v_uiobjects.ChangeExpre:SetActive(false)
    callback()
    curse_bar_sld.fillAmount = cur_curse_val / cur_curse_val_limit
  end
  if not ChallengeRingPlusMgr:is_in_curse_fighting() and parent.v_cfg.name == "challenge_ring_plus" then
    ChallengeRingPlusMgr:record_before_fight_view_info(cur_curse_val, self.v_debuff_list)
    ChallengeRingPlusMgr:reset_fight_add_curse_value()
  end
  self.v_last_curse_val = cur_curse_val
end

function ui:play_add_curse_effect()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
  if self.v_curse_sequence then
    self.v_curse_sequence:Kill(false)
    self.v_curse_sequence = nil
  end
  if not self.v_add_curse_effect then
    local res_name = "Fx_UI_Card_curse_bar"
    local effect = ResMgr:load_gameobj(Path.get_res_path(res_name))
    effect.transform:SetParent(self.v_uiobjects.CurseBarBg.transform, false)
    effect.transform:SetLocalPositionA(0, 0, 0)
    self.v_add_curse_effect = effect
  end
  self.v_add_curse_effect:SetActiveEx(false)
  self.v_add_curse_effect:SetActive(true)
  local effect_status = self.v_add_curse_effect:GetComponent(EffectStatus)
  local length = effect_status.LifeTime
  self.v_timer = Timer:add_timer("play_add_curse_effect", length, function()
    if self.v_add_curse_effect then
      self.v_add_curse_effect:SetActive(false)
    end
  end)
  local img = self.v_uicompents.CurseIcon_img
  local sequence = Util.create_sequence()
  sequence:Append(img:DOColor(ADD_CURSE_COLOR, 0.3))
  sequence:Append(img:DOColor(DEF_CURSE_COLOR, 0.3))
  self.v_curse_sequence = sequence
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.curse_obj_val_add_UI_SOUND)
end

function ui:ui_on_destroy()
end

return ui
