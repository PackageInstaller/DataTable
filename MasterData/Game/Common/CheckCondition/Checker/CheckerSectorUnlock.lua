local CheckerSectorUnlock = {}

function CheckerSectorUnlock.LengthCheck(param)
  if 2 <= #param then
    return true
  end
  return false
end

function CheckerSectorUnlock.ParamsCheck(param)
  return PlayerDataCenter.sectorStage:IsSctChapterUnlock(param[2])
end

function CheckerSectorUnlock.GetUnlockInfo(param)
  return ConfigData:GetTipContent(TipContent.Sector_Lock)
end

return CheckerSectorUnlock
