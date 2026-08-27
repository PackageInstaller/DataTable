local recommend_dialogue = {
  {
    action = "wait_1",
    audio = "riko_WAIT1",
    id = 1
  },
  {
    action = "wait_2",
    audio = "riko_WAIT2",
    id = 2,
    text = 395247
  },
  {
    action = "login_1",
    audio = "riko_LOGIN",
    id = 3,
    text = 218444
  },
  {
    action = "login_2",
    audio = "riko_LOGIN2",
    id = 4,
    text = 503255
  },
  {id = 5, text = 295721},
  {
    action = "buy_2",
    audio = "riko_BUY2",
    id = 6,
    text = 337330
  },
  {
    action = "buy_3",
    audio = "riko_BUY3",
    id = 7,
    text = 441218
  },
  {
    action = "buy_4",
    audio = "riko_BUY4",
    id = 8,
    text = 422893
  },
  {
    action = "touch_1",
    audio = "riko_TOUCH_1",
    id = 9,
    text = 374936
  },
  {
    action = "touch_2",
    audio = "riko_TOUCH_2",
    id = 10,
    text = 141801
  },
  {
    action = "touch_3",
    audio = "riko_TOUCH_3",
    id = 11,
    text = 165208
  },
  [0] = {
    action = "wait_0",
    audio = "riko_NORMAL1",
    text = 147252
  }
}
local __default_values = {
  action = "buy_1",
  audio = "riko_BUY1",
  id = 0,
  text = 105942
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(recommend_dialogue) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  actionMapping = {
    buy_1 = {5},
    buy_2 = {6},
    buy_3 = {7},
    buy_4 = {8},
    login_1 = {3},
    login_2 = {4},
    touch_1 = {9},
    touch_2 = {10},
    touch_3 = {11},
    wait_0 = {0},
    wait_1 = {1},
    wait_2 = {2}
  },
  defaultCvId = 0,
  loginCvIdList = {3, 4}
}
setmetatable(recommend_dialogue, {__index = __rawdata})
return recommend_dialogue
