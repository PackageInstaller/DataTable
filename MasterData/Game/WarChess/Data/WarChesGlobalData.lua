local WarChesGlobalData = class("WarChesGlobalData")

function WarChesGlobalData:ctor()
  self._guideCount = {}
  self._enterPlayCount = 0
  self._outsideItemBoxDic = {}
end

function WarChesGlobalData:GetWCGuideExeCount(wcGuideId)
  return self._guideCount[wcGuideId] or 0
end

function WarChesGlobalData:SetWCGuideExeCount(wcGuideId, count)
  self._guideCount[wcGuideId] = count
end

function WarChesGlobalData:SetEnterPlayCount(count)
  self._enterPlayCount = count
end

function WarChesGlobalData:GetEnterPlayCount()
  return self._enterPlayCount
end

function WarChesGlobalData:SetOutsideItemBoxDic(dic)
  if dic == nil then
    return
  end
  table.merge(self._outsideItemBoxDic, dic)
end

function WarChesGlobalData:SetOutsideItemBoxReceive(boxId)
  self._outsideItemBoxDic[boxId] = true
end

function WarChesGlobalData:IsReceivedOutsideItemBox(boxId)
  return self._outsideItemBoxDic[boxId]
end

function WarChesGlobalData:GetOutSideBoxReward(boxId)
  local warchessId = WarChessManager:GetWCLevelId()
  local outSideCfg = ConfigData.warchess_level_real_rewards[warchessId]
  if outSideCfg == nil then
    return
  end
  local cfg = outSideCfg[boxId]
  if cfg == nil then
    return
  end
  return cfg.reward_ids, cfg.reward_nums
end

return WarChesGlobalData
