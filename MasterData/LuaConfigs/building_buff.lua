local building_buff = {
  [3] = {buff_text_context = 515599, id = 3},
  [4] = {
    buff_text_context = 380994,
    buff_value = 445402,
    id = 4
  },
  [5] = {buff_text_context = 202613, id = 5},
  [6] = {
    buff_text_context = "%s%s",
    buff_value = "+%s",
    id = 6
  },
  [7] = {buff_text_context = 86799, id = 7},
  [8] = {buff_text_context = 322909, id = 8},
  [9] = {buff_text_context = 340866, id = 9},
  [10] = {buff_text_context = 249164},
  [11] = {
    buff_text_context = 100108,
    buff_value = "%s%%",
    id = 11
  },
  [12] = {buff_text_context = 47535, id = 12},
  [13] = {
    buff_text_context = 196886,
    buff_value = "%s%%",
    id = 13
  },
  [14] = {
    buff_text_context = 272529,
    buff_value = "%s%%",
    id = 14
  },
  [15] = {buff_text_context = 387986, id = 15},
  [16] = {
    buff_text_context = 426430,
    buff_value = 233330,
    id = 16
  },
  [17] = {
    buff_text_context = 333523,
    buff_value = "+%s",
    id = 17
  },
  [20] = {
    buff_text_context = 468775,
    buff_value = "%s%%",
    id = 20
  },
  [21] = {
    buff_text_context = 48111,
    buff_value = "+%s",
    id = 21
  },
  [24] = {buff_text_context = 325522, id = 24},
  [25] = {
    buff_text_context = 208686,
    buff_value = 128631,
    id = 25
  },
  [26] = {buff_text_context = 127997, id = 26},
  [27] = {
    buff_text_context = 472997,
    buff_value = "%s%%",
    id = 27
  },
  [28] = {buff_text_context = 253639, id = 28},
  [29] = {buff_text_context = 25635, id = 29},
  [30] = {buff_text_context = 206206, id = 30},
  [31] = {buff_text_context = 519299, id = 31},
  [32] = {buff_text_context = 6908, id = 32},
  [33] = {
    buff_text_context = 425974,
    buff_value = "%s%%",
    id = 33
  },
  [34] = {buff_text_context = 251455, id = 34},
  [46] = {
    buff_text_context = 130510,
    buff_value = "+%s",
    id = 46
  },
  [2202] = {
    buff_text_context = 285568,
    buff_value = "-%s%%",
    id = 2202
  },
  [2208] = {
    buff_text_context = 87462,
    buff_value = "+%s",
    id = 2208
  },
  [2211] = {buff_value = 250604, id = 2211},
  [2212] = {
    buff_text_context = 483664,
    buff_value = "%s%%",
    id = 2212
  },
  [2213] = {
    buff_text_context = 394192,
    buff_value = "%s%%",
    id = 2213
  },
  [2214] = {
    buff_text_context = 80129,
    buff_value = "+%s%%",
    id = 2214
  },
  [2215] = {
    buff_text_context = 117497,
    buff_value = "+%s%%",
    id = 2215
  },
  [2216] = {
    buff_text_context = 12198,
    buff_value = "+%s%%",
    id = 2216
  },
  [2217] = {
    buff_text_context = 493071,
    buff_value = "%s%%",
    id = 2217
  },
  [2218] = {
    buff_text_context = 175475,
    buff_value = "%s%%",
    id = 2218
  },
  [2219] = {
    buff_text_context = 80891,
    buff_value = "+%s%%",
    id = 2219
  },
  [2223] = {id = 2223}
}
local __default_values = {
  buff_text_context = 196695,
  buff_value = "%s",
  id = 10
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(building_buff) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(building_buff, {__index = __rawdata})
return building_buff
