require("ui_season_task_list_content")
_class("UIS3TaskListContent", UISeasonTaskListContent)
UIS3TaskListContent = UIS3TaskListContent

function UIS3TaskListContent:_GetAnimInfo(key)
  local tb = {
    TabBtnIn = {
      animName = "uieffanim_UIS3TaskListContent_TabBtn_in",
      duration = 500
    },
    QuestFin = {
      animName = "uieffanim_UIS2TaskListContent_fin",
      duration = 333
    }
  }
  return tb[key].animName, tb[key].duration
end

function UIS3TaskListContent:_GetRewardInfo()
  return "UISeasonItemS3", "UIS3TaskListContent_Item.prefab"
end

function UIS3TaskListContent:_GetStrIdInfo(key, ...)
  local tb = {
    intro_name = "str_season_s3_task_list_intro_name",
    intro_job = "str_season_s3_task_list_intro_job",
    intro_desc = "str_season_s3_task_list_intro_desc",
    title_task = "str_season_s3_task_list_title_task",
    title_reward = "str_season_s3_task_list_title_reward",
    progress = "str_season_s3_task_list_progress",
    tab_lock = "str_season_s3_task_list_tab_lock",
    page = "str_season_s3_task_list_page"
  }
  local strId = tb[key]
  if string.isnullorempty(strId) then
    return ""
  end
  local text = StringTable.Get(strId, ...)
  return text
end
