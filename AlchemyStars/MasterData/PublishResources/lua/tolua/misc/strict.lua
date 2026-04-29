local getinfo, error, rawset, rawget = debug.getinfo, error, rawset, _ENV.rawget
local mt = getmetatable(_G)
if mt == nil then
  mt = {}
  setmetatable(_G, mt)
end
mt.__declared = {}
