local homeside_info = {
  {
    describe = 102717,
    icon = "notice_Mail",
    switch_name = 239894,
    switch_type = 1,
    title = 413834,
    type = 3
  },
  {
    describe = 109563,
    icon = "notice_Achievement",
    id = 2,
    info_type = 0,
    switch_name = 237651,
    title = 399288
  },
  {
    describe = 98843,
    icon = "notice_OasisBuilding",
    id = 3,
    info_type = 0,
    switch_name = 14065,
    title = 207152
  },
  {
    describe = 430177,
    icon = "notice_SectorBuilding",
    id = 4,
    info_type = 0,
    switch_name = 14065,
    title = 95522
  },
  {
    describe = 241433,
    icon = "notice_CollectRes",
    id = 5,
    info_type = 0,
    put_in_homeside = true,
    switch_name = 413151,
    title = 84185,
    type = 3
  },
  {
    describe = 80406,
    icon = "notice_OasisBuilding",
    id = 6,
    put_in_homeside = true,
    switch_name = 70675,
    switch_type = 3,
    title = 104709
  },
  {
    describe = 89936,
    icon = "notice_SectorBuilding",
    id = 7,
    put_in_homeside = true,
    switch_name = 268102,
    switch_type = 4,
    title = 516921
  },
  {
    describe = 315207,
    icon = "notice_FrgDungeonRefresh",
    id = 8,
    is_reddot = true,
    put_in_homeside = true,
    switch_name = 18753,
    switch_type = 6,
    title = 18753
  },
  {
    describe = 329752,
    icon = "notice_ResDungeonRefresh",
    id = 9,
    info_type = 0,
    switch_name = 131260,
    title = 131260
  },
  {
    describe = 236068,
    icon = "notice_FrgDungeonRefresh",
    id = 10,
    info_type = 0,
    switch_name = 105999,
    title = 194725
  },
  {
    describe = 37466,
    id = 11,
    info_type = 0,
    switch_name = 510413
  },
  {
    describe = 307370,
    id = 12,
    info_type = 0,
    switch_name = 439705
  },
  {
    describe = 139132,
    id = 13,
    is_reddot = true,
    put_in_homeside = true,
    switch_name = 439705,
    switch_type = 7,
    type = 3
  },
  {
    describe = 458926,
    icon = "notice_ResDungeonRefresh",
    id = 14,
    info_type = 0,
    is_reddot = true,
    put_in_homeside = true,
    switch_name = 493231,
    title = 338649
  },
  {
    describe = 67240,
    icon = "notice_Unlock",
    id = 15,
    title = 474690,
    type = 2
  },
  {
    describe = 326696,
    id = 16,
    put_in_homeside = true,
    type = 3
  },
  {
    describe = 301652,
    id = 17,
    is_merge = true,
    type = 3
  },
  {
    describe = 493143,
    icon = "notice_OasisBuilding",
    id = 18,
    put_in_homeside = true,
    title = 104709,
    type = 3
  },
  {
    describe = 282634,
    icon = "notice_OasisBuilding",
    id = 19,
    put_in_homeside = true,
    title = 104709,
    type = 3
  },
  {
    icon = "notice_Achievement",
    id = 20,
    put_in_homeside = true,
    switch_name = 237651,
    switch_type = 2,
    title = 399288,
    type = 1
  },
  {
    icon = "notice_Task",
    id = 21,
    title = 115947,
    type = 3
  },
  {
    describe = 166263,
    icon = "notice_SectorBuilding",
    id = 22,
    title = 516921,
    type = 3
  },
  {
    describe = 399023,
    icon = "notice_LevelUp",
    id = 23,
    title = 373129,
    type = 1
  },
  {
    describe = 384891,
    icon = "notice_ResDungeonRefresh",
    id = 24,
    is_reddot = true,
    put_in_homeside = true,
    switch_name = 285774,
    switch_type = 6,
    title = 82634
  },
  {
    describe = 391949,
    icon = "notice_ResDungeonRefresh",
    id = 25,
    put_in_homeside = true,
    switch_name = 291774,
    switch_type = 6,
    title = 177172
  },
  {
    describe = 431188,
    icon = "notice_ResDungeonRefresh",
    id = 26,
    is_reddot = true,
    put_in_homeside = true,
    switch_name = 453937,
    switch_type = 6,
    title = 504645
  },
  {
    describe = 37427,
    icon = "notice_Unlock",
    id = 27,
    title = 268004,
    type = 2
  },
  {
    describe = 67240,
    icon = "notice_Unlock",
    id = 28,
    is_reddot = true,
    put_in_homeside = true,
    title = 143955,
    type = 3
  },
  {
    describe = 170546,
    icon = "",
    id = 29,
    switch_name = 87744,
    title = 70080,
    type = 4
  },
  {
    describe = "%s",
    icon = "",
    id = 30,
    switch_name = 25819,
    title = 119896,
    type = 5
  },
  [100] = {
    describe = 192918,
    icon = "",
    id = 100,
    switch_name = 116633,
    switch_type = 100,
    title = 192918,
    unlock_for_setting = 2803
  },
  [101] = {
    describe = 64409,
    icon = "",
    id = 101,
    switch_name = 309812,
    switch_type = 101,
    title = 64409,
    unlock_for_setting = 6300
  }
}
local __default_values = {
  describe = 321024,
  icon = "notice_Factory",
  id = 1,
  info_type = 1,
  is_merge = false,
  is_reddot = false,
  put_in_homeside = false,
  switch_name = "",
  switch_type = 0,
  title = 512101,
  type = 0,
  unlock_for_setting = 0
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(homeside_info) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(homeside_info, {__index = __rawdata})
return homeside_info
