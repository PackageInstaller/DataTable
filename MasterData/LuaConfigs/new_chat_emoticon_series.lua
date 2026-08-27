local new_chat_emoticon_series = {
  {
    id = 1,
    series_icon = "Title_Expression_1"
  },
  {
    id = 2,
    series_icon = "Title_Expression_16"
  },
  [0] = {}
}
local __default_values = {
  id = 0,
  series_icon = "Title_Expression_0"
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(new_chat_emoticon_series) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(new_chat_emoticon_series, {__index = __rawdata})
return new_chat_emoticon_series
