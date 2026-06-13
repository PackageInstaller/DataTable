local Base = require("ui.uiobject")
local ui = Util.create_child_mt(Base)
local Visualgame_controller = require("gamelogic.visual_gameplay.visualgame_controller")
local LayoutRebuilder = UnityEngine.UI.LayoutRebuilder
ui.Type = {Quantum = 1, Capture = 2}

function ui:ui_finish_load()
  self:set_button("QuantumCameraBtn", function()
    self:on_click_photo_btn()
  end)
  self.v_capture_item_list = {}
end

function ui:ui_on_show(type)
  self.v_type = type or self.v_type
  self:bind_auto_mq(Const.MSG_QUANTUM_CAPTURE, self._response_capture_list, self)
  self:bind_auto_mq(Const.MSG_CAMERA_CAPTURE, self._response_capture_list, self)
  self.v_capture_system_data = self.v_type == ui.Type.Quantum and VisualGameManager:get_capture_system_data() or CaptureMgr:get_capture_system_data()
  local capture_count = #self.v_capture_system_data.PovID
  local addcount = capture_count - #self.v_capture_item_list
  local dirty = false
  for i = 1, addcount do
    local capture_item = UnityGameObject.Instantiate(self.v_uiobjects.QuantumConditionTem, self.v_uiobjects.StarCondition.transform)
    local t = {gameobject = capture_item}
    self.v_capture_item_list[#self.v_capture_item_list + 1] = t
    dirty = true
  end
  if dirty then
    self:set_data()
  end
  LayoutRebuilder.ForceRebuildLayoutImmediate(self.v_uicompents.StarCondition_rect)
  local _, y = self.v_uicompents.StarCondition_rect:GetAnchoredPositionA()
  local _, height = self.v_uicompents.StarCondition_rect:GetRectWH()
  local camera_btn_y = y - height - 52
  self.v_uicompents.QuantumCameraBtn_rect:SetAnchoredPositionY(camera_btn_y)
  local fight_ui = UIMgr:try_get_visible_ui(UIMgr.FIGHT_UI_NAME)
  if fight_ui then
    local fight_tips_view = fight_ui:get_panel("fight_tips")
    local uicompents = fight_tips_view:get_uicompents()
    self.v_tips_fight_8 = uicompents.TipsFight8_rect
    if not self.v_origin_pos_y then
      _, self.v_origin_pos_y = self.v_tips_fight_8:GetAnchoredPositionA()
    end
    local QuantumCondition_rect = Util.get_rect_transform(nil, self.v_object)
    local _, tmp_y = QuantumCondition_rect:GetAnchoredPositionA()
    if self.v_uiobjects.StarCondition.activeSelf then
      self.v_tips_fight_8:SetAnchoredPositionY(tmp_y - height - 104 - 114)
    else
      self.v_tips_fight_8:SetAnchoredPositionY(tmp_y - 114)
    end
  end
  self:refresh()
end

function ui:ui_on_hide()
  if self.v_tips_fight_8 then
    self.v_tips_fight_8:SetAnchoredPositionY(self.v_origin_pos_y)
  end
end

function ui:ui_on_destroy()
  self.v_capture_item_list = nil
end

function ui:set_data()
  for index, value in ipairs(self.v_capture_item_list) do
    local capture_item = value.gameobject
    capture_item:SetActiveEx(index <= #self.v_capture_system_data.PovID)
    if index <= #self.v_capture_system_data.PovID then
      local Tem_txt = Util.get_text(nil, capture_item)
      Tem_txt.text = self.v_capture_system_data.Desc[index]
      local QuantumComplete = Util.get_child_gameobj("QuantumComplete_", capture_item)
      value.Tem_txt = Tem_txt
      value.QuantumComplete = QuantumComplete
    end
  end
end

function ui:refresh()
  local mgr = self.v_type == ui.Type.Quantum and VisualGameManager or CaptureMgr
  for index, value in ipairs(self.v_capture_item_list) do
    if index <= #self.v_capture_system_data.PovID then
      value.QuantumComplete:SetActiveEx(mgr:get_capture_rt(self.v_capture_system_data.PovID[index]))
    end
  end
end

function ui:on_click_photo_btn()
  if self.v_type == ui.Type.Quantum then
    UIMgr:get_ui("ui_quantum_capture_list"):ui_show()
  else
    UIMgr:get_ui("ui_capture_list"):ui_show()
  end
end

function ui:_response_capture_list()
  self:refresh()
end

return ui
