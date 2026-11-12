function UTILS.AddEffect(nCharId, nEffectId, nLevel, nUseCount)
  if nUseCount == nil then
    nUseCount = 0
  end
  local mapEftCfgData = ConfigTable.GetData_Effect(nEffectId)
  if mapEftCfgData == nil then
    printError("Effect Id missing" .. nEffectId)
    return nil
  end
  local nEffectValueId = nEffectId
  if mapEftCfgData.levelTypeData == GameEnum.levelTypeData.Exclusive then
    nEffectValueId = nEffectValueId + nLevel * 10
  elseif mapEftCfgData.levelTypeData == GameEnum.levelTypeData.OutfitPromote then
  elseif mapEftCfgData.levelTypeData == GameEnum.levelTypeData.OutfifBreak then
  end
  local mapEftValueData = ConfigTable.GetData("EffectValue", nEffectValueId)
  if mapEftValueData == nil then
    printError("EffectValue Id missing" .. nEffectValueId)
    return nil
  end
  local nTakeEffectLimit = mapEftValueData.TakeEffectLimit
  local nEftRemainTimes = nTakeEffectLimit
  if nTakeEffectLimit ~= 0 then
    nEftRemainTimes = nTakeEffectLimit - nUseCount
    if nEftRemainTimes <= 0 then
      printLog("效果次数已用完:" .. nEffectId)
      return nil
    end
  end
  local nEffectUid = 0
  return nEffectUid
end

function UTILS.AddBuildEffect(mapCharEffect, mapOutfitEffect)
  local retCharEffect = {}
  local retOutfitEffect = {}
  for nCharId, mapEffect in pairs(mapCharEffect) do
    if mapEffect[AllEnum.EffectType.Affinity] ~= nil then
      for _, nEffectId in ipairs(mapEffect[AllEnum.EffectType.Affinity]) do
        if retCharEffect[AllEnum.EffectType.Affinity] == nil then
          retCharEffect[AllEnum.EffectType.Affinity] = {}
        end
        if retCharEffect[AllEnum.EffectType.Affinity][nEffectId] ~= nil then
          printError("重复的EffectID：" .. nEffectId)
        else
          local nEftUid = UTILS.AddEffect(nCharId, nEffectId, 0, 0)
          retCharEffect[AllEnum.EffectType.Affinity][nEffectId] = nEftUid
        end
      end
    end
    if mapEffect[AllEnum.EffectType.Talent] ~= nil then
      for _, nEffectId in ipairs(mapEffect[AllEnum.EffectType.Talent]) do
        if retCharEffect[AllEnum.EffectType.Talent] == nil then
          retCharEffect[AllEnum.EffectType.Talent] = {}
        end
        if retCharEffect[AllEnum.EffectType.Talent][nEffectId] ~= nil then
          printError("重复的EffectID：" .. nEffectId)
        else
          local nEftUid = UTILS.AddEffect(nCharId, nEffectId, 0, 0)
          retCharEffect[AllEnum.EffectType.Talent][nEffectId] = nEftUid
        end
      end
    end
    if mapOutfitEffect ~= nil then
      for nOutfitTid, tbOutfitEffectId in pairs(mapCharEffect) do
        if retOutfitEffect[nOutfitTid] == nil then
          retOutfitEffect[nOutfitTid] = {}
        end
        for _, nEffectId in ipairs(tbOutfitEffectId) do
          if retOutfitEffect[nOutfitTid][nEffectId] == nil then
            retOutfitEffect[nOutfitTid][nEffectId] = {}
          end
          local nEftUid = UTILS.AddEffect(nCharId, nEffectId, 0, 0)
          table.insert(retOutfitEffect[nOutfitTid][nEffectId], nEftUid)
        end
      end
    end
  end
end
