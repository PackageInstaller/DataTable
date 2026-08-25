local AwakerLevelUpItemUseAwakerModel = NewClass("AwakerLevelUpItemUseAwakerModel", BaseModel)

function AwakerLevelUpItemUseAwakerModel:OnInit()
  self:OnReset()
end

function AwakerLevelUpItemUseAwakerModel:OnReset()
  self._selectAwakerId = 0
  self._darkTidMap = {}
  self._sortType = CommonDefine.AwakerSortType.Level
end

function AwakerLevelUpItemUseAwakerModel:SetSelectAwakerId(tid)
  if not tid then
    return
  end
  self._selectAwakerId = tid
end

function AwakerLevelUpItemUseAwakerModel:SetSortType(sortType)
  self._sortType = sortType
end

function AwakerLevelUpItemUseAwakerModel:GetSelectAwakerId()
  return self._selectAwakerId
end

function AwakerLevelUpItemUseAwakerModel:GetSortType()
  return self._sortType
end

function AwakerLevelUpItemUseAwakerModel:GetAwakerName(tid)
  do return AwakerDataUtils.GetAwakerName end
  return AwakerDataUtils.GetAwakerName, tid
end

function AwakerLevelUpItemUseAwakerModel:GetAwakerLevel(tid)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  return awaker and awaker.level or 0
end

function AwakerLevelUpItemUseAwakerModel:GetAwakerExp(tid)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  return awaker and awaker.exp or 0
end

function AwakerLevelUpItemUseAwakerModel:GetAwakerCurrLevelLimit(tid)
  local awaker = AwakerDataUtils.GetAwakerData(tid)
  if not awaker then
    return 0
  end
  do return AwakerDataUtils.GetAwakerCurrLevelLimit end
  return AwakerDataUtils.GetAwakerCurrLevelLimit, awaker
end

function AwakerLevelUpItemUseAwakerModel:GetAwakerConfig(tid)
  return DT.AwakerConfig[tid]
end

function AwakerLevelUpItemUseAwakerModel:GetSchoolIcon(schoolTid)
  local config = DT.SchoolConfig[schoolTid]
  return config and config.Icon or nil
end

function AwakerLevelUpItemUseAwakerModel:GetSortTypeTagContent(sortType, awakerTid)
  if not sortType or not awakerTid then
    return
  end
  local awaker = AwakerDataUtils.GetAwakerData(awakerTid)
  if not awaker then
    return
  end
  do return AwakerDataUtils.GetSortTypeTagContent, sortType end
  return AwakerDataUtils.GetSortTypeTagContent, sortType, awaker
end

function AwakerLevelUpItemUseAwakerModel:GetBaseTypeAwakerId()
  local awakerId = self._selectAwakerId
  if AwakerDataUtils.IsOriginType(awakerId) then
    awakerId = AwakerDataUtils.GetChangerForm(awakerId)
  end
  return awakerId
end

function AwakerLevelUpItemUseAwakerModel:GetIsDark(tid)
  return self._darkTidMap[tid]
end

function AwakerLevelUpItemUseAwakerModel:SetDarkTid(tid)
  self._darkTidMap[tid] = true
end

function AwakerLevelUpItemUseAwakerModel:IsDarkTid(tid)
  return self._darkTidMap[tid] == true
end

function AwakerLevelUpItemUseAwakerModel:ClearDarkTid()
  self._darkTidMap = {}
end

function AwakerLevelUpItemUseAwakerModel:HasOwnedAwaker(tid)
  if not tid then
    return false
  end
  do return AwakerDataUtils.HasOwnedAwaker end
  return AwakerDataUtils.HasOwnedAwaker, tid
end

return AwakerLevelUpItemUseAwakerModel
