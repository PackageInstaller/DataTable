local activity_bond_transfer_buff = {
  {buff_name = 467708},
  {
    buff_des = 396853,
    buff_effect = {
      [2] = 4
    },
    buff_icon = "BondExIcon_2",
    buff_name = 47125,
    transfer_buff_id = 2
  },
  {
    buff_des = 45497,
    buff_effect = {
      [3] = 1
    },
    buff_icon = "BondExIcon_3",
    transfer_buff_id = 3
  },
  {
    buff_des = 75536,
    buff_effect = {
      [4] = 3
    },
    buff_icon = "BondExIcon_4",
    buff_name = 269717,
    transfer_buff_id = 4
  }
}
local __default_values = {
  buff_des = 145514,
  buff_effect = {2},
  buff_icon = "BondExIcon_1",
  buff_name = 135855,
  transfer_buff_id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_bond_transfer_buff) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_bond_transfer_buff, {__index = __rawdata})
return activity_bond_transfer_buff
