local BattleFieldDifficulty = {
  Easy = 1,
  Nomarl = 2,
  Hard = 3,
  Purgatory = 4
}
_enum("BattleFieldDifficulty", BattleFieldDifficulty)
local BattleFieldDifficultyImg = {
  DifficultyImg = {
    [BattleFieldDifficulty.Easy] = "n5_result_difficulty_bg1",
    [BattleFieldDifficulty.Nomarl] = "n5_result_difficulty_bg2",
    [BattleFieldDifficulty.Hard] = "n5_result_difficulty_bg3",
    [BattleFieldDifficulty.Purgatory] = "n5_result_difficulty_bg4"
  },
  MapCardImg = {
    [BattleFieldDifficulty.Easy] = "n5_map2_card1",
    [BattleFieldDifficulty.Nomarl] = "n5_map2_card2",
    [BattleFieldDifficulty.Hard] = "n5_map2_card3",
    [BattleFieldDifficulty.Purgatory] = "n5_map2_card4"
  },
  MapTagImg = {
    [BattleFieldDifficulty.Easy] = "n5_map_tag1",
    [BattleFieldDifficulty.Nomarl] = "n5_map_tag2",
    [BattleFieldDifficulty.Hard] = "n5_map_tag3",
    [BattleFieldDifficulty.Purgatory] = "n5_map_tag4"
  },
  MapAvatarImg = {
    [BattleFieldDifficulty.Easy] = "n5_map2_avatar1",
    [BattleFieldDifficulty.Nomarl] = "n5_map2_avatar2",
    [BattleFieldDifficulty.Hard] = "n5_map2_avatar3",
    [BattleFieldDifficulty.Purgatory] = "n5_map2_avatar4"
  }
}
_enum("BattleFieldDifficultyImg", BattleFieldDifficultyImg)
local BattleFieldDifficultyText = {
  DifficultyText = {
    [BattleFieldDifficulty.Easy] = "str_n5_difficulty_easy",
    [BattleFieldDifficulty.Nomarl] = "str_n5_difficulty_normal",
    [BattleFieldDifficulty.Hard] = "str_n5_difficulty_hard",
    [BattleFieldDifficulty.Purgatory] = "str_n5_difficulty_purgatory"
  }
}
_enum("BattleFieldDifficultyText", BattleFieldDifficultyText)
