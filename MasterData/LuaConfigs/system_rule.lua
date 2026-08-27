local system_rule = {
  {
    maintitle = 65134,
    rule_text = 59027,
    subtitle = 10960,
    text_en = "RULES",
    title = 511891
  },
  {
    maintitle = 172769,
    rule_id = 2,
    rule_text = 71942
  },
  {rule_id = 3, rule_text = 235595},
  {
    maintitle = 172733,
    rule_id = 4,
    rule_text = 187300
  },
  {
    maintitle = 21965,
    rule_id = 5,
    rule_text = 357732
  },
  {
    maintitle = 465720,
    rule_id = 6,
    rule_text = 89166
  },
  {
    maintitle = 215019,
    rule_id = 7,
    rule_text = 416730
  },
  {
    maintitle = 15969,
    rule_id = 8,
    rule_text = 423866
  },
  {
    maintitle = 265562,
    rule_id = 9,
    rule_text = 87896
  },
  {
    maintitle = 465368,
    rule_id = 10,
    rule_text = 358500,
    subtitle = 10960,
    text_en = "RULES",
    title = 511891
  },
  {
    maintitle = 5479,
    rule_id = 11,
    rule_text = 332264
  },
  {
    maintitle = 132435,
    rule_id = 12,
    rule_text = 376455
  },
  {
    maintitle = 465720,
    rule_id = 13,
    rule_text = 510996
  },
  {
    maintitle = 172733,
    rule_id = 14,
    rule_text = 42391
  },
  {rule_id = 15, rule_text = 386019},
  {
    maintitle = 172769,
    rule_id = 16,
    rule_text = 438737
  },
  {
    maintitle = 474849,
    rule_id = 17,
    rule_text = 477489,
    subtitle = 10960,
    text_en = "RULES"
  },
  {
    maintitle = 357182,
    rule_id = 18,
    rule_text = 5248,
    subtitle = 10960,
    text_en = "RULES"
  },
  {
    maintitle = 247374,
    rule_id = 19,
    rule_text = 16148,
    subtitle = 10960,
    text_en = "RULES"
  },
  {
    maintitle = 181891,
    rule_id = 20,
    rule_text = 244928,
    subtitle = 10960,
    text_en = "RULES"
  },
  {
    maintitle = 372938,
    rule_id = 21,
    subtitle = 10960,
    text_en = "RULES"
  },
  {
    maintitle = 53814,
    rule_id = 22,
    rule_text = 52174,
    subtitle = 10960,
    text_en = "RULES"
  },
  {
    maintitle = 331190,
    rule_id = 23,
    rule_text = 309833,
    subtitle = 10960,
    text_en = "RULES"
  },
  {
    maintitle = 181891,
    rule_id = 24,
    rule_text = 355298,
    subtitle = 10960,
    text_en = "RULES"
  },
  {
    maintitle = 414132,
    rule_id = 25,
    rule_text = 514137,
    subtitle = 10960,
    text_en = "RULES"
  },
  {
    maintitle = 197134,
    rule_id = 26,
    rule_text = 430488,
    subtitle = 10960,
    text_en = "RULES"
  },
  {
    maintitle = 76047,
    rule_id = 27,
    rule_text = 87486,
    subtitle = 10960,
    text_en = "RULES"
  }
}
local __default_values = {
  maintitle = 167381,
  rule_id = 1,
  rule_text = 120014,
  subtitle = "",
  text_en = "",
  title = ""
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(system_rule) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(system_rule, {__index = __rawdata})
return system_rule
