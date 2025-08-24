local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
  self.v_questionnaire_list = {}
  self.v_player_var_value = {}
end

function M:on_questionnaire_list(questionnaire_list)
  self.v_questionnaire_list = {}
  for _, data in pairs(questionnaire_list.questionnaire_list) do
    local questionnaire_id = data.id
    self.v_questionnaire_list[questionnaire_id] = data
  end
  MsgGame:mq_publish2(Const.MSG_ON_QUESTIONNAIRE_UPDATE)
end

function M:on_questionnaire_info_update(questionnaire_data)
  self.v_questionnaire_list[questionnaire_data.questionnaire_data.id] = questionnaire_data.questionnaire_data
  MsgGame:mq_publish2(Const.MSG_ON_QUESTIONNAIRE_UPDATE)
end

function M:on_player_var_value_update(player_var_value)
  if not self.v_player_var_value then
    self.v_player_var_value = {}
  end
  for i, v in ipairs(player_var_value.var_value_list) do
    self.v_player_var_value[v.var_name] = v.var_value
  end
  MsgGame:mq_publish2(Const.MSG_ON_PLAYER_VAR_VALUE_UPDATE)
end

function M:get_player_var_value(key_str)
  if key_str and self.v_player_var_value then
    return self.v_player_var_value[key_str] or 0
  end
end

function M:get_questionnaire_list()
  return self.v_questionnaire_list
end

function M:get_questionnaire_by_id(q_id)
  return self.v_questionnaire_list[q_id]
end

function M:is_questionnaire_open(q_id)
  local q_cfg = ShareRes.create("questionnaire.questionnaire_reward", q_id)
  local data = self.v_questionnaire_list[q_id]
  if not data then
    return true
  end
  if data.reward_cnt < q_cfg.RewardLimit then
    return true
  else
    return false
  end
end

return M
