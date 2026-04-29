require("ui_season_task_list_navi")
_class("UIS2TaskListNavi", UISeasonTaskListNavi)
UIS2TaskListNavi = UIS2TaskListNavi

function UIS2TaskListNavi:_GetAnimInfo(key)
  local tb = {
    ["in"] = {
      animName = "uieffanim_UIS2TaskListNavi_in",
      duration = 900
    },
    out = {
      animName = "uieffanim_UIS2TaskListNavi_out",
      duration = 500
    }
  }
  return tb[key].animName, tb[key].duration
end
