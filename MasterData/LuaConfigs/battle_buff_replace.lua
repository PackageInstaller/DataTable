local battle_buff_replace = {
  [23] = {id = 23},
  [26] = {id = 26, sueyoi_id = 450000026},
  [65] = {id = 65, sueyoi_id = 450000065},
  [66] = {id = 66, sueyoi_id = 450000066},
  [67] = {id = 67, sueyoi_id = 450000067},
  [110] = {id = 110, sueyoi_id = 450000110},
  [115] = {id = 115, sueyoi_id = 450000115},
  [122] = {id = 122, sueyoi_id = 450000122},
  [141] = {id = 141, sueyoi_id = 450000141},
  [176] = {id = 176, sueyoi_id = 450000176},
  [177] = {id = 177, sueyoi_id = 450000177},
  [178] = {id = 178, sueyoi_id = 450000178},
  [183] = {id = 183, sueyoi_id = 450000183},
  [185] = {id = 185, sueyoi_id = 450000185},
  [186] = {id = 186, sueyoi_id = 450000186},
  [187] = {id = 187, sueyoi_id = 450000187},
  [195] = {id = 195, sueyoi_id = 450000195},
  [205] = {id = 205, sueyoi_id = 450000205},
  [206] = {id = 206, sueyoi_id = 450000206},
  [207] = {id = 207, sueyoi_id = 450000207},
  [223] = {id = 223, sueyoi_id = 450000223},
  [3002] = {id = 3002, sueyoi_id = 450003002},
  [3006] = {id = 3006, sueyoi_id = 450003006},
  [3010] = {id = 3010, sueyoi_id = 450003010},
  [3012] = {id = 3012, sueyoi_id = 450003012},
  [100201] = {sueyoi_id = 450100201},
  [101002] = {id = 101002, sueyoi_id = 450101002},
  [101101] = {id = 101101, sueyoi_id = 450101101},
  [101102] = {id = 101102, sueyoi_id = 450101102},
  [101201] = {id = 101201, sueyoi_id = 450101201},
  [101502] = {id = 101502, sueyoi_id = 450101502},
  [101503] = {id = 101503, sueyoi_id = 450101503},
  [101601] = {id = 101601, sueyoi_id = 450101601},
  [101702] = {id = 101702, sueyoi_id = 450101702},
  [101802] = {id = 101802, sueyoi_id = 450101802},
  [102003] = {id = 102003, sueyoi_id = 450102003},
  [102501] = {id = 102501, sueyoi_id = 450102501},
  [102802] = {id = 102802, sueyoi_id = 450102802},
  [102901] = {id = 102901, sueyoi_id = 450102901},
  [103302] = {id = 103302, sueyoi_id = 450103302},
  [104002] = {id = 104002, sueyoi_id = 450104002},
  [104005] = {id = 104005, sueyoi_id = 450104005},
  [104008] = {id = 104008, sueyoi_id = 450104008},
  [104203] = {id = 104203, sueyoi_id = 450104203},
  [104305] = {id = 104305, sueyoi_id = 450104305},
  [110006] = {id = 110006, sueyoi_id = 450110006},
  [204203] = {id = 204203, sueyoi_id = 450204203},
  [204204] = {id = 204204, sueyoi_id = 450204204},
  [512101] = {id = 512101, sueyoi_id = 450512101},
  [512201] = {id = 512201, sueyoi_id = 450512201}
}
local __default_values = {id = 100201, sueyoi_id = 450000023}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(battle_buff_replace) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(battle_buff_replace, {__index = __rawdata})
return battle_buff_replace
