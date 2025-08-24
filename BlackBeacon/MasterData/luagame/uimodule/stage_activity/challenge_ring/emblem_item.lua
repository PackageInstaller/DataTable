local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local ENTER_EMBLEM_EFFECT = "Fx_UI_Card_06_2"
local ACTIVE_KEY_CARD_PATH = "UIEvent02/Event02_card_point"
local INACTIVE_KEY_CARD_PATH = "UIEvent02/Event02_card_point_white"

function ui:ui_finish_load()
  self:register_effect(ENTER_EMBLEM_EFFECT)
end

function ui:ui_on_hide()
  self:remove_enter_timer()
end

function ui:remove_enter_timer()
  if self.v_enter_timer then
    Timer:remove_timer(self.v_enter_timer)
    self.v_enter_timer = nil
  end
end

function ui:init_ui()
  self.v_active = false
  ResMgr:load_set_icon(self.v_uicompents.SignIcon_img, INACTIVE_KEY_CARD_PATH)
end

function ui:set_emblem_active()
  self.v_active = true
  ResMgr:load_set_icon(self.v_uicompents.SignIcon_img, ACTIVE_KEY_CARD_PATH)
end

function ui:play_enter_effect()
  self:play_effect(ENTER_EMBLEM_EFFECT)
  self:set_emblem_active()
end

function ui:get_enter_effect_time()
  local effect = self:get_effect(ENTER_EMBLEM_EFFECT)
  local length = effect.length
  return length
end

function ui:refresh_num(num)
  local sign_num = self.v_uicompents.SignNum_txt
  if sign_num then
    sign_num.text = string.format("x%d", num)
  end
end

function ui:is_active()
  return self.v_active
end

return ui
