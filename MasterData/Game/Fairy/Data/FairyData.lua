local FairyData = class("FairyData")
local FairySkillData = require("Game.Fairy.Data.FairySkillData")

function FairyData.GenFairyData(fairyMsg)
  local fairyData = FairyData.New()
  fairyData:UpdaetFairyData(fairyMsg)
  return fairyData
end

function FairyData:ctor()
  self.fairyID = nil
  self.fairyUID = nil
  self.name = nil
  self.fairySkinId = nil
  self.level = nil
  self.exp = nil
  self.star = nil
  self.slillSlotDic = nil
  self.isFavourite = nil
  self.__extrAttrDic = nil
end

function FairyData:UpdaetFairyData(fairyMsg)
  local base = fairyMsg.base
  local skill = fairyMsg.skill
  if fairyMsg.keepData == nil then
    self._keepDataDic = nil
    self._keepDataStar = nil
  else
    self._keepDataDic = fairyMsg.keepData.keepSkills
    self._keepDataStar = fairyMsg.keepData.rank
  end
  self.fairyUID = base.uid
  self.fairyID = base.dataId
  self.level = base.level
  self.exp = base.exp
  self.star = base.rank
  self.name = base.name
  self.isFavourite = base.favor
  self.slillSlotDic = {}
  for _, fairySkillMsg in pairs(skill.data) do
    local fSkillData = FairySkillData.GenFairySkillData(self.fairyUID, fairySkillMsg)
    local index = fSkillData:GetFairySkillSlotIndex()
    self.slillSlotDic[index] = fSkillData
  end
  self.__extrAttrDic = nil
end

function FairyData:GetFairyID()
  return self.fairyID
end

function FairyData:GetFairyUID()
  return self.fairyUID
end

function FairyData:GetFairyCurLevel()
  return self.level
end

function FairyData:GetFairyCurExp()
  return self.exp
end

function FairyData:GetFairyCurStar()
  return self.star
end

function FairyData:GetFairyCurName(isTypeName)
  if not string.IsNullOrEmpty(self.name) and not isTypeName then
    return self.name
  end
  local fairyId = self:GetFairyID()
  local fairyCfg = ConfigData.fairy_data[fairyId]
  return LanguageUtil.GetLocaleText(fairyCfg.name)
end

function FairyData:GetFairyItemID()
  local fairyId = self:GetFairyID()
  local fairyCfg = ConfigData.fairy_data[fairyId]
  return fairyCfg.item_id
end

function FairyData:GetFairyPerformAudioId()
  local fairyId = self:GetFairyID()
  local fairyCfg = ConfigData.fairy_data[fairyId]
  return fairyCfg.audio_perform
end

function FairyData:GetFairySkillBySlotIndex(slotIndex)
  return self.slillSlotDic[slotIndex]
end

function FairyData:GetFairySkillDic()
  return self.slillSlotDic
end

function FairyData:GetFairyAttrAdd()
  if self.__extrAttrDic ~= nil then
    return self.__extrAttrDic
  end
  local extrAttrDic = {}
  local level = self:GetFairyCurLevel()
  local fairyId = self:GetFairyID()
  if ConfigData.fairy_level_attr[fairyId] ~= nil and ConfigData.fairy_level_attr[fairyId][level] ~= nil then
    local attrDic = ConfigData.fairy_level_attr[fairyId][level]
    for attrId, value in pairs(attrDic.level_attribute) do
      extrAttrDic[attrId] = value
    end
  end
  self.__extrAttrDic = extrAttrDic
  return self.__extrAttrDic
end

function FairyData:SetIsFavouriteFairy(bool)
  self.isFavourite = bool
end

function FairyData:GetIsFavouriteFairy()
  return self.isFavourite
end

function FairyData:GetCurStarMaxLevel()
  local star = self:GetFairyCurStar()
  return ConfigData.fairy_star_new[star].level_max
end

function FairyData:GetFyStarMaxLevel(star)
  if ConfigData.fairy_star_new[star] == nil then
    error("cant get fairy_star_new, star:" .. tostring(star))
    return
  end
  return ConfigData.fairy_star_new[star].level_max
end

function FairyData:GetMaxStarMaxLevel()
  local star = self:GetMaxStar()
  return ConfigData.fairy_star_new[star].level_max
end

function FairyData:GetIsFairyCurLevelMaxExp()
  local level = self:GetFairyCurLevel()
  return ConfigData.fairy_level[level].exp
end

function FairyData:GetMaxStar()
  return #ConfigData.fairy_star_new
end

function FairyData:GetNextMaxLevel()
  local curStar = self:GetFairyCurStar()
  if curStar == self:GetMaxStar() then
    return self:GetCurStarMaxLevel()
  end
  curStar = curStar + 1
  return ConfigData.fairy_star_new[curStar].level_max
end

function FairyData:GetLastMaxLevel()
  local curStar = self:GetFairyCurStar()
  if 1 < curStar then
    curStar = curStar - 1
  else
    return 1
  end
  return ConfigData.fairy_star_new[curStar].level_max
end

function FairyData:GetResLevel()
  local star = self:GetFairyCurStar()
  local starCfg = ConfigData.fairy_star_new[star]
  return starCfg.res_level
end

function FairyData:GetMaxSkillNum()
  local star = self:GetFairyCurStar()
  local starCfg = ConfigData.fairy_star_new[star]
  return starCfg.skill_slot
end

function FairyData:GetLastMaxSkillNum()
  local curStar = self:GetFairyCurStar()
  if curStar == 1 then
    return 1
  end
  curStar = curStar - 1
  return ConfigData.fairy_star_new[curStar].skill_slot
end

function FairyData:GetFyStarSkillNum(star)
  local starCfg = ConfigData.fairy_star_new[star]
  if starCfg == nil then
    error("cant get fairy_star_new")
    return
  end
  return starCfg.skill_slot
end

function FairyData:GetNextMaxSkillNum()
  local curStar = self:GetFairyCurStar()
  if curStar == self:GetMaxStar() then
    return self:GetMaxSkillNum()
  end
  curStar = curStar + 1
  return ConfigData.fairy_star_new[curStar].skill_slot
end

function FairyData:GetMaxStateSkillNum()
  return 3
end

function FairyData:GetCurFairyQuality()
  local maxLevel = #ConfigData.fairy_skill_weight
  for i, fairySkillData in pairs(self.slillSlotDic) do
    if maxLevel > fairySkillData.fairySkillRare then
      maxLevel = fairySkillData.fairySkillRare
    end
  end
  return maxLevel
end

function FairyData:GetMaxUpLevel()
  if not self:GetIsUpgradeState() then
    return self:GetCurStarMaxLevel()
  end
  local nowLevel = self:GetFairyCurLevel()
  local maxLevel = self:GetCurStarMaxLevel()
  local canUpLevel = nowLevel
  local remainExp = 0
  for i = nowLevel + 1, maxLevel do
    remainExp = remainExp + ConfigData.fairy_level[i - 1].exp
    if remainExp <= PlayerDataCenter:GetItemCount(ConstGlobalItem.FairyExp) then
      canUpLevel = i
    else
      break
    end
  end
  return canUpLevel
end

function FairyData:GetIsFairyCouldLevelUp()
  if not self:GetIsUpgradeState() then
    return false
  end
  local remainExp = self:GetIsFairyCurLevelMaxExp() - self:GetFairyCurExp()
  if remainExp <= PlayerDataCenter:GetItemCount(ConstGlobalItem.FairyExp) then
    return true
  end
  return false
end

function FairyData:GetIsFairyCouldStarUp()
  local star = self:GetFairyCurStar()
  if not self:GetIsUpStarState() then
    return false
  end
  local starCfg = ConfigData.fairy_star_new[star]
  for itemId, needNum in pairs(starCfg.cost) do
    if needNum > PlayerDataCenter:GetItemCount(itemId) then
      return false, itemId
    end
  end
  return true
end

function FairyData:GetIsFairyCouldRecombine()
  local star = self:GetFairyCurStar()
  if not self:GetIsRecombinationState() then
    return false
  end
  local starCfg = ConfigData.fairy_star_new[star]
  for itemId, needNum in pairs(starCfg.tran_cost) do
    if needNum > PlayerDataCenter:GetItemCount(itemId) then
      return false
    end
  end
  return true
end

function FairyData:GetUpStarMainItemList()
  local star = self:GetFairyCurStar()
  local starCfg = ConfigData.fairy_star_new[star]
  return starCfg.starUpItemIds, starCfg.starUpItemNums
end

function FairyData:GetRecombineItem()
  local star = self:GetFairyCurStar()
  local starCfg = ConfigData.fairy_star_new[star]
  for itemId, needNum in pairs(starCfg.tran_cost) do
    return itemId, needNum
  end
  error("fairy_star_new，消耗配置不正确")
end

function FairyData:GetLvUpTime()
  local fairyId = self:GetFairyID()
  local fairyCfg = ConfigData.fairy_data[fairyId]
  return fairyCfg.time_lvup or 0
end

function FairyData:GetIsUpgradeState()
  return self:GetFairyCurLevel() < self:GetCurStarMaxLevel()
end

function FairyData:GetIsUpStarState()
  return self:GetFairyCurLevel() >= self:GetCurStarMaxLevel() and self:GetFairyCurStar() < self:GetMaxStar()
end

function FairyData:GetIsRecombinationState()
  local star = self:GetFairyCurStar()
  if star ~= self:GetMaxStar() then
    return false
  end
  if self:GetFairyCurLevel() < self:GetCurStarMaxLevel() then
    return false
  end
  return true
end

function FairyData:GetIsSatisfyConsume(fairyData)
  if fairyData == self then
    return false
  end
  local star = self:GetFairyCurStar()
  local newStar = fairyData:GetFairyCurStar()
  return star == newStar
end

function FairyData:GetFairyReplacedCommanderSkill()
  local s2tDic = {}
  for slotIndex, fairySkillData in pairs(self.slillSlotDic) do
    local sSkillId, tSkillId = fairySkillData:TryGetFairySkillReplace()
    if sSkillId ~= nil then
      s2tDic[sSkillId] = tSkillId
    end
  end
  return s2tDic
end

function FairyData:GetFairyPoolId()
  local fairyId = self:GetFairyID()
  local fairyCfg = ConfigData.fairy_data[fairyId]
  return fairyCfg.skill_list
end

function FairyData:GetFairySkinID()
  if self.fairySkinId ~= nil and self.fairySkinId ~= 0 then
    return self.fairySkinId
  end
  local fairyId = self:GetFairyID()
  local fairyCfg = ConfigData.fairy_data[fairyId]
  local dafultSkinId = fairyCfg.src_id
  return dafultSkinId
end

function FairyData:GetFairyHeadIconStr()
  local skinId = self:GetFairySkinID()
  local level = self:GetResLevel()
  return ConfigData.fairy_res[skinId][level].src_id_head
end

function FairyData:GetFairyPicResStr()
  local skinId = self:GetFairySkinID()
  local level = self:GetResLevel()
  local resCfg = ConfigData.fairy_res[skinId][level]
  return PathConsts:GetFairyPicPath(resCfg.src_id_pic)
end

function FairyData:GetFairyPrefabResStr()
  local skinId = self:GetFairySkinID()
  local level = self:GetResLevel()
  local resCfg = ConfigData.fairy_res[skinId][level]
  return PathConsts:GetFairyPrefabPath(resCfg.src_id_model)
end

function FairyData:GetFairySkillLevelBySkillId(skillId)
  local maxLevel = 0
  for i, fairySkillData in pairs(self.slillSlotDic) do
    local fsId = fairySkillData:GetFiaryRealSkillId()
    if fsId == skillId then
      local level = fairySkillData:GetFairySkillLevel()
      if maxLevel < level then
        maxLevel = level
      end
    end
  end
  return maxLevel
end

function FairyData:GetFairyAiCfg()
  return ConfigData.dorm_ai[4001]
end

function FairyData:GetFairyKeepData()
  return self._keepDataDic, self._keepDataStar
end

return FairyData
