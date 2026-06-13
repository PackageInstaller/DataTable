local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Quat = require("base.quat")
local Math = require("base.mathx")
local _tinsert = table.insert
local _tsort = table.sort
local _tremove = table.remove
local _floor = math.floor
local CARD_ITEM_CLASS = require("uimodule.stage_activity.challenge_ring.card_item")
local CHALLENGE_RING_CARD_KEY = "CHALLENGE_RING_CARD_KEY"
local Vec3 = require("base.vec3")
local Zero_Euler = Quat.Euler(0, 0, 0)
local UnityCamera = typeof(UnityEngine.Camera)
local DEBUG = false

local function pos_sort(a, b)
  return a.dis > b.dis
end

function ui:ui_finish_load()
  self.v_angle = 0
  self.v_r = 400
  self.v_quat = Quat:New(0, 1, 0, 0)
  self.v_to_left = false
  self:register_exist_auto_template(CHALLENGE_RING_CARD_KEY, self.v_uiobjects.TestCard1, self.v_uiobjects.TestCardPoint)
  self.v_canvas = self:get_canvas(nil)
  self.v_speed = 10
  self:set_button("RotateRound", function()
    self:rotate_round()
  end)
  self:set_button("DrawCard", function()
    self:draw_card()
  end)
  self:set_button("ReverseCard", function()
    self:reverse_card()
  end)
  self:set_button("DeleteCard", function()
    self:normal_delete_card(1)
  end)
  self:set_button("FlyBag", function()
    self:card_fly_to_bag(self.v_uiobjects.BtnCRBag, 1)
  end)
end

function ui:ui_on_show()
  self:open_test_card_panel()
  self:create_card(25)
end

function ui:ui_on_hide()
  self:clear_ani_seq(self.v_card_shrink_seq)
  self:clear_ani_seq(self.v_local_pos_move_seq)
  self:clear_ani_seq(self.v_negative_rotate_seq)
  self:clear_ani_seq(self.v_positive_rotate_seq)
  self.v_card_shrink_seq = nil
  self.v_local_pos_move_seq = nil
  self.v_negative_rotate_seq = nil
  self.v_positive_rotate_seq = nil
end

function ui:hide()
  self.v_uiobjects.Main:SetActive(false)
end

function ui:show(ignore_rotate)
  if not self.v_uiobjects then
    return
  end
  self.v_uiobjects.Main:SetActive(true)
  if ignore_rotate then
    return
  end
  self:rotate_round()
end

function ui:create_card(card_num)
  self.v_card_num = card_num
  self:set_ring_radius()
  self:refresh_card_pos()
  self:create_card_item_list()
  self:rotate_round()
end

function ui:create_card_item_list()
  self.v_card_item_list = {}
  self:give_back_auto_cache(CHALLENGE_RING_CARD_KEY)
  for i, pos_info in ipairs(self.v_card_pos) do
    local x = pos_info.x
    local y = pos_info.y
    local angle = pos_info.angle
    local item = self:get_auto_cache(CHALLENGE_RING_CARD_KEY)
    local lua_obj = CARD_ITEM_CLASS:ui_wrap_ex(self, item, true)
    item.transform:SetLocalPositionA(x, y, 0)
    item.transform.rotation = Zero_Euler
    item.name = "card_" .. i
    lua_obj:set_back_enable()
    local card_info = {
      go = item,
      lua_obj = lua_obj,
      reservse = false,
      idx = i
    }
    lua_obj:set_data(card_info)
    lua_obj:set_num(i)
    _tinsert(self.v_card_item_list, card_info)
    for list_idx, list_info in pairs(self.v_idx_list_by_angle) do
      local origin_angle = list_info.angle
      if origin_angle == angle then
        self.v_idx_list_by_angle[list_idx].idx = i
        self.v_card_item_list[i].list_idx = list_idx
        break
      end
    end
  end
end

function ui:refresh_new_pos(list_idx, defalut_play)
  self:clear_ani_seq(self.v_local_pos_move_seq)
  self.v_local_pos_move_seq = {}
  self.v_card_move_num = 0
  self.v_is_card_move = true
  local new_card_num = self.v_card_num - 1
  local interval = 360 / new_card_num
  self.v_new_angle_list = {}
  for i = 1, new_card_num do
    local now_angle = _floor((i - 1) * interval)
    _tinsert(self.v_new_angle_list, now_angle)
  end
  if 2 == list_idx then
    for i = 3, self.v_card_num do
      self:_refresh_new_pos(i, i - 1, defalut_play)
    end
  elseif 1 == list_idx then
    for i = self.v_card_num, 2, -1 do
      self:_refresh_new_pos(i, i - 1, defalut_play)
    end
  elseif list_idx == self.v_card_num then
    for i = self.v_card_num - 1, 2, -1 do
      self:_refresh_new_pos(i, i, defalut_play)
    end
  end
end

function ui:_refresh_new_pos(list_idx, new_list_idx, defalut_play)
  local list_info = self.v_idx_list_by_angle[list_idx]
  local card_idx = list_info.idx
  local new_angle = self.v_new_angle_list[new_list_idx]
  local item_obj = self.v_card_item_list[card_idx]
  local item_idx = item_obj.idx
  local go = item_obj.go
  local x = _floor(self.v_r * -math.sin(math.rad(new_angle)))
  local y = _floor(self.v_r * -math.cos(math.rad(new_angle)))
  local pos = Vec3.New(x, y, 0)
  if not defalut_play then
    self:move_to_local_pos(go, pos)
  end
  list_info.idx = item_idx
  list_info.angle = new_angle
  item_obj.list_idx = new_list_idx
  item_obj.lua_obj:set_num(new_list_idx)
end

function ui:move_card_to_pos(card_obj, pos)
  local go = card_obj.go
  local seq = Util.create_sequence()
  seq:Append(go.transform:DOLocalMove(pos, 1))
end

function ui:normal_delete_card(list_idx)
  local card_idx = self.v_idx_list_by_angle[list_idx].idx
  local card_obj = self.v_card_item_list[card_idx]
  self:set_ring_radius()
  self:clear_ani_seq(self.v_card_shrink_seq)
  self.v_card_shrink_seq = {}
  self:card_shrink_and_disable(card_obj, list_idx)
end

function ui:select_delete_card(list_idx)
  self:set_ring_radius()
  self:remove_card_item(list_idx)
end

function ui:_delete_card()
  _tremove(self.v_idx_list_by_angle, self.v_delete_list_idx)
  self.v_card_item_list[self.v_delete_card_idx] = nil
  self.v_draw_card_list[self.v_delete_card_idx] = nil
  self.v_card_num = self.v_card_num - 1
  self:reverse_card()
end

function ui:_specail_delete_card(list_idx)
  if self.v_card_num > 1 then
    _tremove(self.v_idx_list_by_angle, self.v_delete_list_idx)
    self.v_card_item_list[self.v_delete_card_idx] = nil
    self.v_draw_card_list[self.v_delete_card_idx] = nil
    self.v_card_num = self.v_card_num - 1
  end
  if 1 == list_idx and 3 == self.v_card_num then
    local temp_card_idx = self.v_idx_list_by_angle[1].idx
    self.v_idx_list_by_angle[1].idx = self.v_idx_list_by_angle[2].idx
    self.v_idx_list_by_angle[2].idx = temp_card_idx
  end
  self:draw_card()
  MsgGame:mq_publish2(Const.MSG_ON_CR_DELETE_CARD_END)
end

function ui:remove_card_item(list_idx)
  local card_idx = self.v_idx_list_by_angle[list_idx].idx
  local card_obj = self.v_card_item_list[card_idx]
  local go = card_obj.go
  if go.activeInHierarchy then
    self:give_back_auto_cache_obj(nil, go)
  end
  self.v_delete_list_idx = list_idx
  self.v_delete_card_idx = card_idx
  if self.v_card_num > 4 then
    self:refresh_new_pos(list_idx)
    self:_delete_card()
  else
    self:refresh_new_pos(list_idx, true)
    self:_specail_delete_card(list_idx)
  end
end

function ui:refresh_card_pos()
  self.v_idx_list_by_angle = {}
  local interval = 360 / self.v_card_num
  local angle = 0
  local r = self.v_r
  self.v_card_pos = {}
  for i = 1, self.v_card_num do
    local now_angle = _floor(angle + (i - 1) * interval)
    local x = _floor(r * -math.sin(math.rad(now_angle)))
    local y = _floor(r * -math.cos(math.rad(now_angle)))
    local origin = -r
    local pos_info = {
      x = x,
      y = y,
      dis = math.abs(x) + math.abs(y - origin),
      angle = now_angle
    }
    local list_info = {angle = now_angle}
    _tinsert(self.v_idx_list_by_angle, list_info)
    _tinsert(self.v_card_pos, pos_info)
  end
  _tsort(self.v_card_pos, pos_sort)
end

function ui:set_ring_radius()
  self.v_r = 750 + (self.v_card_num - 3) * 20
  self:change_ring_pos_z()
end

function ui:change_ring_pos_z()
  local ring_obj = self.v_uiobjects.TestCardPoint
  local x = ring_obj.transform.localPosition.x
  local y = ring_obj.transform.localPosition.y
  local z = -50 + (self.v_card_num - 3) * 20
  ring_obj.transform:SetLocalPositionA(x, y, z)
end

function ui:set_front_card_same_pos()
  self:clear_ani_seq(self.v_local_pos_move_seq)
  self.v_local_pos_move_seq = {}
  self.v_card_move_num = 0
  self.v_is_card_move = true
  local middle_list_idx = self.v_idx_list_by_angle[1].idx
  local middle_card_obj = self.v_card_item_list[middle_list_idx].go
  local left_list_idx = self.v_idx_list_by_angle[2].idx
  local right_list_idx = self.v_idx_list_by_angle[self.v_card_num].idx
  local left_card_obj = self.v_card_item_list[left_list_idx].go
  local right_card_obj = self.v_card_item_list[right_list_idx].go
  local middle_x = middle_card_obj.transform.localPosition.x
  local middle_y = middle_card_obj.transform.localPosition.y
  local middle_z = middle_card_obj.transform.localPosition.z
  local left_x = middle_x - 325
  local right_x = middle_x + 325
  local left_localpos = Vec3.New(left_x, middle_y, middle_z)
  local right_localpos = Vec3.New(right_x, middle_y, middle_z)
  self:set_go_front(middle_card_obj)
  self:set_go_front(left_card_obj)
  self:set_go_front(right_card_obj)
  self:move_to_local_pos(left_card_obj, left_localpos)
  self:move_to_local_pos(right_card_obj, right_localpos)
end

function ui:_set_remain_card_front()
  self:clear_ani_seq(self.v_local_pos_move_seq)
  self.v_local_pos_move_seq = {}
  self.v_card_move_num = 0
  self.v_is_card_move = true
  local middle_list_idx = self.v_idx_list_by_angle[1].idx
  local middle_card_obj = self.v_card_item_list[middle_list_idx].go
  local middle_x = middle_card_obj.transform.localPosition.x
  local left_x = middle_x - 325
  local right_x = middle_x + 325
  local middle_y = -self.v_r
  local middle_z = middle_card_obj.transform.localPosition.z
  local middle_localpos = Vec3.New(0, middle_y, middle_z)
  self:set_go_front(middle_card_obj)
  self:move_to_local_pos(middle_card_obj, middle_localpos)
  if self.v_idx_list_by_angle[2] then
    local left_list_idx = self.v_idx_list_by_angle[2].idx
    local left_card_obj = self.v_card_item_list[left_list_idx].go
    self:set_go_front(left_card_obj)
    local left_localpos = Vec3.New(left_x, middle_y, middle_z)
    self:move_to_local_pos(left_card_obj, left_localpos)
  end
  if self.v_idx_list_by_angle[self.v_card_num] then
    local right_list_idx = self.v_idx_list_by_angle[self.v_card_num].idx
    local right_card_obj = self.v_card_item_list[right_list_idx].go
    local right_localpos = Vec3.New(right_x, middle_y, middle_z)
    self:set_go_front(right_card_obj)
    self:move_to_local_pos(right_card_obj, right_localpos)
  end
end

function ui:set_go_front(card_obj)
  card_obj.transform:SetAsLastSibling()
end

function ui:move_to_local_pos(card_obj, localpos)
  local seq = Util.create_sequence()
  _tinsert(self.v_local_pos_move_seq, seq)
  self.v_card_move_num = self.v_card_move_num + 1
  seq:Append(card_obj.transform:DOLocalMove(localpos, 1))
  seq:OnComplete(function()
    self:card_move_end()
  end)
end

function ui:card_move_end()
  self.v_card_move_num = self.v_card_move_num - 1
  self.v_is_card_move = 0 ~= self.v_card_move_num
end

function ui:rotate_round()
  if DEBUG then
    Log.Error("rotate round")
    Log.Error(debug.traceback())
  end
  if self.v_card_num < 4 then
    self:draw_card()
  else
    local seq = Util.create_sequence()
    seq:Append(self.v_uiobjects.TestCardPoint.transform:DORotate(Vec3.New(90, 0, 360), 0.5, CS.DG.Tweening.RotateMode.FastBeyond360))
    seq:OnComplete(function()
      self:draw_card()
    end)
  end
end

function ui:card_positive_rotate_round(card_obj)
  local go = card_obj.go
  local lua_obj = card_obj.lua_obj
  local seq = Util.create_sequence()
  seq:Append(go.transform:DORotate(Vec3.New(0, 90, 0), 0.1, CS.DG.Tweening.RotateMode.WorldAxisAdd))
  seq:AppendCallback(function()
    lua_obj:set_face_enable()
    if self.v_card_num > 3 then
      self:set_front_card_same_pos()
    else
      self:_set_remain_card_front()
    end
  end)
  seq:Append(go.transform:DORotate(Vec3.New(0, 90, 0), 0.1, CS.DG.Tweening.RotateMode.WorldAxisAdd))
end

function ui:card_negative_rotate_round(card_obj)
  local go = card_obj.go
  local lua_obj = card_obj.lua_obj
  local seq = Util.create_sequence()
  _tinsert(self.v_negative_rotate_seq, seq)
  seq:Append(go.transform:DORotate(Vec3.New(0, 90, 0), 0.1, CS.DG.Tweening.RotateMode.WorldAxisAdd))
  seq:AppendCallback(function()
    lua_obj:set_back_enable()
  end)
  seq:Append(go.transform:DORotate(Vec3.New(0, 90, 0), 0.1, CS.DG.Tweening.RotateMode.WorldAxisAdd))
  seq:OnComplete(function()
    self:reduce_negtive_rotate_num()
  end)
end

function ui:reduce_negtive_rotate_num()
  self.v_negative_num = self.v_negative_num - 1
  self.v_is_negative_rotate = 0 ~= self.v_negative_num
  if self.v_is_negative_rotate then
    MsgGame:mq_publish2(Const.MSG_ON_CR_DELETE_CARD_END)
  end
end

function ui:refuce_positive_rotate_num()
  self.v_positive_num = self.v_positive_num - 1
  self.v_is_positive_rotate = 0 ~= self.v_positive_num
end

function ui:card_shrink_and_disable(card_obj, list_idx)
  local go = card_obj.go
  local seq = Util.create_sequence()
  _tinsert(self.v_card_shrink_seq, seq)
  seq:Append(go.transform:DOScale(Vec3.New(0.5, 0.5, 1), 0.5))
  seq:OnComplete(function()
    self:remove_card_item(list_idx)
  end)
end

function ui:try_fly_to_bag(msg)
  if nil == msg or nil == msg.mm_obj then
    return
  end
  local mm_obj = msg.mm_obj
  local go = mm_obj.go
  local cr_ui = UIMgr:get_ui("ui_challenge_ring")
  if cr_ui then
    cr_ui:try_fly_to_bag(go)
  end
end

function ui:card_fly_to_bag(bag_obj, card_list_idx)
  local card_idx = self.v_idx_list_by_angle[1].idx
  local go = self.v_draw_card_list[card_idx].go
  local seq = Util.create_sequence()
  local uicamera = Util.get_component(nil, UIMgr.root_camera_obj, UnityCamera)
  local world_camera = UIMgr:get_world_camera()
  local first_pos = uicamera:WorldToScreenPoint(bag_obj.transform.position)
  local world_pos = world_camera:ScreenToWorldPoint(first_pos)
  seq:Append(go.transform:DOMove(world_pos, 1))
  seq:OnComplete(function()
    self:select_delete_card(1)
  end)
end

function ui:card_fly_to_sign()
end

function ui:draw_card()
  self.v_draw_card_list = {}
  local card_list = {
    [1] = 1,
    [2] = self.v_card_num >= 2 and 2 or nil,
    [3] = self.v_card_num >= 3 and self.v_card_num or nil
  }
  self:clear_ani_seq(self.v_positive_rotate_seq)
  self.v_positive_rotate_seq = {}
  self.v_positive_num = 0
  self.v_is_positive_rotate = true
  local draw_card_id_list = ChallengeRingMgr:get_random_select_card()
  if DEBUG then
    Log.Error("card_list", card_list)
    Log.Error("draw_card_id_list", draw_card_id_list)
    Log.Error("v_idx_list_by_angle", self.v_idx_list_by_angle)
    Log.Error(debug.traceback())
    for key, value in pairs(self.v_card_item_list) do
      Log.Error("card_list_idx", key)
      Log.Error("card_idx", value.idx)
    end
  end
  for k, list_idx in pairs(card_list) do
    local card_idx = self.v_idx_list_by_angle[list_idx].idx
    if DEBUG then
      Log.Error("card_idx", card_idx)
    end
    if card_idx then
      local item_obj = self.v_card_item_list[card_idx]
      local idx = item_obj.idx
      local reserve = item_obj.reservse
      if not reserve then
        self:card_positive_rotate_round(item_obj)
        item_obj.reservse = true
      end
      self.v_draw_card_list[idx] = item_obj
      if draw_card_id_list and draw_card_id_list[k] then
        local lua_obj = item_obj.lua_obj
        lua_obj:refresh_ui(draw_card_id_list[k])
        item_obj.select_idx = k
      end
    end
  end
  if DEBUG then
    Log.Error("self.v_draw_card_list", self.v_draw_card_list)
  end
end

function ui:reverse_card()
  self:clear_ani_seq(self.v_negative_rotate_seq)
  self.v_negative_rotate_seq = {}
  self.v_negative_num = 0
  self.v_is_negative_rotate = true
  for _, obj_info in pairs(self.v_draw_card_list) do
    self.v_negative_num = self.v_negative_num + 1
    local reserve = obj_info.reservse
    if reserve then
      self:card_negative_rotate_round(obj_info)
      obj_info.reservse = false
    end
  end
end

function ui:open_test_card_panel()
  self.v_uiobjects.FullScreenBackground:SetActive(true)
  self.v_uiobjects.TestCardBtn:SetActive(true)
end

function ui:is_ani_end()
  return not self.v_is_negative_rotate
end

function ui:clear_ani_seq(seq_list)
  if not seq_list then
    return
  end
  for _, seq in pairs(seq_list) do
    seq:Kill()
  end
end

function ui:cache_ui()
  return true
end

return ui
