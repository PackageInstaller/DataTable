local __rt_1 = {
  [1002] = 50
}
local share = {
  [100] = {picture_route = ""},
  [26001] = {
    id = 26001,
    picture_route = "Invitation/UI_EventInvitationPrtSc_1.jpg"
  },
  [26002] = {id = 26002},
  [26003] = {
    id = 26003,
    picture_route = "Invitation/UI_EventInvitationPrtSc_3.png"
  },
  [26004] = {
    id = 26004,
    picture_route = "Invitation/UI_EventInvitationPrtSc_4.png"
  },
  [26005] = {
    id = 26005,
    picture_route = "Invitation/UI_EventInvitationPrtSc_7.png"
  },
  [26006] = {
    id = 26006,
    picture_route = "Invitation/UI_EventInvitationPrtSc_8.png"
  },
  [33001] = {
    id = 33001,
    picture_route = "Carnival23/UI_Carnival23SharePrtSc_1.png"
  },
  [33002] = {
    id = 33002,
    picture_route = "Carnival23/UI_Carnival23SharePrtSc_1.png"
  },
  [33003] = {id = 33003},
  [33004] = {
    id = 33004,
    picture_route = "Invitation/UI_EventInvitationPrtSc_3.png"
  },
  [33005] = {id = 33005},
  [33006] = {
    id = 33006,
    picture_route = "Invitation/UI_EventInvitationPrtSc_8.png"
  },
  [40002] = {
    id = 40002,
    picture_route = "Invitation/UI_EventInvitationPrtSc_6.png"
  },
  [45001] = {
    id = 45001,
    picture_route = "Invitation/UI_EventInvitationPrtSc_4.png"
  },
  [51001] = {
    id = 51001,
    picture_route = "Invitation/UI_EventInvitationPrtSc_5.png"
  },
  [56001] = {
    id = 56001,
    picture_route = "Invitation/UI_EventInvitationPrtSc_7.png"
  },
  [59001] = {
    id = 59001,
    picture_route = "Invitation/UI_EventInvitationPrtSc_9.png"
  }
}
local __default_values = {
  id = 100,
  picture_route = "Invitation/UI_EventInvitationPrtSc_2.png",
  reward = __rt_1,
  reward_num = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(share) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(share, {__index = __rawdata})
return share
