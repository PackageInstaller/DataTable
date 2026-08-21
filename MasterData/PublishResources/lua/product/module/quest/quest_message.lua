require("message_def")
local questMessageDef = {
  CLSID_CEventQuestTake = 18000,
  CLSID_CEventQuestTakeResult = 18001,
  CLSID_CEventOneKeyTake = 18002,
  CLSID_CEventOneKeyTakeResult = 18003,
  CLSID_CEventQuestGetAchReward = 18004,
  CLSID_CEventQuestGetAchRewardResult = 18005,
  CLSID_CEventQuestGetVigReward = 18006,
  CLSID_CEventQuestGetVigRewardResult = 18007,
  CLSID_CEventQuestGrowthFeatherReward = 18008,
  CLSID_CEventQuestGrowthFeatherRewardResult = 18009,
  CLSID_CEventPushQuestUpdate = 18010,
  CLSID_CEventPushQuestStateParamUpdate = 18011,
  CLSID_CEventPushRecentAchieve = 18012,
  CLSID_CEventPushResetDailyQuest = 18013,
  CLSID_CEventQuestDailyRefreshTime = 18014,
  CLSID_CEventQuestDailyRefreshTimeResult = 18015,
  CLSID_CEventApplyAcceptQuest = 18016,
  CLSID_CEventApplyAcceptQuestResult = 18017,
  CLSID_CEventApplyNotify = 18018,
  CLSID_CEventApplyNotifyResult = 18019,
  CLSID_CEventSetAchieve = 18020,
  CLSID_CEventSetAchieveResult = 18021,
  CLSID_CEventSetVigorous = 18022,
  CLSID_CEventSetVigorousResult = 18023,
  CLSID_CEventPushUnlockChapterQuest = 18024,
  CLSID_CEventPushResetWeekQuest = 18025,
  CLSID_CEventPushWorldBossReset = 18026,
  CLSID_CEventClientProcess = 18027,
  CLSID_CEventClientProcessResult = 18028
}
table.append(MessageDef, questMessageDef)
local QuestErrorCode = {
  QuestEC_Unknown = -1,
  QuestEC_Succ = 0,
  QuestEC_Locked = 1,
  QuestEC_NoId = 2,
  QuestEC_UnComplete = 5,
  QuestEC_Taken = 6,
  QuestEC_SendRewardError = 7,
  QuestEC_NeedVigPoint = 8,
  QuestEC_NeedAchPoint = 9,
  QuestEC_NoQuestTaken = 10,
  QuestEC_NoQuestGrowthIsOutTime = 11,
  QuestEC_NeedGrowthPoint = 12,
  QuestEc_NotWhiteTestMode = 13,
  QuestEc_PhyFullPartialFail = 14,
  QuestEC_Complete = 15,
  QuestEC_ProcessNumError = 16,
  QuestEC_Type = 17
}
_enum("QuestErrorCode", QuestErrorCode)
_class("CEventQuestTake", CCallRequestEvent)
CEventQuestTake = CEventQuestTake

function CEventQuestTake:Constructor()
  self.id = 0
end

CEventQuestTake._proto = {
  [1] = {"id", "int"}
}
_class("CEventQuestTakeResult", CCallReplyEvent)
CEventQuestTakeResult = CEventQuestTakeResult

function CEventQuestTakeResult:Constructor()
  self.ret = 0
  self.rewards = {}
end

CEventQuestTakeResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("CEventOneKeyTake", CCallRequestEvent)
CEventOneKeyTake = CEventOneKeyTake

function CEventOneKeyTake:Constructor()
  self.quest_type = 0
  self.custom_quest = {}
end

CEventOneKeyTake._proto = {
  [1] = {"quest_type", "int"},
  [2] = {
    "custom_quest",
    "list<int>"
  }
}
_class("CEventOneKeyTakeResult", CCallReplyEvent)
CEventOneKeyTakeResult = CEventOneKeyTakeResult

function CEventOneKeyTakeResult:Constructor()
  self.ret = 0
  self.rewards = {}
end

CEventOneKeyTakeResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("CEventQuestGetAchReward", CCallRequestEvent)
CEventQuestGetAchReward = CEventQuestGetAchReward

function CEventQuestGetAchReward:Constructor()
  self.reward_id = 0
end

CEventQuestGetAchReward._proto = {
  [1] = {"reward_id", "int"}
}
_class("CEventQuestGetAchRewardResult", CCallReplyEvent)
CEventQuestGetAchRewardResult = CEventQuestGetAchRewardResult

function CEventQuestGetAchRewardResult:Constructor()
  self.ret = 0
  self.rewards = {}
end

CEventQuestGetAchRewardResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("CEventQuestGetVigReward", CCallRequestEvent)
CEventQuestGetVigReward = CEventQuestGetVigReward

function CEventQuestGetVigReward:Constructor()
  self.reward_id = 0
end

CEventQuestGetVigReward._proto = {
  [1] = {"reward_id", "int"}
}
_class("CEventQuestGetVigRewardResult", CCallReplyEvent)
CEventQuestGetVigRewardResult = CEventQuestGetVigRewardResult

function CEventQuestGetVigRewardResult:Constructor()
  self.ret = 0
  self.rewards = {}
end

CEventQuestGetVigRewardResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("CEventQuestGrowthFeatherReward", CCallRequestEvent)
CEventQuestGrowthFeatherReward = CEventQuestGrowthFeatherReward

function CEventQuestGrowthFeatherReward:Constructor()
  self.reward_id = 0
end

CEventQuestGrowthFeatherReward._proto = {
  [1] = {"reward_id", "int"}
}
_class("CEventQuestGrowthFeatherRewardResult", CCallReplyEvent)
CEventQuestGrowthFeatherRewardResult = CEventQuestGrowthFeatherRewardResult

function CEventQuestGrowthFeatherRewardResult:Constructor()
  self.ret = 0
  self.rewards = {}
end

CEventQuestGrowthFeatherRewardResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
_class("CEventPushQuestUpdate", CSvrPushEvent)
CEventPushQuestUpdate = CEventPushQuestUpdate

function CEventPushQuestUpdate:Constructor()
  self.update_list = {}
end

CEventPushQuestUpdate._proto = {
  [1] = {
    "update_list",
    "list<MobileQuestInfo>"
  }
}
_class("CEventPushQuestStateParamUpdate", CSvrPushEvent)
CEventPushQuestStateParamUpdate = CEventPushQuestStateParamUpdate

function CEventPushQuestStateParamUpdate:Constructor()
  self.growth_quest_unlock_time = 0
  self.growth_points = 0
  self.growth_reward_state = 0
  self.growth_stage2_points = 0
  self.growth_stage2_reward_state = 0
end

CEventPushQuestStateParamUpdate._proto = {
  [1] = {
    "growth_quest_unlock_time",
    "time"
  },
  [2] = {
    "growth_points",
    "int"
  },
  [3] = {
    "growth_reward_state",
    "int64"
  },
  [4] = {
    "growth_stage2_points",
    "int"
  },
  [5] = {
    "growth_stage2_reward_state",
    "int64"
  }
}
_class("CEventPushRecentAchieve", CSvrPushEvent)
CEventPushRecentAchieve = CEventPushRecentAchieve

function CEventPushRecentAchieve:Constructor()
  self.recent_achieves = {}
end

CEventPushRecentAchieve._proto = {
  [1] = {
    "recent_achieves",
    "list<int>"
  }
}
_class("CEventPushResetDailyQuest", CSvrPushEvent)
CEventPushResetDailyQuest = CEventPushResetDailyQuest

function CEventPushResetDailyQuest:Constructor()
end

CEventPushResetDailyQuest._proto = {}
_class("CEventQuestDailyRefreshTime", CCallRequestEvent)
CEventQuestDailyRefreshTime = CEventQuestDailyRefreshTime

function CEventQuestDailyRefreshTime:Constructor()
end

CEventQuestDailyRefreshTime._proto = {}
_class("CEventQuestDailyRefreshTimeResult", CCallReplyEvent)
CEventQuestDailyRefreshTimeResult = CEventQuestDailyRefreshTimeResult

function CEventQuestDailyRefreshTimeResult:Constructor()
  self.next_refresh_time = 0
  self.week_next_refresh_time = 0
end

CEventQuestDailyRefreshTimeResult._proto = {
  [1] = {
    "next_refresh_time",
    "time"
  },
  [2] = {
    "week_next_refresh_time",
    "time"
  }
}
_class("CEventApplyAcceptQuest", CCallRequestEvent)
CEventApplyAcceptQuest = CEventApplyAcceptQuest

function CEventApplyAcceptQuest:Constructor()
  self.quest_id = 0
end

CEventApplyAcceptQuest._proto = {
  [1] = {"quest_id", "int"}
}
_class("CEventApplyAcceptQuestResult", CCallReplyEvent)
CEventApplyAcceptQuestResult = CEventApplyAcceptQuestResult

function CEventApplyAcceptQuestResult:Constructor()
  self.ret = 0
end

CEventApplyAcceptQuestResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventApplyNotify", CCallRequestEvent)
CEventApplyNotify = CEventApplyNotify

function CEventApplyNotify:Constructor()
  self.quest_id = 0
  self.notify_type = 0
  self.notify_count = 1
  self.param1 = 0
  self.param2 = 0
  self.param3 = 0
end

CEventApplyNotify._proto = {
  [1] = {"quest_id", "int"},
  [2] = {
    "notify_type",
    "int"
  },
  [3] = {
    "notify_count",
    "int"
  },
  [4] = {"param1", "int"},
  [5] = {"param2", "int"},
  [6] = {"param3", "int"}
}
_class("CEventApplyNotifyResult", CCallReplyEvent)
CEventApplyNotifyResult = CEventApplyNotifyResult

function CEventApplyNotifyResult:Constructor()
  self.ret = 0
end

CEventApplyNotifyResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventSetAchieve", CCallRequestEvent)
CEventSetAchieve = CEventSetAchieve

function CEventSetAchieve:Constructor()
end

CEventSetAchieve._proto = {}
_class("CEventSetAchieveResult", CCallReplyEvent)
CEventSetAchieveResult = CEventSetAchieveResult

function CEventSetAchieveResult:Constructor()
  self.ret = 0
end

CEventSetAchieveResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventSetVigorous", CCallRequestEvent)
CEventSetVigorous = CEventSetVigorous

function CEventSetVigorous:Constructor()
end

CEventSetVigorous._proto = {}
_class("CEventSetVigorousResult", CCallReplyEvent)
CEventSetVigorousResult = CEventSetVigorousResult

function CEventSetVigorousResult:Constructor()
  self.ret = 0
end

CEventSetVigorousResult._proto = {
  [1] = {"ret", "int"}
}
_class("CEventPushUnlockChapterQuest", CSvrPushEvent)
CEventPushUnlockChapterQuest = CEventPushUnlockChapterQuest

function CEventPushUnlockChapterQuest:Constructor()
  self.chapter_index = 0
end

CEventPushUnlockChapterQuest._proto = {
  [1] = {
    "chapter_index",
    "int"
  }
}
_class("CEventPushResetWeekQuest", CSvrPushEvent)
CEventPushResetWeekQuest = CEventPushResetWeekQuest

function CEventPushResetWeekQuest:Constructor()
end

CEventPushResetWeekQuest._proto = {}
_class("CEventPushWorldBossReset", CSvrPushEvent)
CEventPushWorldBossReset = CEventPushWorldBossReset

function CEventPushWorldBossReset:Constructor()
  self.boss_mission_id = 0
end

CEventPushWorldBossReset._proto = {
  [1] = {
    "boss_mission_id",
    "int"
  }
}
_class("CEventClientProcess", CCallRequestEvent)
CEventClientProcess = CEventClientProcess

function CEventClientProcess:Constructor()
  self.quest_id = 0
  self.num = 0
end

CEventClientProcess._proto = {
  [1] = {"quest_id", "int"},
  [2] = {"num", "int"}
}
_class("CEventClientProcessResult", CCallReplyEvent)
CEventClientProcessResult = CEventClientProcessResult

function CEventClientProcessResult:Constructor()
  self.ret = 0
  self.rewards = {}
end

CEventClientProcessResult._proto = {
  [1] = {"ret", "int"},
  [2] = {
    "rewards",
    "list<RoleAsset>"
  }
}
