local Base = require("ui.uiobject")
local MathX = require("base.mathx")
local _clamp = MathX.Clamp
local ui = Util.create_child_mt(Base)
local QiannnengProgressImgFill = ShareRes.get_comm_string_value("QiannnengProgressImgFill")
local Prop_Name_To_Show_Name = {
  hp = "血量",
  sparmor = "霸体值",
  energy = "能量",
  cvenergy = "能量恢复",
  exenergy = "大招能量",
  cvexenergy = "大招能量恢复",
  attack = "物理攻击",
  beacon_level = "信标等级",
  penetrate = "穿防",
  defense = "防御"
}

function ui:ui_finish_load()
  self.v_btn_txt = Util.get_text("BtnAdvanceText", self.v_uiobjects.AdvanceBtn)
  self.v_btn_list = {}
  for i = 1, 6 do
    self:set_button("Advance" .. i, function()
      self:on_click_btn(i)
    end)
    local go = self.v_uiobjects["Advance" .. i]
    self.v_btn_list[i] = {
      normal_bg = Util.get_child_gameobj("NorBg_", go),
      normal_selected = Util.get_child_gameobj("NorBg_/NorSelect_", go),
      active_bg = Util.get_child_gameobj("ActiveBg_", go),
      active_selected = Util.get_child_gameobj("ActiveBg_/ActiveSelect_", go),
      red_go = Util.get_child_gameobj("Red", go),
      eff_go = Util.get_child_gameobj("Fx_Adcance_LvUp_", go),
      icon = Util.get_image("AdvanceIcon_", go)
    }
  end
  self:set_button("AdvanceBtn", function()
    if self.v_is_play_eff or not self:check_advance() then
      return
    end
    Global.sound_mgr:play_lvup_sound()
    
    local function callback()
      self:play_up_lv_effect()
    end
    
    CharacterMgr:char_advance(self.v_buddy_id, callback)
  end)
  self:set_button("CostItem", function()
    if not self.v_cost_id then
      return
    end
    Util.show_item_tip(self.v_cost_id)
  end)
  self:set_button("AdvanceDesc", function()
    self:try_show_keyword()
  end)
  self:set_button("BtnLast", function()
    local select_idx = self.v_cur_selected_idx - 1
    if select_idx <= 1 then
      select_idx = 1
    end
    self:on_click_btn(select_idx)
  end)
  self:set_button("BtnNext", function()
    local select_idx = self.v_cur_selected_idx + 1
    if select_idx >= 6 then
      select_idx = 6
    end
    self:on_click_btn(select_idx)
  end)
  self.v_advance_btn_red = Util.get_child_gameobj("Red", self.v_uiobjects.AdvanceBtn)
  self.v_advance_btn_canvasgroup = self.v_uiobjects.AdvanceBtn:GetComponent("CanvasGroup")
  self.v_max_eff_obj = Util.get_child_gameobj("Title/AdvanceIcon_bg/Fx_UI_Qianneng_Loop", self.v_object)
  self.v_tmp_text = self.v_uiobjects.AdvanceDesc:GetComponent(typeof(CS.TMPro.TMP_Text))
end

function ui:play_up_lv_effect()
  self.v_is_play_eff = true
  self.v_btn_list[self.v_cur_selected_idx].eff_go:SetActive(true)
  self:clear_timer()
  self.v_delay_refresh_timer = Timer:add_timer("potential:play_up_lv_effect", 1, function()
    UIMgr:get_ui("char_advance_suc_pnl"):ui_show(self.v_buddy_id)
    self.v_cur_selected_idx = self.v_cur_selected_idx + 1
    self:update_info()
    self.v_is_play_eff = false
  end)
end

function ui:clear_timer()
  if self.v_delay_refresh_timer then
    Timer:remove_timer(self.v_delay_refresh_timer)
    self.v_delay_refresh_timer = nil
  end
end

function ui:_on_item_update()
  if not self.v_is_other_player then
    self:update_cost_info()
  end
end

function ui:on_click_btn(idx)
  self.v_cur_selected_idx = idx
  self:update_info()
end

function ui:check_advance()
  if self.v_cur_selected_idx ~= self.v_role_cur_lv then
    return
  end
  local cur_item_num = BagMgr:get_item_num(self.v_cost_id)
  if cur_item_num < self.v_cost_num then
    Util.show_message_tip(2115)
    return false
  end
  return true
end

function ui:check_show_lv_up()
  return self.v_can_play_lv_eff
end

function ui:ui_on_show()
  self.v_is_play_eff = false
  self.v_uiobjects.BgTouch:SetActive(false)
  self:bind_auto_mq(Const.MSG_ON_BUDDY_TO_ADVANCE_ITEM, self._on_item_update, self)
  self:bind_auto_mq(Const.MSG_ON_ITEM_UPDATE, self._on_item_update, self)
  self:update_btn_list_img()
end

function ui:refresh(buddy_id)
  self.v_buddy_id = buddy_id
  local buddy_info = CharacterMgr:get_buddy_by_id(buddy_id)
  if not buddy_info then
    return
  end
  self:update_info()
end

function ui:get_prop_desc(lv)
  local cfg = ShareRes.create("buddy.buddy_upgrade_advance_attr", self.v_buddy_id)[lv]
  for prop_name, _ in pairs(Prop_Name_To_Show_Name) do
    if cfg[prop_name] > 0 then
      return Prop_Name_To_Show_Name[prop_name], cfg[prop_name]
    end
  end
  return "", 0
end

function ui:update_btn_list_img()
  for i, v in ipairs(self.v_btn_list) do
    local advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", i + 1)
    local icon_path = advance_icon_cfg.AdvacneAfter
    ResMgr:load_set_icon(v.icon, icon_path, nil, true)
  end
end

function ui:update_btn_list()
  for i, v in ipairs(self.v_btn_list) do
    v.eff_go:SetActiveEx(false)
    v.normal_bg:SetActiveEx(i >= self.v_role_cur_lv)
    v.active_bg:SetActiveEx(i < self.v_role_cur_lv)
    local is_selected = self.v_cur_selected_idx == i
    local alpha = (i < self.v_role_cur_lv or is_selected) and 1 or 0.2
    Util.set_color(v.icon, is_selected and "292929" or "f5ede2", alpha)
    if i >= self.v_role_cur_lv then
      v.normal_selected:SetActiveEx(is_selected)
    else
      v.active_selected:SetActiveEx(is_selected)
    end
    v.red_go:SetActive(self:get_red(i))
  end
  if QiannnengProgressImgFill then
    local fill_amount = QiannnengProgressImgFill[self.v_role_cur_lv] or 0
    self.v_uicompents.ProcessFill_img.fillAmount = fill_amount
  end
end

function ui:get_red(idx)
  if self.v_role_cur_lv ~= idx then
    return false
  end
  local advance_cfg = ShareRes.create("buddy.buddy_advance", self.v_buddy_id)[idx + 1]
  local cost_id = advance_cfg.CostId
  local cost_num = advance_cfg.CostCnt
  local cur_item_num = BagMgr:get_item_num(cost_id)
  return cost_num <= cur_item_num
end

function ui:update_info()
  local advance_cfg = ShareRes.create("buddy.buddy_advance", self.v_buddy_id)
  self.v_buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  self.v_role_cur_lv = self.v_buddy_info.advance
  if self.v_cur_selected_idx == nil then
    self.v_cur_selected_idx = self.v_role_cur_lv - 1
  end
  self.v_cur_selected_idx = _clamp(self.v_cur_selected_idx, 1, #self.v_btn_list)
  self:update_btn_list()
  self.v_uiobjects.IconBgActive:SetActive(self.v_cur_selected_idx <= self.v_role_cur_lv - 1)
  local advance_icon_cfg = ShareRes.create("buddy.buddy_advance_icon", self.v_cur_selected_idx + 1)
  local icon_path = advance_icon_cfg.AdvacneAfter
  ResMgr:load_set_icon(self.v_uicompents.AdcanveIcon_img, icon_path, nil, true)
  local advance_skill_cfg = advance_cfg[self.v_cur_selected_idx + 1]
  self.v_uicompents.AdvanceLv_txt.text = Config.NUM_2_ROMAN[self.v_cur_selected_idx]
  self.v_uicompents.AdvanceName_txt.text = advance_skill_cfg.SkillName
  local skill_desc = ""
  if advance_skill_cfg.SkillDesc and "" ~= advance_skill_cfg.SkillDesc then
    skill_desc = advance_skill_cfg.SkillDesc
  elseif advance_skill_cfg.UpSkillLv > 0 then
    skill_desc = Util.format_str("技能等级+{1}", advance_skill_cfg.UpSkillLv)
  else
    local add_value = 0
    skill_desc, add_value = self:get_prop_desc(advance_skill_cfg.Lv)
    if add_value > 0 then
      skill_desc = Util.format_str("{1}+{2}", skill_desc, add_value)
    end
  end
  self.v_tmp_text.text = skill_desc
  self.v_keyword_list = advance_skill_cfg.Keywords
  self:update_cost_info()
  self.v_uiobjects.BtnLast:SetActive(self.v_cur_selected_idx > 1)
  self.v_uiobjects.BtnNext:SetActive(self.v_cur_selected_idx < 6)
end

function ui:update_cost_info()
  self.v_uiobjects.AdvanceCost:SetActive(self.v_cur_selected_idx == self.v_role_cur_lv)
  Util.apply_grey(nil, self.v_uiobjects.AdvanceBtn, self.v_cur_selected_idx ~= self.v_role_cur_lv, true)
  local str = self.v_cur_selected_idx == self.v_role_cur_lv and "提升" or self.v_cur_selected_idx < self.v_role_cur_lv and "已激活" or "前置潜能未激活"
  self.v_btn_txt.text = Util.format_str(str)
  if self.v_cur_selected_idx == self.v_role_cur_lv then
    local advance_cfg = ShareRes.create("buddy.buddy_advance", self.v_buddy_id)[self.v_cur_selected_idx + 1]
    local cost_id = advance_cfg.CostId
    local cost_num = advance_cfg.CostCnt
    local cur_item_num = BagMgr:get_item_num(cost_id)
    self.v_cost_id = cost_id
    self.v_cost_num = cost_num
    Util.load_ui_item(self.v_uiobjects.CostItem, cost_id, cur_item_num, cost_num)
    if cost_num <= cur_item_num then
      self.v_advance_btn_red:SetActive(true)
      Util.apply_grey(nil, self.v_uiobjects.AdvanceBtn, false)
    else
      self.v_advance_btn_red:SetActive(false)
      Util.apply_grey(nil, self.v_uiobjects.AdvanceBtn, true)
    end
  else
    self.v_advance_btn_red:SetActive(false)
  end
end

function ui:ui_on_hide()
  self.v_cur_selected_idx = nil
  self:clear_timer()
end

function ui:try_show_keyword()
  if self.v_keyword_list then
    UIMgr:try_show_ui("keyword_tips_v2", nil, self.v_keyword_list)
  end
end

return ui
