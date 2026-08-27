local team_strategy_team = {
  [101] = {
    order_id = 50,
    team_des = 228659,
    team_id = 101,
    team_name = 407945
  },
  [102] = {
    order_id = 90,
    team_des = 514016,
    team_id = 102,
    team_name = 281264
  },
  [201] = {
    order_id = 89,
    team_des = 114378,
    team_id = 201
  },
  [301] = {
    order_id = 88,
    team_des = 262815,
    team_id = 301,
    team_name = 518549
  },
  [302] = {
    order_id = 87,
    team_des = 10615,
    team_id = 302,
    team_name = 469291
  },
  [401] = {
    order_id = 91,
    team_des = 234466,
    team_id = 401,
    team_name = 430399
  },
  [501] = {
    order_id = 40,
    team_des = 13571,
    team_id = 501,
    team_name = 369873
  },
  [502] = {
    order_id = 35,
    team_des = 10087,
    team_id = 502,
    team_name = 297712
  },
  [601] = {
    order_id = 21,
    team_id = 601,
    team_name = 453563
  },
  [701] = {
    order_id = 20,
    team_id = 701,
    team_name = 456507
  },
  [801] = {
    order_id = 15,
    team_id = 801,
    team_name = 430133
  },
  [901] = {
    order_id = 10,
    team_id = 901,
    team_name = 255270
  },
  [1001] = {team_name = 54161}
}
local __default_values = {
  is_hide = 0,
  order_id = 1,
  team_des = "",
  team_id = 1001,
  team_name = 234699
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(team_strategy_team) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(team_strategy_team, {__index = __rawdata})
return team_strategy_team
