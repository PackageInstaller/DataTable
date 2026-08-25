local E = require("ejoysdk_lua.ejoysdk")
local Class = require("ejoysdk_lua.ejoysdk_class")
local TAG = "flow_sequence_builder"
local FlowBuilder = Class:Inherit("ej_base_flow_builder")

function FlowBuilder:Instance(...)
  local inst = self:New(...)
  inst._flow_name_sequence = {}
  inst._flow_cache = {}
  return inst
end

function FlowBuilder:_init(...)
end

local function _save_flow_to_cache(_self, flow)
  assert(flow and flow:get_tag() and flow:get_tag() ~= "", "flow or flow tag is invalid")
  local flow_tag = flow:get_tag()
  _self._flow_cache[flow_tag] = flow
  return flow_tag
end

function FlowBuilder:push_back_flow(flow)
  if not flow then
    E.LOG.warn(TAG, "push_back_flow skip, for flow is nil")
    return
  end
  local flow_tag = _save_flow_to_cache(self, flow)
  table.insert(self._flow_name_sequence, flow_tag)
  return self
end

local function _find_position(_self, flow_tag)
  local pos = -1
  for i, v in ipairs(_self._flow_name_sequence) do
    if v == flow_tag then
      pos = i
      break
    end
  end
  return pos
end

function FlowBuilder:insert_flow_before(target_tag, flow)
  local target_pos = _find_position(self, target_tag)
  assert(target_pos > 0, "insert_flow_before failed, for target_tag not found:" .. tostring(target_tag))
  local flow_tag = _save_flow_to_cache(self, flow)
  table.insert(self._flow_name_sequence, target_pos, flow_tag)
  return self
end

function FlowBuilder:insert_flow_after(target_tag, flow)
  local target_pos = _find_position(self, target_tag)
  assert(target_pos > 0, "insert_flow_after failed, for target_tag not found:" .. tostring(target_tag))
  local flow_tag = _save_flow_to_cache(self, flow)
  table.insert(self._flow_name_sequence, target_pos + 1, flow_tag)
  return self
end

function FlowBuilder:remove_flow(target_tag)
  local target_pos = _find_position(self, target_tag)
  if target_pos > 0 then
    table.remove(self._flow_name_sequence, target_pos)
  else
    E.LOG.warn(TAG, "remove_flow failed, for target tag not found:" .. tostring(target_tag))
  end
  return self
end

function FlowBuilder:replace_flow(target_tag, flow)
  local target_pos = _find_position(self, target_tag)
  if target_pos > 0 then
    _save_flow_to_cache(self, flow)
    self._flow_name_sequence[target_pos] = flow
  else
    E.LOG.warn(TAG, "replace_flow failed, for target tag not found:" .. tostring(target_tag))
  end
  return self
end

function FlowBuilder:dump_flow_list()
  E.log(self._flow_name_sequence)
end

function FlowBuilder:build_dependency()
  local flow_len = #self._flow_name_sequence
  local next_flow
  for i = flow_len, 1, -1 do
    local flow_name = self._flow_name_sequence[i]
    local flow = self._flow_cache[flow_name]
    assert(flow, "flow is nil for name:" .. tostring(flow_name))
    if nil == next_flow then
      next_flow = flow
    else
      flow:SetSuccessor(next_flow)
      next_flow = flow
    end
  end
  local print_flow_dependencies = {}
  local print_flow = next_flow
  repeat
    table.insert(print_flow_dependencies, print_flow:get_tag())
    print_flow = print_flow:next()
  until nil == print_flow
  E.LOG.debug(TAG, "flow dependencies:" .. table.concat(print_flow_dependencies, " > ") .. ", entry_task:" .. tostring(next_flow:get_tag()))
  return next_flow
end

function FlowBuilder:is_empty()
  return not self._flow_name_sequence or 0 == #self._flow_name_sequence
end

function FlowBuilder:run()
  local flow_entry_task = self:build_dependency()
  if flow_entry_task then
    flow_entry_task:run()
  else
    E.LOG.warn(TAG, "run failed, for entry task is nil")
  end
end

return FlowBuilder
