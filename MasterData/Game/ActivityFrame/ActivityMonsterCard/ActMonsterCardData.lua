local ActMonsterCardData = class("ActMonsterCardData")
local eActMonsterCardEnum = require("Game.ActivityFrame.ActivityMonsterCard.eActMonsterCardEnum")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")

function ActMonsterCardData:ctor(cardDataMsg, cardDicCfg, isFake)
  self._monCardId = cardDataMsg.id
  self._num = cardDataMsg.num
  self._cardCfg = cardDicCfg[self._monCardId]
  self._type = self._cardCfg.card_type_id
  self._level = nil
  self._lableList = self._cardCfg.label_id
  self._isFakeCard = isFake
end

function ActMonsterCardData:AacMCD_UpdateNum(num)
  if self._num == num then
    return false
  end
  self._num = num
  self._level = nil
  return true
end

function ActMonsterCardData:AacMCD_IsLarger(OtherMonCardData)
  local quality = self:AacMCD_GetQuailty()
  local quality_other = OtherMonCardData:AacMCD_GetQuailty()
  if quality ~= quality_other then
    return quality > quality_other
  end
  return self:AacMCD_GetId() > OtherMonCardData:AacMCD_GetId()
end

function ActMonsterCardData:AacMCD_GetId()
  return self._monCardId
end

function ActMonsterCardData:AacMCD_GetItemCfg()
  return ConfigData.item[self:AacMCD_GetId()]
end

function ActMonsterCardData:AacMCD_GetType()
  return self._type
end

function ActMonsterCardData:AacMCD_GetName()
  local itemCfg = self:AacMCD_GetItemCfg()
  return LanguageUtil.GetLocaleText(itemCfg.name)
end

function ActMonsterCardData:AacMCD_GetIsFakeCard()
  return self._isFakeCard
end

function ActMonsterCardData:AacMCD_GetDes(level, moduleType)
  if level == nil then
    level = self:AacMCD_GetLevel()
  end
  local logicArray, para1Array, para2Array, para3Array = self:AacMCD_GetOrgLogic(level)
  local desStr = CommonLogicUtil.GetLogicDesStrMultiLine(logicArray, para1Array, para2Array, para3Array, moduleType)
  return desStr
end

function ActMonsterCardData:AacMCD_GetLevelUpDes(level, moduleType)
  if level == nil then
    level = self:AacMCD_GetLevel()
  end
  local monCardId = self:AacMCD_GetId()
  local levelList = ConfigData.activity_monster_card_card_level[monCardId]
  local levelCfg = levelList[level]
  local customDes = LanguageUtil.GetLocaleText(levelCfg.des)
  if not string.IsNullOrEmpty(customDes) then
    return customDes
  end
  if level >= #levelList then
    return self:AacMCD_GetDes(level, moduleType)
  end
  local logicArray, para1Array, para2Array, para3Array = self:AacMCD_GetOrgLogic(level)
  local next_logicArray, next_para1Array, next_para2Array, next_para3Array = self:AacMCD_GetOrgLogic(level + 1)
  local desStrList = CommonLogicUtil:GetDesAboutLvUpDes(logicArray, para1Array, para2Array, para3Array, logicArray, next_para1Array, next_para2Array, next_para3Array, moduleType)
  local desStr = ""
  for _, des in ipairs(desStrList) do
    if string.IsNullOrEmpty(desStr) then
      desStr = des
    else
      desStr = desStr .. "\n" .. des
    end
  end
  return desStr
end

function ActMonsterCardData:AacMCD_GetLevel()
  if self._level ~= nil then
    return self._level
  end
  local monCardId = self:AacMCD_GetId()
  local levelList = ConfigData.activity_monster_card_card_level[monCardId]
  for level = #levelList, 1, -1 do
    local levelCfg = levelList[level]
    if self._num >= levelCfg.p_level_num then
      self._level = level
      break
    end
  end
  return self._level
end

function ActMonsterCardData:AacMCD_GetNextLevelInfo()
  local isHaveNextLevel, nextLevel, curNum, needNum
  local curLevel = self:AacMCD_GetLevel()
  local monCardId = self:AacMCD_GetId()
  local levelList = ConfigData.activity_monster_card_card_level[monCardId]
  if curLevel >= #levelList then
    isHaveNextLevel = false
  else
    isHaveNextLevel = true
    nextLevel = curLevel + 1
    local levelCfg = levelList[curLevel]
    local nextLevelCfg = levelList[nextLevel]
    curNum = self._num - levelCfg.p_level_num
    needNum = nextLevelCfg.p_level_num - levelCfg.p_level_num
  end
  return isHaveNextLevel, nextLevel, curNum, needNum
end

function ActMonsterCardData:AacMCD_GetQuailty()
  local itemCfg = self:AacMCD_GetItemCfg()
  return itemCfg.quality
end

function ActMonsterCardData:AacMCD_GetOrgLogic(level)
  local monCardId = self:AacMCD_GetId()
  local curLevel = level or self:AacMCD_GetLevel()
  local levelList = ConfigData.activity_monster_card_card_level[monCardId]
  local levelCfg = levelList[curLevel]
  return levelCfg.logic, levelCfg.para1, levelCfg.para2, levelCfg.para3
end

function ActMonsterCardData:AacMCD_GetLabels()
  return self._lableList
end

function ActMonsterCardData.AacMCD_Static_GetDes(monCardId, level, moduleType)
  local levelList = ConfigData.activity_monster_card_card_level[monCardId]
  local levelCfg = levelList[level]
  local logicArray, para1Array, para2Array, para3Array = levelCfg.logic, levelCfg.para1, levelCfg.para2, levelCfg.para3
  local desStr = CommonLogicUtil.GetLogicDesStrMultiLine(logicArray, para1Array, para2Array, para3Array, moduleType)
  return desStr
end

return ActMonsterCardData
