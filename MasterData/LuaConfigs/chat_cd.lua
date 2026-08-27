local chat_cd = {
  {message = 3},
  {
    id = 2,
    message = 5,
    time = 20
  },
  {
    id = 3,
    message = 7,
    time = 30
  },
  {id = 4, time = 60},
  {
    id = 5,
    message = 300,
    time = 900
  }
}
local __default_values = {
  id = 1,
  message = 10,
  time = 10
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(chat_cd) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(chat_cd, {__index = __rawdata})
return chat_cd
