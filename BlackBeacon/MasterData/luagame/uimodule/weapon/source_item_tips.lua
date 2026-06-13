local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnCloseBg", function()
    self:ui_hide()
  end)
  self:set_button("BtnNextLv", function()
    self.v_is_preview = true
    self:refresh_view()
  end)
  self:set_button("BtnNowLv", function()
    self.v_is_preview = false
    self:refresh_view()
  end)
  self:set_button("BtnReplace", function()
    self:on_click_replace()
  end)
  self:set_button("BtnLevelUp", function()
    self:on_click_up_lv()
  end)
  self.v_anim_lvup = Util.get_playabledirector("SafeArea/Animation/Ani_SourceItemTips_Up", self.v_object)
end

function ui:on_click_replace()
  if self.v_show_wear then
    if self.v_gem_cfg.Quality > self.v_pos_quality then
      Util.show_message_tip(2241)
    else
      if GemStoneMgr:check_is_repeat_right_unselected_gem(self.v_operate_equip_uuid, self.v_uuid, self.v_right_selected_pos) then
        Util.show_message_tip(2242)
        return
      end
      GemStoneMgr:req_c2gs_equip_gemstone_up(self.v_operate_equip_uuid, self.v_uuid, self.v_right_selected_pos, function()
        self.v_gem_equip_uuid = self.v_operate_equip_uuid
        self:refresh_view()
      end)
    end
  else
    GemStoneMgr:req_c2gs_equip_gemstone_down(self.v_gem_equip_uuid, self.v_right_selected_pos, function()
      if self.v_hide_when_unwear == true then
        self:ui_hide()
      else
        self:refresh_view()
      end
    end)
  end
end

function ui:on_click_up_lv()
  if not self.v_cost_gem_data or self.v_lvup_click_blocker then
    return
  end
  
  local function cb()
    GemStoneMgr:req_c2gs_equip_gemstone_up_level(self.v_uuid, self.v_cost_gem_data.uuid, function()
      if self.v_anim_lvup then
        self.v_anim_lvup.time = 0
        self.v_anim_lvup:Play()
      end
      self.v_lvup_click_blocker = true
      self.v_timer_idx = Timer:add_timer("source_item_tips_uplv", 0.58, function()
        self:refresh_view()
        self.v_lvup_click_blocker = false
      end)
    end)
  end
  
  if 0 ~= self.v_cost_gem_data.owner then
    Util.show_notify_popup_message(cb, "消耗材料已被装备，是否继续？")
  elseif self.v_cost_gem_data.level > 1 then
    Util.show_notify_popup_message(cb, "消耗材料等级>1，是否继续？")
  else
    cb()
  end
end

function ui:ui_on_show(self_gem_uuid, operate_data, show_data, hide_when_unwear, show_dark_bg)
  MsgGame:mq_publish2(Const.MSG_ON_GEM_TIPS_SHOW)
  if self.v_anim_lvup then
    self.v_anim_lvup.time = 0
    self.v_anim_lvup:Evaluate()
  end
  self.v_lvup_click_blocker = false
end

function ui:refresh(self_gem_uuid, operate_data, show_data, hide_when_unwear, show_dark_bg)
  if self.v_lvup_click_blocker then
    return
  end
  self:ui_after_show(self_gem_uuid, operate_data, show_data, hide_when_unwear, show_dark_bg)
end

function ui:ui_after_show(self_gem_uuid, operate_data, show_data, hide_when_unwear, show_dark_bg)
  if self_gem_uuid then
    self.v_uuid = self_gem_uuid
    self.v_can_show_wear = false
    self.v_can_show_unwear = true
    self.v_show_uplv_btn = true
    self.v_show_preview_btn = true
  end
  if operate_data then
    self.v_operate_equip_uuid = operate_data.operate_equip_uuid
    self.v_right_selected_pos = operate_data.operate_pos
    self.v_pos_quality = operate_data.operate_pos_quality
    self.v_can_show_wear = true
    self.v_can_show_unwear = true
    self.v_show_uplv_btn = true
    self.v_show_preview_btn = true
  elseif show_data then
    self.v_gem_lv = show_data.level
    self.v_gem_id = show_data.id
    self.v_can_show_wear = false
    self.v_can_show_unwear = false
    self.v_show_uplv_btn = false
    self.v_show_preview_btn = false
  end
  self.v_hide_when_unwear = hide_when_unwear
  self.v_is_preview = false
  self.v_uiobjects.BtnCloseBg:SetActive(true == show_dark_bg)
  self:refresh_view()
end

function ui:refresh_view()
  if self.v_uuid then
    local gem_data = GemStoneMgr:get_gem_data(self.v_uuid)
    self.v_gem_equip_uuid = gem_data.equip_uuid or 0
    self.v_gem_lv = gem_data.level or 1
    self.v_gem_id = gem_data.id
  end
  self.v_gem_cfg = ShareRes.get_gem_cfg(self.v_gem_id)
  self.v_gem_lv_cfg = ShareRes.get_gem_lv_cfg(self.v_gem_id)
  local quality = self.v_gem_cfg.Quality
  self.v_uiobjects.MainSource:SetActive(quality > 5)
  if quality > 5 then
    self.v_can_show_wear = false
    self.v_can_show_unwear = false
    self.v_show_uplv_btn = false
    self.v_show_preview_btn = false
  end
  local uicom = self.v_uicompents
  local quality_cfg = ShareRes.get_equip_icon_cfg(quality)
  local path = string.format("UICommon/%s", quality_cfg.QualityIcon)
  ResMgr:load_set_icon(uicom.Quality_img, path)
  uicom.Name_txt.text = self.v_gem_cfg.Name
  uicom.LvNow_txt.text = string.format("Lv.%s", self.v_gem_lv)
  uicom.LvNext_txt.text = string.format("Lv.%s", self.v_gem_lv + 1)
  local uiobj = self.v_uiobjects
  local gem_lv = self.v_gem_lv
  local is_max = gem_lv >= #self.v_gem_lv_cfg
  if is_max or not self.v_show_preview_btn then
    self.v_is_preview = false
  end
  local show_lv = self.v_is_preview and gem_lv + 1 or gem_lv
  uiobj.EffectText:SetActive(not self.v_is_preview)
  uiobj.LvNext:SetActive(self.v_is_preview)
  uiobj.BtnNextLv:SetActive(not self.v_is_preview and not is_max and self.v_show_preview_btn)
  uiobj.BtnNowLv:SetActive(self.v_is_preview)
  uiobj.LvMax:SetActive(is_max)
  uiobj.BtnLevelUp:SetActive(not self.v_is_preview and not is_max and self.v_show_uplv_btn)
  uiobj.CostItem:SetActive(not self.v_is_preview and not is_max and self.v_show_uplv_btn)
  self.v_uicompents.EffectDesc_txt.text = self.v_gem_lv_cfg[show_lv].Desc
  self.v_show_unwear = false
  self.v_show_wear = false
  if self.v_can_show_wear then
    local right_selected_gem_uuid = GemStoneMgr:get_gem_uuid_by_pos(self.v_operate_equip_uuid, self.v_right_selected_pos)
    self.v_show_wear = right_selected_gem_uuid ~= self.v_uuid
  end
  if self.v_show_wear then
    self.v_show_unwear = false
  elseif self.v_can_show_unwear then
    self.v_right_selected_pos = GemStoneMgr:get_gem_pos(self.v_uuid)
    self.v_show_unwear = 0 ~= self.v_gem_equip_uuid
  end
  self.v_uiobjects.BtnReplace:SetActive(self.v_show_unwear or self.v_show_wear)
  self.v_uicompents.BtnReplaceText_txt.text = Util.format_str(self.v_show_wear and "替换" or "卸下")
  if not self.v_is_preview and not is_max and self.v_show_uplv_btn then
    self:refresh_cost()
  end
end

function ui:refresh_cost()
  local same_gem_list = GemStoneMgr:get_same_gem_list(self.v_uuid)
  if not next(same_gem_list) then
    self.v_cost_gem_data = nil
  else
    self.v_cost_gem_data = same_gem_list[1]
  end
  local same_gem_num = #same_gem_list
  self.v_uiobjects.NotEmpty:SetActive(self.v_cost_gem_data ~= nil)
  local use_color = self.v_cost_gem_data == nil and "ff3030" or "292929"
  self.v_uicompents.HaveNum_txt.text = Util.format_str("<color=#{1}>{2}</color>", use_color, same_gem_num)
  Util.apply_grey_ex(self.v_uiobjects.BtnLevelUp, 0 == same_gem_num, true)
  self.v_uiobjects.RedLevelUp:SetActive(same_gem_num > 0)
  if not self.v_cost_gem_data then
    return
  end
  local uicom = self.v_uicompents
  local icon_path, quality_path = UtilUI.get_item_images(self.v_cost_gem_data.id)
  ResMgr:load_set_icon(uicom.CostQuality_img, quality_path)
  ResMgr:load_set_icon(uicom.CostIcon_img, icon_path)
  local owner = self.v_cost_gem_data.owner
  if 0 ~= owner then
    local path = CharacterMgr:get_buddy_icon_path(owner)
    ResMgr:load_set_icon(uicom.HeroIcon_img, path)
  end
  self.v_uiobjects.Wear:SetActive(0 ~= owner)
  self.v_uiobjects.Lv:SetActive(self.v_cost_gem_data ~= nil)
  if self.v_cost_gem_data ~= nil then
    uicom.Lv_txt.text = Util.format_str("LV.{1}", self.v_cost_gem_data.level)
  end
end

function ui:ui_on_hide()
  self.v_uuid = nil
  MsgGame:mq_publish2(Const.MSG_ON_GEM_TIPS_HIDE)
  self:clear_timer()
end

function ui:ui_on_destroy()
  self:clear_timer()
end

function ui:clear_timer()
  if self.v_timer_idx then
    Timer:remove_timer(self.v_timer_idx)
    self.v_timer_idx = nil
  end
end

return ui
