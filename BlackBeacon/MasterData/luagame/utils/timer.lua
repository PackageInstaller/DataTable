local Util = require("utils.util")
local M = Util.create_class()
local ENABLE_DEBUG = false
local SECOND_PER_FRAME = 0.1
local FRAME_RATE = 1 / SECOND_PER_FRAME
local WHEEL_SIZE_1 = 200
local WHEEL_SIZE_2 = 60
local WHEEL_SIZE_3 = 60
local WHEEL_SIZE_4 = 60
local WHEEL_SIZE_5 = 10
local WHEEL_SIZE_MUL12 = WHEEL_SIZE_1 * WHEEL_SIZE_2
local WHEEL_SIZE_MUL123 = WHEEL_SIZE_1 * WHEEL_SIZE_2 * WHEEL_SIZE_3
local WHEEL_SIZE_MUL1234 = WHEEL_SIZE_1 * WHEEL_SIZE_2 * WHEEL_SIZE_3 * WHEEL_SIZE_4
local WHEEL_SIZE_MUL12345 = WHEEL_SIZE_1 * WHEEL_SIZE_2 * WHEEL_SIZE_3 * WHEEL_SIZE_4 * WHEEL_SIZE_5
local TIMER_COUNTER = 1
local INNER_BARRIER = false

local function _create_wheel(scale)
  local wheel = {}
  for i = 1, scale do
    wheel[i - 1] = {}
  end
  wheel.index = 0
  wheel.bound = scale
  return wheel
end

function M:_init()
  self.v_elapse_time = 0
  self.v_current_frame_idx = 0
  self.v_wheels = {
    _create_wheel(WHEEL_SIZE_1),
    _create_wheel(WHEEL_SIZE_2),
    _create_wheel(WHEEL_SIZE_3),
    _create_wheel(WHEEL_SIZE_4),
    _create_wheel(WHEEL_SIZE_5)
  }
  self.v_index_slot_map = {}
  self.v_unscaled_elapse_time = 0
  self.v_unscaled_cur_frame_idx = 0
  self.v_unscaled_wheels = {
    _create_wheel(WHEEL_SIZE_1),
    _create_wheel(WHEEL_SIZE_2),
    _create_wheel(WHEEL_SIZE_3),
    _create_wheel(WHEEL_SIZE_4),
    _create_wheel(WHEEL_SIZE_5)
  }
  self.v_unscaled_index_slot_map = {}
  if ENABLE_DEBUG then
    self.v_debug_counter_to_trace = {}
  end
end

function M:_internal_add_timer(wheels, current_frame_idx, index_slot_map, timer)
  local expires = timer.expires
  local idx = expires - current_frame_idx
  local slot
  if idx <= 0 then
    local wheel = wheels[1]
    local wheel_idx = wheel.index
    if INNER_BARRIER then
      wheel_idx = (wheel_idx + 1) % WHEEL_SIZE_1
    elseif wheel_idx >= wheel.bound then
      wheel_idx = 0
    end
    slot = wheel[wheel_idx]
  elseif idx < WHEEL_SIZE_1 then
    slot = wheels[1][expires % WHEEL_SIZE_1]
  elseif idx < WHEEL_SIZE_MUL12 then
    slot = wheels[2][(math.floor(expires / WHEEL_SIZE_1) - 1) % WHEEL_SIZE_2]
  elseif idx < WHEEL_SIZE_MUL123 then
    slot = wheels[3][(math.floor(expires / WHEEL_SIZE_MUL12) - 1) % WHEEL_SIZE_3]
  elseif idx < WHEEL_SIZE_MUL1234 then
    slot = wheels[4][(math.floor(expires / WHEEL_SIZE_MUL123) - 1) % WHEEL_SIZE_4]
  elseif idx < WHEEL_SIZE_MUL12345 then
    slot = wheels[5][(math.floor(expires / WHEEL_SIZE_MUL1234) - 1) % WHEEL_SIZE_5]
  else
    Global.log.Debug("too long timer", timer)
    return
  end
  if not slot then
    Global.log.Error("_internal_add_timer", idx, timer, current_frame_idx, wheels, debug.traceback())
    return
  end
  slot[timer.id] = timer
  index_slot_map[timer.id] = slot
  if ENABLE_DEBUG then
    self.v_debug_counter_to_trace[timer.id] = debug.traceback()
  end
end

function M:add_timer(desc, expires, cb, arg1, arg2, cycle, is_unscaled)
  TIMER_COUNTER = TIMER_COUNTER + 1
  cycle = cycle or 0
  local wheels, current_frame_idx, index_slot_map, elapse_time
  if is_unscaled then
    elapse_time = self.v_unscaled_elapse_time
    current_frame_idx = self.v_unscaled_cur_frame_idx
    index_slot_map = self.v_unscaled_index_slot_map
    wheels = self.v_unscaled_wheels
  else
    elapse_time = self.v_elapse_time
    current_frame_idx = self.v_current_frame_idx
    index_slot_map = self.v_index_slot_map
    wheels = self.v_wheels
  end
  local info = {
    id = TIMER_COUNTER,
    expires = math.floor((expires + elapse_time) * FRAME_RATE) + current_frame_idx,
    arg1 = arg1,
    arg2 = arg2,
    callback = cb,
    cycle = cycle * FRAME_RATE,
    desc = desc
  }
  self:_internal_add_timer(wheels, current_frame_idx, index_slot_map, info)
  return TIMER_COUNTER
end

function M:remove_timer(index)
  assert(index, "nil index found")
  local slot = self.v_index_slot_map[index]
  local remove_suc = false
  if slot then
    slot[index] = nil
    self.v_index_slot_map[index] = nil
    remove_suc = true
  end
  slot = self.v_unscaled_index_slot_map[index]
  if slot then
    slot[index] = nil
    self.v_unscaled_index_slot_map[index] = nil
    remove_suc = true
  end
  if ENABLE_DEBUG then
    self.v_debug_counter_to_trace[index] = nil
  end
  return remove_suc
end

function M:cascade_timers(wheel)
  local slot = wheel[wheel.index]
  for _, timer in pairs(slot) do
    self:_internal_add_timer(self.v_wheels, self.v_current_frame_idx, self.v_index_slot_map, timer)
  end
  wheel[wheel.index] = {}
  wheel.index = wheel.index + 1
end

function M:unscaled_cascade_timers(wheel)
  local slot = wheel[wheel.index]
  for _, timer in pairs(slot) do
    self:_internal_add_timer(self.v_unscaled_wheels, self.v_unscaled_cur_frame_idx, self.v_unscaled_index_slot_map, timer)
  end
  wheel[wheel.index] = {}
  wheel.index = wheel.index + 1
end

function M:update(elapse)
  self.v_elapse_time = self.v_elapse_time + elapse
  while self.v_elapse_time > SECOND_PER_FRAME do
    self.v_elapse_time = self.v_elapse_time - SECOND_PER_FRAME
    local wheel = self.v_wheels[1]
    local wheel_idx = 1
    while wheel.index >= wheel.bound do
      wheel.index = 0
      wheel_idx = wheel_idx + 1
      wheel = self.v_wheels[wheel_idx]
      self:cascade_timers(wheel)
    end
    wheel = self.v_wheels[1]
    local slot = wheel[wheel.index]
    for idx, timer in pairs(slot) do
      INNER_BARRIER = true
      local result = timer.callback(timer.arg1, timer.arg2, timer.id)
      INNER_BARRIER = false
      self:remove_timer(idx)
      if timer.cycle > 0 and result then
        timer.expires = timer.expires + timer.cycle
        self:_internal_add_timer(self.v_wheels, self.v_current_frame_idx, self.v_index_slot_map, timer)
      end
    end
    self.v_current_frame_idx = self.v_current_frame_idx + 1
    wheel.index = wheel.index + 1
  end
  self:unscaled_update(elapse)
end

function M:unscaled_update(elapse)
  if not SceneMgr:can_update() then
    return
  end
  self.v_unscaled_elapse_time = self.v_unscaled_elapse_time + elapse
  while self.v_unscaled_elapse_time > SECOND_PER_FRAME do
    self.v_unscaled_elapse_time = self.v_unscaled_elapse_time - SECOND_PER_FRAME
    local wheel = self.v_unscaled_wheels[1]
    local wheel_idx = 1
    while wheel.index >= wheel.bound do
      wheel.index = 0
      wheel_idx = wheel_idx + 1
      wheel = self.v_unscaled_wheels[wheel_idx]
      self:unscaled_cascade_timers(wheel)
    end
    wheel = self.v_unscaled_wheels[1]
    local slot = wheel[wheel.index]
    for idx, timer in pairs(slot) do
      INNER_BARRIER = true
      local result = timer.callback(timer.arg1, timer.arg2, timer.id)
      INNER_BARRIER = false
      self:remove_timer(idx)
      if timer.cycle > 0 and result then
        timer.expires = timer.expires + timer.cycle
        self:_internal_add_timer(self.v_unscaled_wheels, self.v_unscaled_cur_frame_idx, self.v_unscaled_index_slot_map, timer)
      end
    end
    self.v_unscaled_cur_frame_idx = self.v_unscaled_cur_frame_idx + 1
    wheel.index = wheel.index + 1
  end
end

function M:clear()
  self:_init()
end

function M:print_debug_counter_to_trace(timer_idx)
  if ENABLE_DEBUG then
    for idx, trace in pairs(self.v_debug_counter_to_trace) do
      if nil == timer_idx or timer_idx == idx then
        Log.Info("idx: " .. idx .. ", trace: " .. trace)
      end
    end
  else
    Log.Error("print_debug_counter_to_trace: ENABLE_DEBUG is false")
  end
end

return M
