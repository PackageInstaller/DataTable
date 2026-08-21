local ENUM_StarCount_Type = {
  E_StarCount_Lock = -1,
  E_StarCount_Unlock = 0,
  E_StarCount_Perfect = 3
}
_enum("ENUM_StarCount_Type", ENUM_StarCount_Type)
_class("DDbExtTask", Object)
DDbExtTask = DDbExtTask

function DDbExtTask:Constructor()
  self.m_nExtTaskID = 0
  self.m_nStarCount = 0
  self.m_tmActive = 0
  self.m_tmStart = 0
  self.m_tmEnd = 0
  self.m_nAwardRecord = 0
  self.m_nFailCount = 0
  self.m_vecCondition = {}
  self.m_nSuccessCount = 0
  self.pass_without_help = 0
end

DDbExtTask._proto = {
  [1] = {
    "m_nExtTaskID",
    "int"
  },
  [2] = {
    "m_nStarCount",
    "int"
  },
  [3] = {"m_tmActive", "time"},
  [4] = {"m_tmStart", "time"},
  [5] = {"m_tmEnd", "time"},
  [6] = {
    "m_nAwardRecord",
    "int"
  },
  [7] = {
    "m_nFailCount",
    "int"
  },
  [8] = {
    "m_vecCondition",
    "list<int>"
  },
  [9] = {
    "m_nSuccessCount",
    "int"
  },
  [10] = {
    "pass_without_help",
    "int"
  }
}
_class("extra_mission_data", Object)
extra_mission_data = extra_mission_data

function extra_mission_data:Constructor()
  self.pstid = 0
  self.ext_mission_id = 0
  self.ext_mission_time_active = 0
  self.ext_mission_time_alive = 0
  self.ext_mission_total_star = 0
  self.ext_award_record = 0
  self.task_count = 0
  self.task_data = {}
end

extra_mission_data._proto = {
  [1] = {"pstid", "int64"},
  [2] = {
    "ext_mission_id",
    "int"
  },
  [3] = {
    "ext_mission_time_active",
    "time"
  },
  [4] = {
    "ext_mission_time_alive",
    "time"
  },
  [5] = {
    "ext_mission_total_star",
    "int"
  },
  [6] = {
    "ext_award_record",
    "int"
  },
  [7] = {"task_count", "int"},
  [8] = {
    "task_data",
    "list<DDbExtTask>"
  }
}
_class("DSummaryExtTask", Object)
DSummaryExtTask = DSummaryExtTask

function DSummaryExtTask:Constructor()
  self.m_nExtTaskID = 0
  self.m_nStarCount = 0
end

DSummaryExtTask._proto = {
  [1] = {
    "m_nExtTaskID",
    "int"
  },
  [2] = {
    "m_nStarCount",
    "int"
  }
}
_class("DSummaryExtMission", Object)
DSummaryExtMission = DSummaryExtMission

function DSummaryExtMission:Constructor()
  self.m_nExtMissionID = 0
  self.m_nStarCount = 0
  self.m_nAwardRecord = 0
  self.m_vecExtTask = {}
end

DSummaryExtMission._proto = {
  [1] = {
    "m_nExtMissionID",
    "int"
  },
  [2] = {
    "m_nStarCount",
    "int"
  },
  [3] = {
    "m_nAwardRecord",
    "int"
  },
  [4] = {
    "m_vecExtTask",
    "list<DSummaryExtTask>"
  }
}
_class("DDetailExtTask", Object)
DDetailExtTask = DDetailExtTask

function DDetailExtTask:Constructor()
  self.m_nExtTaskID = 0
  self.m_nStarCount = 0
  self.m_nAwardRecord = 0
  self.m_nFailCount = 0
  self.m_vecCondition = {}
  self.pass_without_help = 0
end

DDetailExtTask._proto = {
  [1] = {
    "m_nExtTaskID",
    "int"
  },
  [2] = {
    "m_nStarCount",
    "int"
  },
  [3] = {
    "m_nAwardRecord",
    "int"
  },
  [4] = {
    "m_nFailCount",
    "int"
  },
  [5] = {
    "m_vecCondition",
    "list<int>"
  },
  [6] = {
    "pass_without_help",
    "int"
  }
}
_class("DDetailExtMission", Object)
DDetailExtMission = DDetailExtMission

function DDetailExtMission:Constructor()
  self.m_nExtMissionID = 0
  self.m_nStarCount = 0
  self.m_nAwardRecord = 0
  self.m_vecExtTask = {}
end

DDetailExtMission._proto = {
  [1] = {
    "m_nExtMissionID",
    "int"
  },
  [2] = {
    "m_nStarCount",
    "int"
  },
  [3] = {
    "m_nAwardRecord",
    "int"
  },
  [4] = {
    "m_vecExtTask",
    "list<DDetailExtTask>"
  }
}
_class("DExtStoryTask", Object)
DExtStoryTask = DExtStoryTask

function DExtStoryTask:Constructor()
  self.m_nExtTaskID = 0
  self.m_nExtStroyData = 0
end

DExtStoryTask._proto = {
  [1] = {
    "m_nExtTaskID",
    "int"
  },
  [2] = {
    "m_nExtStroyData",
    "int"
  }
}
_class("DExtStoryDataList", Object)
DExtStoryDataList = DExtStoryDataList

function DExtStoryDataList:Constructor()
  self.m_mapExtStory = {}
end

DExtStoryDataList._proto = {
  [1] = {
    "m_mapExtStory",
    "map<int,DExtStoryTask>"
  }
}
local EnumAwardRecord = {
  Disable = 0,
  Getting = 1,
  HaveDown = 2
}
_enum("EnumAwardRecord", EnumAwardRecord)
_class("UI_AwardLevel", Object)
UI_AwardLevel = UI_AwardLevel

function UI_AwardLevel:Constructor(nAwardRecord)
  self.m_nAwardRecord = nAwardRecord
  self.m_nAwardData = {}
  self.m_nAwardData[4] = math.floor(nAwardRecord / 16777216)
  self.m_nAwardData[3] = math.floor(math.fmod(nAwardRecord, 16777216) / 65536)
  self.m_nAwardData[2] = math.floor(math.fmod(nAwardRecord, 65536) / 256)
  self.m_nAwardData[1] = math.fmod(nAwardRecord, 256)
  self.m_nAwardLevel = {
    [1] = 0,
    [2] = 6,
    [3] = 12,
    [4] = 18
  }
end

function UI_AwardLevel:GetAwardIndex(nStarCount)
  if nStarCount < self.m_nAwardLevel[2] then
    return 1
  elseif nStarCount >= self.m_nAwardLevel[2] and nStarCount < self.m_nAwardLevel[3] then
    return 2
  elseif nStarCount >= self.m_nAwardLevel[3] and nStarCount < self.m_nAwardLevel[4] then
    return 3
  else
    return 4
  end
end

function UI_AwardLevel:GetAwardStat(nStarCount, nCfgStarCount)
  local nIndex = self:GetAwardIndex(nCfgStarCount)
  local nReturn = EnumAwardRecord.Disable
  if self.m_nAwardData[nIndex] > 0 then
    nReturn = EnumAwardRecord.HaveDown
  elseif nStarCount >= self.m_nAwardLevel[nIndex] then
    nReturn = EnumAwardRecord.Getting
  else
    nReturn = EnumAwardRecord.Disable
  end
  return nReturn
end

function UI_AwardLevel:IsHaveAward(nStarCount)
  local nLevelCount = #self.m_nAwardData
  for i = 2, nLevelCount do
    if nStarCount >= self.m_nAwardLevel[i] and self.m_nAwardData[i] <= 0 then
      return true
    end
  end
  return false
end

_class("UI_DetailExtAward", Object)
UI_DetailExtAward = UI_DetailExtAward

function UI_DetailExtAward:Constructor()
  self.m_nStarCount = 0
  self.m_nAwardStat = 0
  self.m_vecAwardItem = {}
end

_class("UI_DetailExtMission", Object)
UI_DetailExtMission = UI_DetailExtMission

function UI_DetailExtMission:Constructor()
  self.m_nID = 0
  self.m_stName = ""
  self.m_nStarCount = 0
  self.m_vecAward = {}
end

_class("UI_DetailExtCondition", Object)
UI_DetailExtCondition = UI_DetailExtCondition

function UI_DetailExtCondition:Constructor()
  self.m_nID = 0
  self.m_nParam = 0
  self.m_stDest = ""
  self.m_bPass = false
end

_class("UI_DetailExtTask", Object)
UI_DetailExtTask = UI_DetailExtTask

function UI_DetailExtTask:Constructor()
  self.m_nID = 0
  self.m_stName = ""
  self.m_stExtName = ""
  self.m_stDesc = ""
  self.m_nStarCount = 0
  self.m_vecCondition = {}
  self.m_awardNormal = UI_DetailExtAward:New()
  self.m_awardNormal.m_nStarCount = 1
  self.m_awardPerfect = UI_DetailExtAward:New()
  self.m_awardPerfect.m_nStarCount = 3
  self.m_nExpendPower = 0
end

local EnumExtraCloseType = {Stage = 0, level = 1}
_enum("EnumExtraCloseType", EnumExtraCloseType)
local RotateDirEnum = {
  None = 0,
  Left = 1,
  Right = 2
}
_enum("RotateDirEnum", RotateDirEnum)
local StageActionType = {Fight = 0, Conversation = 1}
_enum("StageActionType", StageActionType)
