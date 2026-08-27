local banner = {
  {},
  {
    id = 2,
    jump = "https://wj.qq.com/s2/7914217/0ad5",
    pic = "survey"
  }
}
local __default_values = {
  channel = 3,
  id = 1,
  jump = "https://wj.qq.com/s2/7914206/ad81",
  pic = "bug_feedback",
  type = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(banner) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(banner, {__index = __rawdata})
return banner
