local QuestType = {
  QT_None = 0,
  QT_Main = 1,
  QT_Daily = 2,
  QT_Branch = 3,
  QT_Growth = 4,
  QT_Achieve = 5,
  QT_20406080 = 6,
  QT_Campaign = 7,
  QT_Week = 9,
  QT_WorldBoss = 10,
  QT_Tower = 11,
  QT_SeasonTaskLine = 12,
  QT_SeasonTaskRand = 13,
  QT_Homeland_Guide = 101,
  QT_Homeland_Stage = 102,
  QT_Homeland_Stage_Num = 103,
  QT_Homeland_Common = 104,
  QT_Homeland_Change = 105,
  QT_Homeland_Group_Rookie = 111,
  QT_Homeland_Group_Campaign = 112,
  QT_Homeland_Fishing_Challenge = 113,
  QT_Homeland_Story_Task = 114,
  QT_HomelandEventConnect = 121
}
_enum("QuestType", QuestType)
local QuestSubType = {
  QST_None = 0,
  QST_Client_Common = 1,
  QST_Balancing_Game = 2,
  QST_Cleaning_Game = 3,
  QST_Exploring_Game = 4
}
_enum("QuestSubType", QuestSubType)
local QuestStatus = {
  QUEST_NotStart = 0,
  QUEST_Accepted = 1,
  QUEST_Completed = 2,
  QUEST_Taken = 3
}
_enum("QuestStatus", QuestStatus)
local QuestStage = {QUEST_STAGE_FIRST = 1, QUEST_STAGE_SECOND = 2}
_enum("QuestStage", QuestStage)
local HomelandTaskGroupType = {
  HTGT_NEW_PLAYER = 1,
  HTGT_CAMPAIGN = 2,
  HTGT_STORY_TASK = 3
}
_enum("HomelandTaskGroupType", HomelandTaskGroupType)
local AchieveType = {
  AT_All = 1,
  AT_Trace = 100,
  AT_TraceLogin = 101,
  AT_TraceLevel = 102,
  AT_Knowledge = 200,
  AT_KnowledgeMission = 201,
  AT_KnowledgeExtension = 202,
  AT_Battle = 300,
  AT_BattleWin = 301,
  AT_BattleDefeat = 302,
  AT_BattleDungeon = 303,
  AT_BattleMaze = 304,
  AT_Collection = 400,
  AT_CollectionGold = 401,
  AT_CollectionDiamond = 402,
  AT_CollectionPhysics = 403,
  AT_CollectionMazeCoin = 404,
  AT_CollectionDrawCard = 405,
  AT_CollectionPet = 406,
  AT_CollectionAircraft = 407,
  AT_Relationship = 500,
  AT_RelationshipFriend = 501,
  AT_RelationshipTeam = 502
}
_enum("AchieveType", AchieveType)
_class("MobileQuestInfo", Object)
MobileQuestInfo = MobileQuestInfo

function MobileQuestInfo:Constructor()
  self.quest_id = 0
  self.status = 0
  self.cur_progress = 0
  self.total_progress = 0
  self.start_time = 0
  self.last_update_time = 0
  self.complete_time = 0
  self.rewards = {}
  self.QuestType = 0
  self.JumpID = 0
  self.JumpParam = {}
  self.QuestName = ""
  self.QuestDesc = ""
  self.CondDesc = ""
  self.Icon = ""
  self.Day = 0
  self.DayGroup = 0
  self.LayoutIdx = 0
  self.ChapterID = 0
  self.AchieveType = 0
  self.Cond = ""
  self.ShowType = 0
  self.BeginCountersTime = 0
  self.GrowthStage = 0
  self.grouptask_cond_cur_progress = {}
  self.grouptask_cond_total_progress = {}
  self.IsGroupTaskSatisfy = false
end

MobileQuestInfo._proto = {
  [1] = {"quest_id", "int"},
  [2] = {"status", "int"},
  [3] = {
    "cur_progress",
    "int"
  },
  [4] = {
    "total_progress",
    "int"
  },
  [5] = {"start_time", "time"},
  [6] = {
    "last_update_time",
    "time"
  },
  [7] = {
    "complete_time",
    "time"
  },
  [8] = {
    "rewards",
    "list<RoleAsset>"
  },
  [9] = {"QuestType", "int"},
  [10] = {"JumpID", "int"},
  [11] = {"JumpParam", "list<int>"},
  [12] = {"QuestName", "string"},
  [13] = {"QuestDesc", "string"},
  [14] = {"CondDesc", "string"},
  [15] = {"Icon", "string"},
  [16] = {"Day", "int"},
  [17] = {"DayGroup", "int"},
  [18] = {"LayoutIdx", "int"},
  [19] = {"ChapterID", "int"},
  [20] = {
    "AchieveType",
    "int"
  },
  [21] = {"Cond", "string"},
  [22] = {"ShowType", "int"},
  [23] = {
    "BeginCountersTime",
    "time"
  },
  [24] = {
    "GrowthStage",
    "int"
  },
  [25] = {
    "grouptask_cond_cur_progress",
    "map<int,int>"
  },
  [26] = {
    "grouptask_cond_total_progress",
    "map<int,int>"
  },
  [27] = {
    "IsGroupTaskSatisfy",
    "bool"
  }
}
_class("MobileAllQuestData", Object)
MobileAllQuestData = MobileAllQuestData

function MobileAllQuestData:Constructor()
  self.quest_dict = {}
  self.complete_set = {}
  self.recent_complete_achieves = {}
  self.growth_quest_unlock_time = 0
  self.growth_points = 0
  self.growth_reward_state = 0
  self.growth_stage2_points = 0
  self.growth_stage2_reward_state = 0
end

MobileAllQuestData._proto = {
  [1] = {
    "quest_dict",
    "map<int,MobileQuestInfo>"
  },
  [2] = {
    "complete_set",
    "list<int>"
  },
  [3] = {
    "recent_complete_achieves",
    "list<int>"
  },
  [4] = {
    "growth_quest_unlock_time",
    "time"
  },
  [5] = {
    "growth_points",
    "int"
  },
  [6] = {
    "growth_reward_state",
    "int64"
  },
  [7] = {
    "growth_stage2_points",
    "int"
  },
  [8] = {
    "growth_stage2_reward_state",
    "int64"
  }
}
_class("quest_info", Object)
quest_info = quest_info

function quest_info:Constructor()
  self.pstid = 0
  self.quest_id = 0
  self.status = 0
  self.start_time = 0
  self.last_update_time = 0
  self.complete_time = 0
  self.cond_status = ""
end

quest_info._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"quest_id", "int"},
  [3] = {"status", "int"},
  [4] = {"start_time", "time"},
  [5] = {
    "last_update_time",
    "time"
  },
  [6] = {
    "complete_time",
    "time"
  },
  [7] = {
    "cond_status",
    "buffer"
  }
}
_class("quest_completed", Object)
quest_completed = quest_completed

function quest_completed:Constructor()
  self.pstid = 0
  self.complete_set = {}
  self.recent_complete_achieves = {}
end

quest_completed._proto = {
  [1] = {"pstid", "int64"},
  [2] = {
    "complete_set",
    "list<int>"
  },
  [3] = {
    "recent_complete_achieves",
    "list<int>"
  }
}
