local __rt_1 = {
  1,
  1,
  1,
  1,
  1,
  1,
  1
}
local __rt_2 = {
  13,
  14,
  15,
  16,
  17,
  18,
  117
}
local audio_no_voice = {
  [1076] = {},
  [1077] = {hero_id = 1077},
  [1078] = {hero_id = 1078}
}
local __default_values = {
  doc_text = __rt_1,
  hero_id = 1076,
  no_vo_id = __rt_2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(audio_no_voice) do
  setmetatable(v, base)
end
local __rawdata = {
  __basemetatable = base,
  heroNotHaveVoiceDataList = {
    [1076] = {
      [13] = true,
      [14] = true,
      [15] = true,
      [16] = true,
      [17] = true,
      [18] = true,
      [117] = true
    },
    [1077] = {
      [13] = true,
      [14] = true,
      [15] = true,
      [16] = true,
      [17] = true,
      [18] = true,
      [117] = true
    },
    [1078] = {
      [13] = true,
      [14] = true,
      [15] = true,
      [16] = true,
      [17] = true,
      [18] = true,
      [117] = true
    }
  }
}
setmetatable(audio_no_voice, {__index = __rawdata})
return audio_no_voice
