local new_chat_emoticon = {
  [630001] = {},
  [630002] = {
    emoticon_icon = "Expression_2",
    id = 630002
  },
  [630003] = {
    emoticon_icon = "Expression_3",
    id = 630003
  },
  [630004] = {
    emoticon_icon = "Expression_4",
    id = 630004
  },
  [630005] = {
    emoticon_icon = "Expression_5",
    id = 630005
  },
  [630006] = {
    emoticon_icon = "Expression_6",
    id = 630006
  },
  [630007] = {
    emoticon_icon = "Expression_7",
    id = 630007
  },
  [630008] = {
    emoticon_icon = "Expression_8",
    id = 630008
  },
  [630009] = {
    emoticon_icon = "Expression_9",
    id = 630009
  },
  [630010] = {
    emoticon_icon = "Expression_10",
    id = 630010,
    series_id = 2
  },
  [630011] = {
    emoticon_icon = "Expression_11",
    id = 630011,
    series_id = 2
  },
  [630012] = {
    emoticon_icon = "Expression_12",
    id = 630012,
    series_id = 2
  },
  [630013] = {
    emoticon_icon = "Expression_13",
    id = 630013,
    series_id = 2
  },
  [630014] = {
    emoticon_icon = "Expression_14",
    id = 630014,
    series_id = 2
  },
  [630015] = {
    emoticon_icon = "Expression_15",
    id = 630015,
    series_id = 2
  },
  [630016] = {
    emoticon_icon = "Expression_16",
    id = 630016,
    series_id = 2
  }
}
local __default_values = {
  emoticon_icon = "Expression_1",
  id = 630001,
  locked = true,
  series_id = 1
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(new_chat_emoticon) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(new_chat_emoticon, {__index = __rawdata})
return new_chat_emoticon
