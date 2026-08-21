local RANK_TYPE = {
  RANK_TYPE_INVALID = 0,
  RANK_TYPE_LEVEL = 1,
  RANK_TYPE_CONSUME = 2,
  RANK_TYPE_ACTIVE = 3,
  RANK_TYPE_WITH_TEST = 4,
  RANK_TYPE_END = 5
}
_enum("RANK_TYPE", RANK_TYPE)
local RANK_SER_RET_NO = {
  TR_SUCCESS = 0,
  TR_RANK_TYPE_ERR = 1,
  TR_PROC_ERR = 2,
  TR_RANK_NOT_INIT = 3
}
_enum("RANK_SER_RET_NO", RANK_SER_RET_NO)
_class("RankWrapBuff", Object)
RankWrapBuff = RankWrapBuff

function RankWrapBuff:Constructor()
  self.m_buff = ""
end

RankWrapBuff._proto = {
  [1] = {"m_buff", "buffer"}
}
_class("rank_role_info", Object)
rank_role_info = rank_role_info

function rank_role_info:Constructor()
end

rank_role_info._proto = {}
_class("rank_level", rank_role_info)
rank_level = rank_level

function rank_level:Constructor()
  self.pstid = 0
  self.value = 0
  self.enter_time = 0
end

rank_level._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"value", "int64"},
  [3] = {"enter_time", "time"}
}
_class("rank_level_whole", Object)
rank_level_whole = rank_level_whole

function rank_level_whole:Constructor()
  self.rank_base = rank_level:New()
  self.icon_head = ""
end

rank_level_whole._proto = {
  [1] = {"rank_base", "rank_level"},
  [2] = {"icon_head", "string"}
}
_class("rank_active", rank_role_info)
rank_active = rank_active

function rank_active:Constructor()
  self.pstid = 0
  self.value = 0
  self.enter_time = 0
end

rank_active._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"value", "int64"},
  [3] = {"enter_time", "time"}
}
_class("rank_active_whole", Object)
rank_active_whole = rank_active_whole

function rank_active_whole:Constructor()
  self.rank_base = rank_active:New()
  self.icon_head = ""
end

rank_active_whole._proto = {
  [1] = {
    "rank_base",
    "rank_active"
  },
  [2] = {"icon_head", "string"}
}
_class("rank_consume", rank_role_info)
rank_consume = rank_consume

function rank_consume:Constructor()
  self.pstid = 0
  self.value = 0
  self.enter_time = 0
  self.consume_type = 0
end

rank_consume._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"value", "int64"},
  [3] = {"enter_time", "time"},
  [4] = {
    "consume_type",
    "int"
  }
}
_class("rank_consume_whole", Object)
rank_consume_whole = rank_consume_whole

function rank_consume_whole:Constructor()
  self.rank_base = rank_consume:New()
  self.icon_head = ""
end

rank_consume_whole._proto = {
  [1] = {
    "rank_base",
    "rank_consume"
  },
  [2] = {"icon_head", "string"}
}
_class("rank_test_data", rank_role_info)
rank_test_data = rank_test_data

function rank_test_data:Constructor()
  self.pstid = 0
  self.value = 0
  self.enter_time = 0
  self.fill_data = "abcdefghigklmnabcdefghigklmnabcdefghigklmnabcdefghigklmnabcdefghigklmnabcdefghigklmnabcdefghigk"
end

rank_test_data._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"value", "int64"},
  [3] = {"enter_time", "time"},
  [4] = {"fill_data", "string"}
}
_class("rank_test_whole", Object)
rank_test_whole = rank_test_whole

function rank_test_whole:Constructor()
  self.rank_base = rank_test_data:New()
  self.icon_head = ""
end

rank_test_whole._proto = {
  [1] = {
    "rank_base",
    "rank_test_data"
  }
}
