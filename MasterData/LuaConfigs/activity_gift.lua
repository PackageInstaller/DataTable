local activity_gift = {
  {},
  {
    giftlist = {
      314,
      315,
      316,
      317
    },
    id = 2
  },
  {
    giftlist = {
      394,
      395,
      396,
      397
    },
    id = 3
  }
}
local __default_values = {
  desc = 421,
  giftlist = {
    223,
    224,
    225,
    226
  },
  id = 1,
  subtitle = 420
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_gift) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_gift, {__index = __rawdata})
return activity_gift
