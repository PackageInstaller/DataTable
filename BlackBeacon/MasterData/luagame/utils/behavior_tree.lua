local BehaviorDef = require("utils.behavior_def")
local table = _ENV.table
local Parser = {}
local Node = {}
local BT_SUCCESS = BehaviorDef.BT_SUCCESS
local BT_FAILURE = BehaviorDef.BT_FAILURE
local BT_RUNNING = BehaviorDef.BT_RUNNING
local BT_INVALID = BehaviorDef.BT_INVALID

function Node.Noop(node)
  return function()
    return BT_SUCCESS
  end
end

function Node.Action(node)
  local method = node.Method
  local params = node.MethodParams
  return function(robot, ex)
    local func = assert(robot[method], method)
    return func(robot, ex.now, table.unpack(params))
  end
end

function Node.Precondition(node)
  local comparison = node.Operator
  local method = node.Opl
  local params = node.OplParams
  local value = node.Opr2
  if "Equal" == comparison then
    return function(robot, ex)
      local func = assert(robot[method], method)
      return func(robot, ex.now, table.unpack(params)) == value
    end
  elseif "NotEqual" == comparison then
    return function(robot, ex)
      local func = assert(robot[method], method)
      return func(robot, ex.now, table.unpack(params)) ~= value
    end
  end
  error("Unknown Operator " .. comparison)
end

function Node.Condition(node)
  if node.class == "Or" then
    local cond1 = Node.Condition(node.node[1])
    local cond2 = Node.Condition(node.node[2])
    return function(robot, ex)
      return cond1(robot, ex) or cond2(robot, ex)
    end
  else
    local comparison = node.Operator
    local method = node.Opl
    local params = node.OplParams
    local value = node.Opr
    if "Equal" == comparison then
      return function(robot, ex)
        local func = assert(robot[method], method)
        return func(robot, ex.now, table.unpack(params)) == value
      end
    elseif "NotEqual" == comparison then
      return function(robot, ex)
        local func = assert(robot[method], method)
        return func(robot, ex.now, table.unpack(params)) ~= value
      end
    end
    error("Unknown Operator " .. comparison)
  end
end

function Node.Selector(node)
  local funcs = Parser.parse_child_nodes(node)
  local funcs_len = #funcs
  return function(robot, ex)
    local from = 1
    local status_info = ex.running_status_tbl[node.id]
    if status_info and status_info.status == BT_RUNNING then
      from = status_info.child_index
    end
    local ret = BT_FAILURE
    for i = from, funcs_len do
      local func = funcs[i]
      local result = func(robot, ex)
      if result == BT_SUCCESS then
        ret = BT_SUCCESS
        break
      elseif result == BT_RUNNING then
        ex.running_status_tbl[node.id] = {status = BT_RUNNING, child_index = i}
        ret = BT_RUNNING
        break
      end
    end
    if ret ~= BT_RUNNING then
      ex.running_status_tbl[node.id] = nil
    end
    return ret
  end
end

function Node.IfElse(node)
  local cond = node.node[1]
  local tnode = node.node[2]
  local fnode = node.node[3]
  local cond_func = Node.Condition(cond)
  local true_func = Parser.parse_node(tnode)
  local false_func = fnode and Parser.parse_node(fnode)
  return function(robot, ex)
    local branch
    local status_info = ex.running_status_tbl[node.id]
    if status_info and status_info.status == BT_RUNNING then
      branch = status_info.branch
    else
      branch = cond_func(robot, ex)
    end
    local func = true == branch and true_func or false_func
    local ret
    if func then
      ret = func(robot, ex)
    else
      ret = BT_SUCCESS
    end
    if ret == BT_RUNNING then
      if status_info then
        status_info.status = BT_RUNNING
        status_info.branch = branch
      else
        ex.running_status_tbl[node.id] = {status = BT_RUNNING, branch = branch}
      end
    else
      ex.running_status_tbl[node.id] = nil
    end
    return ret
  end
end

function Node.Sequence(node)
  local funcs = Parser.parse_child_nodes(node)
  local funcs_len = #funcs
  return function(robot, ex)
    local from = 1
    local status_info = ex.running_status_tbl[node.id]
    if status_info and status_info.status == BT_RUNNING then
      from = status_info.child_index
    end
    local ret = BT_SUCCESS
    for i = from, funcs_len do
      local func = funcs[i]
      local result = func(robot, ex)
      if result == BT_FAILURE then
        ret = BT_FAILURE
        break
      elseif result == BT_RUNNING then
        if not status_info then
          ex.running_status_tbl[node.id] = {status = BT_RUNNING, child_index = i}
        end
        ret = BT_RUNNING
        break
      end
    end
    if ret ~= BT_RUNNING then
      ex.running_status_tbl[node.id] = nil
    end
    return ret
  end
end

function Node.Parallel(node)
  local funcs = Parser.parse_child_nodes(node)
  local funcs_len = #funcs
  return function(robot, ex)
    local has_fail = false
    local has_success = false
    local has_running = false
    local all_fail = true
    local all_success = true
    local status_info = ex.running_status_tbl[node.id]
    if not status_info then
      status_info = {}
      ex.running_status_tbl[node.id] = status_info
    end
    for i = 1, funcs_len do
      local func = funcs[i]
      local child_id = node.node[i].id
      local status = status_info[child_id] or BT_INVALID
      if node.ChildFinishPolicy == "CHILDFINISH_LOOP" or status == BT_RUNNING or status == BT_INVALID then
        local result = func(robot, ex)
        if result == BT_FAILURE then
          has_fail = true
          all_success = false
        elseif result == BT_SUCCESS then
          has_success = true
          all_fail = false
        elseif result == BT_RUNNING then
          has_running = true
          all_fail = false
          all_success = false
        end
        status_info[child_id] = result
      elseif status == BT_SUCCESS then
        has_success = true
        all_fail = false
      else
        assert(status == BT_FAILURE)
        has_fail = true
        all_success = false
      end
    end
    local ret = true == has_running and BT_RUNNING or BT_FAILURE
    if node.FailurePolicy == "FAIL_ON_ALL" and all_fail or node.FailurePolicy == "FAIL_ON_ONE" and has_fail then
      ret = BT_FAILURE
    elseif node.SuccessPolicy == "SUCCEED_ON_ALL" and all_success or node.SuccessPolicy == "SUCCEED_ON_ONE" and has_success then
      ret = BT_SUCCESS
    end
    if ret ~= BT_RUNNING then
      ex.running_status_tbl[node.id] = nil
    end
    return ret
  end
end

function Node.DecoratorLoop(node)
  local child = node.node[1]
  local func = Parser.parse_node(child)
  local count = node.Count
  return function(robot, ex)
    if count <= 0 then
      while true do
        if func(robot, ex) == BT_FAILURE then
          return BT_FAILURE
        end
      end
    else
      for _ = 1, count do
        if func(robot, ex) == BT_FAILURE then
          return BT_FAILURE
        end
      end
    end
    return BT_SUCCESS
  end
end

function Node.DecoratorNot(node)
  local child = node.node[1]
  local func = Parser.parse_node(child)
  return function(robot, ex)
    local ret = func(robot, ex)
    if ret == BT_SUCCESS then
      return BT_FAILURE
    elseif ret == BT_FAILURE then
      return BT_SUCCESS
    else
      return BT_RUNNING
    end
  end
end

function Node.DecoratorAlwaysSuccess(node)
  local child = node.node[1]
  local func = Parser.parse_node(child)
  return function(robot, ex)
    func(robot, ex)
    return BT_SUCCESS
  end
end

function Node.DecoratorAlwaysFailure(node)
  local child = node.node[1]
  local func = Parser.parse_node(child)
  return function(robot, ex)
    func(robot, ex)
    return BT_FAILURE
  end
end

function Parser.parse_child_nodes(node)
  local funcs = {}
  for i, child in ipairs(node.node) do
    funcs[i] = Parser.parse_node(child)
  end
  return funcs
end

function Parser.parse_preconditions(nodes)
  local funcs = {}
  local is_ors = {}
  for i, node in ipairs(nodes) do
    funcs[i] = Node.Precondition(node)
    local logic = node.BinaryOperator
    if "And" == logic then
      is_ors[i] = false
    elseif "Or" == logic then
      is_ors[i] = true
    else
      error("Unknown BinaryOperator " .. logic)
    end
  end
  local funcs_len = #funcs
  return function(robot, ex)
    local ret = true
    for i = 1, funcs_len do
      local func = funcs[i]
      local result = func(robot, ex)
      if is_ors[i] then
        if not ret then
          ret = result
        end
      else
        ret = ret and result
      end
    end
    return ret
  end
end

function Parser.parse_effectors(nodes)
  local funcs = {}
  local phases = {}
  for i, node in ipairs(nodes) do
    funcs[i] = Node.Action(node)
    local phase = node.Phase
    if "Success" == phase then
      phases[i] = 1
    elseif "Failure" == phase then
      phases[i] = 2
    elseif "Both" == phase then
      phases[i] = 3
    else
      error("Unknown Phase " .. phase)
    end
  end
  local funcs_len = #funcs
  return function(robot, ex, ret)
    for i = 1, funcs_len do
      local func = funcs[i]
      local phase = phases[i]
      if 1 == phase then
        if ret == BT_SUCCESS then
          func(robot, ex)
        end
      elseif 2 == phase then
        if ret == BT_FAILURE then
          func(robot, ex)
        end
      elseif 3 == phase then
        func(robot, ex)
      end
    end
  end
end

function Parser.parse_attachment(attachment)
  local preconditions = {}
  local effectors = {}
  for _, node in ipairs(attachment) do
    local node_type = node.class
    if "Precondition" == node_type then
      table.insert(preconditions, node)
    elseif "Effector" == node_type then
      table.insert(effectors, node)
    else
      error("Unknown attachment Node " .. node_type)
    end
  end
  return Parser.parse_preconditions(preconditions), Parser.parse_effectors(effectors)
end

function Parser.parse_node(node)
  local node_type = node.class
  local make_func = Node[node_type]
  if not make_func then
    error("Unknown Type Node " .. node_type)
  end
  local func = make_func(node)
  local attachment = node.attachment
  if attachment then
    local pre_func, eff_func = Parser.parse_attachment(attachment)
    return function(robot, ex)
      if pre_func(robot, ex) then
        local result = func(robot, ex)
        eff_func(robot, ex, result)
        if result ~= BT_RUNNING then
          ex.running_status_tbl[node.id] = nil
        end
        return result
      end
      return BT_FAILURE
    end
  end
  return func
end

local M = {}

function M.parse(tree)
  local node = tree.behavior[1].node[1]
  return Parser.parse_node(node)
end

function M.make_ai(tree)
  local ai_func = M.parse(tree)
  return function()
    local ex = {
      running_status_tbl = {}
    }
    return function(robot, now)
      ex.now = now
      local result = ai_func(robot, ex)
      if result ~= BT_RUNNING then
        ex.running_status_tbl = {}
      end
      return result
    end
  end
end

return M
