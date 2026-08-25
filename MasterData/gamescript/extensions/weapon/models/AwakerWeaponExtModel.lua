local AwakerWeaponExtModel = NewClass("AwakerWeaponExtModel", BaseModel)

function AwakerWeaponExtModel:OnInit()
end

function AwakerWeaponExtModel:OnReset()
end

function AwakerWeaponExtModel:IsWeaponUsing(uid)
  if 0 == uid then
    return false
  end
  if DBGTeamDataUtils.GetWeaponInTeamIdx(uid) then
    return true
  end
  if table.contains(SocialDataUtils.GetPreviewAwakerWeaponUids(), uid) then
    return true
  end
  return false
end

return AwakerWeaponExtModel
