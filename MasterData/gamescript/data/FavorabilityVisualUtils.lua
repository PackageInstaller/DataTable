local FavorabilityVisualUtils = {}

function FavorabilityVisualUtils.GetPremiumCardFaceRes(awakerTid, cardType)
  local resPath = CommonRes.FullFavorCardFaceFrame
  if cardType == CommonDefine.AwakerSkillType.Card_Awake then
    resPath = CommonRes.FullFavorExclusiveCardFaceFrame
  end
  if not resPath then
    return nil
  end
  return resPath
end

function FavorabilityVisualUtils.ShowPremiumCardFaceLevel()
  if not FavorabilityVisualUtils.showPremiumLevel then
    FavorabilityVisualUtils.showPremiumLevel = DT.GetOriginalConstant("AwakerFavorFrameShowLevel")
  end
  return FavorabilityVisualUtils.showPremiumLevel or 0
end

function FavorabilityVisualUtils.IsPremiumCardFaceUnlocked(awakerTid, awakerData)
  local settingVal = SettingManager.Instance:GetSettingData("CardBorderEffect")
  local isOpen = 1 == settingVal or "Open" == settingVal
  if not isOpen then
    return false
  end
  local awaker = awakerData
  awaker = awaker or AwakerDataUtils.GetAwakerData(awakerTid)
  if not awaker then
    return false
  end
  local likeLevel = awaker.likeLevel or 0
  local showLv = FavorabilityVisualUtils.ShowPremiumCardFaceLevel()
  return likeLevel >= showLv
end

return FavorabilityVisualUtils
