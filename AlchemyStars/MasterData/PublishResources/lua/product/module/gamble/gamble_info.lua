_class("PrizePoolInfo", Object)
PrizePoolInfo = PrizePoolInfo

function PrizePoolInfo:Constructor()
  self.prize_pool_id = 0
  self.seq_id = 0
  self.cost1_id = 0
  self.cost2_id = 0
  self.one_shake_price1 = 0
  self.one_shake_price2 = 0
  self.one_shake_discount1_price = 0
  self.one_shake_discount2_price = 0
  self.multiple_shake_price1 = 0
  self.multiple_shake_price2 = 0
  self.multiple_shake_times = 0
  self.multiple_shake_discount1_price = 0
  self.multiple_shake_discount2_price = 0
  self.performance_id = 0
  self.close_type = 0
  self.extend_data = 0
  self.open_time = 0
  self.prize_pool_type = 0
  self.close_condition2 = 0
  self.remain_free_count = 0
  self.next_refresh_free_time = 0
  self.free_campaign_end_time = 0
  self.mul_remain_free_count = 0
  self.mul_next_refresh_free_time = 0
  self.mul_free_campaign_end_time = 0
  self.pre_use_ticket = 0
  self.prize_group_id = 0
end

PrizePoolInfo._proto = {
  [1] = {
    "prize_pool_id",
    "int"
  },
  [2] = {"seq_id", "int"},
  [3] = {"cost1_id", "int"},
  [4] = {"cost2_id", "int"},
  [5] = {
    "one_shake_price1",
    "int"
  },
  [6] = {
    "one_shake_price2",
    "int"
  },
  [7] = {
    "one_shake_discount1_price",
    "int"
  },
  [8] = {
    "one_shake_discount2_price",
    "int"
  },
  [9] = {
    "multiple_shake_price1",
    "int"
  },
  [10] = {
    "multiple_shake_price2",
    "int"
  },
  [11] = {
    "multiple_shake_times",
    "int"
  },
  [12] = {
    "multiple_shake_discount1_price",
    "int"
  },
  [13] = {
    "multiple_shake_discount2_price",
    "int"
  },
  [14] = {
    "performance_id",
    "int"
  },
  [15] = {"close_type", "int"},
  [16] = {
    "extend_data",
    "int"
  },
  [17] = {"open_time", "int"},
  [18] = {
    "prize_pool_type",
    "int"
  },
  [19] = {
    "close_condition2",
    "time"
  },
  [20] = {
    "remain_free_count",
    "int"
  },
  [21] = {
    "next_refresh_free_time",
    "time"
  },
  [22] = {
    "free_campaign_end_time",
    "time"
  },
  [23] = {
    "mul_remain_free_count",
    "int"
  },
  [24] = {
    "mul_next_refresh_free_time",
    "time"
  },
  [25] = {
    "mul_free_campaign_end_time",
    "time"
  },
  [26] = {
    "pre_use_ticket",
    "int"
  },
  [27] = {
    "prize_group_id",
    "int"
  }
}
local EPrizePoolExtInfoType = {EPPEIT_NIPP = 0, EPPEIT_OPP = 1}
_enum("EPrizePoolExtInfoType", EPrizePoolExtInfoType)
_class("PrizePoolExternInfo", Object)
PrizePoolExternInfo = PrizePoolExternInfo

function PrizePoolExternInfo:Constructor()
  self.param_pool = {}
  self.times = 0
  self.id = 0
end

PrizePoolExternInfo._proto = {
  [1] = {"param_pool", "list<int>"},
  [2] = {"times", "int"},
  [3] = {"id", "int"}
}
_class("PrizePoolShakedTime", Object)
PrizePoolShakedTime = PrizePoolShakedTime

function PrizePoolShakedTime:Constructor()
  self.pool_2_time = {}
end

PrizePoolShakedTime._proto = {
  [1] = {
    "pool_2_time",
    "map<int,int>"
  }
}
_class("FreeTimeInfo", Object)
FreeTimeInfo = FreeTimeInfo

function FreeTimeInfo:Constructor()
  self.last_refresh_time = 0
  self.remain_times = 0
  self.mul_last_refresh_time = 0
  self.mul_remain_times = 0
end

FreeTimeInfo._proto = {
  [1] = {
    "last_refresh_time",
    "time"
  },
  [2] = {
    "remain_times",
    "int"
  },
  [3] = {
    "mul_last_refresh_time",
    "time"
  },
  [4] = {
    "mul_remain_times",
    "int"
  }
}
_class("RemainShakedTime", Object)
RemainShakedTime = RemainShakedTime

function RemainShakedTime:Constructor()
  self.pool_2_info = {}
end

RemainShakedTime._proto = {
  [1] = {
    "pool_2_info",
    "map<int,FreeTimeInfo>"
  }
}
_class("special_pool_data", Object)
special_pool_data = special_pool_data

function special_pool_data:Constructor()
  self.pool_id = 0
  self.begin_time = 0
  self.end_time = 0
end

special_pool_data._proto = {
  [1] = {"pool_id", "int"},
  [2] = {"begin_time", "time"},
  [3] = {"end_time", "time"}
}
_class("special_pool", Object)
special_pool = special_pool

function special_pool:Constructor()
  self.pools = {}
end

special_pool._proto = {
  [1] = {
    "pools",
    "map<int,special_pool_data>"
  }
}
