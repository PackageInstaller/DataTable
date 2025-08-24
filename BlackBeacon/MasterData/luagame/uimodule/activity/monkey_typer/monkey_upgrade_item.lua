local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local UPGRADE_TYPE = Config.CommonDefine.MONKEY_TYPEWRITER_UPGRADE_TYPE

function ui:on_click_BtnLvup()
  if self.v_upgrade_fail_tips then
    Util.show_message_tip(self.v_upgrade_fail_tips)
    return
  end
  if self.v_block_click then
    return
  end
  self.v_block_click = true
  self:clear_timer()
  self.v_uiobjects.ClickEffect:SetActiveEx(false)
  MonkeyTyperMgr:req_upgrade(self.v_activity_id, self.v_type, function(ok)
    if ok then
      Util.show_message_tip(2360)
      self.v_uiobjects.ClickEffect:SetActiveEx(true)
      Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.monkey_typer_up_cpl_UI_SOUND)
      self.v_delay_refresh_timer = Timer:add_timer("monkey_typer_upgrade_delay_refresh_timer", 0.5, function()
        self:self_refresh(true)
        self.v_block_click = false
      end)
    else
      self:self_refresh()
      self.v_block_click = false
    end
  end)
end

function ui:clear_timer()
  if self.v_delay_refresh_timer then
    Timer:remove_timer(self.v_delay_refresh_timer)
    self.v_delay_refresh_timer = nil
  end
end

function ui:ui_finish_load()
  self:set_button("BtnLvup", function()
    self:on_click_BtnLvup()
  end)
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ROLE_RES_CHANGE, self.self_refresh, self)
end

function ui:ui_on_hide()
  self:clear_timer()
end

function ui:ui_on_destroy()
end

function ui:self_refresh(play_show_anim)
  self:set_data(self.v_activity_id, self.v_type, play_show_anim)
end

function ui:set_data(activity_id, type, play_show_anim)
  if not activity_id or not type then
    self.v_object:SetActive(false)
    return
  end
  self.v_activity_id = activity_id
  self.v_type = type
  local cur_lv = MonkeyTyperMgr:get_level_by_type(self.v_activity_id, type)
  self.v_cur_lv = cur_lv
  local all_lv_cfg = ShareRes.get_monkey_typer_upgrade_cfg(self.v_activity_id, type)
  local next_lv_cfg = all_lv_cfg[cur_lv + 1]
  if not next_lv_cfg then
    self.v_object:SetActive(false)
    return
  end
  self.v_uicompents.EfficiencyDesc_txt.text = next_lv_cfg.DescPrefix .. next_lv_cfg.DescUnit
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, next_lv_cfg.Icon)
  local upgrade_fail_tips, cond_desc
  local btn_desc = "开始训练"
  local can_upgrade
  local is_max = false
  if not next_lv_cfg or not all_lv_cfg[cur_lv + 2] then
    cond_desc = "已到达最大等级"
    btn_desc = "最大等级"
    self.v_uiobjects.Check:SetActiveEx(true)
    self.v_uiobjects.NormalBg:SetActiveEx(false)
    self.v_uiobjects.GrayBg:SetActiveEx(true)
    can_upgrade = false
    is_max = true
  elseif next_lv_cfg.Condition then
    cond_desc = ShareRes.get_condition_desc(next_lv_cfg.Condition)
    can_upgrade = Condition:check_condition(next_lv_cfg.Condition)
    if not can_upgrade then
      upgrade_fail_tips = "条件未达成"
    end
  else
    local coin_id = ShareRes.create("activity.monkey_typewriter_misc")[self.v_activity_id].Coin
    local coin_name = UtilUI.get_item_name(coin_id)
    cond_desc = Util.format_str("消耗{1}{2}", next_lv_cfg.ConsumeItemCount, coin_name)
    local own_num = BagMgr:get_item_num(coin_id)
    can_upgrade = own_num >= next_lv_cfg.ConsumeItemCount
    if not can_upgrade then
      upgrade_fail_tips = Util.format_str("{1}不足", coin_name)
    end
  end
  self.v_uicompents.BtnLvup_btn.interactable = not is_max
  self.v_uicompents.Condition_txt.text = cond_desc
  self.v_uicompents.BtnLvupTxt_txt.text = btn_desc
  self.v_uiobjects.Check:SetActiveEx(can_upgrade or is_max)
  self.v_uiobjects.NormalBg:SetActiveEx(can_upgrade)
  self.v_uiobjects.GrayBg:SetActiveEx(not can_upgrade)
  self.v_upgrade_fail_tips = upgrade_fail_tips
  if true == play_show_anim then
    self.v_uiobjects.ClickEffect:SetActiveEx(false)
    self.v_uiobjects.Ani_In:SetActiveEx(false)
    self.v_uiobjects.Ani_In:SetActiveEx(true)
  end
end

return ui
