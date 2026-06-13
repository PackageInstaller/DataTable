local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local _tinsert = table.insert
local _tremove = table.remove
local _floor = math.floor
local _random = math.random
local _min = math.min
local CARD_ITEM_CLASS = require("uimodule.stage_activity.challenge_ring.card_item")
local FLY_EMBLEM_CLASS = require("uimodule.stage_activity.challenge_ring.fly_emblem_item")
local CR_RING_CFG_PATH = require("uimodule.stage_activity.challenge_ring.challenge_ring_cfg")
local CHALLENGE_RING_CARD_KEY = "CHALLENGE_RING_CARD_KEY"
local FLY_EMBLEM_KEY = "FLY_EMBLEM_KEY"
local CommonDef = require("cs_share.common_define")
local RING_CARD_TYPE = CommonDef.CHL_RING_CARD_TYPE
local Vec3 = require("base.vec3")
local UnityCamera = typeof(UnityEngine.Camera)
local DEBUG = false
local CARD_STATUS = {
  INIT = 1,
  SUSPEND = 2,
  ON_CHOOSE = 3,
  DONE = 4
}
local CARD_DECK_STATE = CR_RING_CFG_PATH.CARD_DECK_STATE
local CHANGE_STATE_TB = {
  [CARD_DECK_STATE.INIT] = {
    [CARD_DECK_STATE.IDLE] = "create_card"
  },
  [CARD_DECK_STATE.IDLE] = {
    [CARD_DECK_STATE.ROTATE] = "draw_card_logic",
    [CARD_DECK_STATE.CONTINUE_SELECTING] = "continue_selecting_card_state",
    [CARD_DECK_STATE.SELECT] = "continue_select_logic_check"
  },
  [CARD_DECK_STATE.ROTATE] = {
    [CARD_DECK_STATE.DRAW_CARD] = "draw_card_state"
  },
  [CARD_DECK_STATE.DRAW_CARD] = {
    [CARD_DECK_STATE.SELECT] = "select_card_state"
  },
  [CARD_DECK_STATE.SELECT] = {
    [CARD_DECK_STATE.SELECTTING] = "selecting_card_state",
    [CARD_DECK_STATE.IDLE] = "reset_select_card_state",
    [CARD_DECK_STATE.INIT] = "reset_card_deck_state"
  },
  [CARD_DECK_STATE.SELECTTING] = {
    [CARD_DECK_STATE.DELETE] = "delete_card_state"
  },
  [CARD_DECK_STATE.DELETE] = {
    [CARD_DECK_STATE.IDLE] = "refresh_new_pos_state"
  },
  [CARD_DECK_STATE.DELETING] = {
    [CARD_DECK_STATE.IDLE] = "draw_card_logic"
  },
  [CARD_DECK_STATE.CONTINUE_SELECTING] = {
    [CARD_DECK_STATE.DELETE] = "continue_delete_state"
  },
  [CARD_DECK_STATE.CREATE_KEY_CARD] = {
    [CARD_DECK_STATE.IDLE] = "create_card_state"
  },
  [CARD_DECK_STATE.CREATE_DOOR_CARD] = {
    [CARD_DECK_STATE.IDLE] = "create_card_state"
  }
}
local CAN_OPERATE_STATE = {
  [CARD_DECK_STATE.IDLE] = true,
  [CARD_DECK_STATE.SELECT] = true,
  [CARD_DECK_STATE.SELECTTING] = true,
  [CARD_DECK_STATE.CONTINUE_SELECTING] = true
}

local function limit_range(now_angle)
  if now_angle > 360 then
    return now_angle - 360
  elseif now_angle < 0 then
    return 360 - math.abs(now_angle)
  else
    return now_angle
  end
end

function ui:ui_finish_load()
  self.v_angle = 0
  self.v_base_r = 900
  self.v_r = self.v_base_r
  self:register_exist_auto_template(CHALLENGE_RING_CARD_KEY, self.v_uiobjects.TestCard1, self.v_uiobjects.TestCardPoint)
  self:register_exist_auto_template(FLY_EMBLEM_KEY, self.v_uiobjects.Emblum, self.v_uiobjects.FlyEmblemList)
  self:set_button("RotateRound", function()
    self:rotate_round()
  end)
  self:set_button("DrawCard", function()
    self:draw_card()
  end)
  self:set_button("ReverseCard", function()
    self:reverse_card()
  end)
  self.v_busy_timer = {}
  self.v_enter_timer = {}
end

function ui:ui_on_show()
  self.v_anim_counter = 0
  self.v_timer_busy_idx = 1
  self.v_is_create_key_card = ChallengeRingMgr:is_show_key_card()
  self:set_state(CARD_DECK_STATE.INIT)
  self.v_card_num = ChallengeRingMgr:get_remain_card_num()
  if DEBUG then
    Log.Error("self.v_card_num", self.v_card_num)
  end
  self:register_event()
  self:change_state(CARD_DECK_STATE.IDLE)
  UIMgr:set_world_camera_visible_state(true)
end

function ui:register_event()
  self:bind_auto_mq(Const.MSG_ON_DRAW_CARD_END, self.response_draw_card_end, self)
  self:bind_auto_mq(Const.MSG_ON_CR_REFRESH_DOOR_CARD, self.response_draw_card_end, self)
  self:bind_auto_mq(Const.MSG_ON_CR_SELECT_CARD_END, self.response_select_card_end, self)
  self:bind_auto_mq(Const.MSG_HERO_ATTR_CHANGE, self.response_team_attr_change, self)
  self:bind_auto_mq(Const.MSG_GOD_ATTR_CHANGE, self.response_team_attr_change, self)
  self:bind_auto_mq(Const.MSG_ON_CARD_RANDOM_REFRESH, self.response_card_random_refresh, self)
  self:bind_auto_mq(Const.MSG_ON_RING_CARD_REFRESH, self.response_card_refresh, self)
end

function ui:ui_on_hide()
  self:clear_ani_seq(self.v_card_shrink_seq)
  self:clear_ani_seq(self.v_local_pos_move_seq)
  self:clear_ani_seq(self.v_negative_rotate_seq)
  self:clear_ani_seq(self.v_positive_rotate_seq)
  self:clear_ani_seq(self.v_rotate_seq)
  self:clear_ani_seq(self.v_card_fly_bag_seq)
  self:clear_ani_seq(self.v_emblem_fly_seq)
  self:clear_ani_seq(self.v_goback_move_seq)
  self.v_card_shrink_seq = nil
  self.v_local_pos_move_seq = nil
  self.v_negative_rotate_seq = nil
  self.v_positive_rotate_seq = nil
  self.v_rotate_seq = nil
  self.v_card_fly_bag_seq = nil
  self.v_emblem_fly_seq = nil
  self.v_goback_move_seq = nil
  for timer_idx, _ in pairs(self.v_busy_timer) do
    Timer:remove_timer(timer_idx)
  end
  for _, timer_idx in pairs(self.v_enter_timer) do
    Timer:remove_timer(timer_idx)
  end
  self.v_wrap_uis = {}
  self.v_card_item_list = nil
  MsgGame:mq_publish2(Const.MSG_ON_HIDE_CARD_DECK)
  UIMgr:set_world_camera_visible_state(false)
end

function ui:ui_on_destroy()
  self.v_busy_timer = nil
end

function ui:create_card()
  self:set_ring_radius()
  self:refresh_card_pos()
  self:create_card_item_list()
  self:change_card_layer()
  local ring_state = ChallengeRingMgr:get_card_deck_state()
  self:set_state(CARD_DECK_STATE.IDLE)
  if ring_state then
    self:change_state(ring_state)
  else
    self:change_state(CARD_DECK_STATE.ROTATE)
  end
end

function ui:change_state(new_state)
  if DEBUG then
    Log.Error("状态改变", self.v_ring_state, new_state)
    Log.Error(debug.traceback())
  end
  local state_map = CHANGE_STATE_TB[self.v_ring_state]
  for state_idx, fun in pairs(state_map) do
    if new_state == state_idx then
      ui[fun](self)
      break
    end
  end
end

function ui:set_state(new_state)
  self.v_ring_state = new_state
end

function ui:refresh_new_pos_state()
  self:set_state(CARD_DECK_STATE.DELETING)
  local length = #self.v_card_item_list
  self.v_card_num = length
  self:set_ring_radius()
  self:refresh_card_pos()
  self:move_card_to_new_pos()
  self:change_card_layer()
end

function ui:move_to_local_pos(card_obj, localpos)
  local go = card_obj.go
  local seq = Util.create_sequence()
  _tinsert(self.v_local_pos_move_seq, seq)
  self:add_anim_counter()
  self.v_card_move_num = self.v_card_move_num + 1
  seq:Append(go.transform:DOLocalMove(localpos, 1))
  seq:OnComplete(function()
    self:card_move_end()
    self:reduce_anim_counter()
  end)
end

function ui:move_card_to_new_pos()
  self:clear_ani_seq(self.v_local_pos_move_seq)
  self.v_local_pos_move_seq = {}
  self.v_card_move_num = 0
  for list_idx, pos_info in ipairs(self.v_card_pos) do
    local item_obj = self.v_card_item_list[list_idx]
    item_obj.card_list_idx = list_idx
    local x = pos_info.x
    local y = pos_info.y
    local new_pos = Vec3.New(x, y, 0)
    self:move_to_local_pos(item_obj, new_pos)
  end
end

function ui:draw_card_logic()
  local is_have_draw_card = ChallengeRingMgr:is_draw_card_end()
  if DEBUG then
    Log.Error("is_get_random_list", is_have_draw_card)
  end
  if is_have_draw_card then
    if self.v_card_num < 4 then
      self:draw_card_state()
    else
      self:rotate_ring_state()
    end
  end
end

function ui:create_card_item_list()
  self.v_card_item_list = {}
  if DEBUG then
    Log.Error("self.v_card_num", self.v_card_num)
  end
  self:give_back_auto_cache(CHALLENGE_RING_CARD_KEY)
  for i, pos_info in ipairs(self.v_card_pos) do
    local x = pos_info.x
    local y = pos_info.y
    local angle = pos_info.angle
    local item = self:get_auto_cache(CHALLENGE_RING_CARD_KEY)
    local lua_obj = CARD_ITEM_CLASS:ui_wrap_ex(self, item, true)
    item.transform:SetLocalPositionA(x, y, 0)
    local card_info = {
      go = item,
      lua_obj = lua_obj,
      card_list_idx = i,
      angle = angle
    }
    lua_obj:set_data(card_info)
    lua_obj:set_num(i)
    _tinsert(self.v_card_item_list, card_info)
  end
end

function ui:set_card_pos(card_obj, pos)
  local go = card_obj.go
  go.transform:SetLocalPositionA(pos.x, pos.y, 0)
  if (self.v_ring_state == CARD_DECK_STATE.SELECT or self.v_ring_state == CARD_DECK_STATE.CONTINUE_SELECTING) and self:is_busy_end() then
    MsgGame:mq_publish2(Const.MSG_ON_CR_VIEW_CAN_OPERATE)
  end
end

function ui:move_card_to_draw_area(list_idx_list, is_set)
  local length = #list_idx_list
  local draw_pos = {}
  if 1 == length then
    draw_pos[1] = Vec3.New(0, -self.v_r, 0)
  elseif 2 == length then
    draw_pos[1] = Vec3.New(325, -self.v_r, 0)
    draw_pos[2] = Vec3.New(0, -self.v_r, 0)
  else
    draw_pos[1] = Vec3.New(325, -self.v_r, 0)
    draw_pos[2] = Vec3.New(0, -self.v_r, 0)
    draw_pos[3] = Vec3.New(-325, -self.v_r, 0)
  end
  for _, idx in ipairs(list_idx_list) do
    local card_obj = self.v_card_item_list[idx]
    local pos = draw_pos[idx]
    self:_move_card_to_draw_area(card_obj, pos, is_set)
    self:set_go_front(card_obj)
  end
  if is_set then
    self:goback_card(is_set)
  end
end

function ui:_move_card_to_draw_area(card_obj, pos, is_set)
  if DEBUG then
    Log.Error("card_obj.go", card_obj.go)
    Log.Error("pos", pos)
  end
  if not is_set then
    self:move_to_local_pos(card_obj, pos)
  else
    self:set_card_pos(card_obj, pos)
  end
end

function ui:remove_card_item(list_idx, card_id)
  local card_obj = self.v_card_item_list[list_idx]
  local lua_obj = card_obj.lua_obj
  local go = card_obj.go
  local card_cfg = ShareRes.get_ring_card(card_id)
  local EmblemCnt = card_cfg.EmblemCnt
  lua_obj:card_remove()
  local card_pos = go.transform.position
  self:give_back_auto_cache(FLY_EMBLEM_KEY)
  local cur_emblem_num = ChallengeRingMgr:get_cur_show_emblem()
  local all_emblem_num = ChallengeRingMgr:get_all_emblem_num()
  self.v_delete_list_idx = list_idx
  self.v_delete_card_id = card_id
  if EmblemCnt > 0 and not ChallengeRingMgr:is_key_card_delete() then
    if cur_emblem_num < all_emblem_num then
      self:clear_ani_seq(self.v_emblem_fly_seq)
      self.v_emblem_fly_seq = {}
      if self.v_enter_timer then
        for _, timer_idx in pairs(self.v_enter_timer) do
          Timer:remove_timer(timer_idx)
        end
      end
      local emblem_list = UIMgr:get_ui("ui_challenge_ring"):get_emblem_list()
      local max_diff_num = all_emblem_num - cur_emblem_num
      local fly_num = _min(max_diff_num, EmblemCnt)
      self.v_emblem_fly_num = fly_num
      self.v_enter_timer_num = fly_num
      for i = 1, EmblemCnt do
        local emblem_idx = cur_emblem_num + i
        local emblem_obj = emblem_list[emblem_idx]
        if emblem_obj then
          local fly_emblem_go = self:get_auto_cache(FLY_EMBLEM_KEY)
          local fly_emblem_obj = FLY_EMBLEM_CLASS:ui_wrap_ex(self, fly_emblem_go, true)
          fly_emblem_obj.go = fly_emblem_go
          self:emblem_fly_to_key_obj(card_pos, fly_emblem_obj, emblem_obj)
        end
      end
    else
      self.v_emblem_fly_num = 1
      self.v_enter_timer_num = 1
      self:clear_ani_seq(self.v_emblem_fly_seq)
      self.v_emblem_fly_seq = {}
      if self.v_enter_timer then
        for _, timer_idx in pairs(self.v_enter_timer) do
          Timer:remove_timer(timer_idx)
        end
      end
      local fly_emblem_go = self:get_auto_cache(FLY_EMBLEM_KEY)
      local fly_emblem_obj = FLY_EMBLEM_CLASS:ui_wrap_ex(self, fly_emblem_go, true)
      fly_emblem_obj.go = fly_emblem_go
      local key_emblem_obj = UIMgr:get_ui("ui_challenge_ring"):get_emblem_fly_obj()
      self:emblem_fly_to_key_obj(card_pos, fly_emblem_obj, key_emblem_obj)
    end
  else
    self:check_need_create_card()
  end
end

function ui:refresh_card_pos()
  if self.v_card_num > 3 then
    local interval = 360 / self.v_card_num
    local angle = -interval
    local r = self.v_r
    self.v_card_pos = {}
    for i = 1, self.v_card_num do
      local now_angle = _floor(angle + (i - 1) * interval)
      now_angle = limit_range(now_angle)
      if DEBUG then
        Log.Error("now_angle", now_angle)
      end
      local x = _floor(r * -math.sin(math.rad(now_angle)))
      local y = _floor(r * -math.cos(math.rad(now_angle)))
      local pos_info = {
        x = x,
        y = y,
        angle = now_angle
      }
      _tinsert(self.v_card_pos, pos_info)
    end
  else
    self.v_card_pos = {}
    if 1 == self.v_card_num then
      local pos_info = {
        x = 0,
        y = -self.v_base_r,
        angle = 0
      }
      _tinsert(self.v_card_pos, pos_info)
    else
      for i = 1, self.v_card_num do
        local x = 0
        if 1 == i then
          x = 325
        elseif 3 == i then
          x = -325
        end
        local y = -self.v_base_r
        local pos_info = {
          x = x,
          y = y,
          angle = 0
        }
        _tinsert(self.v_card_pos, pos_info)
      end
    end
  end
end

function ui:set_ring_radius()
  local result_num = self.v_card_num - 4 > 0 and self.v_card_num or 0
  self.v_r = self.v_base_r + result_num * 20
  self:change_ring_pos_z()
end

function ui:change_ring_pos_z()
  local ring_obj = self.v_uiobjects.TestCardPoint
  local x = ring_obj.transform.localPosition.x
  local y = ring_obj.transform.localPosition.y
  local result_num = self.v_card_num - 4 > 0 and self.v_card_num or 0
  local z = 300 + result_num * 20
  ring_obj.transform:SetLocalPositionA(x, y, z)
end

function ui:set_go_front(card_obj)
  local go = card_obj.go
  go.transform:SetAsLastSibling()
end

function ui:card_move_end()
  self.v_card_move_num = self.v_card_move_num - 1
  if self.v_card_move_num > 0 then
    return
  end
  if self.v_ring_state == CARD_DECK_STATE.DELETE or self.v_ring_state == CARD_DECK_STATE.DELETING then
    self:change_state(CARD_DECK_STATE.IDLE)
  elseif self.v_ring_state == CARD_DECK_STATE.SELECT then
    self:goback_card()
    if self:is_busy_end() then
      MsgGame:mq_publish2(Const.MSG_ON_CR_VIEW_CAN_OPERATE)
    end
  end
end

function ui:goback_card(is_set)
  local random_card_list = ChallengeRingMgr:get_random_select_card()
  local dis = 300
  self:clear_ani_seq(self.v_goback_move_seq)
  self.v_goback_move_seq = {}
  for idx, data in pairs(self.v_card_item_list) do
    if not random_card_list[idx] then
      local go = data.go
      local localposition = go.transform.localPosition
      local x = localposition.x
      local y = localposition.y
      local z = localposition.z
      if is_set then
        go.transform:SetLocalPositionA(x, y + dis, z)
      else
        local seq = Util.create_sequence()
        seq:Append(go.transform:DOLocalMoveY(y + dis, 0.5))
        _tinsert(self.v_goback_move_seq, seq)
      end
    end
  end
end

function ui:rotate_ring_state()
  self:set_state(CARD_DECK_STATE.ROTATE)
  self:clear_ani_seq(self.v_rotate_seq)
  self.v_rotate_seq = {}
  local seq = Util.create_sequence()
  _tinsert(self.v_rotate_seq, seq)
  self:add_anim_counter()
  seq:Append(self.v_uiobjects.TestCardPoint.transform:DORotate(Vec3.New(90, 0, 360), 0.5, CS.DG.Tweening.RotateMode.FastBeyond360))
  seq:OnComplete(function()
    self:change_state(CARD_DECK_STATE.DRAW_CARD)
    self:reduce_anim_counter()
  end)
end

function ui:card_positive_rotate_round(card_obj)
  local go = card_obj.go
  go.transform:SetEulerY(0)
  local lua_obj = card_obj.lua_obj
  local seq = Util.create_sequence()
  _tinsert(self.v_positive_rotate_seq, seq)
  self:add_anim_counter()
  seq:Append(go.transform:DORotate(Vec3.New(0, 90, 0), 0.1, CS.DG.Tweening.RotateMode.WorldAxisAdd))
  seq:AppendCallback(function()
    lua_obj:set_face_enable()
  end)
  seq:Append(go.transform:DORotate(Vec3.New(0, 90, 0), 0.1, CS.DG.Tweening.RotateMode.WorldAxisAdd))
  seq:OnComplete(function()
    go.transform:SetEulerY(180)
    self:reduce_positive_rotate_num()
    self:reduce_anim_counter()
  end)
end

function ui:card_negative_rotate_round(card_obj)
  local go = card_obj.go
  go.transform:SetEulerY(180)
  local lua_obj = card_obj.lua_obj
  local seq = Util.create_sequence()
  self:add_anim_counter()
  _tinsert(self.v_negative_rotate_seq, seq)
  seq:Append(go.transform:DORotate(Vec3.New(0, 90, 0), 0.1, CS.DG.Tweening.RotateMode.WorldAxisAdd))
  seq:AppendCallback(function()
    lua_obj:set_back_enable()
  end)
  seq:Append(go.transform:DORotate(Vec3.New(0, 90, 0), 0.1, CS.DG.Tweening.RotateMode.WorldAxisAdd))
  seq:OnComplete(function()
    go.transform:SetEulerY(0)
    self:reduce_negtive_rotate_num()
    self:reduce_anim_counter()
  end)
end

function ui:reduce_negtive_rotate_num()
  self.v_negative_num = self.v_negative_num - 1
  if 0 == self.v_negative_num then
    self:negative_rotate_end()
  end
end

function ui:negative_rotate_end()
  if self.v_ring_state == CARD_DECK_STATE.SELECTTING then
    if DEBUG then
      Log.Error("选择完牌，发送消息")
    end
    if self:is_busy_end() then
      MsgGame:mq_publish2(Const.MSG_ON_CR_VIEW_CAN_OPERATE)
    end
    MsgGame:mq_publish2(Const.MSG_ON_CR_SELECT_CARD_ANI_END)
  elseif self.v_ring_state == CARD_DECK_STATE.SELECT then
    self:set_state(CARD_DECK_STATE.IDLE)
    self:change_state(CARD_DECK_STATE.ROTATE)
  elseif self.v_ring_state == CARD_DECK_STATE.CREATE_DOOR_CARD or self.v_ring_state == CARD_DECK_STATE.CREATE_KEY_CARD then
    self:set_state(CARD_DECK_STATE.DELETE)
    self:change_state(CARD_DECK_STATE.IDLE)
  end
end

function ui:reduce_positive_rotate_num()
  self.v_positive_num = self.v_positive_num - 1
  if 0 == self.v_positive_num then
    self:positive_rotate_end()
  end
end

function ui:positive_rotate_end()
  if DEBUG then
    Log.Error("牌翻成正面完毕")
  end
  ChallengeRingMgr:draw_card_end()
  self:change_state(CARD_DECK_STATE.SELECT)
  MsgGame:mq_publish2(Const.MSG_ON_CR_DRAW_CARD)
end

function ui:card_shrink_and_disable(card_obj, list_idx, card_id)
  self:clear_ani_seq(self.v_card_shrink_seq)
  self.v_card_shrink_seq = {}
  local go = card_obj.go
  local lua_obj = card_obj.lua_obj
  local seq = Util.create_sequence()
  _tinsert(self.v_card_shrink_seq, seq)
  self:add_anim_counter()
  
  local function cb()
    self:remove_card_item(list_idx, card_id)
    self:reduce_anim_counter()
  end
  
  lua_obj:play_shrink_effect()
  seq:Append(go.transform:DOScale(Vec3.New(0.5, 0.5, 0.5), 0.7))
  seq:OnComplete(cb)
end

function ui:card_fly_to_bag(card_obj, bag_obj, card_select_idx)
  local go = card_obj
  self:clear_ani_seq(self.v_card_fly_bag_seq)
  self.v_card_fly_bag_seq = {}
  local seq = Util.create_sequence()
  _tinsert(self.v_card_fly_bag_seq, seq)
  self:add_anim_counter()
  local uicamera = Util.get_component(nil, UIMgr.root_camera_obj, UnityCamera)
  local world_camera = UIMgr:get_world_camera()
  local first_pos = uicamera:WorldToScreenPoint(bag_obj.position)
  local world_pos = world_camera:ScreenToWorldPoint(first_pos)
  seq:Append(go.transform:DOMove(world_pos, 1))
  seq:OnComplete(function()
    UIMgr:get_ui("ui_challenge_ring"):play_enter_bag_effect(card_select_idx)
    go.transform:SetActive(false)
    self:reduce_anim_counter()
  end)
end

function ui:emblem_fly_to_key_obj(card_pos, fly_emblem, emblem_obj)
  local emblem_go = emblem_obj.go
  local fly_emblem_go = fly_emblem.go
  local fly_emblem_tran = fly_emblem_go.transform
  fly_emblem_tran:SetPositionA(card_pos.x, card_pos.y, card_pos.z)
  fly_emblem:play_fly_effect()
  local seq = Util.create_sequence()
  _tinsert(self.v_emblem_fly_seq, seq)
  self:add_anim_counter()
  local busy_idx = self:get_busy_timer_idx()
  local uicamera = Util.get_component(nil, UIMgr.root_camera_obj, UnityCamera)
  local world_camera = UIMgr:get_world_camera()
  local first_pos = uicamera:WorldToScreenPoint(emblem_go.transform.position)
  local world_pos = world_camera:ScreenToWorldPoint(first_pos)
  seq:Append(fly_emblem_tran:DOMove(world_pos, 0.5))
  seq:OnComplete(function()
    emblem_obj:play_enter_effect()
    local length = emblem_obj:get_enter_effect_time()
    local timer_idx = Timer:add_timer("emblem_enter", length, function()
      self:remove_enter_effect_timer(busy_idx)
      MsgGame:mq_publish2(Const.MSG_ON_CR_REFRESH_EMBLEM_NUM)
    end)
    self.v_busy_timer[timer_idx] = true
    self.v_enter_timer[busy_idx] = timer_idx
    self:reduce_emblem_fly_num()
    self:reduce_anim_counter()
  end)
end

function ui:emblem_fly_to_create_card(pos, fly_emblem_obj, target_obj)
  local Emblum_obj = fly_emblem_obj.go
  fly_emblem_obj:play_fly_effect()
  local uicamera = Util.get_component(nil, UIMgr.root_camera_obj, UnityCamera)
  local world_camera = UIMgr:get_world_camera()
  local first_pos = uicamera:WorldToScreenPoint(pos)
  local world_pos = world_camera:ScreenToWorldPoint(first_pos)
  Emblum_obj.transform.position = world_pos
  local seq = Util.create_sequence()
  _tinsert(self.v_emblem_fly_seq, seq)
  self:add_anim_counter()
  seq:Append(Emblum_obj.transform:DOMove(target_obj.transform.position, 0.5))
  seq:OnComplete(function()
    self:reduce_emblem_fly_num()
    self:reduce_anim_counter()
  end)
end

function ui:draw_card_state()
  self:set_state(CARD_DECK_STATE.DRAW_CARD)
  self:clear_ani_seq(self.v_positive_rotate_seq)
  self.v_positive_rotate_seq = {}
  self.v_positive_num = 0
  self.v_draw_card_list = {}
  local random_list = ChallengeRingMgr:get_random_select_card()
  for list_idx, card_uuid in ipairs(random_list) do
    local card_data = ChallengeRingMgr:get_card_by_uuid(card_uuid)
    local card_id = card_data.id
    local item_obj = self.v_card_item_list[list_idx]
    local lua_obj = item_obj.lua_obj
    self:refresh_card_data(lua_obj, card_id, card_uuid)
    _tinsert(self.v_draw_card_list, list_idx)
    self:card_positive_rotate_round(item_obj)
    self.v_positive_num = self.v_positive_num + 1
  end
end

function ui:continue_select_logic_check()
  local is_have_draw_card = ChallengeRingMgr:is_draw_card_end()
  if DEBUG then
    Log.Error("is_get_random_list", is_have_draw_card)
  end
  if is_have_draw_card then
    self:continue_select_card_state()
  end
end

function ui:continue_select_card_state()
  self:set_state(CARD_DECK_STATE.SELECT)
  self.v_draw_card_list = {}
  local random_list = ChallengeRingMgr:get_random_select_card()
  for list_idx, card_uuid in pairs(random_list) do
    local card_data = ChallengeRingMgr:get_card_by_uuid(card_uuid)
    local card_id = card_data.id
    local item_obj = self.v_card_item_list[list_idx]
    local lua_obj = item_obj.lua_obj
    local go = item_obj.go
    self:refresh_card_data(lua_obj, card_id, card_uuid)
    lua_obj:set_face_enable()
    lua_obj:set_is_can_select(true)
    go.transform:SetEulerY(180)
    _tinsert(self.v_draw_card_list, list_idx)
  end
  self:move_card_to_draw_area(self.v_draw_card_list, true)
end

function ui:select_card_state()
  self:set_state(CARD_DECK_STATE.SELECT)
  self:clear_ani_seq(self.v_local_pos_move_seq)
  self.v_local_pos_move_seq = {}
  self.v_card_move_num = 0
  for _, list_idx in ipairs(self.v_draw_card_list) do
    local item_obj = self.v_card_item_list[list_idx]
    local lua_obj = item_obj.lua_obj
    lua_obj:set_is_can_select(true)
  end
  self:move_card_to_draw_area(self.v_draw_card_list)
end

function ui:refresh_card_data(lua_obj, card_id, card_uuid)
  lua_obj:refresh_data(card_id, card_uuid)
end

function ui:selecting_card_state()
  if DEBUG then
    Log.Error("执行选牌中逻辑")
  end
  self:set_state(CARD_DECK_STATE.SELECTTING)
  self:clear_ani_seq(self.v_negative_rotate_seq)
  self.v_negative_rotate_seq = {}
  self.v_negative_num = 0
  local select_card_info = ChallengeRingMgr:get_select_card_info()
  local select_idx = select_card_info.card_list_idx
  for _, list_idx in ipairs(self.v_draw_card_list) do
    local item_obj = self.v_card_item_list[list_idx]
    if select_idx ~= list_idx then
      self.v_negative_num = self.v_negative_num + 1
      self:reverse_card(item_obj)
    end
  end
  if 0 == self.v_negative_num then
    self:negative_rotate_end()
  end
end

function ui:continue_selecting_card_state()
  if DEBUG then
    Log.Error("执行中继选牌中逻辑")
  end
  self:set_state(CARD_DECK_STATE.CONTINUE_SELECTING)
  self.v_select_card_data = ChallengeRingMgr:get_selecting_card()
  local select_random_list = ChallengeRingMgr:get_random_select_card()
  local draw_area_list = {}
  for idx, card_uuid in ipairs(select_random_list) do
    local item_obj = self.v_card_item_list[idx]
    local lua_obj = item_obj.lua_obj
    local card_data = ChallengeRingMgr:get_card_by_uuid(card_uuid)
    local status = card_data.status
    local card_id = card_data.id
    if status == CARD_STATUS.ON_CHOOSE then
      self.v_continue_select_id = idx
      self:refresh_card_data(lua_obj, card_id, card_uuid)
      lua_obj:set_face_enable()
      lua_obj:set_card_angle(180)
    else
      lua_obj:set_back_enable()
      lua_obj:set_card_angle(0)
    end
    _tinsert(draw_area_list, idx)
  end
  self:move_card_to_draw_area(draw_area_list, true)
end

function ui:delete_card_state()
  self:set_state(CARD_DECK_STATE.DELETE)
  local select_card_info = ChallengeRingMgr:get_select_card_info()
  local select_idx = select_card_info.card_list_idx
  for _, list_idx in pairs(self.v_draw_card_list) do
    local item_obj = self.v_card_item_list[list_idx]
    if select_idx == list_idx then
      local lua_obj = item_obj.lua_obj
      local card_cfg = lua_obj:get_card_cfg()
      local card_id = card_cfg.Id
      self:remove_card(item_obj, list_idx, card_id)
    end
  end
end

function ui:continue_delete_state()
  self:set_state(CARD_DECK_STATE.DELETE)
  local card_data = self.v_select_card_data
  local card_id = card_data.id
  local item_obj = self.v_card_item_list[self.v_continue_select_id]
  self:remove_card(item_obj, self.v_continue_select_id, card_id)
end

function ui:create_card_state()
  self:clear_ani_seq(self.v_negative_rotate_seq)
  self.v_negative_rotate_seq = {}
  self.v_negative_num = 0
  local create_list_idx = self.v_delete_list_idx
  local item_obj = self.v_card_item_list[create_list_idx]
  self.v_negative_num = self.v_negative_num + 1
  self:reverse_card(item_obj)
end

function ui:reverse_card(card_obj)
  self:card_negative_rotate_round(card_obj)
end

function ui:remove_card(card_obj, list_idx, card_id)
  self.v_delete_list_idx = list_idx
  local lua_obj
  if card_obj then
    lua_obj = card_obj.lua_obj
  end
  local card_show_type = ShareRes.get_ring_card_show_type(card_id)
  if card_show_type == RING_CARD_TYPE.DOOR then
    if lua_obj then
      lua_obj:set_back_enable()
    end
    self:change_state(CARD_DECK_STATE.IDLE)
    return
  end
  if card_show_type == RING_CARD_TYPE.HEAL then
    if lua_obj then
      lua_obj:play_heal_effect(function()
        self:remove_card_item(list_idx, card_id)
      end)
    end
    return
  else
    self:card_shrink_and_disable(card_obj, list_idx, card_id)
  end
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

function ui:create_key_card(list_idx)
  local card_obj = self.v_card_item_list[list_idx]
  local lua_obj = card_obj.lua_obj
  local card_data = ChallengeRingMgr:get_key_card_data()
  local card_id = card_data.id
  local card_uuid = card_data.uuid
  self:refresh_card_data(lua_obj, card_id, card_uuid)
  lua_obj:set_face_enable()
  lua_obj:play_create_card_effect()
  if self.v_key_card_timer then
    Timer:remove_timer(self.v_key_card_timer)
  end
  self.v_key_card_timer = Timer:add_timer("create_card", 1, function()
    self.v_busy_timer[self.v_key_card_timer] = nil
    self.v_key_card_timer = nil
    self:check_remove_all_event()
    self:change_state(CARD_DECK_STATE.IDLE)
  end)
  self.v_busy_timer[self.v_key_card_timer] = true
end

function ui:create_door_card(list_idx)
  self:set_state(CARD_DECK_STATE.CREATE_DOOR_CARD)
  local card_obj = self.v_card_item_list[list_idx]
  local lua_obj = card_obj.lua_obj
  local card_data = ChallengeRingMgr:get_door_card_data()
  local card_uuid = card_data.uuid
  local card_id = card_data.id
  self:refresh_card_data(lua_obj, card_id, card_uuid)
  lua_obj:set_face_enable()
  lua_obj:play_create_card_effect()
  if self.v_door_card_timer then
    Timer:remove_timer(self.v_door_card_timer)
  end
  self.v_door_card_timer = Timer:add_timer("create_card", 1, function()
    self.v_busy_timer[self.v_door_card_timer] = nil
    self.v_door_card_timer = nil
    self:check_remove_all_event()
    self:change_state(CARD_DECK_STATE.IDLE)
    MsgGame:mq_publish2(Const.MSG_ON_CREATE_DOOR_CARD)
  end)
  self.v_busy_timer[self.v_door_card_timer] = true
end

function ui:response_draw_card_end()
  if not self.v_ring_state then
    return
  end
  if DEBUG then
    Log.Error("收到抽牌完成信息", self.v_ring_state)
  end
  if self.v_ring_state == CARD_DECK_STATE.SELECTTING or self.v_ring_state == CARD_DECK_STATE.CONTINUE_SELECTING then
    self:change_state(CARD_DECK_STATE.DELETE)
  end
  if self.v_ring_state == CARD_DECK_STATE.IDLE then
    self:change_state(CARD_DECK_STATE.ROTATE)
  end
end

function ui:response_select_card_end()
  local select_card_info = ChallengeRingMgr:get_select_card_info()
  local card_list_idx = select_card_info.card_list_idx
  local card_obj = self.v_card_item_list[card_list_idx].lua_obj
  
  local function cb()
    self:change_state(CARD_DECK_STATE.SELECTTING)
  end
  
  card_obj:enlarge_card(cb)
end

function ui:response_selecting_card()
  self:set_card_select_disable()
end

function ui:set_key_obj_ui(go)
  self.v_key_obj = go
end

function ui:add_anim_counter()
  self.v_anim_counter = self.v_anim_counter + 1
  local msg = MsgGame:mq_publish2(Const.MSG_ON_CR_ANI_BEGIN)
  msg.mm_x = CR_RING_CFG_PATH.AniType.CardDeck
end

function ui:reduce_anim_counter()
  self.v_anim_counter = self.v_anim_counter - 1
  self:check_remove_all_event()
end

function ui:check_remove_all_event()
  if self:is_busy_end() then
    local msg = MsgGame:mq_publish2(Const.MSG_ON_CR_ANI_END)
    msg.mm_x = CR_RING_CFG_PATH.AniType.CardDeck
  end
end

function ui:is_busy_end()
  return 0 == self.v_anim_counter and self.v_busy_timer and next(self.v_busy_timer) == nil
end

function ui:change_card_layer()
  local length = #self.v_card_item_list
  if length < 3 then
    for i = 1, length do
      local item_obj = self.v_card_item_list[i]
      self:set_go_front(item_obj)
    end
    return
  end
  local back_list_idx = _floor(length * 3 / 4)
  if DEBUG then
    Log.Error("back_list_idx", back_list_idx)
  end
  local left_idx = back_list_idx
  local right_idx = back_list_idx + 1
  for i = right_idx, length do
    local item_obj = self.v_card_item_list[i]
    self:set_go_front(item_obj)
  end
  for i = left_idx, 1, -1 do
    local item_obj = self.v_card_item_list[i]
    self:set_go_front(item_obj)
  end
end

function ui:reduce_emblem_fly_num()
  self.v_emblem_fly_num = self.v_emblem_fly_num - 1
  if 0 == self.v_emblem_fly_num then
    self:emblem_fly_end()
  end
end

function ui:emblem_fly_end()
  if self.v_ring_state == CARD_DECK_STATE.DELETE then
    self:check_need_create_card()
    return
  end
  if self.v_ring_state == CARD_DECK_STATE.CREATE_KEY_CARD then
    self:create_key_card(self.v_create_card_idx)
    return
  end
end

function ui:check_need_create_card()
  local list_idx = self.v_delete_list_idx
  local card_id = self.v_delete_card_id
  local card_cfg = ShareRes.get_ring_card(card_id)
  local item_obj = self.v_card_item_list[list_idx]
  local is_key_card = card_cfg.KeyThreshold
  local now_emblum = ChallengeRingMgr:get_cur_emblem()
  local all_emblum = ChallengeRingMgr:get_all_emblem_num()
  if now_emblum >= all_emblum and not self.v_is_create_key_card then
    self:set_state(CARD_DECK_STATE.CREATE_KEY_CARD)
    local go = item_obj.go
    local emblem_list = UIMgr:get_ui("ui_challenge_ring"):get_emblem_list()
    self:clear_ani_seq(self.v_emblem_fly_seq)
    self.v_emblem_fly_seq = {}
    self.v_create_card_idx = list_idx
    self.v_emblem_fly_num = #emblem_list
    for _, data in pairs(emblem_list) do
      local fly_emblem_go = self:get_auto_cache(FLY_EMBLEM_KEY)
      local fly_emblem_obj = FLY_EMBLEM_CLASS:ui_wrap_ex(self, fly_emblem_go, true)
      fly_emblem_obj.go = fly_emblem_go
      local emblem_go = data.go
      local pos = emblem_go.transform.position
      self:emblem_fly_to_create_card(pos, fly_emblem_obj, go)
    end
    self.v_is_create_key_card = true
    return
  end
  local card_data = ChallengeRingMgr:get_cache_select_card_data()
  if not card_data then
    Log.Error("card_data is nil")
    return
  end
  local replica = card_data.replica
  if is_key_card and not replica then
    self:create_door_card(list_idx)
    return
  end
  _tremove(self.v_card_item_list, list_idx)
  self:change_state(CARD_DECK_STATE.IDLE)
end

function ui:remove_enter_effect_timer(busy_idx)
  local timer_idx = self.v_enter_timer[busy_idx]
  self.v_busy_timer[timer_idx] = nil
  self.v_enter_timer[busy_idx] = nil
  self.v_enter_timer_num = self.v_enter_timer_num - 1
  if 0 == self.v_enter_timer_num then
    self:remove_enter_timer_end()
  end
end

function ui:get_busy_timer_idx()
  self.v_timer_busy_idx = self.v_timer_busy_idx % 1000 + 1
  return self.v_timer_busy_idx
end

function ui:remove_enter_timer_end()
  ChallengeRingMgr:refresh_show_emblem()
  MsgGame:mq_publish2(Const.MSG_ON_CR_REFRESH_EMBLEM_NUM)
end

function ui:is_ring_can_operate()
  if not self.v_ring_state then
    return
  end
  return CAN_OPERATE_STATE[self.v_ring_state]
end

function ui:response_team_attr_change()
  for _, data in ipairs(self.v_card_item_list) do
    local lua_obj = data.lua_obj
    lua_obj:refresh_lock()
  end
end

function ui:response_card_random_refresh()
  if self.v_ring_state == CARD_DECK_STATE.SELECT then
    self:change_state(CARD_DECK_STATE.IDLE)
  elseif self.v_ring_state == CARD_DECK_STATE.IDLE then
    self:change_state(CARD_DECK_STATE.ROTATE)
  end
end

function ui:reset_select_card_state()
  self:clear_ani_seq(self.v_negative_rotate_seq)
  self.v_negative_rotate_seq = {}
  self.v_negative_num = 0
  for _, list_idx in pairs(self.v_draw_card_list) do
    local item_obj = self.v_card_item_list[list_idx]
    self.v_negative_num = self.v_negative_num + 1
    self:reverse_card(item_obj)
  end
  if 0 == self.v_negative_num then
    self:negative_rotate_end()
  end
end

function ui:response_card_refresh()
  if self.v_ring_state == CARD_DECK_STATE.SELECT then
    self:change_state(CARD_DECK_STATE.INIT)
  end
end

function ui:reset_card_deck_state()
  self.v_is_create_key_card = ChallengeRingMgr:is_show_key_card()
  self.v_card_num = ChallengeRingMgr:get_remain_card_num()
  self:set_ring_radius()
  self:refresh_card_pos()
  self:create_card_item_list()
  self:change_card_layer()
  self.v_draw_card_list = {}
  local random_list = ChallengeRingMgr:get_random_select_card()
  for list_idx, card_uuid in pairs(random_list) do
    local card_data = ChallengeRingMgr:get_card_by_uuid(card_uuid)
    local card_id = card_data.id
    local item_obj = self.v_card_item_list[list_idx]
    local lua_obj = item_obj.lua_obj
    local go = item_obj.go
    self:refresh_card_data(lua_obj, card_id, card_uuid)
    lua_obj:set_face_enable()
    go.transform:SetEulerY(180)
    lua_obj:set_is_can_select(true)
    _tinsert(self.v_draw_card_list, list_idx)
  end
  self:move_card_to_draw_area(self.v_draw_card_list, true)
  self:positive_rotate_end()
end

return ui
