local sector_chapter_difficulty = {
  [250011] = {difficulty_desc = 144507},
  [250012] = {
    difficulty_id = 1,
    difficulty_name = 59556,
    difficulty_name_en = "NORMAL",
    sector_id = 250012,
    sort = 1
  },
  [250021] = {
    difficulty_desc = "",
    difficulty_id = 0,
    difficulty_name = "",
    difficulty_name_en = "",
    sector_id = 250021,
    sort = 0
  },
  [250031] = {difficulty_desc = 144507, sector_id = 250031},
  [250032] = {
    difficulty_id = 1,
    difficulty_name = 59556,
    difficulty_name_en = "NORMAL",
    sector_id = 250032,
    sort = 1
  },
  [330011] = {difficulty_desc = 360689, sector_id = 330011},
  [330012] = {
    difficulty_id = 1,
    difficulty_name = 59556,
    difficulty_name_en = "NORMAL",
    sector_id = 330012,
    sort = 1
  },
  [330021] = {
    difficulty_desc = "",
    difficulty_id = 0,
    difficulty_name = "",
    difficulty_name_en = "",
    sector_id = 330021,
    sort = 0
  },
  [330031] = {difficulty_desc = 360689, sector_id = 330031},
  [330032] = {
    difficulty_id = 1,
    difficulty_name = 59556,
    difficulty_name_en = "NORMAL",
    sector_id = 330032,
    sort = 1
  },
  [330041] = {
    difficulty_desc = "",
    difficulty_id = 0,
    difficulty_name = "",
    difficulty_name_en = "",
    sector_id = 330041,
    sort = 0
  },
  [330051] = {difficulty_desc = 360689, sector_id = 330051},
  [330052] = {
    difficulty_id = 1,
    difficulty_name = 59556,
    difficulty_name_en = "NORMAL",
    sector_id = 330052,
    sort = 1
  },
  [330061] = {difficulty_desc = 144507, sector_id = 330061},
  [330062] = {
    difficulty_id = 1,
    difficulty_name = 59556,
    difficulty_name_en = "NORMAL",
    sector_id = 330062,
    sort = 1
  },
  [330121] = {difficulty_desc = 360689, sector_id = 330121},
  [330122] = {
    difficulty_id = 1,
    difficulty_name = 59556,
    difficulty_name_en = "NORMAL",
    sector_id = 330122,
    sort = 1
  },
  [590011] = {difficulty_desc = 144507, sector_id = 590011},
  [590012] = {
    difficulty_id = 1,
    difficulty_name = 59556,
    difficulty_name_en = "NORMAL",
    sector_id = 590012,
    sort = 1
  },
  [590021] = {difficulty_desc = 144507, sector_id = 590021}
}
local __default_values = {
  difficulty_desc = 360319,
  difficulty_id = 2,
  difficulty_name = 65844,
  difficulty_name_en = "HARD",
  sector_id = 250011,
  sort = 2
}
local base = {
  __index = __default_values,
  __newindex = function()
    error("Attempt to modify read-only table")
  end
}
for k, v in pairs(sector_chapter_difficulty) do
  setmetatable(v, base)
end
local __rawdata = {__basemetatable = base}
setmetatable(sector_chapter_difficulty, {__index = __rawdata})
return sector_chapter_difficulty
