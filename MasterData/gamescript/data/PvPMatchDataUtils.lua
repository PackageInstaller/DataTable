local PvPMatchData = DataCenter.pvpMatchData
local PvPMatchDataUtils = {}

function PvPMatchDataUtils.InitBySvrData(svrData)
  PvPMatchDataUtils.SetEnermyData(svrData.enermyData)
  PvPMatchDataUtils.SetPlayerData(svrData.playerData)
  if not UIManager.Instance:GetWindow(Urls.PvPMatchingPanel) then
    PvPMatchDataUtils.OpenPvPMatchRstPanel()
    UIManager.Instance:CloseByUrl(Urls.PvpDraftAdjustTeamView)
  end
end

function PvPMatchDataUtils.OpenPvPMatchingPanel()
  PvPSettleDataUtils.Reset()
  UIManager.Instance:Reopen(Urls.PvPMatchingPanel)
end

function PvPMatchDataUtils.OpenPvPMatchRstPanel()
  UIManager.Instance:Reopen(Urls.PvPMatchRstPanel)
end

function PvPMatchDataUtils.GetPlayerData()
  return PvPMatchData.playerData
end

function PvPMatchDataUtils.GetEnermyData()
  return PvPMatchData.enermyData
end

function PvPMatchDataUtils.GetIsMatching()
  return PvPMatchData.isMatching
end

function PvPMatchDataUtils.GetIsPvpPreparing()
  return PvPMatchData.isPvpPreparing
end

function PvPMatchDataUtils.GetPvpBattleInfo()
  return PvPMatchData.pvpBattleInfo
end

function PvPMatchDataUtils.GetDraftScoreCond()
  return PvPMatchData.draftScoreCond or DT.GetConstant("RotationModeThresholdScore")
end

function PvPMatchDataUtils.SetIsPvpPreparing(boolVal)
  PvPMatchData.isPvpPreparing = boolVal
end

function PvPMatchDataUtils.SetDraftScoreCond(numVal)
  PvPMatchData.draftScoreCond = numVal
end

function PvPMatchDataUtils.SetPvpBattleInfo(tbl)
  PvPMatchData.pvpBattleInfo = tbl
end

function PvPMatchDataUtils.SetPlayerData(tbl)
  PvPMatchData.playerData = tbl
end

function PvPMatchDataUtils.SetPlayerDataElem(strKey, newVal)
  if PvPMatchData.playerData[strKey] then
    PvPMatchData.playerData[strKey] = newVal
  end
end

function PvPMatchDataUtils.SetEnermyData(tbl)
  PvPMatchData.enermyData = tbl
end

function PvPMatchDataUtils.SetIsMatching(boolVal, withoutPanel)
  if nil == boolVal then
    return
  end
  PvPMatchData.isMatching = boolVal
  if withoutPanel then
    return
  end
  if boolVal then
    PvPMatchDataUtils.OpenPvPMatchingPanel()
    AudioManager.Instance:PostSoundEvent("Set_State_B_PVP_MatchOn")
  elseif not boolVal and UIManager.Instance:GetWindow(Urls.PvPMatchingPanel) then
    AudioManager.Instance:PostSoundEvent("Set_State_B_PVP_MatchOff")
    AudioManager.Instance:PostSoundEvent("Stop_Anim_PVP_Matching_Machine_Loop1")
    UIManager.Instance:CloseByUrl(Urls.PvPMatchingPanel)
  end
end

function PvPMatchDataUtils.SetEnermyDataElem(strKey, newVal)
  if PvPMatchData.enermyData[strKey] then
    PvPMatchData.enermyData[strKey] = newVal
  end
end

return PvPMatchDataUtils
