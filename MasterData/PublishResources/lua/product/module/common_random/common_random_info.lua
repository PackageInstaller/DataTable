local RandomType = {
  RANDOM_NO_TYPE = 0,
  RANDOM_FIXED = 1,
  RANDOM_REAL = 2,
  RANDOM_ARRAYS = 3,
  RANDOM_SEED = 4,
  RANDOM_TIMES = 5,
  RANDOM_BYLEVEL = 6,
  RANDOM_BYSIGN = 7,
  RANDOM_BYDATE = 8,
  RANDOM_COARRAY = 9,
  RANDOM_CUMULATE = 10,
  RANDOM_ONCE = 11,
  RANDOM_NOTINCLUDEPET = 12,
  RANDOM_DELAY_REFRESH_ARRAYS = 51,
  RANDOM_DELAY_REFRESH_CORARRAY = 52
}
_enum("RandomType", RandomType)
local OverdueType = {
  OVERDUE_DAY = 1,
  OVERDUE_SECOND = 2,
  OVERDUE_UNTIL = 3,
  OVERDUE_AFTER_ZERO_SECOND = 4
}
_enum("OverdueType", OverdueType)
local FishForStateType = {
  FFST_Inirate = 1001,
  FFST_AddRate = 1002,
  FFST_Active = 1003,
  FFST_Step = 1004,
  FFST_Maxtime = 1005,
  FFST_NormalCounter = 1006,
  FFST_ArrayAllCcounterNum = 2000,
  FFST_NextRefreshTime = 2001
}
_enum("FishForStateType", FishForStateType)
local UninitializedParam = {PARAM_UNINITIALIZED = -1}
_enum("UninitializedParam", UninitializedParam)
local JumpTimeMax = {MAX_JUMP_TIME = 100}
_enum("JumpTimeMax", JumpTimeMax)
_class("CommonOutput", Object)
CommonOutput = CommonOutput

function CommonOutput:Constructor()
  self.id = -1
  self.count = -1
  self.source_rule_id = -1
end

CommonOutput._proto = {
  [1] = {"id", "int"},
  [2] = {"count", "int"},
  [3] = {
    "source_rule_id",
    "int"
  }
}
local EJumpPick = {
  EJumpPick_Invalid = 0,
  EJumpPick_Random = 1,
  EJumpPick_End = 2
}
_enum("EJumpPick", EJumpPick)
_class("FixedRuleParam", Object)
FixedRuleParam = FixedRuleParam

function FixedRuleParam:Constructor()
  self.output = -1
  self.amount = {}
  self.density = -1
  self.jump = -1
  self.redouble = -1
  self.redo = -1
  self.uniq = -1
  self.jumppick = -1
  self.jpejmp = -1
end

FixedRuleParam._proto = {
  [1] = {"output", "int"},
  [2] = {"amount", "list<int>"},
  [3] = {"density", "int"},
  [4] = {"jump", "int"},
  [5] = {"redouble", "int"},
  [6] = {"redo", "int"},
  [7] = {"uniq", "int"},
  [8] = {"jumppick", "int"},
  [9] = {"jpejmp", "int"}
}
_class("RealRandomRuleParam", Object)
RealRandomRuleParam = RealRandomRuleParam

function RealRandomRuleParam:Constructor()
  self.context = {}
  self.weight = -1
end

RealRandomRuleParam._proto = {
  [1] = {
    "context",
    "list<FixedRuleParam>"
  },
  [2] = {"weight", "int"}
}
_class("ArrayRandomRuleParam", Object)
ArrayRandomRuleParam = ArrayRandomRuleParam

function ArrayRandomRuleParam:Constructor()
  self.copy = -1
  self.weight = -1
  self.context = {}
end

ArrayRandomRuleParam._proto = {
  [1] = {"copy", "int"},
  [2] = {"weight", "int"},
  [3] = {
    "context",
    "list<FixedRuleParam>"
  }
}
_class("CoarrayRandomRuleParam", Object)
CoarrayRandomRuleParam = CoarrayRandomRuleParam

function CoarrayRandomRuleParam:Constructor()
  self.include = -1
end

CoarrayRandomRuleParam._proto = {
  [1] = {"include", "int"}
}
_class("SeedRandomRuleParam", Object)
SeedRandomRuleParam = SeedRandomRuleParam

function SeedRandomRuleParam:Constructor()
  self.pot = {}
  self.densp = -1
  self.copy = {}
  self.densc = -1
  self.hit = {}
  self.miss = {}
end

SeedRandomRuleParam._proto = {
  [1] = {"pot", "list<int>"},
  [2] = {"densp", "int"},
  [3] = {"copy", "list<int>"},
  [4] = {"densc", "int"},
  [5] = {
    "hit",
    "list<FixedRuleParam>"
  },
  [6] = {
    "miss",
    "list<FixedRuleParam>"
  }
}
_class("OnceRandomRuleParam", Object)
OnceRandomRuleParam = OnceRandomRuleParam

function OnceRandomRuleParam:Constructor()
  self.weight = -1
  self.context = {}
end

OnceRandomRuleParam._proto = {
  [1] = {"weight", "int"},
  [2] = {
    "context",
    "list<FixedRuleParam>"
  }
}
_class("ExtendParam", Object)
ExtendParam = ExtendParam

function ExtendParam:Constructor()
  self.day = -1
  self.second = -1
  self.until_ = -1
  self.afterzerosecond = -1
end

ExtendParam._proto = {
  [1] = {"day", "int"},
  [2] = {"second", "int"},
  [3] = {"until_", "int"},
  [4] = {
    "afterzerosecond",
    "int"
  }
}
_class("CumulateRandomParam", Object)
CumulateRandomParam = CumulateRandomParam

function CumulateRandomParam:Constructor()
  self.accumulator = ""
  self.inirate = 0
  self.hit = {}
  self.miss = {}
  self.active = 0
  self.step = 0
  self.addrate = 0
  self.maxtime = 100
  self.uplimit = 0
  self.downlimit = 0
  self.nippid = 0
end

CumulateRandomParam._proto = {
  [1] = {
    "accumulator",
    "string"
  },
  [2] = {"inirate", "int"},
  [3] = {
    "hit",
    "list<FixedRuleParam>"
  },
  [4] = {
    "miss",
    "list<FixedRuleParam>"
  },
  [5] = {"active", "int"},
  [6] = {"step", "int"},
  [7] = {"addrate", "int"},
  [8] = {"maxtime", "int"},
  [9] = {"uplimit", "int"},
  [10] = {"downlimit", "int"},
  [11] = {"nippid", "int"}
}
_class("NotIncludePetRandomParam", Object)
NotIncludePetRandomParam = NotIncludePetRandomParam

function NotIncludePetRandomParam:Constructor()
  self.empty = FixedRuleParam:New()
  self.pool = {}
end

NotIncludePetRandomParam._proto = {
  [1] = {
    "empty",
    "FixedRuleParam"
  },
  [2] = {"pool", "list<int>"}
}
_class("ArraysRandomCounter", Object)
ArraysRandomCounter = ArraysRandomCounter

function ArraysRandomCounter:Constructor()
  self.generate_time = 0
  self.copy = {}
end

ArraysRandomCounter._proto = {
  [1] = {
    "generate_time",
    "time"
  },
  [2] = {"copy", "list<int>"}
}
_class("ActiveRefreshArraysRandomCounter", Object)
ActiveRefreshArraysRandomCounter = ActiveRefreshArraysRandomCounter

function ActiveRefreshArraysRandomCounter:Constructor()
  self.generate_time = 0
  self.copy = {}
  self.counter_zero_time = 0
end

ActiveRefreshArraysRandomCounter._proto = {
  [1] = {
    "generate_time",
    "time"
  },
  [2] = {"copy", "list<int>"},
  [3] = {
    "counter_zero_time",
    "time"
  }
}
_class("SeedRandomCounter", Object)
SeedRandomCounter = SeedRandomCounter

function SeedRandomCounter:Constructor()
  self.generate_time = 0
  self.award_ball_count = 0
  self.pool_ball_count = 0
end

SeedRandomCounter._proto = {
  [1] = {
    "generate_time",
    "time"
  },
  [2] = {
    "award_ball_count",
    "int"
  },
  [3] = {
    "pool_ball_count",
    "int"
  }
}
_class("TimesRandomCounter", Object)
TimesRandomCounter = TimesRandomCounter

function TimesRandomCounter:Constructor()
  self.generate_time = 0
  self.played_times = 0
end

TimesRandomCounter._proto = {
  [1] = {
    "generate_time",
    "time"
  },
  [2] = {
    "played_times",
    "int"
  }
}
_class("NIPPRandomCounter", Object)
NIPPRandomCounter = NIPPRandomCounter

function NIPPRandomCounter:Constructor()
  self.generate_time = 0
  self.played_times = 0
end

NIPPRandomCounter._proto = {
  [1] = {
    "generate_time",
    "time"
  },
  [2] = {
    "played_times",
    "int"
  }
}
_class("CumulateParam", Object)
CumulateParam = CumulateParam

function CumulateParam:Constructor()
  self.normal_counter = 0
  self.downlimit_counter = 0
end

CumulateParam._proto = {
  [1] = {
    "normal_counter",
    "int"
  },
  [2] = {
    "downlimit_counter",
    "int"
  }
}
_class("OnceRandomCounter", Object)
OnceRandomCounter = OnceRandomCounter

function OnceRandomCounter:Constructor()
  self.generate_time = 0
  self.comfirm_index = -1
end

OnceRandomCounter._proto = {
  [1] = {
    "generate_time",
    "time"
  },
  [2] = {
    "comfirm_index",
    "int"
  }
}
_class("CommonCounter", Object)
CommonCounter = CommonCounter

function CommonCounter:Constructor()
  self.random_type = 0
  self.counter_data = ""
end

CommonCounter._proto = {
  [1] = {
    "random_type",
    "int"
  },
  [2] = {
    "counter_data",
    "buffer"
  }
}
_class("all_counter_data", Object)
all_counter_data = all_counter_data

function all_counter_data:Constructor()
  self.pstid = 0
  self.all_random_counter = {}
  self.name2counter = {}
end

all_counter_data._proto = {
  [1] = {"pstid", "int64"},
  [2] = {
    "all_random_counter",
    "map<int,CommonCounter>"
  },
  [3] = {
    "name2counter",
    "map<string,CumulateParam>"
  }
}
_class("OptionDataInfo", Object)
OptionDataInfo = OptionDataInfo

function OptionDataInfo:Constructor()
  self.param_infos = {}
end

OptionDataInfo._proto = {
  [1] = {
    "param_infos",
    "list<int>"
  }
}
_class("OptionalData", Object)
OptionalData = OptionalData

function OptionalData:Constructor()
  self.param_pool = {}
  self.times = 0
end

OptionalData._proto = {
  [1] = {
    "param_pool",
    "map<int,OptionDataInfo>"
  },
  [2] = {"times", "int"}
}
