local activity_instrument_rhythm = {
  {
    audio_time = 66,
    bpm = 120,
    difficulty = 1,
    rhythm_des = 449205
  },
  {
    audio_id = 6152,
    audio_time = 78,
    bpm = 110,
    click_num = 176,
    id = 2,
    max_score = 4400,
    midi = "molihua_midi"
  },
  {
    audio_id = 6153,
    click_num = 188,
    id = 3,
    max_score = 4700,
    midi = "liangzhu_midi",
    rhythm_des = 474962
  }
}
local __default_values = {
  audio_id = 6150,
  audio_time = 102,
  bpm = 100,
  button_track = 2,
  click_num = 132,
  combo_initial = 3,
  difficulty = 2,
  id = 1,
  max_score = 3300,
  midi = "canghaiyishengxiao_midi",
  quarterNoteTick = 240,
  rhythm_des = 322281
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(activity_instrument_rhythm) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(activity_instrument_rhythm, {__index = __rawdata})
return activity_instrument_rhythm
