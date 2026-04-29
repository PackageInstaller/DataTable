local key = {
  ID = 1,
  ExchangeId = 2,
  Index = 3,
  Icon = 4,
  View = 5
}
local config = {
  {
    1,
    6,
    "01",
    "n23_shop_review_tu2",
    {
      spine = "n23_store_1_spine_idle",
      playSequence = {
        [1] = {anim = "door_open", time = 2000},
        [2] = {anim = "door_alscd", time = 6000},
        [3] = {anim = "door_close", time = 2000},
        [4] = {anim = "door_idle"}
      }
    }
  },
  {
    2,
    1,
    "02",
    "n23_shop_review_tu3",
    {
      spine = "n23_store_1_spine_idle",
      playSequence = {
        [1] = {
          anim = "door_dangdang",
          time = 2733
        },
        [2] = {anim = "door_chop", time = 7967},
        [3] = {anim = "door_idle"}
      }
    }
  },
  {
    3,
    7,
    "03",
    "n23_shop_review_tu1",
    {
      spine = "n23_store_2_spine_idle",
      HideOnLoad = 1,
      playSequence = {
        [1] = {ShowSpine = 1},
        [2] = {anim = "1", time = 1333},
        [3] = {anim = "2", time = 500},
        [4] = {anim = "3", time = 8000},
        [5] = {HideSpine = 1}
      }
    }
  }
}
return config, "ID", key
