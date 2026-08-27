local instrument_music = {
  {notation = 1, note = 84},
  {
    char_icon = "2",
    char_note = "re",
    key_id = 2,
    notation = 1,
    note = 86
  },
  {
    char_icon = "3",
    char_note = "mi",
    key_id = 3,
    notation = 1,
    note = 88
  },
  {
    char_icon = "4",
    char_note = "fa",
    key_id = 4,
    notation = 1,
    note = 89
  },
  {
    char_icon = "5",
    char_note = "so",
    key_id = 5,
    notation = 1,
    note = 91
  },
  {
    char_icon = "6",
    char_note = "la",
    key_id = 6,
    notation = 1,
    note = 93
  },
  {
    char_icon = "7",
    char_note = "si",
    key_id = 7,
    notation = 1,
    note = 95
  },
  {key_id = 8, note = 72},
  {
    char_icon = "2",
    char_note = "re",
    key_id = 9,
    note = 74
  },
  {
    char_icon = "3",
    char_note = "mi",
    key_id = 10,
    note = 76
  },
  {
    char_icon = "4",
    char_note = "fa",
    key_id = 11,
    note = 77
  },
  {
    char_icon = "5",
    char_note = "so",
    key_id = 12,
    note = 79
  },
  {
    char_icon = "6",
    char_note = "la",
    key_id = 13,
    note = 81
  },
  {
    char_icon = "7",
    char_note = "si",
    key_id = 14,
    note = 83
  },
  {key_id = 15, notation = 2},
  {
    char_icon = "2",
    char_note = "re",
    key_id = 16,
    notation = 2,
    note = 62
  },
  {
    char_icon = "3",
    char_note = "mi",
    key_id = 17,
    notation = 2,
    note = 64
  },
  {
    char_icon = "4",
    char_note = "fa",
    key_id = 18,
    notation = 2,
    note = 65
  },
  {
    char_icon = "5",
    char_note = "so",
    key_id = 19,
    notation = 2,
    note = 67
  },
  {
    char_icon = "6",
    char_note = "la",
    key_id = 20,
    notation = 2,
    note = 69
  },
  {
    char_icon = "7",
    char_note = "si",
    key_id = 21,
    notation = 2,
    note = 71
  }
}
local __default_values = {
  char_icon = "1",
  char_note = "do",
  key_id = 1,
  notation = 0,
  note = 60
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(instrument_music) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(instrument_music, {__index = __rawdata})
return instrument_music
