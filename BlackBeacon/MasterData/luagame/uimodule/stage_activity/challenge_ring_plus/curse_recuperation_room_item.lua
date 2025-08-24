local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self:set_button_listener(self:get_button(), function()
    self:on_click_pay_btn(Config.PAY_COSE_TYPE.FREE)
  end)
end

function ui:ui_on_show()
end

function ui:set_data(recuperate_data, unlock_ornament_id)
  self.v_recuperate_data = recuperate_data
  self.v_recuperation_cfg = ShareRes.get_recuperation_cfg(self.v_recuperate_data.id)
  self.v_recuperation_type_cfg = ShareRes.get_recuperation_type_cfg(self.v_recuperation_cfg.Type)
  self:set_button_state()
  self:set_text()
  self:set_icon(unlock_ornament_id)
  self:refresh_use_count()
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:refresh_use_count()
end

function ui:set_button_state()
end

function ui:set_text()
  local cfg = self.v_recuperation_cfg
  self.v_uicompents.Name_txt.text = cfg.Name
  self.v_uicompents.Desc_txt.text = cfg.Desc
end

function ui:set_icon(unlock_ornament_id)
  local cfg = self.v_recuperation_type_cfg
  if Util.is_more_than_zero(unlock_ornament_id) then
    local ornament_cfg = ShareRes.get_ornaments(unlock_ornament_id)
    self.v_uiobjects.EffectOrn:SetActive(true)
    ResMgr:load_set_icon(self.v_uicompents.OrnIcon_img, ornament_cfg.Icon)
  else
    self.v_uiobjects.EffectOrn:SetActive(false)
  end
  ResMgr:load_set_icon(self.v_uicompents.Icon_img, cfg.Icon, nil, true, self)
  ResMgr:load_set_icon(self.v_uicompents.Bg1_img, cfg.Bg, nil, true, self)
end

function ui:on_click_pay_btn(pay_type)
  local data = self.v_recuperate_data
  if not (data and data.use_count) or 0 == data.use_count then
    Util.show_message_tip(2291)
    return
  end
  self.v_parent_ui:on_click_pay_btn(pay_type, self.v_recuperate_data)
end

function ui:check_play_mask_effect()
  local use_count = self.v_recuperate_data.use_count
  local id = self.v_recuperate_data.id
  local last_use_count = ChallengeRingPlusMgr:get_last_recuperation_use_count(id)
  ChallengeRingPlusMgr:set_last_recuperation_use_count(id, use_count)
  if not last_use_count or use_count < last_use_count or not use_count then
  end
end

return ui
