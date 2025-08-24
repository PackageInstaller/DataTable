local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)

function ui:ui_finish_load()
  self.v_tra = self:get_object_transform()
end

function ui:ui_on_show()
  self:bind_auto_mq(Const.MSG_ON_SHOW_UI, self.show_message, self)
  self:bind_auto_mq(Const.MSG_ON_HIDE_UI, self.hide_message, self)
  self:bind_auto_mq(Const.MSG_ON_BATTLE_LOADING_END, self.response_battle_loading, self)
  if not Util.is_client_only() then
    self:bind_auto_mq(Const.MSG_ON_HERO_BORN_ANIM_START, self._response_hero_born_event, self)
    self:bind_auto_mq(Const.MSG_ON_HERO_BORN_ANIM_END, self._response_hero_born_finish_event, self)
  end
  Global.ui_dynamic_canvas = self
  self.v_size_delta_x, self.v_size_delta_y = self.v_tra:GetSizeDeltaA()
end

function ui:ui_on_hide()
  Global.ui_dynamic_canvas = nil
end

function ui:show_message(msg)
  if msg.mm_obj == "ui_challenge_ring" then
    local canvas = self:get_canvas()
    canvas.planeDistance = 0
  end
end

function ui:hide_message(msg)
  if msg.mm_obj == "ui_challenge_ring" then
    local canvas = self:get_canvas()
    canvas.planeDistance = 100
  end
end

function ui:_response_hero_born_finish_event()
  self.v_object:SetActive(true)
end

function ui:_response_hero_born_event()
  self.v_object:SetActive(false)
end

function ui:response_battle_loading(msg)
  if nil == msg then
    return
  end
  local is_open = msg.mm_x
  self.v_object:SetActive(is_open)
end

function ui:ui_update()
  if UNITY_EDITOR and (self.v_tra.sizeDelta.x ~= self.v_size_delta_x or self.v_tra.sizeDelta.y ~= self.v_size_delta_y) then
    self.v_size_delta_x = self.v_tra.sizeDelta.x
    self.v_size_delta_y = self.v_tra.sizeDelta.y
  end
end

function ui:get_canvas_scale_x()
  return self.v_size_delta_x / Global.screen_width
end

function ui:get_canvas_scale_y()
  return self.v_size_delta_y / Global.screen_height
end

function ui:get_rect_size_delta_x()
  return self.v_size_delta_x
end

function ui:get_rect_size_delta_y()
  return self.v_size_delta_y
end

return ui
