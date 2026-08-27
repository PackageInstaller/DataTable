local activity_card_tag = {
  {tag_des = 56734, tag_icon = "CardTag_04"},
  {
    id = 2,
    tag_icon = "CardTag_03",
    tag_para1 = 50,
    tag_type = 2
  },
  {
    id = 3,
    tag_des = 198750,
    tag_icon = "CardTag_01",
    tag_para1 = 1,
    tag_type = 3
  },
  {
    id = 4,
    tag_des = 44790,
    tag_para1 = 2,
    tag_type = 4
  },
  {
    id = 5,
    tag_des = 56734,
    tag_icon = "CardTag_06"
  },
  {
    id = 6,
    tag_icon = "CardTag_05",
    tag_para1 = 50,
    tag_type = 2
  }
}
local __default_values = {
  id = 1,
  tag_des = 187448,
  tag_icon = "",
  tag_para1 = 20,
  tag_type = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_card_tag) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_card_tag, {__index = __rawdata})
return activity_card_tag
