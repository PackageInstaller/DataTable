local key = {
  PlayerTitle = 1,
  RankTitle = 2,
  DetailInfo = 3,
  CardImg = 4,
  CardImgDefault = 5,
  CellBg = 6,
  CellBgDefault = 7,
  CellFrontBg = 8,
  CellFrontBgDefault = 9,
  RankInfoStyle = 10,
  RankInfoStyleDefault = 11
}
local config = {
  [100600402] = {
    "str_n5_progress_player_title",
    "str_n5_progress_rank_title",
    nil,
    {
      "1,n5_rank_myrank1",
      "2,n5_rank_myrank2",
      "3,n5_rank_myrank3"
    },
    "n5_rank_di7",
    {
      "1,n5_rank_di1",
      "2,n5_rank_di1",
      "3,n5_rank_di1"
    },
    "n5_rank_di6",
    {
      "1,n5_rank_rank1",
      "2,n5_rank_rank2",
      "3,n5_rank_rank3"
    },
    "n5_rank_rank4",
    {
      "1,1",
      "2,1",
      "3,1"
    },
    "2"
  }
}
return config, "ComponentID", key
