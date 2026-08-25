local AwakerSelectShowingModel = NewClass("AwakerSelectShowingModel", BaseModel)

function AwakerSelectShowingModel:OnInit()
  self:OnReset()
end

function AwakerSelectShowingModel:OnReset()
  self.curSelectAwakerTid = nil
  self._awakerGroup = nil
end

function AwakerSelectShowingModel:ResetData()
  self:OnReset()
end

function AwakerSelectShowingModel:GetCurSelectAwakerTid()
  return self.curSelectAwakerTid
end

function AwakerSelectShowingModel:GetSelectAwakerGroup()
  local list = AwakerDataUtils.GetOwnedAwakerList()
  table.sort(list, function(a, b)
    local aCfg = DT.AwakerConfig[a.tid]
    local bCfg = DT.AwakerConfig[b.tid]
    return aCfg.BaseSortID < bCfg.BaseSortID
  end)
  return list
end

function AwakerSelectShowingModel:GetAwakerLike()
  local awakerId = self.curSelectAwakerTid
  local awaker = AwakerDataUtils.GetAwakerData(awakerId)
  if not awaker then
    return 0
  end
  local level = awaker.likeLevel or 0
  local cfg = DT.AwakerFavorability[awakerId]
  local datalist = cfg.data_list
  local totalNeed = 0
  for _, v in ipairs(datalist) do
    if level >= v.AwakerFavorabilityLevel then
      totalNeed = totalNeed + v.AwakerFavorabilityRequire
    end
  end
  local awakerLike = awaker.like or 0
  return totalNeed + awakerLike
end

function AwakerSelectShowingModel:GetNextAwakerLike()
  local awakerId = self.curSelectAwakerTid
  local awaker = AwakerDataUtils.GetAwakerData(awakerId)
  if not awaker then
    return 0
  end
  local level = awaker.likeLevel or 0
  local cfg = DT.AwakerFavorability[awakerId]
  local datalist = cfg.data_list
  local totalNeed = 0
  local breakThroughLv = AwakerFavorabilityCfgUtils.GetBreakthroughLevel(awakerId)
  for _, v in ipairs(datalist) do
    totalNeed = totalNeed + v.AwakerFavorabilityRequire
    if level < v.AwakerFavorabilityLevel or breakThroughLv <= v.AwakerFavorabilityLevel then
      return totalNeed
    end
  end
  return totalNeed
end

function AwakerSelectShowingModel:SetCurSelectAwakerTid(tid)
  if not tid then
    return
  end
  self.curSelectAwakerTid = tid
end

return AwakerSelectShowingModel
