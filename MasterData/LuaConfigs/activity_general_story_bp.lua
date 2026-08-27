local activity_general_story_bp = {
  {},
  {
    activity_id = 40002,
    id = 2,
    story_id = {
      4000301,
      4000302,
      4000303,
      4000304,
      4000305,
      4000306,
      4000307,
      4000308,
      4000309,
      4000310,
      4000311,
      4000312
    }
  }
}
local __default_values = {
  activity_id = 40001,
  id = 1,
  story_id = {
    4000101,
    4000102,
    4000103,
    4000104,
    4000105,
    4000106,
    4000107,
    4000108,
    4000109,
    4000110,
    4000111,
    4000112
  }
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_general_story_bp) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_general_story_bp, {__index = __rawdata})
return activity_general_story_bp
