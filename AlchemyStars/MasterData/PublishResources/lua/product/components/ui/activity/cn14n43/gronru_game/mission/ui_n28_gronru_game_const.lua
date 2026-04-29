_class("UIN28GronruGameConst", Object)
UIN28GronruGameConst = UIN28GronruGameConst
UIN28GronruGameConst.playerData = {
  [1] = {
    "1600061_players.prefab"
  },
  [2] = {
    "1000011_players.prefab"
  },
  [3] = {
    "1500331_players.prefab"
  }
}
UIN28GronruGameConst.bgData = {
  [1] = {
    {
      "N28_yrj_gzdt_btbg01",
      "N28_yrj_gzdt_btbg02",
      "N28_yrj_gzdt_btbg03",
      "N28_yrj_gzdt_btbg04",
      "N28_yrj_gzdt_btbg05",
      "N28_yrj_gzdt_btbg06",
      "N28_yrj_gzdt_btbg07",
      "N28_yrj_gzdt_btbg12"
    },
    {
      "N28_yrj_gzdt_btbg09",
      "N28_yrj_gzdt_btbg10",
      "N28_yrj_gzdt_btbg11",
      "N28_yrj_gzdt_btbg08"
    }
  },
  [2] = {
    {
      "N28_yrj_gzdt_bwbg01",
      "N28_yrj_gzdt_bwbg02",
      "N28_yrj_gzdt_bwbg03",
      "N28_yrj_gzdt_bwbg04",
      "N28_yrj_gzdt_bwbg05",
      "N28_yrj_gzdt_bwbg06",
      "N28_yrj_gzdt_bwbg07",
      "N28_yrj_gzdt_bwbg12"
    },
    {
      "N28_yrj_gzdt_bwbg09",
      "N28_yrj_gzdt_bwbg10",
      "N28_yrj_gzdt_bwbg11",
      "N28_yrj_gzdt_bwbg08"
    }
  },
  [3] = {
    {
      "N28_yrj_gzdt_ywbg01",
      "N28_yrj_gzdt_ywbg02",
      "N28_yrj_gzdt_ywbg03",
      "N28_yrj_gzdt_ywbg04",
      "N28_yrj_gzdt_ywbg05",
      "N28_yrj_gzdt_ywbg06",
      "N28_yrj_gzdt_ywbg07",
      "N28_yrj_gzdt_ywbg12"
    },
    {
      "N28_yrj_gzdt_ywbg09",
      "N28_yrj_gzdt_ywbg10",
      "N28_yrj_gzdt_ywbg11",
      "N28_yrj_gzdt_ywbg08"
    }
  }
}

function UIN28GronruGameConst:Constructor()
end

function UIN28GronruGameConst.ClearSelectPlayer()
  UIN28GronruGameConst.selectPlayerIndex = nil
end

function UIN28GronruGameConst.GetSelectPlayer()
  return UIN28GronruGameConst.selectPlayerIndex
end

function UIN28GronruGameConst.SetSelectPlayer(playerIndex)
  UIN28GronruGameConst.selectPlayerIndex = playerIndex
end

function UIN28GronruGameConst.ClearSelectLevel()
  UIN28GronruGameConst.selectLevel = nil
end

function UIN28GronruGameConst.GetSelectLevel()
  return UIN28GronruGameConst.selectLevel
end

function UIN28GronruGameConst.SetSelectLevel(level)
  UIN28GronruGameConst.selectLevel = level
end

function UIN28GronruGameConst.GetPlayerInfo(index)
  return UIN28GronruGameConst.playerData[index]
end

function UIN28GronruGameConst.GetScoreFont(score)
  local a, b, c, d = math.floor(score / 1000), math.floor(score / 100 % 10), math.floor(score / 10 % 10), score % 10
  return {
    a,
    b,
    c,
    d
  }
end

function UIN28GronruGameConst.CheckStoryLocalDb(roleId, key, pre)
  local str = pre and "Per" or "Last"
  if LocalDB.GetInt("ui_n28_mini_game_story" .. roleId .. key .. str) > 0 then
    return true
  end
  return false
end

function UIN28GronruGameConst.SetStoryLocalDb(roleId, key, pre)
  local str = pre and "Per" or "Last"
  LocalDB.SetInt("ui_n28_mini_game_story" .. roleId .. key .. str, 1)
end

UIN28GronruGameConst.plainMoveX = -4964
UIN28GronruGameConst.plainMoveSpeed = 100
UIN28GronruGameConst.smallItemsMoveX = -2143
UIN28GronruGameConst.smallItemsMoveSpeed = 200
UIN28GronruGameConst.BossNodeMoveX_1 = -2560
UIN28GronruGameConst.BossNodeMoveSpeed_1 = 100
UIN28GronruGameConst.BossNodeMoveX_2 = -1812
UIN28GronruGameConst.BossNodeMoveSpeed_2 = 300
UIN28GronruGameConst.BossNodeMoveX_3 = -1955
UIN28GronruGameConst.BossNodeMoveSpeed_3 = 200
