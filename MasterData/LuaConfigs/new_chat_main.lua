local new_chat_main = {
  {}
}
local __default_values = {
  blacklist_max = 20,
  id = 1,
  message_num = 10000,
  often_emoticon_num = 9,
  recent_max = 20,
  report_daily_max = 10,
  report_word_max = 100,
  show_time_cd = 36000,
  speak_cd = 1,
  speak_warning = 5,
  speak_word_max = 60
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(new_chat_main) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(new_chat_main, {__index = __rawdata})
return new_chat_main
