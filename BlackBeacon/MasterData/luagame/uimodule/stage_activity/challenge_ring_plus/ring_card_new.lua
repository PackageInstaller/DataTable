local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local CHAL_RING_CARD = "CHAL_RING_CARD"
local CARD_OBJ = require("uimodule.stage_activity.challenge_ring_plus.card_obj")
local _floor = math.floor
local _insert = table.insert
local _mabs = math.abs
local _mceil = math.ceil
local dump = require("utils.dumper")
local PathDefine = require("utils.path_define")
local Vec3 = require("base.vec3")
local LEFT_CARD_POS_INDEX = 1
local RIGHT_CARD_POS_INDEX = 2

function ui:ui_finish_load()
  self.v_wait_remove_anima_card = {}
  self.v_right_node_pos = self.v_uiobjects.RightNode.transform.localPosition
  self.v_left_node_pos = self.v_uiobjects.LeftNode.transform.localPosition
  self.v_centre_node_pos = self.v_uiobjects.CentreNode.transform.localPosition
  self:register_exist_auto_template(CHAL_RING_CARD, self.v_uiobjects.ChalRingCard, self.v_uiobjects.CardContent)
end

function ui:init_card_pos(now_card_num)
  if 1 == now_card_num then
    return {
      [1] = {
        x = 0,
        y = -1500,
        z = 0
      }
    }
  end
  local init_pos_list = {}
  local result_pos_list = {}
  local max_z_num = 1200
  local x_width = 1800
  local y_height = 1200
  local max_card_num = 20
  local cal_card_num = now_card_num - 2
  local x_start_width = x_width / 4
  local diff_x_width = x_width - x_start_width
  local interval_x_width = diff_x_width / max_card_num
  local now_x_width = x_start_width + cal_card_num * interval_x_width
  local is_have_middile_card = 0 ~= cal_card_num % 2
  local start_angle = 90
  local change_time = 1
  local interval_angle = _floor(320 / cal_card_num)
  if now_card_num <= 10 then
    interval_angle = 60 - cal_card_num * 3
  end
  local sign_num = 1
  init_pos_list[now_card_num - 1] = {
    x = -200,
    y = -1500,
    z = 0
  }
  init_pos_list[now_card_num] = {
    x = 200,
    y = -1500,
    z = 0
  }
  if is_have_middile_card then
    local rad_val = math.rad(start_angle)
    local cosx = math.cos(rad_val)
    local siny = math.sin(rad_val)
    local x = now_x_width * cosx
    local y = y_height * siny
    local z = -max_z_num * (y + y_height) / (y_height * 2)
    init_pos_list[1] = {
      x = x,
      y = y,
      z = z
    }
    for i = 1, cal_card_num - 1 do
      local angle = start_angle + change_time * interval_angle * sign_num
      rad_val = math.rad(angle)
      cosx = math.cos(rad_val)
      siny = math.sin(rad_val)
      x = now_x_width * cosx
      y = y_height * siny
      z = -max_z_num * (y + y_height) / (y_height * 2)
      init_pos_list[1 + i] = {
        x = x,
        y = y,
        z = z
      }
      sign_num = -sign_num
      if 0 == i % 2 then
        change_time = change_time + 1
      end
    end
  else
    change_time = 0
    for i = 1, cal_card_num do
      local angle
      if now_card_num <= 10 then
        angle = start_angle + sign_num * (40 - cal_card_num * 3) + change_time * interval_angle * sign_num
      else
        angle = start_angle + sign_num * 10 + change_time * interval_angle * sign_num
      end
      local rad_val = math.rad(angle)
      local cosx = math.cos(rad_val)
      local siny = math.sin(rad_val)
      local x = now_x_width * cosx
      local y = y_height * siny
      local z = -max_z_num * (y + y_height) / (y_height * 2)
      init_pos_list[i] = {
        x = x,
        y = y,
        z = z
      }
      sign_num = -sign_num
      if 0 == i % 2 then
        change_time = change_time + 1
      end
    end
  end
  if 0 == now_card_num % 2 then
    local left_idx = now_card_num / 2
    local right_idx = left_idx + 1
    local idx = 1
    for i = left_idx, 1, -1 do
      result_pos_list[i] = init_pos_list[idx]
      idx = idx + 2
    end
    idx = 2
    for i = right_idx, now_card_num do
      result_pos_list[i] = init_pos_list[idx]
      idx = idx + 2
    end
  else
    local root_idx = _floor(now_card_num / 2) + 1
    result_pos_list[root_idx] = init_pos_list[1]
    local idx_time = 1
    local sign = -1
    for i = 2, now_card_num do
      local now_idx = idx_time * sign
      result_pos_list[root_idx + now_idx] = init_pos_list[i]
      if 0 ~= i % 2 then
        idx_time = idx_time + 1
      end
      sign = -sign
    end
  end
  return result_pos_list
end

function ui:init_event()
  self:bind_auto_mq(Const.MSG_ON_SKIP_CARD_SUC, self.skip_card_suc, self)
  self:bind_auto_mq(Const.MSG_ON_SKIP_CARD_FAIL, self.skip_card_fail, self)
  self:bind_auto_mq(Const.MSG_ON_SELECT_CARD_END, self.response_select_card, self)
end

function ui:ui_on_show()
  self.v_pos_2_card_list = {}
  self.v_card_obj_list = {}
  self.v_move_dotween_seq = {}
  self.v_pos_list = {}
  self:init_anim_state()
  self:init_event()
  self:init_card()
  local is_in_battle = ChallengeRingPlusMgr:is_in_curse_fighting()
  if not is_in_battle then
    self:set_curse_activate_view()
  end
  ChallengeRingPlusMgr:wait_skip_end()
  self.v_ring_plus_ui = UIMgr:try_get_ui("challenge_ring_plus")
end

function ui:init_anim_state()
  self.v_is_moving = false
  self:set_is_play_anim(false)
end

function ui:clear_anim_seq()
  for _, seq in pairs(self.v_move_dotween_seq) do
    seq:Kill()
  end
  self.v_move_dotween_seq = nil
end

function ui:init_card()
  self.v_card_index_list = ChallengeRingPlusMgr:get_show_card_index_list()
  local card_count = #self.v_card_index_list
  self.v_left_pos_index = 1
  self.v_right_pos_index = card_count
  self.v_left_card_index = self.v_card_index_list[1]
  self.v_right_card_index = self.v_card_index_list[card_count]
  self.v_now_card_num = math.min(card_count, 2)
  if Global.is_show_ring_skip_btn == nil then
    if card_count > 1 then
      self:create_card_obj(self.v_left_pos_index, self.v_left_card_index, true, self.v_left_node_pos)
      self:create_card_obj(self.v_right_pos_index, self.v_right_card_index, true, self.v_right_node_pos)
    elseif 1 == card_count then
      self:create_card_obj(self.v_left_pos_index, self.v_left_card_index, true, self.v_centre_node_pos)
    end
  else
    self.v_pos_list = ShareRes.create("ring_plus_pos.ring_pos", card_count)
    if not self.v_pos_list then
      if self.v_now_card_num and self.v_now_card_num > 0 then
        local len = UtilTable.hash_lenth(ShareRes.create("ring_plus_pos.ring_pos"))
        Log.Error("卡牌数量超过ring_pos配置数量, 卡牌数量", self.v_now_card_num, "ring_pos配置数量：", len)
      end
      return
    end
    for pos_index, card_index in pairs(self.v_card_index_list) do
      self:create_card_obj(pos_index, card_index, true, self.v_pos_list[pos_index])
    end
  end
end

function ui:create_card_obj(pos_index, card_index, is_can_click, pos)
  local card_obj = self.v_card_obj_list[card_index]
  if not card_obj then
    local item = self:get_auto_cache(CHAL_RING_CARD)
    card_obj = CARD_OBJ:ui_wrap_ex(self, item, true)
    self.v_card_obj_list[card_index] = card_obj
  end
  if not self.v_pos_2_card_list[pos_index] then
    local trans = card_obj:get_object_transform()
    self.v_pos_2_card_list[pos_index] = {
      go = trans.gameObject,
      trans = trans,
      card_obj = card_obj
    }
  end
  local data = {card_index = card_index, is_can_click = is_can_click}
  card_obj:set_enable(true)
  card_obj:set_data(data)
  card_obj:change_click_state(data.is_can_click)
  local trans = self.v_pos_2_card_list[pos_index].trans
  trans:SetLocalPositionA(pos.x, pos.y, pos.z)
end

function ui:do_remove_card(remove_pos)
  local CURSE_CARD_TYPE = Config.CommonDefine.CURSE_CARD_TYPE
  local card_obj = self.v_pos_2_card_list[remove_pos] and self.v_pos_2_card_list[remove_pos].card_obj
  if not card_obj then
    return
  end
  self.v_wait_remove_anima_card[remove_pos] = true
  local romve_card_cfg = card_obj:get_card_cfg()
  if romve_card_cfg.Type == CURSE_CARD_TYPE.BOSS then
    self:play_unlock_door_anima(remove_pos)
  else
    self:remove_card_anim(remove_pos)
  end
end

function ui:check_have_remove_card()
  local remove_data = ChallengeRingPlusMgr:get_remove_card_data()
  if remove_data then
    local remove_pos = remove_data.remove_pos
    self:do_remove_card(remove_pos)
    local add_remove_pos = remove_data.additional_remove_pos
    if add_remove_pos then
      self:do_remove_card(add_remove_pos)
    end
  end
end

function ui:set_curse_activate_view()
  local debuff_list = ChallengeRingPlusMgr:get_debuff()
  local debuff_list_old = ChallengeRingPlusMgr:get_debuff_old()
  local challenge_ring_plus = UIMgr:get_ui("challenge_ring_plus")
  
  local function cb()
    self:check_have_remove_card()
  end
  
  local count = #debuff_list
  if count <= 4 and count > #debuff_list_old and challenge_ring_plus:visible() then
    local curse_activate = UIMgr:get_ui("curse_activate")
    curse_activate:ui_show()
    curse_activate:set_hide_cb(cb)
  else
    cb()
  end
end

function ui:ui_on_hide()
  self:remove_wrap_list()
  self.v_pos_list = nil
  self:clear_anim_seq()
end

function ui:ui_on_destroy()
end

function ui:remove_card(remove_index)
  if Global.is_show_ring_skip_btn then
    self:remove_move_end()
    self:init_card()
    return
  end
  if not self.v_pos_2_card_list[remove_index] then
    return
  end
  self.v_is_moving = true
  self.v_wait_remove_anima_card[remove_index] = nil
  self:remove_card_obj(remove_index)
  self.v_now_card_num = self.v_now_card_num - 1
  if UtilTable.is_empty(self.v_wait_remove_anima_card) then
    if self.v_now_card_num <= 0 or ChallengeRingPlusMgr:get_show_card_index_list_num() > 1 then
      self:remove_move_end()
      self:init_card()
    else
      for _, data in pairs(self.v_pos_2_card_list) do
        local trans = data.trans
        local pos = self.v_centre_node_pos
        local seq = Util.create_sequence()
        local target_pos = Vec3.New(pos.x, pos.y, pos.z)
        seq:Append(trans:DOLocalMove(target_pos, 0.5))
        seq:OnComplete(function()
          self:remove_move_end()
        end)
        _insert(self.v_move_dotween_seq, seq)
      end
    end
  end
end

function ui:remove_left_card()
  local remove_index = self.v_left_pos_index
  self:remove_card(remove_index)
end

function ui:remove_right_card()
  local remove_index = self.v_right_pos_index
  self:remove_card(remove_index)
end

function ui:step_to_left_card()
  self.v_is_moving = true
  self.v_step_card_num = 0
  self.v_change_card_idx = {}
  local step_card_num = #self.v_pos_2_card_list
  self.v_step_card_num = step_card_num
  for i = 1, #self.v_pos_2_card_list do
    local item = self.v_pos_2_card_list[i]
    local trans = item.trans
    local pre_idx = i - 1
    if 0 == pre_idx then
      pre_idx = self.v_now_card_num
    end
    local pos = self.v_pos_list[pre_idx]
    self.v_change_card_idx[pre_idx] = item
    local seq = Util.create_sequence()
    local target_pos = Vec3.New(pos.x, pos.y, pos.z)
    seq:Append(trans:DOLocalMove(target_pos, 0.5))
    seq:OnComplete(function()
      self:step_move_end()
    end)
    _insert(self.v_move_dotween_seq, seq)
  end
end

function ui:step_to_right_card()
  self.v_is_moving = true
  self.v_step_card_num = 0
  self.v_change_card_idx = {}
  local step_card_num = #self.v_pos_2_card_list
  self.v_step_card_num = step_card_num
  for i = 1, #self.v_pos_2_card_list do
    local item = self.v_pos_2_card_list[i]
    local trans = item.trans
    local next_idx = i % self.v_now_card_num + 1
    local pos = self.v_pos_list[next_idx]
    self.v_change_card_idx[next_idx] = item
    local seq = Util.create_sequence()
    local target_pos = Vec3.New(pos.x, pos.y, pos.z)
    seq:Append(trans:DOLocalMove(target_pos, 0.5))
    seq:OnComplete(function()
      self:step_move_end()
    end)
    _insert(self.v_move_dotween_seq, seq)
  end
end

function ui:remove_move_end()
  for idx, item in pairs(self.v_pos_2_card_list) do
    local card_obj = item.card_obj
    card_obj:change_click_state(idx == self.v_left_pos_index or idx == self.v_right_pos_index)
  end
  ChallengeRingPlusMgr:update_remove_card()
  self.v_is_moving = false
end

function ui:step_move_end()
  self.v_step_card_num = self.v_step_card_num - 1
  if self.v_step_card_num > 0 then
    return
  end
  for idx, item in pairs(self.v_change_card_idx) do
    self.v_pos_2_card_list[idx] = item
    local card_obj = item.card_obj
    card_obj:change_click_state(1 == idx or idx == self.v_now_card_num)
  end
  self.v_is_moving = false
end

function ui:sort_gameobject_layer()
  local now_card_num = self.v_now_card_num
  if 0 == now_card_num % 2 then
    local left_idx = now_card_num / 2
    local right_idx = left_idx + 1
    for i = left_idx, 1, -1 do
      local trans = self.v_pos_2_card_list[i].trans
      trans:SetAsLastSibling()
    end
    for i = right_idx, now_card_num do
      local trans = self.v_pos_2_card_list[i].trans
      trans:SetAsLastSibling()
    end
  else
    local root_idx = _floor(now_card_num / 2) + 1
    local root_trans = self.v_pos_2_card_list[root_idx].trans
    root_trans:SetAsLastSibling()
    for i = root_idx, 1, -1 do
      local trans = self.v_pos_2_card_list[i].trans
      trans:SetAsLastSibling()
    end
    for i = root_idx, now_card_num do
      local trans = self.v_pos_2_card_list[i].trans
      trans:SetAsLastSibling()
    end
  end
end

function ui:create_ring_pos_data(card_num)
  local pos_data = {}
  for i = 1, card_num do
    pos_data[i] = self:init_card_pos(i)
  end
  self:save_lua_file(pos_data)
end

function ui:save_lua_file(result_tb)
  local data = dump(result_tb)
  local path = PathDefine.ring_pos_dir .. "ring_pos.lua"
  local f = io.open(path, "w")
  if f then
    f:write(data)
    f:flush()
    f:close()
  end
end

function ui:remove_wrap_list()
  self:give_back_auto_cache(CHAL_RING_CARD)
  for _, item in pairs(self.v_card_obj_list) do
    item:ui_hide()
    item:ui_destroy()
  end
  self.v_pos_2_card_list = {}
  self.v_card_obj_list = {}
end

function ui:response_skip_card(msg)
  if not msg then
    return
  end
  local is_left = msg.mm_x
  if is_left then
    self:step_to_left_card()
  else
    self:step_to_right_card()
  end
end

function ui:response_remove_card(msg)
  if not msg then
    return
  end
end

function ui:skip_card_suc(msg)
  self:remove_wrap_list()
  self:init_card()
  ChallengeRingPlusMgr:wait_skip_end()
end

function ui:skip_card_fail(msg)
  self:remove_wrap_list()
  self:init_card()
  ChallengeRingPlusMgr:wait_skip_end()
end

function ui:remove_card_anim(remove_idx)
  local card_item = (self.v_pos_2_card_list[remove_idx] or {}).card_obj
  if not card_item then
    return
  end
  
  local function cb()
    self:remove_card_after_anima(remove_idx)
  end
  
  if self.v_ring_plus_ui then
    self.v_ring_plus_ui:set_pnl_not_click(true)
  end
  self:set_is_play_anim(true)
  card_item:play_remove_card_effect(cb)
end

function ui:remove_create_boss_card_anim(remove_idx, boss_index)
  local card_obj = self.v_pos_2_card_list[remove_idx] and self.v_pos_2_card_list[remove_idx].card_obj
  if not card_obj then
    return
  end
  
  local function cb()
    local function effect_end_cb()
      card_obj:change_click_state(true)
    end
    
    local boss_data = {
      card_index = boss_index,
      is_can_click = 1 == remove_idx or remove_idx == self.v_now_card_num
    }
    card_obj:set_data(boss_data)
    card_obj:reset_main_alpha()
    ChallengeRingPlusMgr:update_remove_card()
    if self.v_ring_plus_ui then
      self.v_ring_plus_ui:remove_card_particle_move(1 ~= remove_idx)
    end
    card_obj:play_boss_card_show_effect(effect_end_cb)
  end
  
  self:set_is_play_anim(true)
  if self.v_ring_plus_ui then
    self.v_ring_plus_ui:set_pnl_not_click(true)
  end
  card_obj:play_remove_card_effect(cb, 0.05)
end

function ui:play_unlock_door_anima(remove_idx)
  if self.v_ring_plus_ui then
    self.v_ring_plus_ui:set_pnl_not_click(true)
  end
  self:set_is_play_anim(true)
  local card_obj = self.v_pos_2_card_list[remove_idx] and self.v_pos_2_card_list[remove_idx].card_obj
  if not card_obj then
    return
  end
  local pos = card_obj:get_key_pos()
  
  local function remove_card_cb()
    if self.v_ring_plus_ui then
      self.v_ring_plus_ui:play_key_anima(pos)
    end
    self:remove_card_after_anima(remove_idx)
  end
  
  if self.v_ring_plus_ui then
    self.v_ring_plus_ui:open_unlock_icon(false)
    self.v_ring_plus_ui:play_key_break_effect()
  end
  card_obj:play_remove_card_effect(remove_card_cb)
end

function ui:is_play_anim()
  return self.v_is_moving or self.v_is_play_card_anim
end

function ui:set_is_play_anim(is_playing)
  self.v_is_play_card_anim = is_playing
end

function ui:response_select_card(msg)
  if not msg then
    return
  end
  local select_idx = msg.mm_x
  local card_item = (self.v_pos_2_card_list[select_idx] or {}).card_obj
  if not card_item then
    return
  end
  local card_cfg = card_item:get_card_cfg()
  local is_battle_card = ChallengeRingPlusMgr:is_battle_card(card_cfg.Type)
  local cb
  if not is_battle_card then
    function cb()
      self:set_is_play_anim(false)
    end
  end
  self:set_is_play_anim(true)
  card_item:play_select_card_anim(cb)
  Global.sound_mgr:play_ui_sound(Config.UI_SOUND_CFG.card_select_UI_SOUND)
end

function ui:get_card_cfg(is_left)
  local index = is_left and 1 or self.v_now_card_num
  local card_obj = (self.v_pos_2_card_list[index] or {}).card_obj
  if card_obj then
    return card_obj.v_card_cfg
  end
end

function ui:update_card_canvas_sortingoder()
  local num = #self.v_pos_2_card_list
  local parent_canvas = self:get_canvas(nil, self.v_object)
  for i = 1, num do
    local target = self.v_pos_2_card_list[i]
    local canvas = target.card_obj:get_canvas(nil, target.go)
    local half_card_num = _mceil(num / 2)
    local add_sort = _mabs(half_card_num - i)
    canvas.sortingOrder = parent_canvas.sortingOrder + add_sort + 5
  end
end

function ui:remove_card_after_anima(remove_idx)
  if self.v_ring_plus_ui then
    self.v_ring_plus_ui:remove_card_particle_move(1 ~= remove_idx)
  end
  if 1 == remove_idx then
    self:remove_left_card()
  else
    self:remove_right_card()
  end
end

function ui:play_end_card_select_effect()
  if not self.v_pos_2_card_list then
    return
  end
  local card_cfg, card_type, card_obj
  for key, card in pairs(self.v_pos_2_card_list) do
    card_obj = card.card_obj
    card_cfg = card_obj:get_card_cfg()
    card_type = card_cfg.Type
    if card_type == Config.CommonDefine.CURSE_CARD_TYPE.BOSS then
      card_obj:play_select_effect()
      break
    end
  end
end

function ui:remove_card_obj(remove_index)
  if not self.v_pos_2_card_list[remove_index] then
    return
  end
  local card_index = self.v_pos_2_card_list[remove_index].card_obj:get_card_index()
  self.v_pos_2_card_list[remove_index] = nil
  local item = self.v_card_obj_list[card_index]
  if item then
    self:give_back_auto_cache_obj(CHAL_RING_CARD, item:get_lua_object())
    item:ui_hide()
    item:ui_destroy()
    self.v_card_obj_list[card_index] = nil
  end
end

return ui
