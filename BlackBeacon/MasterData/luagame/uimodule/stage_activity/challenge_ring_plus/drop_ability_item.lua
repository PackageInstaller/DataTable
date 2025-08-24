local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local curse_com_def = require("uimodule.stage_activity.challenge_ring_plus.curse_common_define")
local CURSE_CHOOSE_ITEM_TYPE = curse_com_def.CURSE_CHOOSE_ITEM_TYPE

function ui:on_click_Recommend()
  UIMgr:try_show_ui("equation_show_tips")
end

function ui:on_click_TalentDesc()
  if UtilTable.is_empty(self.v_key_id_list) then
    return
  end
  UIMgr:try_show_ui("keyword_tips_v2", nil, self.v_key_id_list)
end

function ui:ui_finish_load()
end

function ui:ui_on_show()
end

function ui:ui_on_hide()
  self.v_ability_cfg = nil
  self.v_quality = nil
  self.v_ability_index = nil
  self.v_main_genres_id = nil
  self.v_ability_grade = nil
  self.v_ability_id = nil
  self.v_is_only_show = nil
end

function ui:ui_on_destroy()
end

function ui:set_data(ability_id, ability_index, is_drop, is_only_show, ability_grade, pause_view, show_type)
  self.v_show_type = show_type
  self.v_is_only_show = is_only_show
  self.v_ability_index = ability_index
  self.v_ability_id = ability_id
  self.v_main_genres_id = GenresMgr:get_main_genres_id()
  if not ability_grade then
    self.v_ability_grade = not (not is_only_show and is_drop) and GenresMgr:get_ability_grade(ability_id) or 1
  else
    self.v_ability_grade = ability_grade
  end
  local ability_cfg = ShareRes.get_ability_cfg(ability_id)
  self.v_quality = ability_cfg.Quality
  self.v_ability_cfg = ability_cfg
  self.v_ability_upgrade_cfg = ShareRes.get_ability_upgrade_cfg(self.v_ability_id, self.v_ability_grade)
  if not self.v_ability_upgrade_cfg then
    Log.Error("配置能力升级配置获取失败，能力id:", self.v_ability_id, "等级：", self.v_ability_grade)
    return
  end
  if is_drop then
    self:set_drop_ability_item_info(pause_view)
  else
    self:set_lv_up_ability_item_info()
  end
  if self.v_uiobjects.Select then
    self.v_uiobjects.Select:SetActive(false)
  end
  if self.v_uiobjects.BtnChoose then
    if self.v_is_only_show then
      self.v_uiobjects.BtnChoose:SetActive(false)
    else
      self.v_uiobjects.BtnChoose:SetActive(true)
      self:set_button("BtnChoose", function()
        self:on_select_drop_ability(true)
        self.v_parent_ui:on_click_select_button()
      end)
    end
  end
  if self.v_uicompents.TalentDesc_btn then
    self.v_key_id_list = self.v_ability_upgrade_cfg.KeyIDList
    self:set_button("TalentDesc", function()
      self:on_click_TalentDesc()
    end)
  end
  if self.v_uicompents.Recommend_btn then
    self:set_button("Recommend", function()
      self:on_click_Recommend()
    end)
  end
end

function ui:set_lv_up_ability_item_info()
  self:set_start()
  self:set_icon(false)
  self:set_text(false)
  self:set_lv()
end

function ui:set_drop_ability_item_info(pause_view)
  if not self.v_is_only_show then
    self:set_effect_active_by_parent(self.v_uiobjects.Effect.transform)
  end
  if self.v_uiobjects.Recommend then
    if self.v_show_type ~= CURSE_CHOOSE_ITEM_TYPE.UPDAGRADE_ABILITY then
      local is_recommend, can_lv_up = FateBookMgr:is_recommend_genres(self.v_ability_cfg.Sect)
      local show_recommend = not pause_view and is_recommend
      self.v_uiobjects.Recommend:SetActive(show_recommend)
      self.v_uiobjects.RecommendLight:SetActive(can_lv_up)
    else
      self.v_uiobjects.Recommend:SetActive(false)
    end
  end
  if self.v_uiobjects.New then
    self.v_uiobjects.New:SetActive(not pause_view and not FateBookMgr:check_illustrated_is_unlock(Config.CommonDefine.CURSE_ILLUSTRATED_TYPE.SECT, self.v_ability_id))
  end
  if self.v_uicompents.DescContent_rect then
    local init_x = self.v_uicompents.DescContent_rect.anchoredPosition.x
    self.v_uicompents.DescContent_rect:SetAnchoredPositionA(init_x, 0)
  end
  if self.v_uicompents.Ani_UICRTalentSelect_Drop_pd then
    self.v_uicompents.Ani_UICRTalentSelect_Drop_pd:ResetPD()
    self.v_uicompents.Ani_UICRTalentSelect_Drop_pd:Play()
  end
  self:set_start()
  self:set_icon(true)
  self:set_text(true)
  self:set_effect_active_by_parent(self.v_uiobjects.Mask.transform, "BgLoop" .. self.v_quality)
end

function ui:set_lv()
  local max_lv = ShareRes.get_ability_max_lv(self.v_ability_id)
  local cur_lv_cfg = ShareRes.get_ability_upgrade_cfg(self.v_ability_id, self.v_ability_grade + 1)
  if self.v_uiobjects.IllustratedLock then
    self.v_uiobjects.IllustratedLock:SetActive(false)
  end
  if self.v_uiobjects.Lock then
    self.v_uiobjects.Lock:SetActive(false)
  end
  if self.v_uiobjects.HandBookUnlock then
    self.v_uiobjects.HandBookUnlock:SetActive(false)
  end
  local is_max_level = max_lv <= self.v_ability_grade
  local show_cost = not is_max_level and cur_lv_cfg and Util.is_more_than_zero(cur_lv_cfg.CostItem) and Util.is_more_than_zero(cur_lv_cfg.CostItemCount)
  if show_cost then
    local final_cost = ChallengeRingPlusMgr:get_after_discount_price(cur_lv_cfg.CostItemCount)
    local path = UtilUI.get_item_icon(cur_lv_cfg.CostItem)
    ResMgr:load_set_icon(self.v_uicompents.CurrIcon_img, path)
    self.v_uicompents.CurrText_txt.text = final_cost
  end
  if self.v_uiobjects.LvMax then
    self.v_uiobjects.LvMax:SetActive(is_max_level)
  end
  self.v_uiobjects.CurrLayout:SetActive(show_cost)
end

function ui:set_start()
  local start_layout_tf = self.v_uiobjects.StarLayout.transform
  if start_layout_tf.childCount < self.v_ability_cfg.Star then
    for index = start_layout_tf.childCount, self.v_ability_cfg.Star do
      local child_tf = start_layout_tf:GetChild(0)
      UnityGameObject.Instantiate(child_tf.gameObject, start_layout_tf)
    end
  end
  for index = 1, start_layout_tf.childCount do
    local child_tf = start_layout_tf:GetChild(index - 1)
    if index <= self.v_ability_cfg.Star and index <= self.v_ability_cfg.Star then
      child_tf.gameObject:SetActive(true)
    else
      child_tf.gameObject:SetActive(false)
    end
  end
end

function ui:set_icon(is_drop)
  local genres_cfg = ShareRes.get_genres_cfg(self.v_ability_cfg.Sect)
  local quality_cfg = ShareRes.get_ability_quality_cfg(self.v_quality)
  ResMgr:load_set_icon(self.v_uicompents.SectIcon_img, genres_cfg.IconPath, nil, true, self)
  local bg_path = (self.v_is_only_show or is_drop) and quality_cfg.QualityBg1 or quality_cfg.QualityBg3
  ResMgr:load_set_icon(self.v_uicompents.QualityBg_img, bg_path, nil, true, self)
  if self.v_uiobjects.RedPoint then
    self.v_uiobjects.RedPoint:SetActive(false)
  end
  if self.v_uiobjects.IllustratedLock then
    self.v_uiobjects.IllustratedLock:SetActive(false)
  end
end

function ui:set_text(is_drop)
  if self.v_uiobjects.ScrollView then
    self.v_uiobjects.ScrollView:SetActive(true)
  end
  local show_lv = self.v_show_type == CURSE_CHOOSE_ITEM_TYPE.UPDAGRADE_ABILITY and math.max(self.v_ability_grade - 1, 1) or self.v_ability_grade
  local show_lv_cfg = ShareRes.get_ability_upgrade_cfg(self.v_ability_id, show_lv)
  if is_drop then
    self.v_uicompents.TalentDesc_txt.text = show_lv_cfg.Desc
    self.v_uicompents.Tag_txt.text = self.v_ability_cfg.Tag
  end
  if self.v_uiobjects.TalentLvUpDesc then
    local show_desc = false
    if self.v_show_type == CURSE_CHOOSE_ITEM_TYPE.COST_UPDAGRADE_ABILITY or self.v_show_type == CURSE_CHOOSE_ITEM_TYPE.UPDAGRADE_ABILITY then
      local ability_next_lv_cfg = ShareRes.get_ability_upgrade_cfg(self.v_ability_id, show_lv + 1)
      if ability_next_lv_cfg then
        show_desc = true
        self.v_uicompents.TalentLvUpDesc_txt.text = "<color=#ffda90>升级后：</color>" .. ability_next_lv_cfg.Desc
      end
    end
    self.v_uiobjects.TalentLvUpDesc:SetActive(show_desc)
  end
  local grade = self.v_ability_upgrade_cfg.Grade
  self.v_uicompents.TalentName_txt.text = self.v_ability_upgrade_cfg.Name
  local color_str = grade >= 2 and "FFD07B" or "FFFFFF"
  Util.set_color(self.v_uicompents.TalentName_txt, color_str)
end

function ui:on_select_drop_ability(is_on)
  if is_on then
    self.v_parent_ui:on_select_drop_ability(self.v_ability_index, self.v_ability_id)
  end
end

function ui:set_effect_active_by_parent(parent, effect_name)
  for index = 1, parent.childCount do
    local child = parent:GetChild(index - 1)
    child.gameObject:SetActive(child.name == effect_name)
  end
end

function ui:on_confirm_select_ability()
  self:set_effect_active_by_parent(self.v_uiobjects.Effect.transform, "QualityEffect" .. self.v_quality)
end

return ui
