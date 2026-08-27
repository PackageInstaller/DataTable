local __rt_1 = {}
local event_assist_ex = {
  {describe = 442013},
  {
    describe = 310242,
    id = 2,
    replace_txt = 600002
  },
  {
    describe = 472326,
    id = 3,
    replace_txt = 600003
  },
  {id = 4, replace_txt = 600004},
  {
    describe = 496232,
    id = 5,
    replace_txt = 600005
  },
  {
    describe = 442013,
    id = 6,
    replace_txt = 600006
  },
  {
    describe = 310242,
    id = 7,
    replace_txt = 600007
  },
  {
    describe = 472326,
    id = 8,
    replace_txt = 600008
  },
  {id = 9, replace_txt = 600009},
  {
    describe = 496232,
    id = 10,
    replace_txt = 600010
  }
}
local __default_values = {
  auto_choice_arg = __rt_1,
  auto_choice_type = 0,
  auto_priority = 0,
  choice_color = false,
  describe = 255199,
  icon = "event_icon_help",
  id = 1,
  replace_txt = 600001
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(event_assist_ex) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(event_assist_ex, {__index = __rawdata})
return event_assist_ex
