local key = {
  ID = 1,
  petIDs = 2,
  Anim = 3,
  InteractionBubbles = 4
}
local config = {
  {
    1,
    nil,
    {
      [1] = {anim = "stand"}
    }
  },
  {
    2,
    nil,
    {
      [1] = {
        anim = "diaoyu_in_hli",
        panim = "diaoyu_in_hli",
        peff = "hl_tool_5012001_1",
        pholder = "Root"
      }
    }
  },
  {
    3,
    nil,
    {
      [1] = {
        anim = "diaoyu_idle",
        panim = "diaoyu_idle",
        peff = "hl_tool_5012001_1",
        pholder = "Root"
      }
    }
  },
  {
    4,
    nil,
    {
      [1] = {
        anim = "diaoyu_hli",
        panim = "diaoyu_hli",
        peff = "hl_tool_5012001_1",
        pholder = "Root"
      }
    }
  },
  {
    5,
    nil,
    {
      [1] = {
        anim = "diaoyu_out_hli",
        panim = "diaoyu_out_hli",
        peff = "hl_tool_5012001_1",
        pholder = "Root"
      }
    }
  },
  {
    6,
    nil,
    {
      [1] = {
        peff = "eff_jy_fish_toss_baoqi",
        pholder = "Root"
      }
    }
  },
  {
    7,
    nil,
    {
      [1] = {anim = "happy"}
    }
  },
  {
    8,
    nil,
    {
      [1] = {anim = "sad"}
    }
  }
}
return config, "ID", key
