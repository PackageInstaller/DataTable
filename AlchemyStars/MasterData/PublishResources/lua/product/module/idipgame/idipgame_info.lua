local IDIPBanType = {
  IDIPBan_Min = 0,
  IDIPBan_Account = 1,
  IDIPBan_Shutup = 2,
  IDIPBan_Nick = 3,
  IDIPBan_Signs = 4,
  IDIPBan_Teamdes = 5,
  IDIPBan_Max = 6
}
_enum("IDIPBanType", IDIPBanType)
local IDIPOtherType = {
  IDIPOther_Min = 0,
  IDIPOther_Nick = 1,
  IDIPOther_Signs = 2,
  IDIPOther_Teamdes = 3,
  IDIPOther_Max = 4
}
_enum("IDIPOtherType", IDIPOtherType)
_class("idip_ban_msg", Object)
idip_ban_msg = idip_ban_msg

function idip_ban_msg:Constructor()
  self.banacc_end_time = 0
  self.banacc_cause = ""
  self.shutup_end_time = 0
  self.shutup_cause = ""
  self.nick_end_time = 0
  self.nick_cause = ""
  self.signs_end_time = 0
  self.signs_cause = ""
  self.teamdes_end_time = 0
  self.teamdes_cause = ""
end

idip_ban_msg._proto = {
  [1] = {
    "banacc_end_time",
    "time"
  },
  [2] = {
    "banacc_cause",
    "string"
  },
  [3] = {
    "shutup_end_time",
    "time"
  },
  [4] = {
    "shutup_cause",
    "string"
  },
  [5] = {
    "nick_end_time",
    "time"
  },
  [6] = {"nick_cause", "string"},
  [7] = {
    "signs_end_time",
    "time"
  },
  [8] = {
    "signs_cause",
    "string"
  },
  [9] = {
    "teamdes_end_time",
    "time"
  },
  [10] = {
    "teamdes_cause",
    "string"
  }
}
