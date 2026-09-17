local laborCommonFunc = {}
local _homeLaborTypeTpl = L_GameTpl:getHomeLaborTypeTpl()
local _petAccessoryRarityProductTpl = L_GameTpl:getPetAccessoryRarityProductTpl()
local _petLaborAccessoryExtraTpl = L_GameTpl:getPetLaborAccessoryExtraTpl()
local _homeBuffTpl = L_GameTpl:getHomeBuffTpl()
local _homeLaborTrainConditionTpl = L_GameTpl:getHomeLaborTrainConditionTpl()
local _petLaborTrainExpTpl = L_GameTpl:getPetLaborTrainExpTpl()
local _homeLaborEfficiencyTpl = L_GameTpl:getHomeLaborEfficiencyTpl()

function laborCommonFunc.getRarityProduct(laborGrade)
  return _petAccessoryRarityProductTpl:getRarityByScore(laborGrade)
end

function laborCommonFunc.getNoTalentDetailDescText(index, _laborId, needLaborType, laborGrade)
  return laborCommonFunc._getNoTalentDescText(index, _laborId, needLaborType, laborGrade, "Detail")
end

function laborCommonFunc.getNoTalentDescText(index, _laborId, needLaborType, laborGrade)
  return laborCommonFunc._getNoTalentDescText(index, _laborId, needLaborType, laborGrade, "Simple")
end

function laborCommonFunc.getRarityByScore(laborGrade)
  return _petAccessoryRarityProductTpl:getRarityByScore(laborGrade)
end

function laborCommonFunc.getBuffDisplayList(homeLaborTypeTpl)
  local titleList = _homeLaborTypeTpl:getHomeBuffTitleList(homeLaborTypeTpl)
  local iconList = _homeLaborTypeTpl:getHomeBuffIconList(homeLaborTypeTpl)
  local simpleTextList = _homeLaborTypeTpl:getHomeBuffSimpleTextList(homeLaborTypeTpl)
  local simpleIconList = _homeLaborTypeTpl:getHomeBuffSimpleIconList(homeLaborTypeTpl)
  local displayList = {}
  for i = 1, #titleList do
    local title = L_Lang:get(titleList[i])
    if title ~= nil and title ~= " " and title ~= "" then
      table.insert(displayList, {
        titleName = title,
        titleIcon = iconList[i],
        buffSimpleDesc = simpleTextList[i],
        iconList = simpleIconList[i]
      })
    end
  end
  return displayList
end

function laborCommonFunc._getNoTalentDescText(index, _laborId, needLaborType, laborGrade, descType)
  local laborId = laborCommonFunc._getLaborId(needLaborType, _laborId)
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  local descList = laborCommonFunc._getDescList(homeLaborTypeTpl, descType)
  local noTalentDesc = descList[index]
  local funcName = _homeLaborTypeTpl:getLaborParameter(homeLaborTypeTpl)[index]
  if funcName then
    local textOfBuffValue = laborCommonFunc._getBuffValueTextWithFunc(funcName, laborGrade)
    return L_Lang:get(noTalentDesc, {
      [0] = textOfBuffValue
    })
  end
  local notEmptyDescDetailList = laborCommonFunc._getNotEmptyDescList(descList)
  local buffIdIndex = laborCommonFunc._findDescIndex(notEmptyDescDetailList, noTalentDesc)
  local buffId = laborCommonFunc._getBuffId(homeLaborTypeTpl, buffIdIndex)
  if buffId == 2015 or buffId == 2016 then
    return laborCommonFunc._handleSpecialBuff(buffId, homeLaborTypeTpl, laborGrade, noTalentDesc)
  end
  local textOfBuffValue = laborCommonFunc._getBuffValueText(buffId, laborId, laborGrade)
  return L_Lang:get(noTalentDesc, {
    [0] = textOfBuffValue
  })
end

function laborCommonFunc._getBuffValueTextWithFunc(funcName, laborGrade)
  if not _homeLaborEfficiencyTpl:getTplById(laborGrade) then
    return "0%"
  end
  local buffValue = L_HomeBuffManager:getLaborBuffValueWithFunc(funcName, laborGrade) / 10000
  local showBuffValue = buffValue * 100
  local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
  return showBuffValueIntPart .. "%"
end

function laborCommonFunc._getLaborId(needLaborType, _laborId)
  if needLaborType then
    if type(needLaborType) == "table" then
      return needLaborType[1]
    else
      return needLaborType
    end
  else
    return _laborId
  end
end

function laborCommonFunc._getDescList(homeLaborTypeTpl, descType)
  if descType == "Detail" then
    return _homeLaborTypeTpl:getLaborDescDetailList(homeLaborTypeTpl)
  else
    local descList = {}
    for _, displayData in ipairs(laborCommonFunc.getBuffDisplayList(homeLaborTypeTpl)) do
      table.insert(descList, displayData.buffSimpleDesc)
    end
    return descList
  end
end

function laborCommonFunc._getNotEmptyDescList(descList)
  local notEmptyList = {}
  for _, descDetail in pairs(descList) do
    if descDetail ~= nil and descDetail ~= " " and descDetail ~= "" then
      table.insert(notEmptyList, descDetail)
    end
  end
  return notEmptyList
end

function laborCommonFunc._findDescIndex(descList, targetDesc)
  for i, desc in pairs(descList) do
    if desc == targetDesc then
      return i
    end
  end
  return nil
end

function laborCommonFunc._getBuffId(homeLaborTypeTpl, buffIdIndex)
  local buffIdList = _homeLaborTypeTpl:getHomeBuffIdList(homeLaborTypeTpl)
  local buffId = buffIdList[buffIdIndex or 1]
  return buffId or buffIdList[1]
end

function laborCommonFunc._getBuffValueText(buffId, laborId, laborGrade)
  local homeBuffTpl = _homeBuffTpl:getTplById(buffId)
  local buffValueType = _homeBuffTpl:getType(homeBuffTpl)
  local buffValue = L_HomeBuffManager:getLaborBuffValue(laborId, laborGrade, buffId)
  if buffId == L_HomeConst.buffId.CROP_SEED_SAVE_PROB or buffId == L_HomeConst.buffId.CROP_HARVEST_SEED_HARVEST then
    buffValue = buffValue / 10000
  else
    buffValue = 10000 / (10000 - buffValue) - 1
  end
  if buffValueType == L_HomeConst.buffValueType.PERCENT then
    local showBuffValue = buffValue * 100
    local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
    return showBuffValueIntPart .. "%"
  else
    local showBuffValue = buffValue
    local showBuffValueIntPart = math.ceil(showBuffValue - showBuffValue % 1)
    return tostring(showBuffValueIntPart)
  end
end

function laborCommonFunc._handleSpecialBuff(buffId, homeLaborTypeTpl, laborGrade, noTalentDesc)
  if buffId == 2015 then
    local textOfBuffValue = _petAccessoryRarityProductTpl:getMaxRarityDescByLaborScore(laborGrade)
    local canMakeDesc = _homeLaborTypeTpl:getBuffCanMakeDesc(homeLaborTypeTpl, buffId)
    return L_Lang:get(noTalentDesc, {
      [0] = textOfBuffValue,
      [1] = canMakeDesc
    })
  end
  if buffId == 2016 then
    local homeBuffTpl = _homeBuffTpl:getTplById(buffId)
    local buffDesc = _homeBuffTpl:getBuffDescription(homeBuffTpl)
    local canMakeDesc = _homeLaborTypeTpl:getBuffCanMakeDesc(homeLaborTypeTpl, buffId)
    local buffValue = _petLaborAccessoryExtraTpl:getGoldRarityDescByLaborScore(laborGrade, canMakeDesc)
    if string.isEmpty(buffValue) then
      return string.empty
    end
    if string.isEmpty(buffDesc) then
      buffDesc = "{0}"
    end
    return L_Lang:get(buffDesc, {
      [0] = buffValue
    })
  end
end

function laborCommonFunc._handleSpecialBuffRarity(index, _laborId, needLaborType, laborGrade)
  local laborId = laborCommonFunc._getLaborId(needLaborType, _laborId)
  local homeLaborTypeTpl = _homeLaborTypeTpl:getTplById(laborId)
  local descList = laborCommonFunc._getDescList(homeLaborTypeTpl, "Detail")
  local noTalentDesc = descList[index]
  local notEmptyDescDetailList = laborCommonFunc._getNotEmptyDescList(descList)
  local buffIdIndex = laborCommonFunc._findDescIndex(notEmptyDescDetailList, noTalentDesc)
  local buffId = laborCommonFunc._getBuffId(homeLaborTypeTpl, buffIdIndex)
  if buffId == 2015 then
    return _petAccessoryRarityProductTpl:getRarityByScore(laborGrade), false
  end
  if buffId == 2016 then
    return _petLaborAccessoryExtraTpl:getRarityByScore(laborGrade), true
  end
  return 0, false
end

function laborCommonFunc:getMinRarityDescByLaborGrade(laborGrade, laborId)
  local minRarity
  local homeLaborTrainConditionTpl = _homeLaborTrainConditionTpl:getTplById(laborId)
  if homeLaborTrainConditionTpl == nil then
    return string.empty
  end
  for _, rarity in ipairs(L_Const.qualityList) do
    local exp = _petLaborTrainExpTpl:getExpByScoreAndRarity(laborGrade, rarity)
    if exp ~= 0 then
      minRarity = rarity
      break
    end
  end
  if not minRarity then
    return string.empty
  end
  local rarityTpl = L_RarityTpl:getTplById(minRarity)
  local color = L_Const.colorHtml[L_RarityTpl:getEquipmentColorAst(rarityTpl)]
  local rarityDescNoColor = L_RarityTpl:getRarityName(rarityTpl)
  local rarityDesc = L_GameUtil.fillColor(rarityDescNoColor, color)
  local desc = _homeLaborTrainConditionTpl:getDesc(homeLaborTrainConditionTpl)
  local showDesc = L_Lang:get(desc, {
    [0] = rarityDesc
  })
  return showDesc or string.empty
end

return laborCommonFunc
