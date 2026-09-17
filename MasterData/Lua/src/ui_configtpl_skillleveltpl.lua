local this = class("skillLevelTpl")

function this:init()
end

function this:getTplByIdAndLevel(skillId, level)
  level = level or 1
  local tpl = C_TDSkillLevelTable.GetSkillLevel(skillId, level)
  return tpl
end

function this:getMaxLevelById(skillId)
  local maxLevel = C_TDSkillLevelTable.GetMaxLevel(skillId)
  return maxLevel
end

function this:getSubSkillId(tpl)
  return tpl.subSkillId
end

function this:getItem(tpl)
  return tpl.item
end

function this:getCanUp(tpl)
  return tpl.canUp ~= 0
end

function this:getValue(tpl)
  local value = tpl.value
  local res = {}
  for i = 0, value.Count - 1 do
    table.insert(res, value[i])
  end
  return res
end

function this:getName(tpl)
  local value = tpl.name
  local res = {}
  for i = 0, value.Count - 1 do
    table.insert(res, L_Config:provider(value[i]))
  end
  return res
end

function this:getSkillDescribe(tpl)
  if TableIsNull(tpl) then
    return
  end
  local propertyValueCur_list = self:getValue(tpl)
  local curDescribeTxt = string.gsub(L_Config:provider(tpl.skillDescribe.value), " ", " ")
  local propertyList_txt = {}
  for i = 0, #propertyValueCur_list - 1 do
    local value = propertyValueCur_list[i + 1]
    local startPos, endPos = string.find(curDescribeTxt, "{" .. i .. "}")
    if startPos then
      if not string.isEmpty(value) then
        propertyList_txt[i] = value
      end
    else
      break
    end
  end
  return L_Lang:get(curDescribeTxt, propertyList_txt)
end

function this:getSkillDetailDescribe(tpl)
  if TableIsNull(tpl) then
    return
  end
  local propertyValueCur_list = self:getValue(tpl)
  local curDescribeTxt = string.gsub(L_Config:provider(tpl.skillDescribeDetail.value), " ", " ")
  local propertyList_txt = {}
  for i = 0, #propertyValueCur_list - 1 do
    local value = propertyValueCur_list[i + 1]
    local startPos, endPos = string.find(curDescribeTxt, "{" .. i .. "}")
    if startPos then
      if not string.isEmpty(value) then
        propertyList_txt[i] = value
      end
    else
      break
    end
  end
  return L_Lang:get(curDescribeTxt, propertyList_txt)
end

function this:getSkillPowerName(tpl)
  if tpl == nil then
    return
  end
  return tpl.skillPowerName
end

function this:getSkillPower(tpl)
  if tpl == nil then
    return
  end
  return tpl.skillPower
end

function this:getSkillPowerType(tpl)
  local value = tpl.name
  local temp = ""
  for i = 0, value.Count - 1 do
    temp = temp .. tostring(L_Config:provider(value[i]))
  end
  return temp
end

function this:getId(tpl)
  return tpl.id
end

function this:getGold(tpl)
  return tpl.gold
end

function this:getHeroLevel(tpl)
  return tpl.heroLevel or 0
end

function this:getHeroRank(tpl)
  return tpl.heroRank or 0
end

function this:getSkillGroupId(tpl)
  return tpl.skillId
end

function this:getSubSkillId(tpl)
  return tpl.subSkillId
end

function this:getSkillSpecialDesc(tpl)
  return L_Config:provider(tpl.skillSpecialDesc.value)
end

return this
