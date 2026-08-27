local __rt_1 = {1}
local __rt_2 = {2}
local __rt_3 = {3}
local __rt_4 = {4}
local __rt_5 = {5}
local activity_bond_bond = {
  {
    {
      bond_des = 126301,
      bond_icon = "BondIcon_1",
      bond_id = 1,
      bond_name = 66324,
      bond_type = 1,
      id = 1,
      type_id = __rt_1
    },
    {
      bond_des = 70384,
      bond_icon = "BondIcon_2",
      bond_id = 2,
      bond_name = 359819,
      bond_type = 1,
      id = 1,
      type_id = __rt_2
    },
    {
      bond_des = 244823,
      bond_icon = "BondIcon_3",
      bond_id = 3,
      bond_name = 326679,
      bond_type = 1,
      id = 1,
      type_id = __rt_3
    },
    {
      bond_des = 29880,
      bond_icon = "BondIcon_4",
      bond_id = 4,
      bond_name = 83178,
      bond_type = 1,
      id = 1,
      type_id = __rt_4
    },
    {
      bond_des = 402220,
      bond_icon = "BondIcon_5",
      bond_id = 5,
      bond_name = 388173,
      bond_type = 1,
      id = 1,
      type_id = __rt_5
    },
    {
      bond_des = 471894,
      bond_icon = "BondIcon_6",
      bond_id = 6,
      bond_name = 387183,
      bond_type = 2,
      id = 1,
      type_id = __rt_1
    },
    {
      bond_des = 374287,
      bond_icon = "BondIcon_7",
      bond_id = 7,
      bond_name = "42Lab",
      bond_type = 2,
      id = 1,
      type_id = __rt_2
    },
    {
      bond_des = 8732,
      bond_icon = "BondIcon_8",
      bond_id = 8,
      bond_name = 23549,
      bond_type = 2,
      id = 1,
      type_id = __rt_3
    },
    {
      bond_des = 310255,
      bond_icon = "BondIcon_9",
      bond_id = 9,
      bond_name = 11829,
      bond_type = 2,
      id = 1,
      type_id = __rt_4
    },
    {
      bond_des = 207876,
      bond_icon = "BondIcon_10",
      bond_id = 10,
      bond_name = 444397,
      bond_type = 2,
      id = 1,
      type_id = __rt_5
    },
    {
      bond_des = 157340,
      bond_icon = "BondIcon_11",
      bond_id = 11,
      bond_name = "EXTRA",
      bond_type = 2,
      id = 1,
      type_id = {
        6,
        7,
        8
      }
    }
  }
}
local __default_values = {
  campBondDic = {
    6,
    7,
    8,
    9,
    10,
    11,
    11,
    11
  },
  careerBondDic = {
    1,
    2,
    3,
    4,
    5
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_bond_bond) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_bond_bond, {__index = __rawdata})
return activity_bond_bond
