local GenderDataUtils = {}

function GenderDataUtils.GetGenderCfgByRoleData()
  local key = DataCenter.playerData.DRole.gender
  do return GenderDataUtils.GetGenderCfgByKey end
  return GenderDataUtils.GetGenderCfgByKey, key
end

function GenderDataUtils.GetGenderCfgByKey(Key)
  for _, genderCfg in pairs(DT.Lead) do
    if genderCfg.Gender == CommonDefine.GenderName[Key] then
      return genderCfg
    end
  end
  return nil
end

function GenderDataUtils.GetMapAvatarRes()
  local key = DataCenter.playerData.DRole.gender
  local genderCfg = GenderDataUtils.GetGenderCfgByKey(key)
  return genderCfg and genderCfg.MapAvatarRes or ""
end

function GenderDataUtils.GetMainCharacterAvatarRes()
  local genderItem = GenderDataUtils.GetGenderCfgByRoleData()
  return genderItem and genderItem.MainCharacterAvatarRes
end

function GenderDataUtils.GetAvgPlayerRes()
  local gender = DataCenter.playerData.DRole.gender
  if gender == CommonDefine.GenderID.Girl then
    return CommonDefine.AvgFemalePlayerRes
  end
  return CommonDefine.AvgMalePlayerRes
end

function GenderDataUtils.GetMainHeadRes(gender)
  if PlayerDataUtils.IsInAprileFool() then
    local replacementTid = PlayerDataUtils.GetAprileFoolReplaceItem()
    if replacementTid and ItemDataUtils.IsAvatarItem(replacementTid) then
      do return ItemDataUtils.GetAvatarIcon end
      return ItemDataUtils.GetAvatarIcon, replacementTid, nil
    end
  end
  local defaultGender = table.next(CommonDefine.GenderName)
  local key = gender or DataCenter.playerData.DRole.gender or defaultGender
  local genderCfg = GenderDataUtils.GetGenderCfgByKey(key)
  return genderCfg and genderCfg.MainCharacterAvatarRes or ""
end

function GenderDataUtils.GetBattleMainHeadRes(gender)
  local defaultGender = table.next(CommonDefine.GenderName)
  local key = gender or DataCenter.playerData.DRole.gender or defaultGender
  local genderCfg = GenderDataUtils.GetGenderCfgByKey(key)
  return genderCfg and genderCfg.MainCharacterAvatarRes or ""
end

function GenderDataUtils.GetPaintingRes(gender)
  local defaultGender = table.next(CommonDefine.GenderName)
  local key = gender or DataCenter.playerData.DRole.gender or defaultGender
  local genderCfg = GenderDataUtils.GetGenderCfgByKey(key)
  return genderCfg and genderCfg.PaintingRes or ""
end

function GenderDataUtils.GetCfgByTid(tid)
  local cfg = DT.Lead[tid] or GenderDataUtils.GetDefaultCfg()
  return cfg
end

function GenderDataUtils.GetDefaultCfg()
  for _, cfg in pairs(DT.Lead) do
    if 1 == cfg.BaseSortID then
      return cfg
    end
  end
  return nil
end

function GenderDataUtils.ChangeGender(callback)
  UIManager.Instance:Show(Urls.SocialGenderChangeConfirmView, callback)
end

local avatarResList = {}

function GenderDataUtils.GetAvatarResList()
  if not table.next(avatarResList) then
    for _, cfg in pairs(DT.Lead) do
      table.insert(avatarResList, cfg.MainCharacterAvatarRes)
    end
  end
  return avatarResList
end

return GenderDataUtils
