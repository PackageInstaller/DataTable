local ShareRes = require("utils.share_res")
local common_def = require("cs_share.common_define")
local M = {}
M.TASK_TYPE = {
  MAIN = 1,
  BRANCH = 2,
  CHALLENGE = 3
}
M.SHOW_TASK_LIST = {
  [M.TASK_TYPE.MAIN] = "主线任务",
  [M.TASK_TYPE.BRANCH] = "支线任务",
  [M.TASK_TYPE.CHALLENGE] = "挑战任务"
}
M.TASK_STATE = {
  NOT_RECEIVE = 0,
  CAN_RECEIVE = 1,
  RECEIVE = 2,
  COMPLETE = 3,
  GET_REWARD = 4
}
M.NOTICE_TYPE = {BATTLE_TASK_RECEIVE = 1, BATTLE_TASK_COMPLETE = 2}
return M
