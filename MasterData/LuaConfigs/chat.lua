local chat = {
  {name = 371728},
  {id = 2, screening = true}
}
local __default_values = {
  id = 1,
  name = 153555,
  screening = false
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(chat) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(chat, {__index = __rawdata})
return chat
