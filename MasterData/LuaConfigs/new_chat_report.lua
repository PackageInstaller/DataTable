local new_chat_report = {
  {report_reason = 230343},
  {id = 2, report_reason = 180191},
  {id = 3, report_reason = 301315},
  {id = 4, report_reason = 398541},
  {id = 5, report_reason = 94780},
  {id = 6, report_reason = 271375},
  {id = 7},
  {id = 8, report_reason = 431933}
}
local __default_values = {id = 1, report_reason = 134726}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(new_chat_report) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(new_chat_report, {__index = __rawdata})
return new_chat_report
