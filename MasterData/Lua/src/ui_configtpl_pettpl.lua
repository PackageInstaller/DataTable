local this = class("petTpl")
local _mountTpl = L_GameTpl:getMountTpl()

function this:init(config)
  self.data = config
  local countIconographyshow = 0
  for k, v in pairs(self.data) do
    if v.iconographyshow == 1 then
      countIconographyshow = countIconographyshow + 1
    end
  end
  self.totalIconographyshow = countIconographyshow
end

function this:getTplById(id)
  return self.data[id]
end

function this:getAllTpl()
  return self.data
end

function this:getSpeciesId(tpl)
  return tpl.speciesId
end

function this:getIsRename(tpl)
  return tpl.isRename
end

function this:getIsCatch(tpl)
  return tpl.IsCatch
end

function this:getCatchHP(tpl)
  return tpl.catchHP
end

function this:getSize(tpl)
  return tpl.size
end

function this:getGrowthAttribute(tpl)
  local growthAttribute = {}
  for i, v in pairs(tpl.growthAttribute) do
    growthAttribute[i] = v / 10000
  end
  return growthAttribute
end

function this:getPetIcon(tpl, isSpecial)
  local petIcon
  if not isSpecial or isSpecial == 0 then
    petIcon = L_Config:getPathByHash(tpl.petIcon)
  else
    petIcon = L_Config:getPathByHash(tpl.petIconSp[isSpecial])
  end
  if string.isEmpty(petIcon) then
    return "UI/Atlas/Item/tex_icon_pet_default.png"
  end
  return petIcon
end

function this:getPetPixelIcon(tpl, isSpecial)
  local petIcon
  if not isSpecial or isSpecial == 0 then
    petIcon = L_Config:getPathByHash(tpl.petPixelIcon)
  else
    petIcon = L_Config:getPathByHash(tpl.petPixelIconSp[isSpecial])
  end
  if string.isEmpty(petIcon) then
    return "UI/Atlas/Item/tex_icon_pet_default.png"
  end
  return petIcon
end

function this:getPetBattleIcon(tpl, index, isSpecial)
  local petIcon
  if not isSpecial or isSpecial == 0 then
    petIcon = L_Config:getPathByHash(tpl.petBattleIcon[index])
  else
    petIcon = L_Config:getPathByHash(tpl.petBattleIconSp[isSpecial][index])
  end
  if string.isEmpty(petIcon) then
    return "UI/Atlas/Item/tex_icon_pet_default.png"
  end
  return petIcon
end

function this:getKiboBoxCardIcon(tpl, index, isSpecial)
  local petIcon
  if not isSpecial or isSpecial == 0 then
    petIcon = L_Config:getPathByHash(tpl.kiboBoxCardIcon[index])
  else
    if tpl.kiboBoxCardIconSp[isSpecial] then
      petIcon = L_Config:getPathByHash(tpl.kiboBoxCardIconSp[isSpecial][index])
    end
    if string.isEmpty(petIcon) then
      petIcon = L_Config:getPathByHash(tpl.kiboBoxCardIcon[index])
    end
  end
  if string.isEmpty(petIcon) then
    return ""
  end
  return petIcon
end

function this:getPetLongIcon(tpl)
  local petIcon = L_Config:getPathByHash(tpl.petlongIcon)
  if string.isEmpty(petIcon) then
    return "UI/Atlas/Item/tex_icon_pet_default.png"
  end
  return petIcon
end

function this:getPetPuzzleIcon(tpl)
  local petIcon = L_Config:getPathByHash(tpl.petPuzzleIcon)
  if string.isEmpty(petIcon) then
    return "UI/Icon/BuffS/tex_battle_icon_guang.png"
  end
  return petIcon
end

function this:getGradeScore(tpl, isSpecial)
  if not isSpecial or isSpecial == 0 then
    return tpl.gradeScore
  end
  return tpl.gradeScoreSp[isSpecial] or 0
end

function this:getPuzzleType(tpl)
  return tpl.puzzleType
end

function this:getRace(tpl)
  return tpl.race
end

function this:getIsBattle(tpl)
  return tpl.isBattle
end

function this:getIsMount(tpl)
  return _mountTpl:isMount(tpl.id)
end

function this:getElement(tpl)
  return tpl.element
end

function this:getIsRelease(tpl)
  return tpl.isRelease
end

function this:getFirstElement(tpl)
  return tpl.element[1]
end

function this:getBaseAttribute(tpl)
  local baseAttribute = {}
  for i, v in pairs(tpl.baseAttribute) do
    baseAttribute[i] = v
  end
  return baseAttribute
end

function this:getName(tpl, isSpecial)
  if not isSpecial or isSpecial == 0 then
    return L_Config:provider(tpl.name)
  end
  return L_Config:provider(tpl.nameSp[isSpecial])
end

function this:getRawName(tpl, isSpecial)
  if not isSpecial or isSpecial == 0 then
    return tpl.name
  end
  return tpl.nameSp[isSpecial]
end

function this:getSkillGet(tpl)
  return tpl.skillGet
end

function this:getDesc(tpl)
  return L_Config:provider(tpl.desc)
end

function this:getUnitID(tpl)
  return tpl.unitId
end

function this:getUnitScaleGet(tpl)
  return tpl.unitScaleGet
end

function this:getUnitPositionGet(tpl)
  return tpl.unitPositionGet
end

function this:getUnitRotationGet(tpl)
  return tpl.unitRotationGet
end

function this:getUnitRotationType(tpl)
  return tpl.unitRotationType
end

function this:getId(tpl)
  return tpl.id
end

function this:getFeature(tpl)
  return tpl.feature
end

function this:getEgg(tpl)
  return tpl.egg
end

function this:getPetStage(tpl)
  return tpl.petStage
end

function this:getRandomSkillListCount(tpl)
  return tpl.rPropertyskillCount
end

function this:getRandomSkillList(tpl)
  return tpl.rPropertyskillList
end

function this:getFeatureSkillList(tpl)
  return tpl.fPropertyskillList
end

function this:getKiboBPropertyskillList(tpl)
  return tpl.kiboBPropertyskillList
end

function this:getBPropertyskillList(tpl)
  return tpl.bPropertyskillList
end

function this:getSignatureSkillList(tpl)
  return tpl.signatureSkillList
end

function this:getSkillListCount(tpl)
  return tpl.skillListCount
end

function this:getCommonSkillList(tpl)
  return tpl.skillList
end

function this:getBreakSkillList(tpl)
  return tpl.breakSkillList
end

function this:getFixedSkillList(tpl)
  return tpl.fixedSkillList
end

function this:getMountSkillList(tpl)
  return tpl.mountSkill or {}
end

function this:getMountSkillBySlot(tpl, slotType)
  local mountSkillList = self:getMountSkillList(tpl)
  return mountSkillList[slotType]
end

function this:getMountSkill751(tpl)
  return self:getMountSkillBySlot(tpl, 751)
end

function this:getPetPixelPosition(tpl, isSpecial)
  if not isSpecial or isSpecial == 0 then
    return tpl.petPixelPosition
  end
  return tpl.petPixelPositionSp[isSpecial]
end

function this:getDna(tpl)
  return tpl.dna
end

function this:getDnaRecommend(tpl)
  return tpl.dnaRecommend
end

function this:getKiboCardIcon(tpl, isSpecial)
  if not isSpecial or isSpecial == 0 then
    return tpl.kiboCardIcon[1]
  end
  if tpl.kiboCardIconSp[isSpecial] ~= nil then
    return tpl.kiboCardIconSp[isSpecial][1]
  end
end

function this:getKiboCardIconBg(tpl, isSpecial)
  if not isSpecial or isSpecial == 0 then
    return tpl.kiboCardIcon[2]
  end
  if tpl.kiboCardIconSp[isSpecial] ~= nil then
    return tpl.kiboCardIconSp[isSpecial][2]
  end
end

function this:getKiboCardIconNew(tpl, isSpecial)
  if not isSpecial or isSpecial == 0 then
    return tpl.kiboCardIcon[1]
  end
  if tpl.kiboCardIconSp[isSpecial] ~= nil then
    return tpl.kiboCardIconSp[isSpecial][1]
  end
end

function this:getPetTalkIcon(tpl, isSpecial)
  if not isSpecial or isSpecial == 0 then
    return tpl.petTalkIcon
  end
  return tpl.petTalkIconSp[isSpecial]
end

function this:getBattleTag(tpl)
  return tpl.battleTag
end

function this:getKiboDuelTag(tpl)
  return tpl.kiboDuelTag
end

function this:getKiboSkillList(tpl)
  return tpl.kiboSkillList
end

function this:getIconographyMapPos(tpl)
  return tpl.iconographyMapPos or {}
end

function this:getBodyType(tpl)
  return tpl.bodyType
end

function this:getIconographyshow(tpl)
  return tpl.iconographyshow
end

function this:getTotalIconographyshow()
  return self.totalIconographyshow
end

function this:getUnitScale(tpl)
  return tpl.unitScale
end

function this:getUnitCameraPosition(tpl)
  return tpl.unitCameraPosition
end

function this:getUnitPosition(tpl)
  return tpl.unitPosition
end

function this:getIconographyScale(tpl)
  return tpl.iconographyUnitScale
end

function this:getIconographyPosition(tpl)
  return tpl.iconographyUnitPosition
end

function this:getHouseType(tpl)
  return tpl.houseType
end

function this:getStarsoulId(tpl)
  return tpl.starsoulId
end

function this:getStarsoulItem(tpl)
  return tpl.starsoulItem
end

function this:getStaroulCamPos(tpl)
  return tpl and tpl.starsoulCamPosition
end

function this:getStarsoulCamRot(tpl)
  return tpl and tpl.starsoulCamRotation
end

function this:getNoShadow(tpl)
  return tpl.noShadow
end

function this:getGetKiboArenaBaseTemplateID(tpl)
  return tpl.kiboArenaBaseTemplateID
end

function this:getIconographyReportReward(tpl)
  return tpl.iconographyreportreward
end

function this:getIconographyReportTimes(tpl)
  return tpl.iconographyreporttimes
end

function this:getGetKiboArenaBaseTemplateID(tpl)
  return tpl.kiboArenaBaseTemplateID
end

return this
