local ShareRes = require("utils.share_res")
local common_def = require("cs_share.common_define")
local M = {}
M.SHOW_TASK_TYPE = {
  NORMAL = 1,
  WEEKLY_PRE = 2,
  WEEKLY_PVP = 3
}
M.TASK_TYPE = {MAIN = 1, BRANCH = 2}
M.TYPE_NAME = {
  [M.TASK_TYPE.MAIN] = "主线任务",
  [M.TASK_TYPE.BRANCH] = "支线任务"
}
M.POINT_TYPE = {FIGHT = 1, STORY = 2}
M.POINTSTATE = {
  complete = 1,
  quit = 2,
  all_die = 3
}
M.DEFAULT_STARTING_POS = 1
M.FIGHT_RES_TYPE = {
  NONE = 0,
  FIGHT_ENERGY = 2,
  FIGHT_ANGER = 3
}
M.CHAPTER_TYPE = {NORMAL = 1, SHOW_TASK = 2}
M.POINT_INFO_RES_PATH = "prefab/Tips/PointInfoCommon.prefab"
return M
