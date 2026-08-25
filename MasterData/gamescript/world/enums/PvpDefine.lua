local PvpDefine = {}
PvpDefine.PvpType = {
  Draft = 1,
  PreBuilt = 2,
  DraftAndPreBuilt = 3
}
PvpDefine.WWiseEventList = {
  [PvpDefine.PvpType.PreBuilt] = {
    "Set_State_A_Ingame",
    "Set_State_B_PVP_Default",
    "Set_State_E_In"
  },
  [PvpDefine.PvpType.Draft] = {
    "Set_State_A_Ingame",
    "Set_State_B_PVP_Runoff",
    "Set_State_E_In"
  }
}
PvpDefine.PvpDraftPhase = {
  Draft = 1,
  Adjust = 2,
  Start = 3
}
PvpDefine.PvpStarImgRankTypes = {
  RankDefine.RankType.WeeklyPVP,
  RankDefine.RankType.PVP
}
PvpDefine.PvpCrownImgRankTypes = {
  RankDefine.RankType.WeeklyDraftPVP,
  RankDefine.RankType.DraftPVP
}
PvpDefine.RoomExpiredTime = DT.GetConstant("PVP_PasswordBattle_WaitTime")
PvpDefine.RoomPwdLen = 6
PvpDefine.RoomStatus = {
  Close = 0,
  Matched = 1,
  Disband = 2,
  Created = 3,
  Waiting = 4
}
PvpDefine.RoomPlayerStatus = {Ready = 10, SelectedTeam = 11}
PvpDefine.RoomFightPlayerCount = 2
PvpDefine.PVPMatchType = {
  AutoMatch = 1,
  Friend = 2,
  Password = 3
}
PvpDefine.PVPModeNameKeyMap = {
  [PvpDefine.PVPMatchType.AutoMatch] = {
    [PvpDefine.PvpType.PreBuilt] = "PvPReplayModeDisp1",
    [PvpDefine.PvpType.Draft] = "PvPReplayModeDisp2"
  },
  [PvpDefine.PVPMatchType.Password] = {
    [PvpDefine.PvpType.PreBuilt] = "PvPReplayModeDisp3",
    [PvpDefine.PvpType.Draft] = "PvPReplayModeDisp4"
  },
  [PvpDefine.PVPMatchType.Friend] = {
    [PvpDefine.PvpType.PreBuilt] = "PvPReplayModeDisp5",
    [PvpDefine.PvpType.Draft] = "PvPReplayModeDisp6"
  }
}

function PvpDefine.GetPVPModeName(matchType, pvpType)
  local keyMap = PvpDefine.PVPModeNameKeyMap[matchType]
  local key = keyMap and keyMap[pvpType]
  if not key then
    return ""
  end
  do return LT.Text end
  return LT.Text, key
end

return PvpDefine
