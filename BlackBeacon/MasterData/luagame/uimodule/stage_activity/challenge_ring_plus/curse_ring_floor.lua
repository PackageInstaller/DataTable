local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Cs_color = UnityEngine.Color
local Quat = require("base.quat")
local Vec3 = require("base.vec3")
local ACTIVE_COLOR = Cs_color(1, 0.9411764705882353, 0.8352941176470589, 1)
local UNACTIVE_COLOR = Cs_color(0.40784313725490196, 0.39215686274509803, 0.37254901960784315, 1)
local RING_ITEM_STATE = {
  Passed = 1,
  Now = 2,
  Next = 3,
  UnLock = 4
}
local detween_total_time = 2
local POINTER_ANGLE = {
  [1] = 303,
  [2] = 236,
  [3] = 154,
  [4] = 99,
  [5] = 10
}
local _insert = table.insert

function ui:ui_finish_load()
end

function ui:ui_on_show()
  self.v_timer = nil
  self.v_dotween_anim_seq_list = {}
  local tower = TowerMgr:get_tower()
  local max_floor = tower:get_max_floor()
  local cur_floor = ChallengeRingPlusMgr.v_cur_circle_index
  self.v_uicompents.FloorNumMax_txt.text = max_floor
  self.v_uicompents.FloorNumNow_txt.text = cur_floor
  self.v_cur_floor_num = cur_floor
  for i = 1, 5 do
    local type = RING_ITEM_STATE.UnLock
    if i == cur_floor then
      type = RING_ITEM_STATE.Now
    elseif i == cur_floor + 1 then
      type = RING_ITEM_STATE.Next
    elseif i <= cur_floor then
      type = RING_ITEM_STATE.Passed
    end
    self:refresh_item(i, type)
  end
  local pointer_trans = self.v_uiobjects.Pointer.transform
  local now_angle = POINTER_ANGLE[self.v_cur_floor_num]
  pointer_trans:SetEuler(0, 0, now_angle)
  self:set_timer()
end

function ui:set_timer()
  local duration = self.v_uicompents.Ani_ChalRingFloor_IN_pd.duration
  if duration >= detween_total_time then
    local function cb()
      ChallengeRingPlusMgr:req_enter_door()
      
      self.v_timer = nil
    end
    
    self.v_timer = Timer:add_timer(nil, duration, cb)
  end
end

function ui:pointer_move()
  local next_angle = POINTER_ANGLE[self.v_cur_floor_num + 1]
  local pointer_trans = self.v_uiobjects.Pointer.transform
  local seq = Util.create_sequence()
  seq:Append(pointer_trans:DORotate(Vec3.New(0, 0, next_angle), 0.5))
  seq:OnComplete(function()
    self:show_next_floor_ui()
    if not self.v_timer then
      ChallengeRingPlusMgr:req_enter_door()
    end
  end)
  _insert(self.v_dotween_anim_seq_list, seq)
end

function ui:refresh_item(idx, type)
  local floorNow_trans = self.v_uiobjects["FloorNow" .. idx].transform
  local num_trans = self.v_uiobjects["Num" .. idx].transform
  local num_txt_com = self.v_uicompents["Num" .. idx .. "_txt"]
  local canvas_group = floorNow_trans:GetComponent("CanvasGroup")
  local color = UNACTIVE_COLOR
  floorNow_trans:SetActive(false)
  num_trans:SetActive(false)
  if type == RING_ITEM_STATE.Passed then
    num_trans:SetActive(true)
  elseif type == RING_ITEM_STATE.Now then
    canvas_group.alpha = 1
    floorNow_trans:SetActive(true)
    num_trans:SetActive(true)
    local seq = Util.create_sequence()
    seq:Append(canvas_group:DOFade(0, 0.5))
    seq:Join(num_txt_com:DOColor(UNACTIVE_COLOR, 0.5))
    seq:OnComplete(function()
      self:pointer_move()
    end)
    _insert(self.v_dotween_anim_seq_list, seq)
    color = ACTIVE_COLOR
  elseif type == RING_ITEM_STATE.Next then
    num_trans:SetActive(true)
    local seq = Util.create_sequence()
    seq:Append(num_txt_com:DOColor(ACTIVE_COLOR, 1.5))
    color = UNACTIVE_COLOR
  end
  num_txt_com.color = color
end

function ui:show_next_floor_ui()
  local idx = self.v_cur_floor_num + 1
  if ChallengeRingPlusMgr:is_end_ring() then
    idx = self.v_cur_floor_num
  end
  self.v_uicompents.FloorNumNow_txt.text = idx
  local floorNow_trans = self.v_uiobjects["FloorNow" .. idx].transform
  local canvas_group = floorNow_trans:GetComponent("CanvasGroup")
  canvas_group.alpha = 0
  floorNow_trans:SetActive(true)
  local seq = Util.create_sequence()
  seq:Append(canvas_group:DOFade(1, 0.5))
  _insert(self.v_dotween_anim_seq_list, seq)
end

function ui:ui_on_hide()
  if self.v_timer then
    Timer:remove_timer(self.v_timer)
    self.v_timer = nil
  end
  for _, seq in pairs(self.v_dotween_anim_seq_list) do
    seq:Kill()
  end
  self.v_dotween_anim_seq_list = nil
end

function ui:ui_on_destroy()
end

return ui
