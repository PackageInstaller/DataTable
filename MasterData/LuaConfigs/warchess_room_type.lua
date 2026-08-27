local warchess_room_type = {
  {type_name = 77830},
  {type_id = 2, type_name = 8064},
  {type_id = 3, type_name = 399082},
  {type_id = 4},
  {type_id = 5, type_name = 63912},
  {type_id = 6, type_name = 482816},
  {type_id = 7, type_name = 399524},
  {type_id = 8, type_name = 401483}
}
local __default_values = {type_id = 1, type_name = 130375}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(warchess_room_type) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(warchess_room_type, {__index = __rawdata})
return warchess_room_type
