local AwakerLevelUpItemUseModel, Super = NewClass("AwakerLevelUpItemUseModel", BaseModel)

function AwakerLevelUpItemUseModel:ctor(itemUid)
  Super.ctor(self)
  self._itemUid = itemUid
end

function AwakerLevelUpItemUseModel:OnInit()
  self:OnReset()
end

function AwakerLevelUpItemUseModel:OnReset()
  self._awakerTid = nil
  local fastPromotionSpParam = self:_GetFastPromotionSpParam()
  self._toLevel = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(fastPromotionSpParam, CommonDefine.FastPromotionSpParamKey.DirectPromotionLevel)) or 0
  self._toSkillLevel = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(fastPromotionSpParam, CommonDefine.FastPromotionSpParamKey.DirectSkillPromotionLevel)) or 0
  self._toBreakLevel = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(fastPromotionSpParam, CommonDefine.FastPromotionSpParamKey.DirectBreakthroughStage)) or 0
  self._toBreakSkillUnlock1 = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(fastPromotionSpParam, CommonDefine.FastPromotionSpParamKey.BreakthroughSkill1Unlocked))
  self._toBreakSkillUnlock2 = tonumber(ItemDataUtils.GetFastPromotionSpParamValByKey(fastPromotionSpParam, CommonDefine.FastPromotionSpParamKey.BreakthroughSkill2Unlocked))
  self._awakerList = self:_SortAwakerList()
end

function AwakerLevelUpItemUseModel:_GetFastPromotionSpParam()
  local rst = {}
  local item = ItemDataUtils.GetItemByUid(self._itemUid)
  if item then
    local cfg = DT.Item[item.tid]
    rst = cfg.SpParam
  end
  return rst
end

function AwakerLevelUpItemUseModel:GetItemUid()
  return self._itemUid
end

function AwakerLevelUpItemUseModel:GetAwakerTid()
  return self._awakerTid
end

function AwakerLevelUpItemUseModel:GetToLevel()
  return self._toLevel
end

function AwakerLevelUpItemUseModel:GetToSkillLevel()
  return self._toSkillLevel
end

function AwakerLevelUpItemUseModel:GetToBreakLevel()
  return self._toBreakLevel
end

function AwakerLevelUpItemUseModel:GetToBreakSkillUnlock1()
  return self._toBreakSkillUnlock1
end

function AwakerLevelUpItemUseModel:GetToBreakSkillUnlock2()
  return self._toBreakSkillUnlock2
end

function AwakerLevelUpItemUseModel:GetAwakerList()
  return self._awakerList
end

function AwakerLevelUpItemUseModel:GetAwakerListCount()
  return self._awakerList and #self._awakerList or 0
end

function AwakerLevelUpItemUseModel:GetAwakerDataByIndex(index)
  if not self._awakerList then
    return nil
  end
  return self._awakerList[index]
end

function AwakerLevelUpItemUseModel:SetAwakerTid(tid)
  if not tid then
    return
  end
  self._awakerTid = tid
  self:LocalNotify(NotifyId.OnItemUseAwakerLevelUpTidChanged, tid)
end

function AwakerLevelUpItemUseModel:SetItemUid(uid)
  self._itemUid = uid
  self:OnReset()
end

function AwakerLevelUpItemUseModel:_SortAwakerList()
  local awakerList = ItemDataUtils.GetItemLevelUpAwakerList(self._itemUid, true)
  table.sort(awakerList, function(a, b)
    if a.isCanUse ~= b.isCanUse then
      return a.isCanUse
    end
    if a.qualitySort ~= b.qualitySort then
      return a.qualitySort > b.qualitySort
    end
    if a.awakerData.level ~= b.awakerData.level then
      return a.awakerData.level < b.awakerData.level
    end
    return a.awakerData.tid > b.awakerData.tid
  end)
  return awakerList
end

return AwakerLevelUpItemUseModel
