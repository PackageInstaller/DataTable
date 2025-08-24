local Condition = require("gamelogic.condition.condition"):new()
local Battle_Condition = require("gamelogic.condition.battle_condition"):new()
local M = Util.create_class()

function M:_init()
end

function M:check_condition(condition_id, show_tips)
  if not condition_id or 0 == condition_id then
    return true
  end
  local condition = ShareRes.create("condition.condition", condition_id)
  if condition then
    return Condition:check_condition(condition_id, show_tips)
  else
    return Battle_Condition:check_condition(condition_id, show_tips)
  end
end

function M:check_condition_list(condition_list, show_tips)
  for _, con_id in pairs(condition_list) do
    if not self:check_condition(con_id, show_tips) then
      return con_id
    end
  end
  return 0
end

function M:get_condition_need_item(condition_id)
  local condition = ShareRes.create("condition.condition", condition_id)
  if condition.Type == 1028 and condition.Param then
    return condition.Param[1], condition.Value
  end
end

function M:get_condition_desc(condition_id)
  if not condition_id or 0 == condition_id then
    return ""
  end
  local condition = ShareRes.create("condition.condition", condition_id)
  condition = condition or ShareRes.create("battle.battle_condition", condition_id)
  assert(condition, "no such condition " .. condition_id)
  return condition.Desc
end

return M
