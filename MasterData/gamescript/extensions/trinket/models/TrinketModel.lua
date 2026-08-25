local MaxEquipTrinketsNum = CommonDefine.MaxEquipTrinketsNum
local ItemType = CommonDefine.ItemType
local TrinketModel, Super = NewClass("TrinketModel", BaseModel)

function TrinketModel:OnInit()
  self:OnReset()
end

function TrinketModel:OnReset()
end

function TrinketModel.CopyAwakerTrinkets(trinkets)
  local awakerTrinkets = {}
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    local trinketUid = trinkets and trinkets[i] or 0
    if 0 ~= trinketUid and not ItemDataUtils.GetItemByUid(trinketUid) then
      trinketUid = 0
    end
    awakerTrinkets[i] = trinketUid
  end
  return awakerTrinkets
end

function TrinketModel:HasAnyTrinketsInBag(partType)
  local itemBagData = DataCenter.itemData.BagItemData
  for _, v in pairs(itemBagData) do
    if not v then
    else
      local config = DT.Item[v.tid]
      if config.Type ~= ItemType.Trinket then
      elseif not AwakerTrinketDataUtils.IsTrinketVisibleInList(v.uid) then
      else
        if not partType or 0 == partType then
          return true
        end
        local pos = ItemDataUtils.GetTrinketPosIndex(v)
        if pos == partType then
          return true
        end
      end
    end
  end
  return false
end

function TrinketModel:IsSuitGatherAll(trinketUids)
  if not trinketUids then
    return false
  end
  local firstUid = trinketUids[1]
  if not firstUid or 0 == firstUid then
    return false
  end
  local firstTrinket = ItemDataUtils.GetItemByUid(firstUid)
  if not firstTrinket then
    return false
  end
  local count = 0
  local suitId = firstTrinket.suitId or 0
  if 0 == suitId then
    return false
  end
  for _, trinketUid in pairs(trinketUids) do
    local trinket = ItemDataUtils.GetItemByUid(trinketUid)
    if not trinket then
      return false
    end
    if trinket.suitId ~= suitId then
      return false
    end
    count = count + 1
  end
  return count == MaxEquipTrinketsNum
end

function TrinketModel:GetTrinketName(tid, withPosName)
  if 0 == tid then
    return ""
  end
  local name = ItemDataUtils.GetItemName(tid)
  if withPosName then
    local trinketInfo = ItemDataUtils.GetTrinketInfoByItemTid(tid)
    local pos = trinketInfo[1]
    name = string.format("%s · %s", name, pos)
  end
  return name
end

function TrinketModel:ExistsAnyTrinkets(trinkets)
  if not trinkets then
    return false
  end
  for _, trinketUid in pairs(trinkets) do
    if trinketUid and trinketUid > 0 then
      return true
    end
  end
  return false
end

function TrinketModel:GetTrinketAttrsByUids(trinketUids)
  local trinkets = {}
  for _, uid in pairs(trinketUids or {}) do
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if itemData then
      table.insert(trinkets, itemData)
    end
  end
  do return self.GetTrinketAttrs, self end
  return self.GetTrinketAttrs, self, trinkets, pairs(trinketUids or {})
end

function TrinketModel:GetTrinketAttrs(trinkets)
  local attrsActiveMap = {}
  for _, trinket in pairs(trinkets or {}) do
    if not trinket or not trinket.attrs then
    else
      for _, attr in pairs(trinket.attrs) do
        local curVal = attrsActiveMap[attr.attrId] or 0
        attrsActiveMap[attr.attrId] = curVal + attr.val
      end
    end
  end
  return attrsActiveMap
end

function TrinketModel:GetActiveTrinketAttrsByUids(trinketUids)
  local trinkets = {}
  for _, uid in pairs(trinketUids or {}) do
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if itemData then
      table.insert(trinkets, itemData)
    end
  end
  do return self.GetActiveTrinketAttrs, self end
  return self.GetActiveTrinketAttrs, self, trinkets, pairs(trinketUids or {})
end

function TrinketModel:GetActiveTrinketAttrs(trinkets)
  local attrsActiveMap = self:GetTrinketAttrs(trinkets)
  local showAttrIds = AwakerDataUtils.GetSortedAttrIds(CommonDefine.AttrShowType.TrinketShow)
  local attrsArray = {}
  for _, attrId in ipairs(showAttrIds) do
    table.insert(attrsArray, AwakerTrinketDataUtils.TrinketAttrToClientAttr({
      attrId = attrId,
      val = attrsActiveMap[attrId] or 0
    }))
  end
  return attrsArray
end

function TrinketModel:GetActiveSuitEffectsByUids(trinketUids)
  local trinkets = {}
  for _, uid in pairs(trinketUids or {}) do
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if itemData then
      table.insert(trinkets, itemData)
    end
  end
  do return self.GetActiveSuitEffects, self end
  return self.GetActiveSuitEffects, self, trinkets, pairs(trinketUids or {})
end

function TrinketModel:GetActiveSuitEffects(trinkets)
  local suitActiveMap = {}
  for _, trinket in pairs(trinkets or {}) do
    if not trinket or not trinket.suitId then
    else
      local suitId = trinket.suitId
      local activeNum = suitActiveMap[suitId]
      if not activeNum then
        suitActiveMap[suitId] = 1
      else
        suitActiveMap[suitId] = activeNum + 1
      end
    end
  end
  return suitActiveMap
end

function TrinketModel:GetActiveSuitAttrsList(trinkets)
  local suitActiveMap = self:GetActiveSuitEffects(trinkets)
  local suitEff = {}
  for suitId, activeNum in pairs(suitActiveMap) do
    local suitConfig = DT.TrinketSuitEffect[suitId]
    if suitConfig then
      for targetNum = 1, 6 do
        local suitNumKey = string.format("SuitEffectNum_%s", targetNum)
        if not suitConfig[suitNumKey] then
        else
          local suitActiveNum = suitConfig[suitNumKey]
          if activeNum >= suitActiveNum then
            local params = suitConfig["SuitEffectParam_" .. targetNum]
            if not params then
            else
              local attrId = params[1]
              if DT.ActorAttrType[attrId] and type(params[1]) == "number" then
                table.insert(suitEff, {
                  attrId = attrId,
                  val = params[2]
                })
              end
            end
          end
        end
      end
    end
  end
  return suitEff
end

function TrinketModel:GetActiveSuitEffectDescListByUids(trinketUids)
  local trinkets = {}
  for _, uid in pairs(trinketUids or {}) do
    local itemData = ItemDataUtils.GetItemByUid(uid)
    if itemData then
      table.insert(trinkets, itemData)
    end
  end
  do return self.GetActiveSuitEffectDescList, self end
  return self.GetActiveSuitEffectDescList, self, trinkets, pairs(trinketUids or {})
end

function TrinketModel:GetActiveSuitEffectDescList(trinkets)
  local suitActiveMap = self:GetActiveSuitEffects(trinkets)
  local descList = {}
  local titleColor = DT.ColorConfig.TrinketPlanSuitTitleActived
  local descColor = DT.ColorConfig.TrinketPlanSuitActived
  for suitId, activeNum in pairs(suitActiveMap) do
    local suitConfig = DT.TrinketSuitEffect[suitId]
    local suitName = LT.Text(suitConfig.Name)
    local titleDesc = string.format("<color=%s>%s (%s)</color>", titleColor.Light, suitName, activeNum)
    local tmp = {}
    for targetNum = 1, 6 do
      local descKey = string.format("SuitEffectDesc_%s", targetNum)
      local desc = suitConfig[descKey] and LT.Text(suitConfig[descKey])
      if desc then
        local suitActiveNum = targetNum
        local suitNumKey = string.format("SuitEffectNum_%s", targetNum)
        if suitConfig[suitNumKey] then
          suitActiveNum = suitConfig[suitNumKey]
        end
        if activeNum >= suitActiveNum then
          desc = LT.Textf("TrinketSuitEffect", suitActiveNum, desc)
          desc = string.format("<color=%s>%s</color>", descColor.Light, desc)
          local tmpData = {activeNum = suitActiveNum, desc = desc}
          table.insert(tmp, tmpData)
        end
      end
    end
    table.sort(tmp, function(a, b)
      return a.activeNum < b.activeNum
    end)
    if #tmp > 0 then
      local descData = {
        suitEffectTitle = LT.Text(titleDesc),
        effectDescList = tmp,
        suitId = suitId,
        activeNum = activeNum
      }
      table.insert(descList, descData)
    end
  end
  table.sort(descList, function(a, b)
    return #a.effectDescList > #b.effectDescList
  end)
  return descList
end

return TrinketModel
