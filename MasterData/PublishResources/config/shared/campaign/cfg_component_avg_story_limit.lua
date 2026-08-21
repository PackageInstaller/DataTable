local key = {
  ID = 1,
  ComponentID = 2,
  StartBlood = 3,
  MinBlood = 4,
  MaxBlood = 5,
  TeammateInitList = 6,
  TeammateMinList = 7,
  TeammateMaxList = 8,
  StartEvidences = 9,
  ActorInfo = 10
}
local common = {
  {
    0,
    0,
    0
  },
  {0, 0},
  {10, 10},
  {
    [1] = {
      icon = "N28_avg_jq_di06",
      iconOption = "N28_avg_jq_di07"
    },
    [2] = {
      icon = "N28_avg_jq_di04",
      iconOption = "N28_avg_jq_di04"
    },
    [3] = {
      icon = "N28_avg_jq_di03",
      iconOption = "N28_avg_jq_di03"
    }
  }
}
local config = {
  {
    1,
    106310709,
    10,
    0,
    10,
    common[1],
    common[1],
    {
      10,
      10,
      10
    },
    nil,
    {
      [1] = {
        icon = "N20_avg_zjm_head04",
        iconOption = "N20_avg_zjm_head04"
      },
      [2] = {
        icon = "N20_avg_zjm_head01",
        iconOption = "N20_avg_dh_head01"
      },
      [3] = {
        icon = "N20_avg_zjm_head03",
        iconOption = "N20_avg_dh_head03"
      },
      [4] = {
        icon = "N20_avg_zjm_head02",
        iconOption = "N20_avg_dh_head02"
      }
    }
  },
  {
    2,
    108410708,
    5,
    0,
    5,
    common[2],
    common[2],
    common[3],
    nil,
    common[4]
  },
  {
    3,
    114510702,
    5,
    0,
    5,
    common[2],
    common[2],
    common[3],
    nil,
    common[4]
  }
}
return config, "ID", key
