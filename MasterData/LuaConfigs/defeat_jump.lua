local __rt_1 = {}
local defeat_jump = {
  {des = 294611, pic_path = "Failure0"},
  {
    des = 421939,
    id = 2,
    jump_arg = {11001}
  },
  {
    id = 3,
    jump_id = 28,
    pic_path = "Failure_win21"
  },
  {des = 41522, id = 4},
  {
    id = 5,
    jump_arg = {11002},
    jump_id = 28,
    pic_path = "Failure_win21"
  }
}
local __default_values = {
  des = 411239,
  id = 1,
  jump_arg = __rt_1,
  jump_id = 7,
  pic_path = "Failure1"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(defeat_jump) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(defeat_jump, {__index = __rawdata})
return defeat_jump
