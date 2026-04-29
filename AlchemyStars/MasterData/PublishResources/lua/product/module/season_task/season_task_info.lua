local SeasonTaskErrorType = {
  E_SEASONTASK_ERROR_TYPE_SUCCESS = 0,
  E_SEASONTASK_ERROR_TYPE_FAILURE = 1,
  E_SEASONTASK_LOAD_ERROR = 2,
  E_SEASONTASK_SAVE_ERROR = 3,
  E_SEASONTASK_ERROR_UNLOCK = 4,
  E_SEASONTASK_ERROR_CASTLE_ID = 100,
  E_SEASONTASK_ERROR_CASTLE_LV = 101,
  E_SEASONTASK_ERROR_CASTLE_LV_LOCK = 102,
  E_SEASONTASK_ERROR_CASTLE_TIME = 103,
  E_SEASONTASK_ERROR_DEBRISMISSION = 150,
  E_SEASONTASK_ERROR_DEBRISMISSION_LOCK = 151,
  E_SEASONTASK_ERROR_DEBRISMISSION_REPEAT = 152
}
_enum("SeasonTaskErrorType", SeasonTaskErrorType)
local TaskStageType = {LINETASK = 0, RANDOMTASK = 1}
_enum("TaskStageType", TaskStageType)
_class("TaskNode", Object)
TaskNode = TaskNode

function TaskNode:Constructor()
  self.node_id = 0
  self.is_finish = false
end

TaskNode._proto = {
  [1] = {"node_id", "int"},
  [2] = {"is_finish", "bool"}
}
_class("OneSeasonTaskInfo", Object)
OneSeasonTaskInfo = OneSeasonTaskInfo

function OneSeasonTaskInfo:Constructor()
  self.season_task_list_id = 0
  self.cur_line_task = TaskNode:New()
  self.cur_rand_task = {}
  self.stage = TaskStageType.LINETASK
end

OneSeasonTaskInfo._proto = {
  [1] = {
    "season_task_list_id",
    "int"
  },
  [2] = {
    "cur_line_task",
    "TaskNode"
  },
  [3] = {
    "cur_rand_task",
    "list<TaskNode>"
  },
  [4] = {"stage", "int"}
}
_class("EvenPointInfo", Object)
EvenPointInfo = EvenPointInfo

function EvenPointInfo:Constructor()
  self.event_id = 0
  self.status = 0
end

EvenPointInfo._proto = {
  [1] = {"event_id", "int"},
  [2] = {"status", "int"}
}
_class("QuestProgress", Object)
QuestProgress = QuestProgress

function QuestProgress:Constructor()
  self.quest_id = 0
  self.event_infos = {}
end

QuestProgress._proto = {
  [1] = {"quest_id", "int"},
  [2] = {
    "event_infos",
    "map<int,EvenPointInfo>"
  }
}
_class("ClientQuestProgressInfo", Object)
ClientQuestProgressInfo = ClientQuestProgressInfo

function ClientQuestProgressInfo:Constructor()
  self.line_quest_progress_info = {}
  self.rand_quest_progress_info = {}
  self.eventpoint_info = {}
end

ClientQuestProgressInfo._proto = {
  [1] = {
    "line_quest_progress_info",
    "map<int,QuestProgress>"
  },
  [2] = {
    "rand_quest_progress_info",
    "map<int,QuestProgress>"
  },
  [3] = {
    "eventpoint_info",
    "map<int,EvenPointInfo>"
  }
}
_class("client_season_task_info", Object)
client_season_task_info = client_season_task_info

function client_season_task_info:Constructor()
  self.season_task_list_id = 0
  self.cur_line_task = TaskNode:New()
  self.cur_rand_task = {}
  self.stage = 0
end

client_season_task_info._proto = {
  [1] = {
    "season_task_list_id",
    "int"
  },
  [2] = {
    "cur_line_task",
    "TaskNode"
  },
  [3] = {
    "cur_rand_task",
    "list<TaskNode>"
  },
  [4] = {"stage", "int"}
}
