local BonusCardModel = NewClass("BonusCardModel", BaseModel)

function BonusCardModel:OnInit()
end

function BonusCardModel:OnReset()
end

function BonusCardModel:GetBonusShortTips(stageGroupTid, ...)
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if not stageGroupConfig or not stageGroupConfig.BonusTips then
    return
  end
  local key = stageGroupConfig.BonusTips[1]
  if not key then
    return
  end
  local textParams = table.pack(...)
  if table.next(textParams) ~= nil then
    do return LT.Textf, key, ... end
    return LT.Textf, key, ...
  end
  do return LT.Text end
  return LT.Text, key, ...
end

function BonusCardModel:GetBonusTipsViewContent(stageGroupTid)
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if not stageGroupConfig or not stageGroupConfig.BonusTips then
    return
  end
  local title = stageGroupConfig.BonusTips[2] and LT.Text(stageGroupConfig.BonusTips[2])
  local content = stageGroupConfig.BonusTips[3] and LT.Text(stageGroupConfig.BonusTips[3])
  return title, content
end

function BonusCardModel:GetBonusRewardTagText(stageGroupTid)
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  local tagTextKey = stageGroupConfig and stageGroupConfig.BonusTips and stageGroupConfig.BonusTips[4]
  return tagTextKey and LT.Text(tagTextKey)
end

function BonusCardModel:GetBonusRateByStageGroupTid(stageGroupTid, assistAwaker, assistItems)
  local list = self:GetBonusByStageGroupTid(stageGroupTid)
  if not list then
    return
  end
  do return self.GetBonusRateByBonusTidList, self, list, assistAwaker end
  return self.GetBonusRateByBonusTidList, self, list, assistAwaker, assistItems
end

function BonusCardModel:GetBonusByStageGroupTid(stageGroupTid)
  local stageGroupConfig = CopyDataUtils.GetStageGroupConfig(stageGroupTid)
  if not stageGroupConfig or not stageGroupConfig.Bonus then
    return
  end
  return stageGroupConfig.Bonus
end

function BonusCardModel:GetBonusRateByBonusTidList(bonusTidList, assistAwaker, assistItems)
  if not bonusTidList then
    return 0
  end
  local allRate = {}
  local curMaxRate = 0
  for i = 1, #bonusTidList do
    local curRate = self:GetBonusRateByBonusTid(bonusTidList[i], assistAwaker, assistItems)
    if curRate then
      allRate[curRate.itemId] = allRate[curRate.itemId] or 0
      allRate[curRate.itemId] = allRate[curRate.itemId] + curRate.rate
      if curMaxRate < allRate[curRate.itemId] then
        curMaxRate = allRate[curRate.itemId]
      end
    end
  end
  return curMaxRate
end

function BonusCardModel:GetBonusRateByBonusTid(bonusTid, assistAwaker, assistItems)
  local bonusCfg = DT.Bonus[bonusTid]
  if not bonusCfg then
    return
  end
  local awakerRate = self:GetAwakerRateByBonusTid(bonusTid, assistAwaker)
  local weaponRate = self:GetWeaponRateByBonusTid(bonusTid, assistAwaker, assistItems)
  local activityShopRate = self:GetActivityShopRateByBonusTid(bonusTid)
  return {
    itemId = bonusCfg.BonusItem,
    rate = awakerRate + weaponRate + activityShopRate
  }
end

function BonusCardModel:GetAwakerRateByBonusTid(bonusTid, assistAwaker)
  local bonusCfg = DT.Bonus[bonusTid]
  if not (bonusCfg and bonusCfg.Awaker) or 0 == bonusCfg.Awaker then
    return 0
  end
  local awakerRate = 0
  local assistAwakerRate = 0
  local changeTid = AwakerDataUtils.GetChangerForm(bonusCfg.Awaker)
  local awakerData = AwakerDataUtils.GetAwakerData(bonusCfg.Awaker)
  awakerData = awakerData or AwakerDataUtils.GetAwakerData(changeTid)
  if awakerData and awakerData.state == CommonDefine.AwakerState.Owned and bonusCfg.PotencyBonusRatio then
    local len = math.min((awakerData.potencyLevel or 0) + 1, #bonusCfg.PotencyBonusRatio)
    awakerRate = bonusCfg.PotencyBonusRatio and bonusCfg.PotencyBonusRatio[len] or 0
  end
  if assistAwaker and (assistAwaker.tid == bonusCfg.Awaker or assistAwaker.tid == changeTid) and bonusCfg.AssistPotencyBonusRatio then
    local len = math.min((assistAwaker.potencyLevel or 0) + 1, #bonusCfg.AssistPotencyBonusRatio)
    assistAwakerRate = bonusCfg.AssistPotencyBonusRatio and bonusCfg.AssistPotencyBonusRatio[len] or 0
  end
  do return math.max, awakerRate or 0 end
  return math.max, awakerRate or 0, assistAwakerRate or 0
end

function BonusCardModel:GetWeaponRateByBonusTid(bonusTid, assistAwaker, assistItems)
  local bonusCfg = DT.Bonus[bonusTid]
  if not (bonusCfg and bonusCfg.Weapon) or 0 == bonusCfg.Weapon then
    return 0
  end
  local weaponRate = 0
  local assistWeaponRate = 0
  if bonusCfg.RefineBonusRatio then
    local uids = ItemDataUtils.GetItemUidMap(bonusCfg.Weapon)
    if uids then
      local maxLevelItem
      for uid, _ in pairs(uids) do
        local item = ItemDataUtils.GetItemByUid(uid)
        if not item then
        elseif not maxLevelItem or maxLevelItem.level < item.level then
          maxLevelItem = item
        end
      end
      if maxLevelItem then
        local len = math.min(#bonusCfg.RefineBonusRatio, maxLevelItem.level + 1)
        weaponRate = bonusCfg.RefineBonusRatio and bonusCfg.RefineBonusRatio[len] or 0
      end
    end
  end
  if bonusCfg.AssistRefineBonusRatio and assistAwaker and AwakerDataUtils.GetWeaponSlotData(assistAwaker) then
    for _, weapon in pairs(AwakerDataUtils.GetWeaponSlotData(assistAwaker)) do
      local item = assistItems and assistItems[weapon.weaponUid] or nil
      if item and item.tid == bonusCfg.Weapon then
        local len = math.min(#bonusCfg.AssistRefineBonusRatio, item.level + 1)
        assistWeaponRate = bonusCfg.AssistRefineBonusRatio and bonusCfg.AssistRefineBonusRatio[len] or 0
      end
    end
  end
  do return math.max, weaponRate or 0 end
  return math.max, weaponRate or 0, assistWeaponRate or 0, pairs(AwakerDataUtils.GetWeaponSlotData(assistAwaker))
end

function BonusCardModel:GetActivityShopRateByBonusTid(bonusTid)
  local bonusCfg = DT.Bonus[bonusTid]
  if not (bonusCfg and bonusCfg.ActivityShopPara) or not bonusCfg.ActivityShopBonusRatio then
    return 0
  end
  local activityShopRate = 0
  for idx, shopId in ipairs(bonusCfg.ActivityShopPara) do
    local rate = bonusCfg.ActivityShopBonusRatio[idx]
    local shopItemData = MainShopDataUtils.GetShopDataByTid(shopId)
    if shopItemData then
      local isBuyPassport = shopItemData.buyCount >= 1
      if rate and isBuyPassport then
        activityShopRate = activityShopRate + rate
      end
    end
  end
  return activityShopRate
end

return BonusCardModel
